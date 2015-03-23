nuget = "nuget"
package_dir = "packages"

namespace :nuget do
  desc "Removes installed NuGet packages"
  task :clean do
    rm_rf package_dir
  end

  desc "Installs NuGet dependencies"
  task :restore do
    sh "#{nuget} restore ."
  end

  task :pack => :build do
    # FIXME: Un-hardcode this
    dir = File.dirname Dir.glob('*/*.nuspec').first
    csproj = Dir.glob("#{dir}/*.csproj").first
    sh "#{nuget} pack #{csproj} -Prop Configuration=Release"
  end
end

desc "Builds a NuGet package"
task :nuget => 'nuget:pack'

