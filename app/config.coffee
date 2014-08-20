ec   = encodeURIComponent

clients =
  "trackx.stonephp.com": 'f81aeef668ac9ecc175a'
  "trackt.stonephp.com": '53e47f084939381ad1aa'

open =
  url: 'http://open.admaster.com.cn/'
  clientId: clients[location.host]

module.exports =

  # api接口地址
  apiRoot: '/api_v2'

  # languages 系统可用的语言，i18n, L10n
  languages: ['zh', 'en']

  # 插件的设置
  plugins: []

  # urlParams 当前url参数
  urlParams: null

  # route 当前页面对应的route
  route: null

  # 当前登陆者信息
  session: null

  # 当前登陆者所拥有的工作网络collection
  networks: null

  # 当前选择的工作网络model
  network: null

  # session过期时间, 单位毫秒
  sessionExpired: 10 * 60 * 1000

  # open相关配置，主要是url和clientId
  # 这里一定不能防止secert
  open: open

  # 上传文件相关配置，目前使用qiniu的云存储
  storage:
    bucket: 'admaster-snap'
    uploadUrl: "http://up.qiniu.com"

  # 缩略图配置，供 view_helper.qiniuThumb 使用
  thumbnails:
    medium:
      width: 156
      height: 156
    small:
      width: 64
      height: 64

  # 系统登陆地址
  loginUrl: [
    "#{open.url}oauth/authorize?"
    "client_id=#{open.clientId}&response_type=token&"
    "redirect_uri=#{ec "http://#{location.host}/#!/session/create"}"
  ].join('')

  # 系统退出地址
  logoutUrl: [
    "#{open.url}user/logout"
    [
      "client_id=#{open.clientId}"
      "redirect_uri=#{ec "http://#{location.host}#!/session/remove"}"
    ].join '&'
  ].join '?'

  # loader 实例，loader 的控制全部通过utils里的方法来控制，不直接读取该变量
  loader: null

  # 日期格式
  dateFormat: "YYYY-MM-DD"
  dateTimeFormat: "YYYY-MM-DD HH:mm:ss"

  # 创意的颜色列表
  creativeColors:
    No0:  "#FFFFFF"
    No1:  "#FFEE97"
    No2:  "#FF952D"
    No3:  "#CAE66E"
    No4:  "#91E9FE"
    No5:  "#F8BAD6"
    No6:  "#8371E0"
    No7:  "#A87A6E"
    No8:  "#FFDA3C"
    No9:  "#FF7600"
    No10: "#4BAE3B"
    No11: "#03ACE6"
    No12: "#B54ECD"
    No13: "#AC4F34"
    No14: "#FE3358"
    No15: "#21C2C5"
    No16: "#E9478E"
    No17: "#0AA352"
    No18: "#2862CF"
    No19: "#C2355C"
    No20: "#D0816F"
