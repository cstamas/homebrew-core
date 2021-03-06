class MongoCDriver < Formula
  desc "C driver for MongoDB"
  homepage "https://github.com/mongodb/mongo-c-driver"
  url "https://github.com/mongodb/mongo-c-driver/releases/download/1.14.0/mongo-c-driver-1.14.0.tar.gz"
  sha256 "ebe9694f7fa6477e594f19507877bbaa0b72747682541cf0cf9a6c29187e97e8"
  head "https://github.com/mongodb/mongo-c-driver.git"

  bottle do
    cellar :any
    sha256 "e492f5639ad8ce4918e65ddc9e34e56d5969381ae90a9f96540d97d785c3a694" => :mojave
    sha256 "16a81d2bc7606573034cfdbbcc4772e877145c6a920f52781fd73e2af2f9033e" => :high_sierra
    sha256 "c30dd2e19f5b5b2ec6cfa93726658e9300dafab21725a12e1b1fea624790cf69" => :sierra
    sha256 "fa258a89556244c12f6f7cfb5782bdb5c6d8428e12c4ee3716029225ec910587" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build
  unless OS.mac?
    depends_on "openssl"
    depends_on "zlib"
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    (pkgshare/"libbson").install "src/libbson/examples"
    (pkgshare/"libmongoc").install "src/libmongoc/examples"
  end

  test do
    system ENV.cc, "-o", "test", pkgshare/"libbson/examples/json-to-bson.c",
      "-I#{include}/libbson-1.0", "-L#{lib}", "-lbson-1.0"
    (testpath/"test.json").write('{"name": "test"}')
    assert_match "\u0000test\u0000", shell_output("./test test.json")

    system ENV.cc, "-o", "test", pkgshare/"libmongoc/examples/mongoc-ping.c",
      "-I#{include}/libmongoc-1.0", "-I#{include}/libbson-1.0",
      "-L#{lib}", "-lmongoc-1.0", "-lbson-1.0"
    assert_match "No suitable servers", shell_output("./test mongodb://0.0.0.0 2>&1", 3)
  end
end
