def os
  case RUBY_PLATFORM
  when 'x86_64-darwin16'
    'osx'
  else
    raise "unsupported platform #{RUBY_PLATFORM}"
  end
end

out = directory("out")
desc "build for #{os}"
task :build => [out] do
  sh "dub build"
  sh "rm -f #{out}/tools-in-d-#{os}"
  sh "cp tools-in-d #{out}/tools-in-d-#{os}"
end

task :default => [:build]
