class HttpConstants {
  static const HOME_PAGE_URL = "https://www.wanandroid.com/banner/json";
  static const HOME_ARTICLE_URL =
      "https://www.wanandroid.com/article/list/#/json"; //#:替换为页码
  static const PUBLIC_SUBSCRIPTION =
      "https://wanandroid.com/wxarticle/chapters/json";
  static const PUBLIC_SUBSCRIPTION_HISTORY =
      "https://wanandroid.com/wxarticle/list/@/#/json"; //@:替换为公众号id，#:替换为页码
  static const GANK_MZ_PICS = "http://gank.io/api/data/福利/10/#"; //#为页码
  static const HOT_KEY = "https://www.wanandroid.com//hotkey/json"; //搜索热词
  //搜索关键词文章 #:替换为页码 方法：POST 页码：拼接在链接上，从0开始。k ： 搜索关键词
  static const ARTICLE_QUERY =
      "https://www.wanandroid.com/article/query/#/json";

  //登录 方法：POST 参数：username，password
  static const LOGIN = "https://www.wanandroid.com/user/login";

  //注册 方法：POST 参数：username,password,repassword
  static const REGISTER = "https://www.wanandroid.com/user/register";

  //退出登录 方法：GET
  static const OUT_LOGIN = "https://www.wanandroid.com/user/logout/json";

  //收藏文章列表 GET
  static const COLLECT_LIST =
      "https://www.wanandroid.com/lg/collect/list/#/json"; //#:替换为页码

  //收藏站内文章 POST
  static const COLLECT_ARTICLE =
      "https://www.wanandroid.com/lg/collect/#/json"; //#:替换为文章id
  //取消收藏 POST
  static const UNCOLLECT_ARTICLE =
      "https://www.wanandroid.com/lg/uncollect_originId/#/json"; //#:替换为文章id

  //知识体系列表查询 GET
  static const QUERY_STUDY_TREE = "https://www.wanandroid.com/tree/json";

  //知识体系文章列表查询 GET cid 分类的id，上述二级目录的id
  //	页码：拼接在链接上，从0开始。
  static const QUERY_STUDY_TREE_ART =
      "https://www.wanandroid.com/article/list/#/json?cid=@"; //@:替换为二级目录id，#:替换为页码
}
