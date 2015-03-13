
module YumSafe
  class App

    def initialize
      validate_config()
      @safe = YumSafe.load
    end

    def validate_config
      if ENV["YUMSAFE_PINBOARD"].nil? then
        STDERR.puts "error: YUMSAFE_PINBOARD not set!"
        exit 1
      end

      if ENV["YUMSAFE_USER"].nil? then
        STDERR.puts "error: YUMSAFE_USER not set!"
        exit 1
      end
    end

    def run!
      box = YumSafe::RecipeBox.new(ENV["YUMSAFE_USER"])

      puts "fetched #{box.recipes.size} recipes"
      new_recipes = 0
      box.recipes.each do |r|
        if !@safe.seen?(r.id) then

          if new_recipes > 0 then
            sleep_with_jitter
          end

          new_recipes += 1
          store_recipe(r)
        end
      end

      puts "total new recipes: #{new_recipes}"
    end

    def store_recipe(r)
      puts "found new recipe: #{r.title}"
      if !r.directions_url.nil? then
        send_to_pinboard(r)
      end
      @safe.touch(r.id)
    end

    def send_to_pinboard(recipe)
      url = recipe.directions_url
      puts "saving to pinboard: #{url}"
      pinboard = Pinboard::Client.new(:token => ENV["YUMSAFE_PINBOARD"])
      pinboard.add(:url => url, :description => recipe.title, :tags => %w(recipes via_yummly))
    end

    def sleep_with_jitter
      sleep SecureRandom.random_number + SecureRandom.random_number(3)
    end

  end
end
