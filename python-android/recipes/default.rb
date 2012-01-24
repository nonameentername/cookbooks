%w{libbz2-dev}.each do |pkg|
  #chef could not install lib32z-dev ia32-libs
  package pkg do
    action :install
  end
end

src_dir = node[:settings][:src_dir]
python_dir = "#{src_dir}/python-android"

script "setup-python-android-repo" do
  interpreter "bash"
  user node[:settings][:user]
  cwd src_dir
  code "git clone git://github.com/nonameentername/python-android.git"
  not_if do
    File.exists?(python_dir)
  end
end

script "bootstrap-python-android" do
  interpreter "bash"
  user node[:settings][:user]
  cwd python_dir
  code "./bootstrap.sh"
  not_if do
    File.exists?("#{python_dir}/prebuilt")
  end
end

bash "build-python-android" do
  user node[:settings][:user]
  cwd python_dir
  code "./build.sh"
  environment "HOME" => "/home/#{node[:settings][:user]}"
  not_if do
    File.exists?("#{python_dir}/build")
  end
end

execute "add-virtualenv-bash_aliases" do
  user node[:settings][:user]
  virtualenv_str = "cd #{python_dir} && source virtualenv.sh && cd /home/#{node[:settings][:user]}"
  command "echo \"#{virtualenv_str}\" >> /home/#{node[:settings][:user]}/.bash_aliases"
  not_if "grep virtualenv.sh /home/#{node[:settings][:user]}/.bash_aliases"
end
