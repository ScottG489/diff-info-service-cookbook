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


# TODO: This is all pretty terrible but I'll keep it until I can figure out how to do it appropriately.
# TODO: How can I read these from a file instead of having the string literal here?
# TODO: How can I read a JSON object from the result of the curl command? The fields are in different order so comparing
# TODO:         against the expected result exactly isn't the way to go.
# TODO: Additionally this isn't even parsing correctly as is.
multiline_patch = %q{diff --git a/.gitignore b/.gitignore\r\nnew file mode 100644\r\nindex 0000000..d490e8e\r\n--- /dev/null\r\n+++ b/.gitignore\r\n@@ -0,0 +1,19 @@\r\n+.*swp\r\n+.coverage\r\n+.ropeproject\r\n+\r\n+src/tasks.dat\r\n+\r\n+src/examples/taskfile\r\n+src/examples/keyfile\r\n+src/examples/taskdb\r\n+src/examples/tasks.dat\r\n+src/examples/*.pyc\r\n+\r\n+src/task/.ropeproject/\r\n+src/task/*.pyc\r\n+\r\n+src/test/.ropeproject/\r\n+src/test/taskdb\r\n+src/test/tasks.dat\r\n+src/test/*.pyc\r\ndiff --git a/task.py b/task.py\r\ndeleted file mode 100644\r\nindex 70e053b..0000000\r\n--- a/task.py\r\n+++ /dev/null\r\n@@ -1,15 +0,0 @@\r\n-import textwrap\r\n-class Task():\r\n-\tdef __init__(self, title='', notes = '', priority = int(), tags = []):\r\n-\t\tself.title = title\r\n-\t\tself.notes = notes\r\n-\t\tself.priority = priority\r\n-\t\tself.tags = tags\r\n-\r\n-\tdef __str__(self):\r\n-\t\treturn textwrap.dedent('''\\\r\n-\t\t\tTitle: %(title)s\r\n-\t\t\tNotes: %(notes)s''') % {\r\n-\t\t\t\t'title': self.title,\r\n-\t\t\t'notes': self.notes\r\n-\t\t}\r\ndiff --git a/a b/a\r\nindex 5c31be7..45cfaf4 100644\r\n--- a/a\r\n+++ b/a\r\n@@ -1,9 +1,9 @@\r\n asdf\r\n asdf\r\n-asfd\r\n fasd\r\n afsd\r\n-asfdfad\r\n+asdf\r\n+fdfad\r\n sfad\r\n sfa\r\n sd}

# TODO: This is what the result would look like for the most part but the field ordering might be different so I need
# TODO:         to figure out how to parse the resulting JSON.

expected_result = %q{[ {
  "rawDiff" : "diff --git a/.gitignore b/.gitignore\r\nnew file mode 100644\r\nindex 0000000..d490e8e\r\n--- /dev/null\r\n+++ b/.gitignore\r\n@@ -0,0 +1,19 @@\r\n+.*swp\r\n+.coverage\r\n+.ropeproject\r\n+\r\n+src/tasks.dat\r\n+\r\n+src/examples/taskfile\r\n+src/examples/keyfile\r\n+src/examples/taskdb\r\n+src/examples/tasks.dat\r\n+src/examples/*.pyc\r\n+\r\n+src/task/.ropeproject/\r\n+src/task/*.pyc\r\n+\r\n+src/test/.ropeproject/\r\n+src/test/taskdb\r\n+src/test/tasks.dat\r\n+src/test/*.pyc\r\n",
  "fromFile" : "/dev/null",
  "toFile" : ".gitignore",
  "fileStatus" : "Added",
  "mode" : "100644",
  "oldMode" : null,
  "similarityIndex" : null,
  "checksumBefore" : "0000000",
  "checksumAfter" : "d490e8e",
  "binary" : false,
  "disimilarityIndex" : null,
  "addedFile" : true,
  "copied" : false,
  "removedFile" : false,
  "renamed" : false,
  "modifiedFile" : false
}, {
  "rawDiff" : "diff --git a/task.py b/task.py\r\ndeleted file mode 100644\r\nindex 70e053b..0000000\r\n--- a/task.py\r\n+++ /dev/null\r\n@@ -1,15 +0,0 @@\r\n-import textwrap\r\n-class Task():\r\n-\tdef __init__(self, title='', notes = '', priority = int(), tags = []):\r\n-\t\tself.title = title\r\n-\t\tself.notes = notes\r\n-\t\tself.priority = priority\r\n-\t\tself.tags = tags\r\n-\r\n-\tdef __str__(self):\r\n-\t\treturn textwrap.dedent('''\\\r\n-\t\t\tTitle: %(title)s\r\n-\t\t\tNotes: %(notes)s''') % {\r\n-\t\t\t\t'title': self.title,\r\n-\t\t\t'notes': self.notes\r\n-\t\t}\r\n",
  "fromFile" : "task.py",
  "toFile" : "/dev/null",
  "fileStatus" : "Removed",
  "mode" : "100644",
  "oldMode" : null,
  "similarityIndex" : null,
  "checksumBefore" : "70e053b",
  "checksumAfter" : "0000000",
  "binary" : false,
  "disimilarityIndex" : null,
  "addedFile" : false,
  "copied" : false,
  "removedFile" : true,
  "renamed" : false,
  "modifiedFile" : false
}, {
  "rawDiff" : "diff --git a/a b/a\r\nindex 5c31be7..45cfaf4 100644\r\n--- a/a\r\n+++ b/a\r\n@@ -1,9 +1,9 @@\r\n asdf\r\n asdf\r\n-asfd\r\n fasd\r\n afsd\r\n-asfdfad\r\n+asdf\r\n+fdfad\r\n sfad\r\n sfa\r\n sd",
  "fromFile" : "a",
  "toFile" : "a",
  "fileStatus" : "Modified",
  "mode" : "100644",
  "oldMode" : null,
  "similarityIndex" : null,
  "checksumBefore" : "5c31be7",
  "checksumAfter" : "45cfaf4",
  "binary" : false,
  "disimilarityIndex" : null,
  "addedFile" : false,
  "copied" : false,
  "removedFile" : false,
  "renamed" : false,
  "modifiedFile" : true
} ]}

describe command("curl -X GET -H 'Content-Type:text/plain' --data \"#{multiline_patch}\" localhost:8080/info") do
  # TODO: Don't compare against exact result but parse JSON into an object and check field values.
  #its(:stdout) { should eq expected_result }
  # TODO: This will have to do as a check for now
  its(:stdout) { should match /rawDiff/ }
  its(:exit_status) { should eq 0 }
end

