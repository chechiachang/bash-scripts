#!/usr/bin/env bats

source http.sh

@test "httpie::get" {
    httpie::get http://httpbin.org/get
    [ $? = 0 ]
}

@test "httpie::post" {
    httpie::post http://httpbin.org/post {}
    [ $? = 0 ]
}
