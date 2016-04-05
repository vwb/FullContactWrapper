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
end
