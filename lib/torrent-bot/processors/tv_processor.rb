require "torrent-bot/processor"

class TorrentBot::Processor::TV < TorrentBot::Processor
  def self.download_path
    File.join(TorrentBot::DOWNLOAD_ROOT, "TV Shows")
  end

  def self.video_file_pattern
    File.join(download_path, "**", "*.{#{video_extensions_string}}")
  end

  def self.video_extensions_string
    TorrentBot.video_extensions.join(",")
  end

  def self.destination_path
    File.join(TorrentBot::DESTINATION_ROOT)
  end

  def self.format
    File.join(destination_path, "{plex}")
  end

  def self.filebot_command
    TorrentBot.filebot_command
  end

  def self.filebot_options
    TorrentBot.filebot_options
  end

  def self.filebot_options_string
    TorrentBot.filebot_options.join(" ")
  end

  def self.rename_options
    ["--db", "TheTVDB"]
  end

  def self.rename_options_string
    rename_options.join(" ")
  end
end

TorrentBot.register_processor(TorrentBot::Processor::TV)
