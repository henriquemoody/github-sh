Github Shell (php version)
==========================
Its a implementation of github services into terminal.
------------------------------------------------------

At this time the project have:

   * the structure to support GitHub Api (v3).
   *  hello
   *  exit|tchau
   * set session data
      * set username [githubusername]
      * set project  [projectname]
	  * set branch   [branchname]
   * get session data
      * get username
      * get project
	  * get branch
   * issue [id]
      * this show single data about one issue.
   * history
      * we use readline to get history in session and between it(hello->tchau->hello)

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
	
	- Validate Data Provided for a action and if haven't the necessary
		request using readline.			
	
	- create a Class to implement History
		need rotate lines.
		need auto-complete/ suggests
		need handle with readline_list_history not exists(not compiled)

	- use session branch data to handle with branchs on github.
		and make it part of prompt.

		
How to Use
==========
	Clone the project
	change branch to php-version
	pull the files.
	verify if php path is right in github-sh.php
	verify if github-sh.php is execlutable
	run ./github-sh.php and your have a prompt
	github>
	github>set username henriquemoody
	github/henriquemoody>set project github-sh 
	github/henriquemoody/github-sh> hello
	github/henriquemoody/github-sh> tchau

	yes, its small things but we are working to add more commands soon.

	cheers.



related Gists
=============
* issue / issues (how it will work) https://gist.github.com/3190502

