
module YumSafe
  class Base

    BASE_URL = "http://www.yummly.com"

    def strip_tags(html)
      return HTMLEntities.new.decode(html)
    end

    # Fetch the given URL with a few retries in case of non-404 failure
    def fetch(url)
      # puts "fetching #{url}"
      3.times do |i|
        begin
          res = HTTParty.get(url)
          case res.code
            when 200
              return res.body
            when 404
              return nil
          end

        rescue Exception => ex
          raise ex if i == 2
          # fall thru to retry
        end

        sleep 0.5 if i < 2
      end

      # puts "failed"
      nil # failed
    end

  end
end
