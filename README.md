# CSV Lint
This is a fork of CSV Lint to handle large files.  Instead of storing all errors/warnings in memory and waiting for the user to manipulate those lists of objects, I have chosen to immediately dump the errors/warnings to the console.

## History
I am dealing with data files that can be hundreds of megabytes in size and can't afford to store the errors.  Before implementing these changes, I couldn't lint an 88MB file due to the amount of errors it accumulated.  I'm now able to lint and redirect the streaming output to a results file.