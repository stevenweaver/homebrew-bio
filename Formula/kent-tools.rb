class KentTools < Formula
  desc "Utilities for the UCSC Genome Browser"
  homepage "https://genome.ucsc.edu/"
  url "https://hgdownload.soe.ucsc.edu/admin/exe/userApps.v401.src.tgz"
  sha256 "3608689a07a6327f5695672a804ef5f35c9d680c114b0ee947ca2a4f3b768514"
  head "git://genome-source.cse.ucsc.edu/kent.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    sha256 "ac093db4c2f1d86ce71d9b7eb062e6cfb1d14e1f347e81f801c1f4929619f0c1" => :catalina
    sha256 "2daa36698e7b56d5cf0d97cb4721ff7063462515a2d29bc76ac376f05a07f9e4" => :x86_64_linux
  end

  depends_on "libpng"
  depends_on "mysql@5.7"
  depends_on "openssl@1.1"

  uses_from_macos "rsync"
  uses_from_macos "zlib"

  on_linux do
    depends_on "util-linux"
  end

  def install
    libpng = Formula["libpng"]
    mysql = Formula["mysql@5.7"]

    args = ["userApps", "BINDIR=#{bin}", "SCRIPTS=#{bin}"]
    args << "MACHTYPE=#{`uname -m`.chomp}"
    args << "PNGLIB=-L#{libpng.opt_lib} -lpng -lz"
    args << "PNGINCL=-I#{libpng.opt_include}"
    args << "MYSQLINC=#{mysql.opt_include}/mysql"
    args << "MYSQLLIBS=-L#{mysql.opt_lib} -lmysqlclient -lz -lstdc++"

    cd build.head? ? "src" : "kent/src" do
      inreplace "parasol/makefile", "DESTDIR=${HOME}/bin", ""
      system "make", *args
    end

    cd bin do
      blat_bin = %w[blat faToTwoBit gfClient gfServer nibFrag pslPretty
                    pslReps pslSort twoBitInfo twoBitToFa]
      rm blat_bin
      mv "calc", "kent-tools-calc"
    end
  end

  def caveats
    <<~EOS
      The `calc` tool has been renamed to `kent-tools-calc`.

      This only installs the standalone tools located at
        http://hgdownload.cse.ucsc.edu/admin/exe/

      If you need the full UCSC Genome Browser, run:
        brew install ucsc-genome-browser

      This does not install the BLAT tools. To install BLAT:
        brew install blat
    EOS
  end

  test do
    (testpath/"test.fa").write <<~EOS
      >test
      ACTG
    EOS
    system "#{bin}/faOneRecord test.fa test > out.fa"
    compare_file "test.fa", "out.fa"
  end
end
