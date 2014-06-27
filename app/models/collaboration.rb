class Collaboration < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  belongs_to :post
end
