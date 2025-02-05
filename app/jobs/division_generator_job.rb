# app/jobs/division_generator_job.rb
class DivisionGeneratorJob < ApplicationJob
  queue_as :default

  puts "!!!!!!!!!!!Started!!!!!!!!!!!!!!!!"
  WEIGHT_CLASSES = {
    "Bay" => {
      horoz: { min: 0, max: 57.5 },
      hafif_tuy: { min: 57.5, max: 64.0 },
      tuy: { min: 64.0, max: 70.0 },
      hafif: { min: 70.0, max: 76.0 },
      orta: { min: 76.0, max: 82.3 },
      orta_agir: { min: 82.3, max: 88.3 },
      agir: { min: 88.3, max: 94.3 },
      super_agir: { min: 94.3, max: 100.5 },
      ultra_agir: { min: 100.5, max: Float::INFINITY }
    },
    "Bayan" => {
      horoz: { min: 0, max: 48.5 },
      hafif_tuy: { min: 48.5, max: 53.5 },
      tuy: { min: 53.5, max: 58.5 },
      hafif: { min: 58.5, max: 64.0 },
      orta: { min: 64.0, max: 69.0 },
      orta_agir: { min: 69.0, max: 74.0 },
      agir: { min: 74.0, max: 79.3 },
      super_agir: { min: 79.3, max: Float::INFINITY }
    }
  }.freeze

  AGE_RANGES = {
    juvenile: { min: 16, max: 17 },
    adult: { min: 18, max: 29 },
    master_1: { min: 30, max: 35 },
    master_2: { min: 36, max: 40 },
    master_3: { min: 41, max: 45 }
  }.freeze

    # app/jobs/division_generator_job.rb
    def perform(event_id)
      puts "Starting division generation for event: #{event_id}"  # Debug line
      @event = Event.find(event_id)
      @draft_status = DivisionStatus.find_by(name: "Taslak")

      puts "Found approved applications: #{@event.event_applications.count}"  # Debug line

      ApplicationRecord.transaction do
        generate_for_category("gi") if @event.gi
        generate_for_category("nogi") if @event.nogi
        generate_for_category("mma") if @event.mma
      end
    end

  private

  def generate_for_category(category)
    approved_applications = @event.event_applications
      .includes(:warrior)
      .where(event_application_status: EventApplicationStatus.find_by(name: "Onaylandı"))
      .select { |app| app.send("#{category}?") }

    Gender.find_each do |gender|
      gender_apps = approved_applications.select { |app| app.warrior.gender_id == gender.id }
      process_gender_group(gender_apps, gender, category)
    end
  end

  def process_gender_group(applications, gender, category)
    puts "Processing for gender: #{gender.name}, applications: #{applications.count}" # Debug

    applications.group_by { |app| get_age_group(app.warrior.date_of_birth) }.each do |age_group, age_apps|
      puts "Age group: #{age_group}, applications: #{age_apps.count}" # Debug

      age_apps.group_by { |app| app.warrior.belt_rank }.each do |belt, belt_apps|
        puts "Belt: #{belt}, applications: #{belt_apps.count}" # Debug

        belt_apps.group_by { |app| get_weight_class(app.weight, gender.name) }.each do |weight_class, weight_apps|
          puts "Weight class: #{weight_class}, applications: #{weight_apps.count}" # Debug

          next if weight_apps.count < 2

          puts "Creating division for: #{gender.name} - #{age_group} - #{belt} - #{weight_class}" # Debug
          create_division(
            category: category,
            gender: gender,
            age_group: age_group,
            belt_rank: belt,
            weight_class: weight_class,
            applications: weight_apps
          )
        end
      end
    end
  end

  def create_division(category:, gender:, age_group:, belt_rank:, weight_class:, applications:)
    weight_range = WEIGHT_CLASSES[gender.name][weight_class]
    age_range = AGE_RANGES[age_group]

    division_name = [
      gender.name,
      age_group.to_s.humanize,
      belt_rank,
      weight_class.to_s.humanize,
      category.upcase,
      "#{weight_range[:min]}-#{weight_range[:max]}kg"
    ].join(" ")

    @event.divisions.create!(
      name: division_name,
      gender: gender,
      category: category,
      belt_rank: belt_rank,
      min_weight: weight_range[:min],
      max_weight: weight_range[:max],
      min_age: age_range[:min],
      max_age: age_range[:max],
      division_status: @draft_status
    )
  end

  def get_weight_class(weight, gender)
    WEIGHT_CLASSES[gender].find { |_, range| weight >= range[:min] && weight < range[:max] }&.first
  end

  def get_age_group(birth_date)
    age = calculate_age(birth_date)
    AGE_RANGES.find { |_, range| age >= range[:min] && age <= range[:max] }&.first
  end

  def calculate_age(birth_date)
    ((@event.date - birth_date) / 365.25).floor
  end
end
