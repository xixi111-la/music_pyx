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