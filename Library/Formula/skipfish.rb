require 'formula'

class Skipfish < Formula
  desc "Web application security scanner"
  homepage 'http://code.google.com/p/skipfish/'
  url 'https://skipfish.googlecode.com/files/skipfish-2.10b.tgz'
  sha1 '2564162a13d02f8310eef5edcbaf74ed6043be99'

  bottle do
    sha1 "509453d1b4e717ab4858b22c6fffe1d5f98744a2" => :mavericks
    sha1 "d79d26539fac30870ee1699791638f7a38ffd884" => :mountain_lion
    sha1 "516a27501c45f82c782cbe61867cc958f0063113" => :lion
  end

  depends_on 'libidn'
  depends_on 'pcre'

  def install
    ENV.append "CFLAGS", "-I#{HOMEBREW_PREFIX}/include"
    ENV.append "LDFLAGS", "-L#{HOMEBREW_PREFIX}/lib"

    chmod 0755, "src/config.h" # Not writeable in the tgz. Lame.
    inreplace "src/config.h",
      "#define ASSETS_DIR              \"assets\"",
      "#define ASSETS_DIR	       \"#{libexec}/assets\""

    system 'make'
    bin.install 'skipfish'
    libexec.install %w(assets dictionaries config signatures doc)
  end

  def caveats; <<-EOS.undent
    NOTE: Skipfish uses dictionary-based probes and will not run until
    you have specified a dictionary for it to use. Please read:
      #{libexec}/doc/dictionaries.txt
    carefully to make the right choice. This step has a profound impact
    on the quality of results later on.

    Use this command to print usage information:
      skipfish -h
    EOS
  end
end
