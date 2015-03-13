
require "fileutils"

module YumSafe

  def self.load
    Safe.load
  end
  # public_class_method(:load)

  class Safe

    def initialize
      @path = ENV["YUMSAFE_PATH"] || ""
      if @path.strip.empty? then
        STDERR.puts "error: YUMSAFE_PATH not set!"
        exit 1
      end
      @path = File.join(@path.strip, ".yumsafe")
      FileUtils.mkdir_p(File.join(@path, "recipes"))
    end

    def self.load
      safe = Safe.new
      safe
    end

    def seen?(recipe)
      !seen_time(recipe).nil?
    end

    def seen_time(recipe)
      r = recipe_path(recipe)
      if !File.exists?(r) then
        return nil
      end

      File.stat(r).mtime
    end

    def touch(recipe)
      r = recipe_path(recipe)
      FileUtils.touch(r) if !File.exists?(r)
      true
    end

    def recipe_path(recipe)
      File.join(@path, "recipes", recipe)
    end

  end
end
