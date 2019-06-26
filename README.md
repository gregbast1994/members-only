# Members Only
After completing the first 12 chapters of the [Ruby on Rails Tutorial](https://www.railstutorial.org/), I am flexing my own rails muscles by creating a simple application which allows users to write posts. These posts can only be seen by other users. This gives me an excellent opertunity to roll my own authenication system, get a feel for writing my own tests and get used to the RoR work flow.

## Features
- [x] Model users
- [x] create persistant sessions
- [x] implement a 'remember me' feature
- [] implement a 'account activation' feature, creating a token upon create, digest token, save to db, send a confirmation email to user and change attribute to true
- [] implement a 'forgot password' feature, allowing users to submit an email address, create a token, digest and save that token and send email to users to provide access to the rest password form
- [] implement a change in the user model which differeniates admins from non-admins. Admins can see and delete other others
- [] model posts and connect them to users
