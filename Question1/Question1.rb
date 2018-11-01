#!/usr/bin/ruby


=begin
Question 1:



There is a file containing a word and its possible meanings (like a Dictionary). The contents of the file look like this:



Apple – a fruit, a tech firm

Table – an object, contains rows and columns when used in context of computers

Orange – a fruit



Given a path to the file, do the following:



a)    Create a method called doesFileExist(String path) which takes the path of the file and tells the user if the file exists at that path or not.
      Assume all paths are relative to your project structure. If the file does not exist, catch the requisite exception.

b)    Read each word and its possible meanings and print them out. Your output should look like this:



Word1

Meaning 1

Meaning 2

Word2

Meaning1

Meaning2



Use appropriate data structures wherever necessary.
=end
########################################################################
require 'pathname'

DEFAULT_PATH = "words.txt"

def check_empty_arguments(cli_arguments)
  if cli_arguments.empty?
    puts "Please specify the path to the word file (#{DEFAULT_PATH} is default)"
    new_path = STDIN.gets.chomp.split(' ')
    new_path.empty? ? [DEFAULT_PATH] : new_path
  else
    cli_arguments
  end
end

def check_files_specified(files)
  if files.count > 1
    puts "More than one file specified, please specify just one."
    exit 1
  else if files.first.strip == ""
         puts "No input detected, please be sure to specify a file name"
       else
         puts "Processing, the #{files.first} file, just a second...\n \n"
       end
  end
end

def does_file_exist(path)
  begin
    File.readlines(path) do
  end
  rescue Exception => e
    puts e.message + "\nDouble check the file name and please try again.\n \n"
    puts e.backtrace.inspect
    exit 1
  end
end

def process_word_file(words)
  dictionary = { }

  #Delete newline characters in the array created from File.readlines
  words.delete("\n")

  words.each do |line|
    #Massaging the input data to get it to a form that's easy to insert to a hash
    # Output looks like this: {"Word" => ["definition_1", "definition_2]"}

    #Grab the first word in every line
    word = line.slice!(/^([\w\-]+)/)
    #Eliminate hyphen and grab each definiton using the comma as delimiter
    definitions = line.gsub(/[–]/, '').split(',')

    sanitizedDefinitions = []
    definitions.each do |definition|
      sanitizedDefinitions << definition.strip
    end
    #Set each word as the hash key and make its value the definition array
    dictionary[word] = sanitizedDefinitions
  end
  dictionary
end

def print_out(word_hash)
  #Loop through each key/value to print output in desired format
  word_hash.each do |key, values|
    puts key
    puts "---------------"

    values.each do |value|
      puts "#{value} \n \n"
    end
  end
end

file_path = check_empty_arguments(ARGV)
check_files_specified(file_path)
word_file = does_file_exist(Pathname.new(file_path.first))
word_hash = process_word_file(word_file)
print_out(word_hash)