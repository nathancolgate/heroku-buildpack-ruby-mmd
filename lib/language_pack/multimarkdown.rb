## require 'formula'
require "language_pack"

# Multimarkdown Language Pack
## class Multimarkdown < Formula
class LanguagePack::Multimarkdown < LanguagePack::Rails3
  
  ## homepage 'http://fletcherpenney.net/multimarkdown/'
  ## url 'https://github.com/fletcher/peg-multimarkdown/tarball/3.2'
  ## md5 '438a7c09af13adf91e318ba2f49681b6'
  ## head 'https://github.com/fletcher/peg-multimarkdown.git', :branch => 'development'
  # URL           = "https://github.com/fletcher/peg-multimarkdown/tarball/3.2"
  GIT_REPO      = "git://github.com/fletcher/peg-multimarkdown.git"

  # name of the Language Pack
  # @return [String] the result
  def name
    "Multimarkdown"
  end

  ## def install
  ##   ENV.append 'CFLAGS', '-include GLibFacade.h'
  ##   system "make"
  ##   bin.install 'multimarkdown'
  ##   bin.install Dir['Support/bin/*']
  ##   bin.install Dir['scripts/*']
  ## end

  def compile
    super
    ENV["CFLAGS"] = '-include GLibFacade.h'
    # Downloads from web and unzips the file
    # -L = Follows redirects
    # -s = Silent
    # -o - | tar zxf - = Take the downloaded data, and unzip it
    topic "Git clone peg-multimarkdown"
    Dir.chdir(build_path) do
      # run("curl #{URL} -L -s -o - | tar zxf -")
      pipe("git clone #{GIT_REPO}")
    end
    error 'Uh oh 1' unless $?.success?
    
    topic "Make peg-multimarkdown"
    Dir.chdir("#{build_path}/peg-multimarkdown") do
      # run("curl #{URL} -L -s -o - | tar zxf -")
      pipe("make")
    end
    error 'Uh oh 2' unless $?.success?
    
    topic "Make install peg-multimarkdown"
    Dir.chdir("#{build_path}/peg-multimarkdown") do
      # run("curl #{URL} -L -s -o - | tar zxf -")
      pipe("make install")
    end
    error 'Uh oh 3' unless $?.success?
  end


end
