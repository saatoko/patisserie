class Genre < ActiveHash::Base
  self.data = [
      {id: 1, name: '和菓子'}, {id: 2, name: 'スポンジケーキ類'}, {id: 3, name: 'バターケーキ類'},
      {id: 4, name: 'シュ－菓子類'}, {id: 5, name: '発酵菓子類'}, {id: 6, name: 'フィユタ－ジュ類'},
      {id: 7, name: 'デザート菓子類'}, {id: 8, name: 'クッキー類'}, {id: 9, name: 'マカロン'},
      {id: 10, name: 'チョコレート類'}, {id: 11, name: 'ジャム類'}, {id: 12, name: 'クリーム類'},
      {id: 13, name: 'アイスケーキ'}, {id: 14, name: 'メレンゲ菓子類'}, {id: 15, name: 'その他'}
  ]
end