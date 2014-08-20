# Application routes.
module.exports = [
  ['', 'home#index']
  # 登陆系统
  ['!/session/create',  'session#create']
  # 退出系统
  ['!/session/remove',  'session#remove']
]
