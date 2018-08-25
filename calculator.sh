#!/bin/bash

calculator::evaluate(){
  declare express=$*
  echo $(($*))
}
