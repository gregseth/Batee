Batee
=====

A full-batch tee implementation
	
History
-------

This script is originally [an answer][1] to a [StackOverflow][2] question about
finding a Windows native alternative to the GNU `tee` command.


Usage
-----

    dir | batee output.txt

	
The above will overwrite any existing `output.txt`.

Content can be appended to an existing file by adding a + second argument.

    dir | batee output.txt +



 [1]: http://stackoverflow.com/questions/11239924/windows-batch-tee-command/21841567?iemail=1&noredirect=1#21841567
 [2]: http://stackoverflow.com
 