#!/usr/bin/env ruby

require 'open-uri'
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

puts "Welcome to the daily challenges :)\n"
puts "Opening the tasks\n"

(1..16).to_a.shuffle.first(3).each do |x|
  doc = Nokogiri::HTML(open("https://codility.com/programmers/lessons/#{x}"))
  task = doc.css(".task-box").to_a.shuffle.first
  difficulty = task.css('.difficulty').text
  link = task.css('.main-column .left a')
  name = link.text.strip

  puts "Lesson:#{x} Difficulty:#{difficulty}\t\tName:#{name}"
  `open "https://codility.com/#{link.attr('href').value}"`
end


