%w{cmake}.each do |pkg|
  package pkg do
    action :install
  end
end

src_dir = "/home/vagrant/source"
bullet_dir = "#{src_dir}/bullet-android"

script "setup-bullet-android-repo" do
  interpreter "bash"
  user "vagrant"
  cwd src_dir
  code "git clone git://github.com/nonameentername/bullet-android.git"
  not_if do
    File.exists?(bullet_dir)
  end
end

bash "build-bullet-android" do
  user "vagrant"
  cwd bullet_dir
  code "./build.sh"
  environment "HOME" => "/home/vagrant"
  not_if do
    File.exists?("#{bullet_dir}/build")
  end
end

