# String manipulation

STRING=one-one-two-three

echo ${STRING/one/1} # Replace first occurance
echo ${STRING//one/1} # Replace all

# Shell parameter
# https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion

echo ${STRING:-one}

# Remove string before

echo ${STRING#one} # does non-greedy match from left, use ## for greediness
#-one-two-three
echo ${STRING#*one} # matches and discards upto first 'one' from variable
#-two-three
echo ${STRING##one} # does non-greedy match from left, use ## for greediness
#-two-three

# Remove string after

echo ${STRING%one} # does non-greedy match from left, use ## for greediness
echo ${STRING%%one} # does non-greedy match from left, use ## for greediness
echo ${STRING%*one} # matches and discards upto first 'one' from variable
