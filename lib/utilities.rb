module Utilities

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def asset_path(filename)
      ext = File.extname(filename)[1..-1].downcase
      type = case ext
      when 'jpg', 'png', 'gif', 'tiff', 'bmp'
        'images'
      when 'ogg', 'mp3'
        'sound'
      end
      File.join(GAME_ROOT_PATH, "assets", type, filename)
    end

    def scene_path(filename)
      File.join(GAME_ROOT_PATH, "scenes", filename)
    end

  end
end
