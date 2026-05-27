require "digest"

class ClFilerTools < Formula
  desc "Symlinks for CL filer-resident tools under /anfs/www/tools/bin"
  homepage "https://www.cst.cam.ac.uk/local/sys/web/tools"

  url     "file://#{File.expand_path(__FILE__)}"
  sha256  Digest::SHA256.file(File.expand_path(__FILE__)).hexdigest
  version IO.popen(
            ["git", "-C", File.dirname(__FILE__), "log", "-1",
             "--format=%cd", "--date=format:%Y%m%d",
             "--", File.basename(__FILE__)], &:read
          ).strip

  TOOLS = %w[
    cl-web-view
    cl-web-checkout
    filerpath
  ].freeze

  def install
    TOOLS.each do |t|
      bin.install_symlink "/anfs/www/tools/bin/#{t}"
    end
  end

  def caveats
    <<~EOS
      This package installs symbolic links to tools that are only
      available while /anfs/www/ is mounted from the
      departmental filer.
    EOS
  end

  test do
    TOOLS.each { |t| assert_predicate bin/t, :symlink? }
  end
end
