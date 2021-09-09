class Article < ApplicationRecord
  enum category: [:introduction, :application, :sat, :toefl]

  has_one_attached :image
  has_one_attached :bodypdf
end
