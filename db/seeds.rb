# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Task.destroy_all
Timeslot.destroy_all

# Create sample Tasks
task1 = Task.create!(name: "Write report", description: "Finish the quarterly report for Q2")
task2 = Task.create!(name: "Email client", description: "Send follow-up email to client X")
task3 = Task.create!(name: "Prepare presentation", description: "Create slides for next week's meeting")
task4 = Task.create!(name: "Review code", description: "Review pull request #123")

# Create sample Timeslots
timeslot1 = Timeslot.create!(start_time: DateTime.parse("2025-07-05 09:00:00"), end_time: DateTime.parse("2025-07-05 10:00:00"), slot_date: Date.parse("2025-07-05"))
timeslot2 = Timeslot.create!(start_time: DateTime.parse("2025-07-05 10:00:00"), end_time: DateTime.parse("2025-07-05 11:00:00"), slot_date: Date.parse("2025-07-05"))
timeslot3 = Timeslot.create!(start_time: DateTime.parse("2025-07-05 13:00:00"), end_time: DateTime.parse("2025-07-05 14:00:00"), slot_date: Date.parse("2025-07-05"))

puts "Created #{Task.count} tasks and #{Timeslot.count} timeslots."
