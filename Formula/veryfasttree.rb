class Veryfasttree < Formula
  desc "Efficient phylogenetic tree inference for massive taxonomic datasets"
  homepage "https://github.com/citiususc/veryfasttree"
  url "https://github.com/citiususc/veryfasttree/archive/refs/tags/v4.0.3.tar.gz"
  sha256 "770e41773806c65e60ebc77363beccf40e3d339affd97c07eb7b2e1acb51af60"
  license "GPL-3.0-only"
  head "https://github.com/citiususc/veryfasttree.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/brewsci/bio"
    sha256 cellar: :any,                 arm64_sonoma: "9fd027b60078be523d5606f10aa80a58ba2de5dd4d286de2aa80e7a6668ca446"
    sha256 cellar: :any,                 ventura:      "2fb6eff6d23a315dc56f4e9bb0102cecff3243c3b3a39b27e7c600699b9a00e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e1aab8ce49030994171374cf3907d420d9ef9e0082461ce27ffc509af011c514"
  end

  depends_on "cmake" => :build

  on_macos do
    depends_on "libomp"
  end

  def install
    system "cmake", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.fasta").write(">N3289
--RNRSCRRDNTNGQDLQAALAIFAAKVYVGVALQSVQVAAGIGKHPVYKHIPSKKYTGL
IIQELYLERLMAELADGLADAAPDVLLDIRGLMLALDAPAREKPIIL-LHLAASAGDALR
DKGQALRRELLPRLSGLGYAGLASGALTGDNATLMSARLIGLLVSATLLAL---------
-----------------
>N1763
------ISKDTTEERFLEVDKLTFAPKSYAGTLQTKILSAVSVPAGTLYKDFPTTELALL
VTLEVYQATDTSGAQDGLAANARDILHVLVELFLALAGFAAQDPLHLLLPMAAALTSSLR
GRLRELRRELLAKGAAKVYTGLGAADATGDGVQLGAASLAMQLLGALLPCLRLDALLGSL
ASGLPEEKLASLAIFL-
>N2100
--RGRARPKQTTAESNLDATMGKFASQEYDGTMHRELGAASGVSLGTLYPDYPTWEMLIL
VTLESYLEPVVSALYAGLATDAPDILQR-LQLFLALLGFAMNHPGALLKSLAATLESELC
GKLKALTREVLEKLGASVFEGLPEPTLTGDEATPMSAALLMPLVQALLLCLLLQPLLAKH
SDDLPQIILAIYGIF--
>N774
--RGRRRTKTIVSEKDLSATMGRFAEQPYDGSLERNAATAASAPLNTMYGEFPTQDMFLL
MCLESYLIPTVLEADAE-ATEARDVLRRRLQLFLALLGFALNHPTQLLKMLATTLHKALR
GKIKDLQREVFARLTASAPAGLAAQFLTGDNATLMEAVLLMPFLAALLSCLILEPLDRKF
ADDFPAVILAIYAIF--
>N211
--KARGRTTIETGEKVLTGEMDRFAELQYDGSLQRDDTTGAAPPLGTLYGKLPTQDMFLL
FALESYLDPGTPELGQGLATKAPDGLRKRLHLFLGLLSFSLDHPVHLLKSLATT-HKAVR
GKVKDLQRDRFARLNASAPSGIAHPALTGDMATLMEAGLLMPLLAALLPILILAPLDKKY
AHDNHNDILAIYAIFLT
>N747
MGKARGITTAYAYSQVLIGRLGAHAALPYNGSLERKDVAALDAPTNKLYGQFPDGDSWLL
GALEAYIHTCPPELPQSLATQAPETIFTRLQPYLGLADFGLAHPGQLLKIEATKLQRAVR
GKFKELQKDAPAQLTANGITVVGQPNLTGDLGTLSEAVVLLQLVPSLLAAIIFKPIDKKY
GESAPVGILLPFSVW--
>N952
MGRGRARTTVEAGEKVLLGTMIRFAELPHDGSLQRNDSTALAAPLNTLYAKFPTQDMFLL
FALESYLHPSSPELGMGLATPAPDILRKRLALFLGLLSFSLEHPIQLLKSLATT-HKAVR
GPFKDLQKDVPAHLTATAPSGIAHPALTGDMATLMEAVLLMPLLAALLPVLVLKPLDKKF
ADDSPGDILAVYAIF--
>N3964
------RTTVEDNDKVLNATMDRFADLPYDGSLQRDDTTAQTAPLGTLYGKFPTADMFLL
NALESYLDPKRPELGQGLATKAPDALRKKLQLFLGLLAFALSHPNRLLKSLATT-HKLVR
GKLKDQEREIFARLTASAPPAIAHPALTGDMATLMEAVLLMPLLAALLTVLPLEPLDKAY
EDDSPGDILAVYAVF--
>N3613
LGRGMARTTVEDLETVLNATMDRFAQLPYDGSLQRDDTTAASAPLGTLYGKSPTADMFLQ
FALESYLDPKRPELGQGLATKAPDALRKRLQLYLGLLSFALEHPTPLLQSLATTLHK-VR
GKLKNLQREVFARLTASAASGIAHPALTGDMATLMDAVLLMPLLAKLLTIIILEPLDKKY
SDNSPDDILAAYAAFLS
>N1689
MKLGRYRTVQTANEKYLETTAGRYADQNYAGTAQRGVQKANSVPLGTLYPDLPTRDMLLL
VSLESYLESITAGL-AGLATKAVTLFKVVLVLFLSVTGFALSHPGELFLSMAAVLQTEIR
GKLKNLTRELLQKLSASLTAGLAVPELTGDEASLGAGKILVPLLAALLVALLLSPLLGGF
SDDLPNMVLAIYAVTL-
>N3700
MKMGRPRTKQSTSQRYLDTAGARYDDQAYAGTLQRGLGNAKGVPLGTLYLDFPIRDMLLL
VTLESYLESIVAGLYA-GATKAPNLLQAVLILFLNVVGFALLHPGALLLTMAAVLHNELI
GKLKEFSRELLERLAASVITGLAVPELTGDEGTLAAGVILMALLAALLLYLLLDPLLSGF
SGDLPDSGLAVHA----")
    system bin/"VeryFastTree", "test.fasta"
  end
end