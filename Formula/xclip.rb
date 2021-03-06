class Xclip < Formula
  desc "Command-line utility that is designed to run on any system with an X11"
  homepage "https://github.com/astrand/xclip"
  url "https://github.com/astrand/xclip/archive/0.13.tar.gz"
  sha256 "ca5b8804e3c910a66423a882d79bf3c9450b875ac8528791fb60ec9de667f758"
  revision 1 unless OS.mac?

  bottle do
    cellar :any_skip_relocation
    sha256 "7bb1acc9b968eba155874f614dbfea960e883121321b063faf81f106f2521014" => :mojave
    sha256 "0963015158b7d4ae2981503edc18427737a0586b7155da5cd2ddaa93fb3b92bd" => :high_sierra
    sha256 "bb26c2bb6d7ce8f15ab50144f38d11ddde113bb400326ccea990ca9a5d0a9c69" => :sierra
    sha256 "9e17790e9a94ae1e29317f013a65f2d639ae9063db48ed7fa0aed7449f221abb" => :el_capitan
    sha256 "9de13067a4d4ab379e82ab78d97c559695551fd51ee99c23879e2503de6c4d7e" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on :x11 if OS.mac?
  uses_from_macos "linuxbrew/xorg/xorg"

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/xclip", "-version"
  end
end
