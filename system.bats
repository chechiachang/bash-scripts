#!/usr/bin/env bats

source system.sh

@test "system::get_os" {
    system::get_os 
    [ $? = 0 ]
}

@test "system::get_machine" {
    system::get_machine
    [ $? = 0 ]
}

@test "system::check_command" {
    system::check_command echo
    [ $? = 0 ]
}
