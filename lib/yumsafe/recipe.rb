
module YumSafe
  class Recipe < Base

    attr_reader :id, :title, :link, :ingredients

    # @param [Struct] card
    def initialize(card)
      @id          = card.id
      @link        = card.link
      @title       = strip_tags(card.title)
      @ingredients = strip_tags(card.ingredients)
    end

    def url
      BASE_URL + @link
    end

    def directions_url
      @directions_url ||= scrape_directions_url()
    end


    private

    def scrape_directions_url
      url = "#{BASE_URL}/recipe/external/#{@id}"
      html = fetch(url)

      url_scraper = Scraper.define do
        process "iframe#yFrame", :url => "@src"
        result :url
      end

      return url_scraper.scrape(html)
    end

  end
end
