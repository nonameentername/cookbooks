script "setup-python-android-repo" do
  interpreter "bash"
  user "vagrant"
  cwd "/home/vagrant/source"
  code "
    git clone git://github.com/nonameentername/python-android.git
  "
end

script "bootstrap-python-android" do
  interpreter "bash"
  user "vagrant"
  cwd "/home/vagrant/source/python-android"
  code "
    ./bootstrap.sh
  "
end
