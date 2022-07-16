class SnsCredential < ApplicationRecord
  belongs_to :member, optional: true
end
