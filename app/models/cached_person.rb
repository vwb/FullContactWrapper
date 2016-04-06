# == Schema Information
#
# Table name: cached_people
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  data       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CachedPerson < ActiveRecord::Base
  validates :email, :data, presence: true
  validates :email, uniqueness: true

  def self.look_up_email(email)
    formatted_email = CachedPerson.sanitize_email(email)
    person = CachedPerson.find_by_email(email)
  end

  def self.create_new_person(email, data)
    formatted_email = CachedPerson.sanitize_email(email)
    person = CachedPerson.new(email: formatted_email, data: data)
    
    if person.save
      data
    else
      raise ArgumentError, "#{person.errors.full_messages}"
    end
  end

  def self.sanitize_email(email)
    if m = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.match(email)
      formatted_email = email.split("@")
      formatted_email.first.downcase!
      formatted_email = formatted_email.join("@")
    else
      raise ArgumentError, "Not a properly formatted email"
    end
  end
  
end
