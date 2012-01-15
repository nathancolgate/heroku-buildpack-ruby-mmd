## require 'formula'
require "language_pack"

# Multimarkdown Language Pack
## class Multimarkdown < Formula
class LanguagePack::Multimarkdown < LanguagePack::Base
  
  ## homepage 'http://fletcherpenney.net/multimarkdown/'
  ## url 'https://github.com/fletcher/peg-multimarkdown/tarball/3.2'
  ## md5 '438a7c09af13adf91e318ba2f49681b6'
  ## head 'https://github.com/fletcher/peg-multimarkdown.git', :branch => 'development'
  # URL           = "https://github.com/fletcher/peg-multimarkdown/tarball/3.2"
  GIT_REPO      = "git://github.com/fletcher/peg-multimarkdown.git"
  
  def self.use?
    true
  end

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
    ENV["CFLAGS"] = '-include GLibFacade.h'
    # Downloads from web and unzips the file
    # -L = Follows redirects
    # -s = Silent
    # -o - | tar zxf - = Take the downloaded data, and unzip it
    Dir.chdir(build_path) do
      # run("curl #{URL} -L -s -o - | tar zxf -")
      run("git clone #{GIT_REPO}")
    end
    error 'Uh oh 1' unless $?.success?
    
    Dir.chdir("#{build_path}/peg-multimarkdown") do
      # run("curl #{URL} -L -s -o - | tar zxf -")
      run("make")
    end
    error 'Uh oh 2' unless $?.success?

  end


end
