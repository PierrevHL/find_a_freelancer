class Conversation < ApplicationRecord
  attr_accessor :contact
  belongs_to :receiver, class_name: :User, foreign_key: :receiver_id
  belongs_to :sender, class_name: :User, foreign_key: :sender_id
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :receiver_id

  scope :between, -> (sender_id,receiver_id) do
  where("(conversations.sender_id = ? AND conversations.receiver_id =?) OR (conversations.sender_id = ? AND conversations.receiver_id =?)", sender_id,receiver_id, receiver_id, sender_id)
  end


  def contact_user(current_user)
    User.find( self.sender_id == current_user.id ? self.receiver_id : self.sender_id )
  end

end
