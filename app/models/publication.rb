class Publication < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy #Esto debe mostrarse en una columna tipo instagram bien alternativo

  before_destroy :purge_images

  private

  def purge_images
    images.each do |image|
      image.purge if image.attached?
    end
  end
end
