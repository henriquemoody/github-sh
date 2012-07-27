Github Shell
============
Its a implementation of github services into terminal.
At this time the project have:
	- the structure to support GitHub Api (v3).
	- hello
	- exit|tchau
	- set session data
		set username [githubusername]
		set project  [projectname]
	- get session data
		get username
		get project

TODO
====
	- Error handler for API Client requests
		We have no error handler for cases when request Api fail

	- Response Object
		All responses are made directly and its dificulty to manage
			with a response object we can organize the presentation.

	- Presentation Objects
		The presentation Object with allow the terminal to show
			data in any formats including grids for watch information.

	- implement the command watch
		This command allow user to watch some commands exacly watch do in bash
	
	- local commands
		The Idea is setting a local repo for reference and permit basic git commands
			like:
				- git log
				- git pull
				- git push
				- git status
				- git commit
			

PHP Version.
