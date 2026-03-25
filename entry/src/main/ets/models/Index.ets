export interface TabType {
  icon: Resource;	// 页签的图标
  text: string;		// 页签的文本
  name: string;		// 页签的标识
}
// 【新增】每日推荐数据类型（从apis移过来也可以，保持导入路径一致即可）
export interface DailyRecommendType {
  img: string;
  title: string;
  type: string;
  top: string;
  bottom: string;
}

// 【新增】推荐歌单数据类型
export interface RecommendListType {
  img: string;
  title: string;
  count: string;
}

export interface SongItemType {
  img: string;		// 封面图
  title: string;	// 歌曲名称
  artist: string;	// 艺术家
  url: string;   	// 歌曲URL
  id: string;     // 唯一标识
}

export interface MomentListType {
  author: string;		  // 作者
  avatar: string;		  // 头像
  content: string;		// 内容
  comment: number;		// 评论数
  like: number;			  // 喜欢数
  song: SongItemType;	// 歌曲
}

export class SongItem implements SongItemType {
  img: string = '';
  title: string = '';
  artist: string = '';
  url: string = '';
  id: string = '';
  constructor(model: SongItemType) {
    this.img = model.img;
    this.title = model.title;
    this.artist = model.artist;
    this.url = model.url;
    this.id = model.id;
  }
}

