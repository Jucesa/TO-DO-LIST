class Task < ApplicationRecord
    belongs_to :list

    validates :name, presence: true
    validates :priority, presence: true
    validates :estimated_time, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :details, presence: true
    validates :list_id, presence: true
    
    validates :list, presence: true
end
