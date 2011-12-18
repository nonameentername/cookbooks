execute "update-apt" do
    command "sudo apt-get clean; sudo apt-get update"
end

%w{vim git-core subversion mercurial}.each do |pkg|
  package pkg do
    action :install
  end
end
