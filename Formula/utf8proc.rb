class Utf8proc < Formula
  desc "Clean C library for processing UTF-8 Unicode data"
  homepage "https://juliastrings.github.io/utf8proc/"
  url "https://github.com/JuliaStrings/utf8proc/archive/v2.4.0.tar.gz"
  sha256 "b2e5d547c1d94762a6d03a7e05cea46092aab68636460ff8648f1295e2cdfbd7"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles"
    cellar :any
    sha256 "5cbd1c95723915eda5c5bb0437f49c3aeb50d768cfec87e9ff09507912244589" => :mojave
    sha256 "b1bbbd93be674c8304888ff5843a63433a5e3b7ccd7d8c8d9ceb450ce71a9c88" => :high_sierra
    sha256 "447fe55565ddc9e411a78939b829d2a175f608ea0497eae069c86befef471d34" => :sierra
    sha256 "f21c5d190ec1627e4eee59a488985e2704fc77131275bcf0d8c4cb439cf69b74" => :x86_64_linux
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <string.h>
      #include <utf8proc.h>

      int main() {
        const char *version = utf8proc_version();
        return strnlen(version, sizeof("1.3.1-dev")) > 0 ? 0 : -1;
      }
    EOS

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lutf8proc", "-o", "test"
    system "./test"
  end
end
