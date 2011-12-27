src_dir = "/home/vagrant/source"
pybullet_dir = "#{src_dir}/pybullet-android"

script "setup-pybullet-android-repo" do
  interpreter "bash"
  user "vagrant"
  cwd src_dir
  code "git clone git://github.com/nonameentername/pybullet-android.git"
  not_if do
    File.exists?(pybullet_dir)
  end
end

bash "build-pybullet-android" do
  user "vagrant"
  cwd pybullet_dir
  code "./build.sh"
  environment "HOME" => "/home/vagrant"
end
