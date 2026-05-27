class Ucampas < Formula
  desc "University of Cambridge web page augmentation system"
  homepage "https://www.cl.cam.ac.uk/local/sys/web/ucampas/"
  url "https://www.cl.cam.ac.uk/~mgk25/download/ucampas-20260316.tar.gz"
  version "20260316"
  sha256 "dd7852b569966ab7f883868d8b1aecd45cf4fb718820dfea98fcca5f831d389e" # paste output of `make distribution`

  # The ucampas script locates its bundled Perl modules and templates
  # via FindBin by substituting /bin -> /share/ucampas in $RealBin, so
  # the bin/ and share/ucampas/ layout below is required.
  def install
    bin.install %w[
      ucampas
      ucampas-clean
      ucampas-find
      ucampas-gitignore
      ucampas-grep
      ucampas-navtest
      ucampas-svnignore
      ucampas-syntaxcheck
      ucampas-xargs
    ]
    pkgshare.install "NavTree.pm", "perl-PlexTree", "templates"
  end

  test do
    assert_match "ucampas", shell_output("#{bin}/ucampas --help 2>&1")
  end
end
