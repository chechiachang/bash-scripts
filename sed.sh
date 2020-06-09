# Remove string before :
# .* is greedy (include ':' and '*') so it will match up to last ':'
echo 'abcdefg:*:123456789:john.doe' | sed 's/.*://'
