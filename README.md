### What is this?

Here you'll find a simple ruby script used to safely see if your password has been comprised in a data breach. It uses [haveibeenpwned.com's](https://haveibeenpwned.com/API/v2) api and database.

### Why should I trust someone else with my password?

You shouldn't. Luckily Troy Hunt, the creator of the website, implemented a k-Anonymity model in their api. This means instead of asking the api "Does my password `ilovepancakes` exist in the data breach", we hash it using SHA-1 (`219CE5D6FABD9AE870E66E1FE6B21942C0D34E14`), take the first few characters and ask the api "Does a hashed password starting with `219CE` exist in your database?"

The api will respond with a list of leaked hashed passwords that you can scan to see if any of them exactly match your hashed password, and if you find it, you'll know it was compromised. This script will do all the tedious bits, but you'll be sure you won't be sending in your actual password.


```sh
$ Enter your password:
$ ⚩  #ilovepancakes
Sending GET request to https://api.pwnedpasswords.com/range/219CE
Your password occured 229 times in the database
```
