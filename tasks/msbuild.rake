namespace :msbuild do
  def _build(configuration)
    sln = Dir.glob('**/*.sln').first
    target = 'Clean;Rebuild'

    sh "MSBuild.exe #{sln} /p:Configuration=#{configuration} /target:'#{target}'"
  end

  task :release => 'nuget:restore' do
    _build 'Release'
  end

  desc 'Run MSBuild for debug configuration'
  task :debug => 'nuget:restore' do
    _build 'Debug'
  end
end

desc 'Run MSBuild for release configuration'
task :msbuild => 'msbuild:release'
