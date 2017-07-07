,                 read into cell 0
.                 print value from cell 0
> ,               read into cell 1
> ++++ ++++ ++    put '\n' into cell 2
.                 print '\n' from cell 2
< .               print value from cell 1

[                 loop until cell 1 is 0
	-               subtract 1 from cell 1
	< +             add 1 to cell 0
	>               move to cell 1
]

> .               print '\n' at cell 2
<< .              print sum at cell 0
