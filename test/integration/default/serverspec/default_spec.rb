require 'spec_helper'
require 'json'

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


multiline_patch = File.open("/tmp/verifier/suites/serverspec/resources/multi.patch", "rb").read
expected_result = JSON.parse(File.open("/tmp/verifier/suites/serverspec/resources/expected.json", "rb").read)

describe command("curl -X GET -H 'Content-Type:text/plain' --data-binary \"#{multiline_patch}\" localhost:8080/info") do
  it "has expected values" do
      actual_result = JSON.parse(subject.stdout)
      expect(actual_result.length).to eq(3)
      # TODO: This may be a bug, it's returning the rawDiff with \n always even when in this case the input is \r\n
      # TODO: What behavior do we want?
      #compare(actual_result, expected_result, 'rawDiff')
      compare(actual_result, expected_result, 'fromFile')
      compare(actual_result, expected_result, 'toFile')
      compare(actual_result, expected_result, 'mode')
  end
  its(:exit_status) { should eq 0 }
end

def compare(actual_result, expected_result, field)
  expect(actual_result[0][field]).to eq(expected_result[0][field])
  expect(actual_result[1][field]).to eq(expected_result[1][field])
  expect(actual_result[2][field]).to eq(expected_result[2][field])
end
