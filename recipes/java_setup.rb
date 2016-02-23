#
# Cookbook Name:: diff-info-service
# Recipe:: java_setup
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'java::default'

directory '/opt/diff-info-service'

remote_file '/opt/diff-info-service/diff-info-service.jar' do
  source 'https://oss.jfrog.org/artifactory/repo/com/github/scottg489/diff-info-service/%5BRELEASE%5D/diff-info-service-%5BRELEASE%5D-capsule.jar'
end

#poise_service 'diff-info-service' do
#  command 'java -jar diff-info-service.jar server'
#  directory '/opt/diff-info-service'
#end

execute 'runit' do
  command 'java -jar /opt/diff-info-service.jar server &'
end
