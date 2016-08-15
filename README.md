a sweatshop by Alex and Matt

demo_secrets
============

Shhhhh....

Write out the Happy / Sad / Bad paths you can identify from the app's functionality.

Action: Signing in
  Happy
    1. Creating a new user with a unique email and password.
  Sad
    1. Creating a new user with a non-unique email fails.

Action: New Secret 
  Happy
    1. Creating a new secret with a title and body between 4 and 24 or 140 characters respectivey creates a new secret. Secrets must also have an author.
  Sad
    1. Creating a new secret with no title or no body fails.
    2. Creating a new secret whose title and/or body are too short or too long fails.

Action: Secrets index
  Happy
    1. Page shows 5 most recent secrets in descending order.


