# spec/spec_helper.rbを読み込む
require 'spec_helper'

# Gitがインストールされていること
describe package('git') do
  it { should be_installed }
end

# rbenvがインストールされていること
describe file('/home/kohei/.rbenv') do
  it { should exist}
  it { should be_directory }
end

# ruby-buildがインストールされていること
describe file('/home/kohei/.rbenv/plugins/ruby-build') do
  it { should exist}
  it { should be_directory }
end

# Rubyのインストールに必要なパッケージがインストールされていること
%w{gcc
   gcc-c++
   bzip2 
   openssl-devel 
   libyaml-devel 
   libffi-devel 
   readline-devel 
   zlib-devel 
   gdbm-devel 
   ncurses-devel}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# Ruby2.4.5がインストールされていること
describe command('ruby -v') do
  its(:stdout) { should match /ruby 2\.4\.5+/ }
end

# Node.jsがインストールされていること
describe command('node -v') do
  its(:stdout) { should match /v14\.11\.0/ }
end

# Yarnがインストールされていること
describe command('yarn -v') do
  its(:stdout) { should match /1\.22\.5/ }
end

# Rails5.2.2がインストールされていること
describe package('rails') do
  it { should be_installed.by('gem').with_version('5.2.2') }
end

# MySQL関連のパッケージがインストールされていること
%w{mysql-community-client
   mysql-community-common 
   mysql-community-devel 
   mysql-community-libs 
   mysql-community-server 
   mysql57-community-release}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

# nginxがインストールされていること
describe package('nginx') do
  it { should be_installed }
end

# nginxが自動起動かつ起動していること
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

# TCPの80番ポートがリッスン状態になっていること
describe port(80) do
  it { should be_listening.with('tcp') }
end

# Pumaでソケット通信されていること
describe file('/var/www/rails/udemy-rails-kj/tmp/sockets/puma.sock') do
  it { should be_socket }
end