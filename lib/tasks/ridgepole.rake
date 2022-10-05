namespace :ridgepole do
  desc 'Apply schema to database'
  task apply: :environment do
    run('--apply', '--file')
  end

  desc 'Export schema to Schemafile'
  task export: :environment do
    run('--export', '--split', '--output')
  end

  private

    def run(*options)
      config_file = 'config/database.yml'
      schema_file = 'db/schemas/Schemafile'
      rails_env   = ENV['RAILS_ENV'] || Rails.env

      base_command = "bundle exec ridgepole --config #{config_file} --env #{rails_env}"
      full_command = [base_command, *options, schema_file].join(' ')

      puts '=== run ridgepole... ==='
      puts "[Running] #{full_command}"

      system full_command
    end
end