%w{git-core gnupg flex bison gperf build-essential
  zip curl zlib1g-dev libc6-dev lib32ncurses5-dev ia32-libs
  x11proto-core-dev libx11-dev lib32readline6-dev
  libgl1-mesa-dev g++-multilib mingw32 tofrodos python-markdown
  libxml2-utils xsltproc}.each do |pkg|
  package pkg do
    action :install
  end
end

script "install-lib32z-dev" do
  interpreter "bash"
  user "root"
  code "apt-get install -y lib32z-dev"
end

src_dir = node[:settings][:src_dir]

script "setup-android-ndk" do
  interpreter "bash"
  user node[:settings][:user]
  cwd "/tmp"
  code "
    wget http://dl.google.com/android/ndk/android-ndk-r7-linux-x86.tar.bz2
    tar jxvf android-ndk-r7-linux-x86.tar.bz2
    mkdir -p #{src_dir}
    mv android-ndk-r7 #{src_dir}/android-ndk
  "
  not_if do
    File.exists?("#{src_dir}/android-ndk")
  end
end
