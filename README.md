alchemist-server
================

welcome!
--------

`alchemist` is a sandbox that uses unicode characters to represent objects in a persistent world that multiple users may interact with.

`alchemist` has few commands for interacting with the server. Here they are with some helpful tips for using them.

other than these commands below, all that needs doing is opening a TCP socket to the server with a unicode-supported client.

you can start a local server with `./bin/alchemist-server`

after you connect, you will be greeted with…

`Welcome, alchemical friend. What is your name?`

…after which you can enter your name and continue with commands below. (Parenthesized characters are optional.)

commands!
=========

app(ear)
--------
adds your avatar into the world! (this is important if you want to interact with people and other things.)

it also returns the any local avatars nearby with the following format:

	avatars N
	AVATARNAME X Y
	AVATARNAME2 X Y
	appeared
	

example:

	> appear
	avatars 2
	qxjit -8 6
	moob 0 0
	appeared	
	
basics
------
returns a string that identifies the basic elements that exist in alchemist

example:

	> basics
	basics 火░〃〰
	
basics include:

		name   unicode
	火  fire   \u706b
	〰  water  \u3030
	░   earth  \u2591
	〃  wind   \u3003


compounds
---------
returns a string that identifies the compound elements that (currently) exist in alchemist

example:

	> compounds
	compounds ʬㄒㄘ〝

create ABX
----------
allows you to create new compounds in alchemist. they are created by providing two basic characters and a currently unused unicode character that will represent the compound in alchemist

example:

	> create 火░ㄒ
	
!!! incomplete !!!

read
----
returns the messages of all nearby avatars. this command is automatically called after a successful `message` call

	> read
	messages 10
	Alchemistasaur:
	
	Ryan:
	
	moob:
	"pants"
	
	
	
    qxjit:

message|msg N MSG
-----------------

allows you to add messages to your avatar where N is 0-9 and MSG is a string to attach to that position

the server will respond as if you had called `read` immediately after

example:

	> message 0 "hi"
	messages 10
	Alchemistasaur:
	
	Ryan:
	
	moob:
	"pants"
	
	
	
	qxjit:
