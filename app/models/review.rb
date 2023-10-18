class Review < ApplicationRecord
    belongs_to :user
    belongs_to :listing, foreign_key: :user_id
    belongs_to :reviewable, polymorphic: true

    attribute :content, :string
end