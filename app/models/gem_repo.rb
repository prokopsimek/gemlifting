class GemRepo
  attr_reader :names

  def initialize
    @names = []
    load_names
  end

  def size
    @names.size
  end

  def urls
    @names.map { |name| "https://rubygems.org/gems/#{name}" }
  end

  def self.names_of_latest
    # Returns the 50 gems most recently added to RubyGems.org
    Gems.latest.map{ |gem_hash| gem_hash["name"] }
  end

  def self.names_of_just_updated
    # Returns the 50 most recently updated gems
    Gems.just_updated.map{ |gem_hash| gem_hash["name"] }
  end

  private

  def load_names
    `gem search`.each_line do |line|
      next if line.empty? || line.match(/\*/)
      @names << line.split().first
    end
  end
end
