class Libre < Formula
  desc "Toolkit library for asynchronous network I/O with protocol stacks"
  homepage "http://www.creytiv.com"
  url "http://www.creytiv.com/pub/re-0.6.0.tar.gz"
  sha256 "0e97bcb5cc8f84d6920aa78de24c7d4bf271c5ddefbb650848e0db50afe98131"

  bottle do
    cellar :any
    sha256 "ce0476d0d26515adbcf11f27d185cf503214a1efa95223d1eba02840f090af85" => :mojave
    sha256 "9679c767b3cd61b552b03bf7f6b9d97b9ae056076fa3aa84262ee086f606f481" => :high_sierra
    sha256 "290fdbf6dd3a1b2064d00badb610ee1af38d1c070f38a72a54ec5a02ba3b4b2f" => :sierra
    sha256 "410d3da5a40c5d1c70741297172cb8da4c2bb0a902f0caad814aacfbd41f40f1" => :x86_64_linux
  end

  depends_on "openssl"

  def install
    system "make", *("SYSROOT=#{MacOS.sdk_path}/usr" if OS.mac?), "install", "PREFIX=#{prefix}"
  end

  test do
    if OS.mac?
      (testpath/"test.c").write <<~EOS
        #include <re/re.h>
        int main() {
          return libre_init();
        }
      EOS
    else
      (testpath/"test.c").write <<~EOS
        #include <stdint.h>
        #include <re/re.h>
        int main() {
          return libre_init();
        }
      EOS
    end
    system ENV.cc, "test.c", "-L#{lib}", "-lre"
  end
end
