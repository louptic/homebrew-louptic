require "language/node"

class Api < Formula
  desc "The Optic CLI"
  homepage "https://github.com/opticdev/optic"
  url "{URL}"
  sha256 "{SHASUM}"
  license "MIT"

  livecheck do
    url :stable
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)

    # Set shebang to Homebrew cellar
    puts path
    lines = IO.readlines(path)
    lines[0] = "#! #{HOMEBREW_PREFIX}/opt/node"
    puts "#{HOMEBREW_PREFIX}"
    puts "#! #{HOMEBREW_PREFIX}/opt/node"
    File.open(path, 'w') do |file|
      file.puts lines
    end

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "@useoptic/cli", shell_output("#{bin}/api --version | awk '{print $1}' ")
  end
end
