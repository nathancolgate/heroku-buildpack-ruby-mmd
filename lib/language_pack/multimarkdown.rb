## require 'formula'
require "language_pack"

# Multimarkdown Language Pack
## class Multimarkdown < Formula
class LanguagePack::Multimarkdown < LanguagePack::Rails3
  
  VULCAN_BINARY      = "http://heroku-buildpacks.s3.amazonaws.com/multimarkdown-3.5.tgz"

  # name of the Language Pack
  # @return [String] the result
  def name
    "Multimarkdown"
  end

  
  # the relative path to the vendored ruby directory
  # @return [String] resulting path
  def slug_vendor_multimarkdown
    "vendor/multimarkdown"
  end

  def compile
    super

    topic "Installing multimarkdown"
    FileUtils.mkdir_p(slug_vendor_multimarkdown)
    Dir.chdir(slug_vendor_multimarkdown) do
      run("curl #{VULCAN_BINARY} -s -o - | tar zxf -")
    end
    error 'Multimarkdown could not be installed' unless $?.success?

    bin_dir = "bin"
    FileUtils.mkdir_p bin_dir
    run("cp #{slug_vendor_multimarkdown}/* #{bin_dir}")
    Dir["bin/*"].each {|path| run("chmod +x #{path}") }

  end


end
