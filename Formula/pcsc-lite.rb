class PcscLite < Formula
  desc "Middleware to access a smart card using SCard API"
  homepage "https://pcsclite.apdu.fr/"
  url "https://pcsclite.apdu.fr/files/pcsc-lite-1.8.23.tar.bz2"
  sha256 "5a27262586eff39cfd5c19aadc8891dd71c0818d3d629539bd631b958be689c9"

  bottle do
    cellar :any_skip_relocation
    sha256 "be4068d6d357c142d4978b1325cb1c534fcc369cba2bbbe44fb3eaceb8fdd501" => :mojave
    sha256 "0ed981ad7244d50d3084cef08991c5662658cd321d24784b2a6c2f8586f8f205" => :high_sierra
    sha256 "16167530e755c8c59a43b72433e9e1aba53b14f4f7364e85fc3159ecdc8ce75b" => :sierra
    sha256 "9a2816b3aaa1717d6c5d2c59495681915b62de67e496bb3edfecf1e5b6d537c0" => :el_capitan
    sha256 "5893a25cd181bd3711d8a0b935f4a1fc9ab3e314accd2f1c5c60a0b27e2ee947" => :x86_64_linux
  end

  keg_only :provided_by_macos,
    "pcsc-lite interferes with detection of macOS's PCSC.framework"

  unless OS.mac?
    depends_on "pkg-config" => :build
    depends_on "libusb"
  end

  def install
    args = %W[--disable-dependency-tracking
              --disable-silent-rules
              --prefix=#{prefix}
              --sysconfdir=#{etc}
              --disable-libsystemd]
    args << "--disable-libudev" unless OS.mac?

    system "./configure", *args
    system "make", "install"
  end

  test do
    system sbin/"pcscd", "--version"
  end
end
