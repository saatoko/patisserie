parents = %w[ 洋菓子 和菓子 その他 ]
yougashi_child = %w[ スポンジケーキ類 バターケーキ類 シュ－菓子類 発酵菓子類 フィユタ－ジュ類 デザート菓子類 クッキー類 マカロン チョコレート類 ジャム類 クリーム類 アイスケーキ メレンゲ菓子類 その他]
wagashi_child = %w[ 生菓子 半生菓子 干菓子 その他]
other_child = %w[ パン その他]

parents.each do |parent|
  Category.seed do |c|
    c.name = parent
  end
end
yougashi_child.each do |child|
  Category.find_by!(name: '洋菓子').children.create(name: child)
end
wagashi_child.each do |child|
  Category.find_by!(name: '和菓子').children.create(name: child)
end
other_child.each do |child|
  Category.find_by!(name: 'その他').children.create(name: child)
end

# childrenがancestryをinstallしたことで使えるようになったメソッド