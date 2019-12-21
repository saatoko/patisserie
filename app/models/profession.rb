class Profession < ActiveHash::Base
  self.data = [
      {id: 1, name: '会社員'}, {id: 2, name: '自営業'}, {id: 3, name: '主婦'},
      {id: 4, name: '学生'}, {id: 5, name: 'その他'}
  ]
end