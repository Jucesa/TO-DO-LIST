class Lista < ApplicationRecord
  has_many :tasks
  def tasks
    JSON.parse(read_attribute(:tasks))
  rescue JSON::ParserError
    []
  end

  def tasks=(value)
    write_attribute(:tasks, value.to_json)
  end
end
  