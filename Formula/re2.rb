class Re2 < Formula
  desc "Alternative to backtracking PCRE-style regular expression engines"
  homepage "https://github.com/google/re2"
  url "https://github.com/google/re2/archive/2019-07-01.tar.gz"
  version "20190701"
  sha256 "de6c3ee49b2cecdfd2936af18d6947db36726590e566b5915db3746784c55745"
  head "https://github.com/google/re2.git"

  bottle do
    cellar :any
    sha256 "e957b0c301ce7996062404b9f758402e1658e4819bebe63b1fff8b90d9017a0d" => :mojave
    sha256 "5de0688fe875d29ca58b9a9bedb16cb780c4d5a06b44c493e9494a4bd36634be" => :high_sierra
    sha256 "0a3bc16aaafe6553cfd36fa73fc4a03a11f3734d8fa06a4836de3ee2c6f3ab5c" => :sierra
    sha256 "0e39d668c0c1af7275a93b49254e644099f705c92e3369a3a4bc3dd3be819b0f" => :x86_64_linux
  end

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j8" if ENV["CIRCLECI"]

    ENV.cxx11

    system "make", "install", "prefix=#{prefix}"
    MachO::Tools.change_dylib_id("#{lib}/libre2.0.0.0.dylib", "#{lib}/libre2.0.dylib") if OS.mac?
    ext = OS.mac? ? "dylib" : "so"
    lib.install_symlink "libre2.0.0.0.#{ext}" => "libre2.0.#{ext}"
    lib.install_symlink "libre2.0.0.0.#{ext}" => "libre2.#{ext}"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <re2/re2.h>
      #include <assert.h>
      int main() {
        assert(!RE2::FullMatch("hello", "e"));
        assert(RE2::PartialMatch("hello", "e"));
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11",
           "test.cpp", "-I#{include}", "-L#{lib}", "-pthread", "-lre2", "-o", "test"
    system "./test"
  end
end
