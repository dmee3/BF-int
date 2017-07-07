++++ ++++ +           add 9 to cell 0
> ++++ ++++ ++++      add 12 to cell 1

[                     loop until cell 1 is 0
	> ++++ +            add 5 to cell 2
	> ++++              add 4 to cell 3
	<< -                subtract 1 from cell 1
]

>> + .                print '1' at cell 3
- .                   print '0' at cell 3

< ---                 subtract 3 from cell 2
< ++++ ++++ ++        add 10 to cell 1

<                     move to cell 0
[                     loop until cell 0 is 0
	> .                 print '\n' at cell 1
	> .                 print # at cell 2
	-                   subtract 1 from cell 2
	<< -                subtract 1 from cell 0
]

> .                   print '\n' at cell 1
< ++++ ++++           add 8 to cell 0

[                     loop until cell 0 is 0
	> ++++ +++          add 7 to cell 1
	> ++++ +++          add 7 to cell 2
	> ++++ ++           add 6 to cell 3
	> ++++ ++++ ++++ ++ add 12 to cell 4
	> ++++              add 4 to cell 5
	<<<<< -             subtract 1 from cell 0
]

> .                   print 'B' at cell 1
> ++++ .              print 'l' at cell 2
> + .                 print 'a' at cell 3
> +++ .               print 's' at cell 4
+ .                   print 't' at cell 4
> .                   print ' ' at cell 5
<<< +++ .             print 'o' at cell 2
> ++++ + ..           print 'ff' at cell 3
>> + .                print '!' at cell 5
> ++++ ++++ ++        print '\n' at cell 6
