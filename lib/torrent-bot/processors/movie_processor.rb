require "torrent-bot/processor"

class TorrentBot::Processor::Movie < TorrentBot::Processor
  def self.download_path
    File.join(TorrentBot::DOWNLOAD_ROOT, "Movies")
  end

  def self.database
    "TheMovieDB"
  end

  def self.log_file_directory
    File.join(TorrentBot.logs_root, "movies")
  end

  def self.log_filename
    "movies.log"
  end
end

TorrentBot.register_processor(TorrentBot::Processor::Movie)
