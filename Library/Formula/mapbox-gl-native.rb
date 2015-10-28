# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class MapboxGlNative < Formula
  desc "Render Mapbox styles in mobile, desktop, and node applications using C++ and OpenGL"
  homepage "https://mapbox.com/mobile"
  url "https://github.com/mapbox/mapbox-gl-native/archive/c80c823da25bcc67d89158f339be7cfb93c45f50.tar.gz"
  version "50"
  sha256 "f408c63032ad6bf222ddb2503bdbd91f22074e80404f1838dbdcd17992609e02"

  # depends_on "cmake" => :build
  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on "libpng"
  depends_on "libuv"
  depends_on "lzlib"
  depends_on "boost"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "osx run-osx" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test mapbox-gl-native`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
