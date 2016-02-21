#
# Cookbook Name:: diff-info-service
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt::default'

#docker_service 'default'
docker_installation 'default' do
  action :create
end
docker_service_manager_execute 'default' do
#docker_service_manager_sysvinit 'default' do
#docker_service_manager_upstart 'default' do
#docker_service_manager_systemd 'default' do
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
