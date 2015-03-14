
require "tidy_ffi"
if RUBY_PLATFORM =~ /darwin/ then
  TidyFFI.library_path = "/usr/lib/libtidy.dylib"
elsif RUBY_PLATFORM =~ /linux/ && File.exists?("/usr/lib/libtidy.so") then
  TidyFFI.library_path = "/usr/lib/libtidy.so"
end

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
