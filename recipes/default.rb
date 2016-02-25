#
# Cookbook Name:: diff-info-service
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#include_recipe 'apt::default'
include_recipe 'diff-info-service::docker_setup'
#include_recipe 'diff-info-service::java_setup'
