class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: 'メンズ' },
    { id: 1, name: 'レディース' },
    { id: 2, name: 'ベビー・キッズ' },
    { id: 3, name: 'インテリア・住まい・小物' },
    { id: 4, name: '本・音楽・ゲーム' },
    { id: 5, name: 'おもちゃ・ホビー・グッズ' },
    { id: 6, name: '家電・スマホ・カメラ' },
    { id: 7, name: 'スポーツ・レジャー' },
    { id: 8, name: 'ハンドメイド' },
    { id: 9, name: 'その他' },
    { id: 100, name: '---' }
  ]
  include ActiveHash::Associations
  has_many :items
end
