#!/usr/bin/env bats

@test "httpie::get" {
    http -v --check-status http://httpbin.org/get
    [ $? = 0 ]
}

@test "httpie::post" {
    echo {} | http -v --check-status http://httpbin.org/post
    [ $? = 0 ]
}
