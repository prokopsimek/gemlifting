class Search
  attr_reader :query, :page

  def initialize(query, page)
    @query = query
    @page = page
  end

  def call
    GemObject
      .search(search_body)
      .page(page)
      .records
  end

  private

  def search_body
    {
      query: {
        multi_match: {
          query: query,
          type: 'best_fields',
          fields: %w[name^10 info^5 authors]
        }
      }
    }
  end

end
