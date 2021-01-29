require "language/node"

class Api < Formula
  desc "The Optic CLI"
  homepage "https://github.com/opticdev/optic"
  url "https://registry.npmjs.org/@useoptic/cli/-/cli-9.0.7.tgz"
  sha256 "783cd8baadb65e81df821e47723c4f2446fb12f4fe6141341c3acb606c6d28ec"
  license "MIT"

  livecheck do
    url :stable
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)

    # Set shebang to Homebrew cellar
    cellar_location = shell_output("brew --prefix node").strip
    puts path
    lines = IO.readlines(path)
    lines[0] = "#! #{cellar_location}/bin/node"
    puts "#{HOMEBREW_PREFIX}"
    puts "#! #{cellar_location}/bin/node"
    File.open(path, 'w') do |file|
      file.puts lines
    end

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "@useoptic/cli", shell_output("#{bin}/api --version | awk '{print $1}' ")
  end
end
