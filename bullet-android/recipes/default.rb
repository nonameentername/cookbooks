%w{cmake}.each do |pkg|
  package pkg do
    action :install
  end
end

src_dir = node[:settings][:src_dir]
bullet_dir = "#{src_dir}/bullet-android"

script "setup-bullet-android-repo" do
  interpreter "bash"
  user node[:settings][:user]
  cwd src_dir
  code "git clone git://github.com/nonameentername/bullet-android.git"
  not_if do
    File.exists?(bullet_dir)
  end
end

bash "build-bullet-android" do
  user node[:settings][:user]
  cwd bullet_dir
  code "./build.sh"
  environment "HOME" => "/home/#{node[:settings][:user]}"
  not_if do
    File.exists?("#{bullet_dir}/build")
  end
end

