src_dir = node[:settings][:src_dir]
pybullet_dir = "#{src_dir}/pybullet-android"

script "setup-pybullet-android-repo" do
  interpreter "bash"
  user node[:settings][:user]
  cwd src_dir
  code "git clone git://github.com/nonameentername/pybullet-android.git"
  not_if do
    File.exists?(pybullet_dir)
  end
end

bash "build-pybullet-android" do
  user node[:settings][:user]
  cwd pybullet_dir
  code "./build.sh"
  environment "HOME" => "/home/#{node[:settings][:user]}"
end
