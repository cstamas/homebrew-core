class Securefs < Formula
  desc "Filesystem with transparent authenticated encryption"
  homepage "https://github.com/netheril96/securefs"
  url "https://github.com/netheril96/securefs/archive/0.8.3.tar.gz"
  sha256 "04b0aa78108addcdeef64a4333ac75dff2833b7a48797b7c9060e325520db706"
  head "https://github.com/netheril96/securefs.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles"
    cellar :any
    sha256 "07605d0d88a95902f1ee39d88c56dceadcacdf6e61a71431f68cdbf97003c848" => :mojave
    sha256 "e0a3b66b2dd99a8cd2a6f79b4fe537875c55aa240f7383bef450b008fff6dfff" => :high_sierra
    sha256 "a75071f5711a298f0223c4776891c2ccd5062f0a2830debfaa0191a0152d8bfc" => :sierra
    sha256 "1de8baf2c55e06b9f90183bd248d5353a97bf0931eff408dd2ec094eda905776" => :x86_64_linux
  end

  depends_on "cmake" => :build
  if OS.mac?
    depends_on :osxfuse
  else
    depends_on "libfuse"
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "#{bin}/securefs", "version" # The sandbox prevents a more thorough test
  end
end
