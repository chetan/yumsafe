
if RUBY_PLATFORM =~ /darwin/ then
    # fix for scrapi on Mac OS X
    require "tidy_ffi"
    TidyFFI.library_path = "/usr/lib/libtidy.dylib"
end

require 'tidy_ffi'
require 'httparty'
require 'scrapi'
require 'ostruct'
require 'htmlentities'
require 'securerandom'
require 'pinboard'

module YumSafe
end

require "yumsafe/safe"
require "yumsafe/base"
require "yumsafe/recipe_box"
require "yumsafe/recipe"
require "yumsafe/app"
