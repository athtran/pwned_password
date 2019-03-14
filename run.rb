require 'digest'
require 'faraday'
require 'colorize'
require 'io/console'

def run(password)
  hashed_password = Digest::SHA1.hexdigest(password).upcase
  num = num_occurances(possible_matches(hashed_password), hashed_password[5..-1])
  if num > 0
    puts "Your password occured #{num} times in the database".red
  else
    puts "Did not find your password in database".green
  end
end

def num_occurances(possible_matches, hashed_password)
  possible_matches.each do |match|
    hash, num = match.split(":")
    return num.to_i if hash == hashed_password
  end
  0
end

def possible_matches(hashed_password)
  url = "https://api.pwnedpasswords.com/range/#{hashed_password[0..4]}"
  puts "Sending GET request to #{url}".blue
  Faraday.get(url).body.split("\r\n")
end

puts "Enter your password: "
password = STDIN.noecho(&:gets).chomp
run(password)
