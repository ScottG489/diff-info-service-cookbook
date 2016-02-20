#
# Cookbook Name:: diff-info-service
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt::default'

docker_service 'default'

docker_image 'diff-info-service' do
  repo 'scottg489/diff-info-service'
  action [:pull]
end
docker_container 'diff-info-service' do
  repo 'scottg489/diff-info-service'
  port '8080:8080'
  action [:stop, :delete, :run]
end
