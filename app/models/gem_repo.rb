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

  private

  def load_names
    `gem search`.each_line do |line|
      next if line.empty? || line.match(/\*/)
      @names << line.split().first
    end
  end
end
