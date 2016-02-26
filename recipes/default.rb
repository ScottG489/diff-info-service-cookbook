#
# Cookbook Name:: diff-info-service
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#include_recipe 'apt::default'
# TODO: Since CI currently can't run the docker recipe for unknown reasons this is necessary
if node['diff-info-service']['CI'] == 'true'
    puts 'CI ENV DETECTED, USING JAVA SETUP RECIPE'
    puts "CI is: '#{node['diff-info-service']['CI']}'"
    include_recipe 'diff-info-service::java_setup'
else
    puts 'NON-CI ENV DETECTED, USING DOCKER SETUP RECIPE'
    puts "CI is: '#{node['diff-info-service']['CI']}'"
    include_recipe 'diff-info-service::docker_setup'
end
