# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Libdwarf < Formula
  desc "A library for dealing with DWARF debug information"
  homepage "https://www.prevanders.net/dwarf.html"
  url "https://www.prevanders.net/libdwarf-20161124.tar.gz"
  version "20161124"
  sha256 "bd3d6dc7da0509876fb95b8681f165febd898845dc66714aa58e69b8feca988f"

  depends_on "libelf" => :build # if your formula requires any X11/XQuartz components
  depends_on "autoconf" => :build # if your formula requires any X11/XQuartz components

  patch :p2 do
    url "https://raw.githubusercontent.com/moyix/homebrew-libdwarf/c66723d4e37703c9cda1a12c686fd995b510dc0d/patches/darwin_libdwarf.patch"
    sha256 "365a77fbe8f34f6374207444f8e47e38f7a1c76bf7046b453c6a72e2be46b877"
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "autoconf"

    Dir.chdir("libdwarf") do
      system "autoconf"
    end

    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--enable-shared",
                          "--disable-nonshared",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test libdwarf`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
