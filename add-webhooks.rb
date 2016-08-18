#!/usr/bin/env ruby
#
# Copyright (C) 2015  Kouhei Sutou <kou@cozmixng.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "octokit"

available_content_type = %w{json form}

unless ARGV.size == 3
  $stderr.puts("#{$0} USER WEBHOOK_URL CONTENT_TYPE")
  $stderr.puts("  Available values for CONTENT_TYPE: #{available_content_type.join(", ")}")
  exit(false)
end

user = ARGV.shift
webhook_url = ARGV.shift
content_type = ARGV.shift

unless available_content_type.include?(content_type)
  $stderr.puts("Unsupported content type: #{content_type}")
  exit(false)
end

webhook_name = "web"
webhook_config = {
  :url          => webhook_url,
  :content_type => content_type,
}
webhook_options = {
#  :events => ["push"],
#  :active => true,
}

github_token = ENV["GITHUB_TOKEN"]
if github_token.nil?
  $stderr.puts("GITHUB_TOKEN environment variable isn't set")
  exit(false)
end

client = Octokit::Client.new(:access_token => github_token)
client.auto_paginate = true

client.repositories(user).each do |repository|
  already_exist = client.hooks(repository.full_name).any? do |hook|
    hook.config.url == webhook_url
  end
  if already_exist
    puts("Already exist at #{repository.full_name}")
    next
  end
  puts("Creating a webhook at #{repository.full_name}...")
  client.create_hook(repository.full_name, webhook_name, webhook_config, webhook_options)
end
