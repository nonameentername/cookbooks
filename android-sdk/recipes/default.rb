%w{openjdk-6-jre openjdk-6-jdk}.each do |pkg|
  package pkg do
    action :install
  end
end

src_dir = "/home/vagrant/source"

script "setup-android-sdk" do
  interpreter "bash"
  user "vagrant"
  cwd "/tmp"
  code "
    wget http://dl.google.com/android/android-sdk_r16-linux.tgz
    tar zxvf android-sdk_r16-linux.tgz
    mkdir -p #{src_dir}
    mv android-sdk-linux #{src_dir}/android-sdk
    #{src_dir}/android-sdk/tools/android update sdk -u -t platform-tool
  "
  not_if do
    File.exists?("#{src_dir}/android-sdk")
  end
end

execute "add-platform-tools-bash_aliases" do
  user "vagrant"
  path = "#{src_dir}/android-sdk/tools:#{src_dir}/android-sdk/platform-tools"
  command "echo \"export PATH=#{path}:\\$PATH\" >> /home/vagrant/.bash_aliases"
  not_if "grep platform-tools /home/vagrant/.bash_aliases"
end

=begin
android list targets
android create avd -n <name> -t <target_id>
emulator -avd <name> -no-window &
=end
