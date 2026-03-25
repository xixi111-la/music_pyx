import { getSwiper, getDailyRecommend, getRecommendList } from '../apis';
import { DailyRecommendType, RecommendListType } from '../models/Index';

@Component
export default struct Recommend {
  // ---------------- 状态变量 ----------------
  @State swiperList: string[] = [];              // 轮播图数据
  @State dailyRecommend: DailyRecommendType[] = []; // 每日推荐数据
  @State recommendList: RecommendListType[] = [];   // 推荐歌单数据

  // ---------------- 生命周期 ----------------
  async aboutToAppear() {
    // 页面加载时同时请求所有数据
    try {
      this.swiperList = await getSwiper() as string[];
      this.dailyRecommend = await getDailyRecommend() as DailyRecommendType[];
      this.recommendList = await getRecommendList() as RecommendListType[];
    } catch (error) {
      console.error('数据加载失败');
    }
  }

  // ---------------- 自定义构建函数 ----------------

  /** 1. 搜索区域构建器 */
  @Builder
  searchBuilder() {
    Row() {
      Row({ space: 5 }) {
        // 左侧放大镜图标（需添加 ic_search 图标资源）
        Image($r('app.media.ic_search'))
          .width(20)
          .fillColor('#7e7e7c')

        // 搜索输入框
        TextInput({ placeholder: '搜索歌曲' })
          .padding({ left: 3, top: 0, bottom: 0, right: 0 })
          .placeholderColor('#7e7e7c')
          .layoutWeight(1)
          .backgroundColor(Color.Transparent)

        // 右侧扫一扫图标（需添加 ic_code 图标资源）
        Image($r('app.media.ic_code'))
          .width(22)
          .fillColor('#7e7e7c')
      }
      .width('100%')
      .height(35)
      .backgroundColor('#2d2b29')
      .borderRadius(20)
      .padding({ left: 8, right: 8 })
    }
    .width('100%')
    .padding({ top: 15, bottom: 10, left: 8, right: 8 })
  }

  /** 2. 通用标题构建器（"每日推荐"和"推荐歌单"共用） */
  @Builder
  titleBuilder(title: string) {
    Row() {
      // 标题文字
      Text(title)
        .fontColor('#fff')
        .fontWeight(700)
        .fontSize(18)

      // 右侧"更多"图标（需添加 ic_more 图标资源）
      Image($r('app.media.ic_more'))
        .width(22)
        .fillColor('#fff')
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 5, bottom: 5 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  /** 3. 轮播图区域构建器 */
  @Builder
  swiperBuilder() {
    Swiper() {
      ForEach(this.swiperList, (item: string) => {
        Image(item)
          .width('100%')
          .aspectRatio(720 / 330) // 保持宽高比
          .borderRadius(8)
          .objectFit(ImageFit.Cover)
      })
    }
    .padding({ left: 8, right: 8 })
    .width('100%')
    .autoPlay(true)    // 自动播放
    .loop(true)        // 循环播放
    // 【已修复】正确的指示器属性配置
    .indicator(new DotIndicator()
      .color('#6da8a5')          // 未选中圆点颜色
      .selectedColor('#e4608b')  // 选中圆点颜色
    )
  }

  /** 4. 每日推荐区域构建器 */
  @Builder
  dailyBuilder() {
    this.titleBuilder('每日推荐')

    Scroll() {
      Row({ space: 10 }) {
        ForEach(this.dailyRecommend, (item: DailyRecommendType) => {
          Column() {
            // 顶部类型标签
            Text(item.type)
              .width('100%')
              .backgroundColor(item.top)
              .padding(8)
              .fontColor('#fff')
              .fontSize(12)
              .textAlign(TextAlign.Center)

            // 中间封面图
            Image(item.img)
              .width('100%')
              .aspectRatio(1) // 正方形
              .objectFit(ImageFit.Cover)

            // 底部标题
            Text(item.title)
              .width('100%')
              .backgroundColor(item.bottom)
              .padding(8)
              .fontColor('#fff')
              .fontSize(14)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .lineHeight(18)
              .textAlign(TextAlign.Center)
          }
          .width('40%')
          .borderRadius(8)
          .clip(true) // 裁剪圆角
        })
      }
      .padding({ left: 8, right: 8 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal) // 横向滚动
    .scrollBar(BarState.Off) // 隐藏滚动条
    .edgeEffect(EdgeEffect.Spring)
  }

  /** 5. 推荐歌单区域构建器 */
  @Builder
  songBuilder() {
    this.titleBuilder('推荐歌单')

    Scroll() {
      Row({ space: 8 }) {
        ForEach(this.recommendList, (item: RecommendListType) => {
          Column({ space: 5 }) {
            Stack({ alignContent: Alignment.BottomEnd }) {
              // 封面图
              Image(item.img)
                .width('100%')
                .aspectRatio(1)
                .borderRadius(8)
                .objectFit(ImageFit.Cover)

              // 播放量（叠加在右下角）
              Text(item.count)
                .margin({ right: 8, bottom: 8 })
                .fontColor('#fff')
                .fontWeight(FontWeight.Bold)
                .fontSize(12)
                .textShadow({ offsetX: 1, offsetY: 1, radius: 2, color: '#33000000' })
            }
            .width('100%')

            // 歌单标题
            Text(item.title)
              .width('100%')
              .fontColor('#fff')
              .fontSize(14)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .lineHeight(18)
          }
          .width('30%')
        })
      }
      .padding({ left: 8, right: 8 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  // ---------------- 页面主布局 ----------------
  build() {
    Scroll() {
      Column() {
        // 1. 搜索区域
        this.searchBuilder()

        // 2. 轮播图区域
        this.swiperBuilder()

        // 3. 每日推荐区域
        this.dailyBuilder()

        // 4. 推荐歌单区域
        this.songBuilder()

        // 底部留白，避免内容被Tab栏遮挡
        Blank(20)
      }
      .constraintSize({ minHeight: '100%' })
    }
    .scrollable(ScrollDirection.Vertical)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height('100%')
    .backgroundColor('#131215') // 页面背景色
  }
}