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

    def self.process
      process_results = Dir.glob(video_file_pattern).map { |video_file| process_file(video_file) }
      process_results.each { |result| puts result }
    end

    def self.process_file(file)
      %x{#{filebot_command} #{filebot_options_string} #{rename_options_string} --format #{format}}
    end
  end
end
