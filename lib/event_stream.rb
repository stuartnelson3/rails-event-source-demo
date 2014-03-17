class EventStream
  def self.post_event(task)
    Net::HTTP.post_form(
      URI.parse(update_url),
      card: task, stream: name, token: token
    )
  end

  def self.connection_info
    {
      url: url,
      eventName: name
    }
  end

  def self.name
    "task_stream"
  end

  def self.token
    ENV["ES_TOKEN"] || 'token123'
  end

  def self.url
    ENV["ES_URL"] || "http://stuart.local:8080/stream?token=#{token}"
  end

  def self.update_url
    ENV["ES_UPDATE_URL"] || "http://stuart.local:8080/update_stream"
  end
end
