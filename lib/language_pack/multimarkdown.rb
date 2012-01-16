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

    FileUtils.mkdir_p(slug_vendor_multimarkdown)
    Dir.chdir(slug_vendor_multimarkdown) do
      run("curl #{VULCAN_BINARY} -s -o - | tar zxf -")
    end
    error 'Bad News Bears' unless $?.success?

    bin_dir = "bin"
    FileUtils.mkdir_p bin_dir
    run("cp #{slug_vendor_multimarkdown}/* #{bin_dir}")
    Dir["bin/*"].each {|path| run("chmod +x #{path}") }


    # ENV["CFLAGS"] = '-include GLibFacade.h'
    # # run("curl #{URL} -L -s -o - | tar zxf -")
    # # Downloads from web and unzips the file
    # # -L = Follows redirects
    # # -s = Silent
    # # -o - | tar zxf - = Take the downloaded data, and unzip it
    # topic "Git clone peg-multimarkdown"
    # Dir.chdir(build_path) do
    #   pipe("git clone #{GIT_REPO}")
    # end
    # error 'Uh oh 1' unless $?.success?
    # 
    # topic "Make peg-multimarkdown"
    # Dir.chdir("#{build_path}/peg-multimarkdown") do
    #   # run("curl #{URL} -L -s -o - | tar zxf -")
    #   pipe("make")
    # end
    # error 'Uh oh 2' unless $?.success?
    # 
    # topic "copy peg-multimarkdown"
    # Dir.chdir("#{build_path}/peg-multimarkdown") do
    #   # run("curl #{URL} -L -s -o - | tar zxf -")
    #   pipe("cp multimarkdown /usr/local/bin/multimarkdown")
    # end
    # error 'Uh oh 3' unless $?.success?
  end


end
