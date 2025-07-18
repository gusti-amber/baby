class Task < ApplicationRecord
  belongs_to :user

  has_many :tasktags
  has_many :tags, through: :tasktags
  has_many :todos, dependent: :destroy

  # 🎓 reject_if: :all_blank について、:all_blankが渡されると、_destroyの値を除くすべての属性が空白レコードを受け付けなくなるprocが1つ生成されます。
  #   つまり、_destroyの値を除くすべての属性に値がないと、レコードが作成されないようになる。
  accepts_nested_attributes_for :todos, allow_destroy: true, reject_if: :all_blank

  enum status: { todo: 0, doing: 1, done: 2 }

  validates :title, presence: true, length: { minimum: 2, maximum: 255 }
  validates :status, presence: true
end
