class TorrentBot
  DOWNLOAD_ROOT = File.join(ENV["HOME"], "Downloads").freeze
  DESTINATION_ROOT = File.join("/", "mnt", "5TB").freeze
  PROCESSORS = []

  def self.lib_root
    File.join(File.expand_path(File.dirname(__FILE__)), "torrent-bot")
  end

  def self.register_processor(processor)
    PROCESSORS << processor
  end

  def self.filebot_format
    "{plex}"
  end

  def self.filebot_command
    "/usr/bin/filebot"
  end

  def self.filebot_options
    ["-rename", "-r", "-non-strict"]
  end

  def self.rename_options
    []
  end

  def self.run
    PROCESSORS.each { |processor| processor.process }
  end

  def self.video_extensions
    ["mp4", "mkv"]
  end
end

Dir.glob(File.join(TorrentBot.lib_root, "processors", "*.rb")).each do |processor|
  require processor
end
