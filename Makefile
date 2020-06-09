bats:
	bats .

# Shell variable: Always use $$ escape $ so that make won't try to expend VAR

# VAR=new-text make sed
sed:
	sed -e "s!TEXT_TO_REPLACE!$${VAR}!g" text
sed-inplace:
	sed -i '' -e  "s!TEXT_TO_REPLACE!$${VAR}!g" text

# Shell parameter extension
# VAR=one-one-two-three make variable
variable:
	echo $${VAR}
	echo $${VAR#*-}
