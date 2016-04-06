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
    #sanitize passed in email
      #ensure proper formatting
      #regex!
    person = CachedPerson.find_by_email(email)
    person
  end

  def self.create_new_person(email, data)
    person = CachedPerson.new(email: email, data: data)
    if person.save
      data
    else
      #handle error
    end
  end

end
