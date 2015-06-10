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

if ARGV.size != 2
  $stderr.puts("#{$0} USER_OR_ORGANIZATION WEBHOOK_URL")
  exit(false)
end

user = ARGV.shift
webhook_url = ARGV.shift

github_token = ENV["GITHUB_TOKEN"]
if github_token.nil?
  $stderr.puts("GITHUB_TOKEN environment variable isn't set")
  exit(false)
end

client = Octokit::Client.new(:access_token => github_token)
client.auto_paginate = true

client.repositories(user).each do |repository|
  client.hooks(repository.full_name).each do |hook|
    next unless hook.config.url == webhook_url
    puts("Remove a webhook: #{hook.id} at #{repository.full_name}")
    client.remove_hook(repository.full_name, hook.id)
  end
end
