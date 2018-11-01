#!/usr/bin/ruby


=begin
Question 3:
    Generate 500 random numbers and print the nth smallest number in a programming language of your choice.
=end

UPPER_LIMIT = 10000

def generate_number_array
  number_array = []
  500.times do |number|
      number = rand(UPPER_LIMIT)
  number_array << number
  end
  number_array
end

def sort_array(array, user_input)
  #The built-in Ruby sort is one of the fastest out there and far more efficient than any custom merge sort I would write:
  # https://medium.com/@erickcodes/how-fast-is-the-sort-method-in-ruby-a730c1928e4
  array.sort!
  #With regards to memory usage, eliminate any elements after we know what place the user wants to cut down array size.
  array.slice!(user_input..array.count - 1)
  array
end

def prompt_user
  puts "Enter the Nth lowest number"
  input = STDIN.gets.chomp.to_i
  array = generate_number_array
  array = sort_array(array, input)
  #Subtract 1 from user input to account for array indicies
  puts "The #{input}th lowest number is: #{array[input - 1]}"
end

prompt_user