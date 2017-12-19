class TorrentBot
  DOWNLOAD_ROOT = File.join(ENV["HOME"], "Downloads").freeze
  DESTINATION_ROOT = File.join("/", "mnt", "5TB").freeze
  PROCESSORS = []

  def self.lib_root
    File.join(File.expand_path(File.dirname(__FILE__)), "torrent-bot")
  end

  def self.logs_root
    File.join(File.expand_path("..", File.dirname(__FILE__)), "logs")
  end

  def self.register_processor(processor)
    PROCESSORS << processor
  end

  def self.run
    PROCESSORS.each { |processor| processor.process }
  end
end

Dir.glob(File.join(TorrentBot.lib_root, "processors", "*.rb")).each do |processor|
  require processor
end
