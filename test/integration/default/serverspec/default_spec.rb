require 'spec_helper'

describe command('docker -v') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /Docker version.*/ }
end

describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end

describe docker_image('diff-info-service') do
  it { should exist }
  its(['State.Status']) { should eq 'running' }
  its(['State.Running']) { should eq true }
end

describe port(8080) do
  it { should be_listening }
end

describe command('curl localhost:8080') do
  its(:stdout) { should eq '{"code":404,"message":"HTTP 404 Not Found"}' }
  its(:exit_status) { should eq 0 }
end
