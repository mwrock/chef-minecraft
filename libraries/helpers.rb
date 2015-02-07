#
# Cookbook Name:: minecraft
# Libraries:: helpers
#
# Copyright (c) 2014, Greg Fitzgerald <greg@gregf.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

def minecraft_file_format
  uses_json ? "json" : "txt"
end

def minecraft_server_files
  if uses_json
    %w(ops banned-ips banned-players whitelist).each
  else
    %w(ops banned-ips banned-players white-list).each
  end
end

def uses_json
  node['minecraft']['version'] && node['minecraft']['version'] < '1.7.9'
end

def minecraft_file(uri)
  require 'pathname'
  require 'uri'
  Pathname.new(URI.parse(uri).path).basename.to_s
end

def total_memory
  if node['platform_family'] == 'windows'
    wmi = ::WIN32OLE.connect("winmgmts://")
    res = wmi.ExecQuery("select Capacity from Win32_PhysicalMemory")
    mem = res.each.next.capacity
    mem.to_i / 1024
  else
    node['memory']['total'].to_i
  end
end