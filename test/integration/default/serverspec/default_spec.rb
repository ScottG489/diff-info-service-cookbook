require 'spec_helper'

# TODO: These are no longer relevant without docker. Move them to a separate file to save but ignore test?
=begin
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
=end

# TODO: Move to it's own test file?
describe command('curl localhost:8080') do
  its(:stdout) { should eq '{"code":404,"message":"HTTP 404 Not Found"}' }
  its(:exit_status) { should eq 0 }
end

describe command('curl localhost:8080/foo') do
  its(:stdout) { should eq '{"code":404,"message":"HTTP 404 Not Found"}' }
  its(:exit_status) { should eq 0 }
end

describe command('curl localhost:8080/info') do
  its(:stdout) { should match /{"code":500,"message":"There was an error processing your request. It has been logged \(ID [a-f0-9]{16}\)."}/ }
  its(:exit_status) { should eq 0 }
end
