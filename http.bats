#!/usr/bin/env bats

source http.sh

@test "httpie::get" {
    httpie::get http://httpbin.org/get
    [ $? = 0 ]
}

@test "httpie::post" {
    echo {} | httpie http://httpbin.org/post
    [ $? = 0 ]
}
