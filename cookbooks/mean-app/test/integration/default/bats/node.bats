#!/usr/bin/env bats

@test "node is found in PATH" {
  run which node
  [ "$status" -eq 0 ]
}

@test "npm is found in PATH" {
  run which npm
  [ "$status" -eq 0 ]
}