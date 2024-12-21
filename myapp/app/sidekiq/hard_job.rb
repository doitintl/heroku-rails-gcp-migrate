class HardJob
  include Sidekiq::Job

  def perform(*args)
    puts "Hello from inside a background HardJob!"
  end
end
