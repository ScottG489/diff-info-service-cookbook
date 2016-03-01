require 'json'
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
def compare(actual_result, expected_result, field)
  expect(actual_result[0][field]).to eq(expected_result[0][field])
  expect(actual_result[1][field]).to eq(expected_result[1][field])
  expect(actual_result[2][field]).to eq(expected_result[2][field])
end