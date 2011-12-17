%w{git-core gnupg flex bison gperf build-essential
zip curl zlib1g-dev libc6-dev lib32ncurses5-dev
x11proto-core-dev libx11-dev lib32readline5-dev
libgl1-mesa-dev g++-multilib mingw32 tofrodos python-markdown
libxml2-utils python-pip wget}.each do |pkg|
  #chef could not install lib32z-dev ia32-libs
  package pkg do
    action :install
  end
end

script "install-lib32z-dev" do
  interpreter "bash"
  user "root"
  code "
    apt-get install -y lib32z-dev
  "
end

script "setup-android-ndk" do
  interpreter "bash"
  user "vagrant"
  cwd "/tmp"
  code "
    wget http://dl.google.com/android/ndk/android-ndk-r7-linux-x86.tar.bz2
    tar jxvf android-ndk-r7-linux-x86.tar.bz2
    mkdir -p /home/vagrant/source
    mv android-ndk-r7 /home/vagrant/source/android-ndk
  "
end
