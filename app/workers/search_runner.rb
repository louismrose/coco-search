class SearchRunner
  # The name of the Redis queue from which this worker takes jobs
  @queue = :searches
  
  # The work to be done for each search
  def self.perform(search_id)
    search = Search.find(search_id)
    search.grammar # the grammar to search over
    search.evaluation_url # the URL to which "samples" from the grammar can be POSTed
  end
end