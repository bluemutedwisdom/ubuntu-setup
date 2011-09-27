#!/usr/bin/env ruby

require 'find'
require 'yaml'

archives = [
            {
              'name' => 'ubuntu',
              'link' => 'http://archive.ubuntu.com/ubuntu/',
            },
           ]

begin
  File.open('update-sources.yml') do |fd|
    archives = YAML::load(fd)
  end
rescue
  nil
end

Find.find('/etc/apt') do |name|
  next if !name.match(/\.list\Z/)
  contents = nil
  File.open(name, 'r') do |fd|
    contents = fd.read
    archives.each do |archive|
      contents = contents.gsub("@#{archive['name']}@", archive['link'])
    end
  end
  File.open(name, 'w') do |fd|
    fd.puts contents
  end
end

# Local Variables:
# indent-tabs-mode: nil
# End:
# vim: ai et sw=2 ts=2
