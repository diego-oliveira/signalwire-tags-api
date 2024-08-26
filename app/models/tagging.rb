class Tagging < ApplicationRecord
  belongs_to :ticket
  belongs_to :tag, counter_cache: true
end
