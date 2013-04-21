require 'open3'
require 'edn'

$choices = EDN.read(STDIN.read)
$keys = $choices.keys

Open3.popen2("dmenu") {|stdin, stdout, wait_thr|
  stdin.write($keys.join("\n"))
  stdin.close_write
  command = $choices[stdout.read.strip]
  exec(command) if fork.nil?
}