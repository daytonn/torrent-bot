require "torrent-bot/processor"

class TorrentBot::Processor::TV < TorrentBot::Processor
  def self.download_path
    File.join(TorrentBot::DOWNLOAD_ROOT, "TV Shows")
  end

  def self.database
    "TheTVDB"
  end

  def self.log_file_directory
    File.join(TorrentBot.logs_root, "tv_shows")
  end

  def self.log_filename
    "tv-shows.log"
  end
end

TorrentBot.register_processor(TorrentBot::Processor::TV)
