class Article < ApplicationRecord
  enum category: [:introduction, :application, :sat, :toefl]
end
