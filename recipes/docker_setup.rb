#
# Cookbook Name:: diff-info-service
# Recipe:: docker_setup
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# TODO: Nested docker not working on CI. This is a nice to have but for the sake of getting builds working on CI
# TODO:         I'm going to forego this and just work with the jar directly.
#docker_service 'default'

docker_installation 'default' do
  action :create
end
docker_service_manager_execute 'default' do
  action :start
end

docker_image 'diff-info-service' do
  repo 'scottg489/diff-info-service'
  action [:pull]
end
docker_container 'diff-info-service' do
  repo 'scottg489/diff-info-service'
  port '8080:8080'
  action [:stop, :delete, :run]
end
