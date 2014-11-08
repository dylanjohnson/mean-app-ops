#!/usr/bin/env bats

@test "mongo is found in PATH" {
  run which mongod
  [ "$status" -eq 0 ]
}

@test "mongo is running" {
  result=$(ps aux | grep mongod|wc -l)
  [ "$result" -eq 1 ]
}