
module YumSafe
  class RecipeBox < Base

    attr_reader :recipes

    def initialize(username)
      @url = "http://www.yummly.com/profile/#{username}/recipes"
      scrape(fetch(@url))
    end

    def scrape(html)

      card_scraper = Scraper.define do
        process ".y-card", :id => "@data-id"
        process ".y-title a.y-full", :title => :text
        process ".y-title a.y-full", :link => "@href"
        process ".y-ingredients p", :ingredients => :text

        result :id, :title, :link, :ingredients
      end

      box_scraper = Scraper.define do
        array :cards
        process "#cards div.y-card", :cards => card_scraper
        result :cards
      end

      cards = box_scraper.scrape(html)
      @recipes = cards.map{ |c| Recipe.new(c) }
    end

  end
end
