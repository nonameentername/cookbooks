%w{libbz2-dev}.each do |pkg|
  #chef could not install lib32z-dev ia32-libs
  package pkg do
    action :install
  end
end

script "setup-python-android-repo" do
  interpreter "bash"
  user "vagrant"
  cwd "/home/vagrant/source"
  code "git clone git://github.com/nonameentername/python-android.git"
end

script "bootstrap-python-android" do
  interpreter "bash"
  user "vagrant"
  cwd "/home/vagrant/source/python-android"
  code "./bootstrap.sh"
end
