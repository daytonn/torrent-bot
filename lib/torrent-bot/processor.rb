require "fileutils"
require "date"

class TorrentBot
  class Processor
    def self.download_path
      raise NotImplementedError
    end

    def self.video_file_pattern
      raise NotImplementedError
    end

    def self.video_extensions_string
      raise NotImplementedError
    end

    def self.destination_path
      raise NotImplementedError
    end

    def self.format
      raise NotImplementedError
    end

    def self.filebot_command
      raise NotImplementedError
    end

    def self.filebot_options
      raise NotImplementedError
    end

    def self.filebot_options_string
      raise NotImplementedError
    end

    def self.rename_options
      raise NotImplementedError
    end

    def self.rename_options_string
      raise NotImplementedError
    end

    def self.log_file_path
      raise NotImplementedError
    end

    def self.log_filename
      raise NotImplementedError
    end

    def self.log_file_directory
      raise NotImplementedError
    end

    def self.write_log(message)
      File.open(log_file_path, "a") { |f| f.puts(message) } if File.exist?(log_file_path)
    end

    def self.create_log!
      FileUtils.mkdir_p(log_file_directory) unless File.directory?(log_file_directory)
      FileUtils.touch(log_file_path) unless File.exist?(log_file_path)
    end

    def self.process
      create_log!
      File.open(log_file_path, "a") { |f| f.puts "\n\n--------------------#{Date.new}--------------------" }
      Dir.glob(video_file_pattern).map { |video_file| process_file(video_file) }
      File.open(log_file_path, "a") { |f| f.puts "-----------------------------------------------------" }
    end

    def self.process_file(file)
      result = %x[#{filebot_command} #{filebot_options_string} "#{file}" #{rename_options_string} --format "#{format}"]
      write_log(result)
      puts result
    end
  end
end
