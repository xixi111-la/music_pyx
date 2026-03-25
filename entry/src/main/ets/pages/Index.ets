import { TabType } from '../models/Index';
import Recommend from '../views/Recommend';
import Find from '../views/Find';
import Moment from '../views/Moment';
import Mine from '../views/Mine';
import { SAFE_TOP, SAFE_BOTTOM } from '../constants';

@Entry
@Component
struct Index {
  // 当前高亮的页签标识
  @State isActive: string = 'recommend';
  // 读取顶部/底部安全区域高度
  @StorageProp(SAFE_TOP) safeTop: number = 0;
  @StorageProp(SAFE_BOTTOM) safeBottom: number = 0;

  // Tab栏数据（需提前在resources/base/media添加4个图标文件）
  tabData: TabType[] = [
    { icon: $r('app.media.ic_recommend'), text: '推荐', name: 'recommend' },
    { icon: $r('app.media.ic_find'), text: '发现', name: 'find' },
    { icon: $r('app.media.ic_moment'), text: '动态', name: 'moment' },
    { icon: $r('app.media.ic_mine'), text: '我的', name: 'mine' }
  ];

  // 自定义TabBar构建函数（图标+文字）
  @Builder
  tabBarBuilder(item: TabType) {
    Column({ space: 5 }) {
      Image(item.icon)
        .height(24)
        .fillColor(this.isActive === item.name ? '#e4608b' : '#6da8a5')
      Text(item.text)
        .fontSize(14)
        .fontColor(this.isActive === item.name ? '#e4608b' : '#6da8a5')
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      ForEach(this.tabData, (item: TabType) => {
        TabContent() {
          // 根据页签标识渲染对应内容视图
          if (item.name === 'recommend') Recommend()
          else if (item.name === 'find') Find()
          else if (item.name === 'moment') Moment()
          else if (item.name === 'mine') Mine()
        }
        .backgroundColor('#131215')
        .padding({ top: this.safeTop }) // 内容顶部避开状态栏
        .tabBar(this.tabBarBuilder(item))
      })
    }
    .backgroundColor('#3b3f42')
    .padding({ bottom: this.safeBottom }) // Tab栏底部避开导航条
    .onChange((index: number) => {
      // 切换页签时更新高亮状态
      this.isActive = this.tabData[index].name;
    })
  }
}