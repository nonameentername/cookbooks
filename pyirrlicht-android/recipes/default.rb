src_dir = node[:settings][:src_dir]
irrlicht_dir = "#{src_dir}/irrlicht-android"
pyirrlicht_dir = "#{src_dir}/pyirrlicht-android"

script "setup-pyirrlicht-android-repo" do
  interpreter "bash"
  user node[:settings][:user]
  cwd src_dir
  code "git clone git://github.com/nonameentername/irrlicht-android.git"
  not_if do
    File.exists?(irrlicht_dir)
  end
end

script "setup-pyirrlicht-android-repo" do
  interpreter "bash"
  user node[:settings][:user]
  cwd src_dir
  code "git clone git://github.com/nonameentername/pyirrlicht-android.git"
  not_if do
    File.exists?(pyirrlicht_dir)
  end
end

bash "build-pyirrlicht-android" do
  user node[:settings][:user]
  cwd pyirrlicht_dir
  code "./build.sh"
  environment "HOME" => "/home/#{node[:settings][:user]}"
end
