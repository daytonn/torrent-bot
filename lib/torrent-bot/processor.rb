require "fileutils"
require "date"

class TorrentBot
  class Processor
    def self.process
      create_log!
      write_log "\n\n--------------------#{Date.new}--------------------"
      Dir.glob(video_file_pattern).map { |video_file| process_file(video_file) }
      write_log "-----------------------------------------------------"
    end

    private

    def self.filebot_format
      "{plex}"
    end

    def self.filebot_command
      "/usr/bin/filebot"
    end

    def self.filebot_options
      ["-rename", "-r", "-non-strict"].join(" ")
    end

    def self.video_extensions
      ["mp4", "mkv"]
    end

    def self.video_file_pattern
      File.join(download_path, "**", "*.{#{video_extensions.join(',')}}")
    end

    def self.destination_path
      File.join(TorrentBot::DESTINATION_ROOT)
    end

    def self.format
      File.join(destination_path, "{plex}")
    end

    def self.create_log!
      FileUtils.mkdir_p(log_file_directory) unless File.directory?(log_file_directory)
      FileUtils.touch(log_file_path) unless File.exist?(log_file_path)
    end

    def self.write_log(message)
      File.open(log_file_path, "a") { |f| f.puts(message) } if File.exist?(log_file_path)
    end

    def self.process_file(file)
      result = %x[#{filebot_command} #{filebot_options} "#{file}" --db #{database} --format "#{format}"]
      write_log(result)
      puts result
      notify("Processed #{File.basename(file)}")
    end

    def self.notify(message)
      %x{notify-send --app-name=TorrentBot "#{message}"}
    end

    def self.log_file_path
      File.join(log_file_directory, log_filename)
    end

    def self.download_path
      raise NotImplementedError
    end

    def self.database
      raise NotImplementedError
    end

    def self.log_file_directory
      raise NotImplementedError
    end

    def self.log_filename
      raise NotImplementedError
    end
  end
end
