demo_secrets
============

Shhhhh....

Happy_path:
	User: 
		Validation :

			Create a User with proper attributes is valid
			User with name between good length is valid
			User within password lenth is valid

		Association :

			User respond to secrets call


	Secret:
		Validation : 
			Create a secret with proper attributes is valid
			Secret with good title length is valid
			Secret with good body length is valid


		Association :
			Secret respond to author call

		Method: 
			#last_five should return the last 5 posts


Sad_path:
	User:
		Create a User with wrong attributes absent is invalid
		User with name shorter or longer than valid lengh is invalid
		User with already created email is invalid
		User with shorter or longer password is invalid

	Secret:

		Validation :

			Should not be valid with a title, body, or author attribute missing
			Should not be valid with a short or long title
			Should not be valid with a short or long body


Bad_path:

