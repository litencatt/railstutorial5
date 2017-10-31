class HardWorker
  include Sidekiq::Worker

  def perform(complexity)
    case complexity
    when "super_hard"
      sleep  20
      puts "Realy took quire a bit of effort"
    when "hard"
      sleep  10
      puts "That was a bit of work"
    else
      sleep 1
      puts "That wasn't a lot of effort"
    end
  end
end
