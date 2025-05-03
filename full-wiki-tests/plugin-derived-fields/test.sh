#!/bin/bash

# extract the foo tiddler from our example plugin, and get its modified field with second-level precision
got_modified_time=$(../../tiddlywiki.js ++example-plugin/ . --rendertiddler '$:/core/templates/exporters/JsonFile' /dev/stdout text/plain '' exportFilter '$:/plugins/hoelzro/example-plugin/foo' | jq -r '.[].modified | .[:-3]')

# get the mtime of the underlying file for the foo tiddler
expected_modified_time=$(date -u -d @$(stat -c %Y example-plugin/foo.tid) +'%Y%m%d%H%M%S')

if [[ $got_modified_time != $expected_modified_time ]] ; then
  echo "modified field in plugin tiddler foo didn't match expectations" >&2
  echo "" >&2
  echo "got:      $got_modified_time" >&2
  echo "expected: $expected_modified_time" >&2
  exit 1
fi
