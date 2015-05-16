++++ ++++			add 8 to cell 0

[					loop until cell 0 is 0
	> ++++			add 4 to cell 1

	[				loop until cell 1 is 0
		> ++		add 2 to cell 2
		> +++		add 3 to cell 3
		> +++		add 3 to cell 4
		> +			add 1 to cell 5
		<<<< -		subtract 1 from cell 1
	]

	> +				add 1 to cell 2
	> +				add 1 to cell 3
	> -				subtract 1 from cell 4
	>> +			add 1 to cell 6

	[ < ]			move to cell 1

	< -				subtract 1 from cell 0
]

>> .				print 'H' at cell 2
> --- .				print 'e' at cell 3
++++ +++ ..			print 'll' at cell 3
+++ .				print 'o' at cell 3
>> .				print ' ' at cell 5
< - .				print 'W' at cell 4
< .					print 'o' at cell 3
+++ .				print 'r' at cell 3
---- -- .			print 'l' at cell 3
---- ---- .			print 'd' at cell 3
>> + .				print '!' at cell 5
> ++ .				print '\n' at cell 6
