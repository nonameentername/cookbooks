src_dir = "/home/vagrant/source"
irrlicht_dir = "#{src_dir}/irrlicht-android"
pyirrlicht_dir = "#{src_dir}/pyirrlicht-android"

script "setup-pyirrlicht-android-repo" do
  interpreter "bash"
  user "vagrant"
  cwd src_dir
  code "git clone git://github.com/nonameentername/irrlicht-android.git"
  not_if do
    File.exists?(irrlicht_dir)
  end
end

script "setup-pyirrlicht-android-repo" do
  interpreter "bash"
  user "vagrant"
  cwd src_dir
  code "git clone git://github.com/nonameentername/pyirrlicht-android.git"
  not_if do
    File.exists?(pyirrlicht_dir)
  end
end

bash "build-pyirrlicht-android" do
  user "vagrant"
  cwd pyirrlicht_dir
  code "./build.sh"
  environment "HOME" => "/home/vagrant"
end
