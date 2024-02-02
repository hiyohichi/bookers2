class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites,dependent: :destroy
  #favoritesテーブルを介してUserモデルのコレクションを取得する
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments,dependent: :destroy
  #閲覧数カウント
  has_many :read_counts, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  validates :title,presence: true
  validates :body,presence: true, length:{maximum:200}


end
