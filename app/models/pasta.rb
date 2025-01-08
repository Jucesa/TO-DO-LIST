class Pasta < ApplicationRecord
    def tasks
      JSON.parse(read_attribute(:listas))
    rescue JSON::ParserError
      []
    end
  
    def listas=(value)
      write_attribute(:listas, value.to_json)
    end
  end