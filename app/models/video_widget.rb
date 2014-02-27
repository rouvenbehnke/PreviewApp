class VideoWidget < Widget
  # Determines the mime type of the video.
  def mime_type
    if source.present?
      source.mime_type
    end
  end
end
