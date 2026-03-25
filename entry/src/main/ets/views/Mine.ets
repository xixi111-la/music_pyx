import { getSongList } from '../apis';
import { SongItemType, SongItem } from '../models/Index';

@Component
export default struct Mine {
  // 状态变量：4列歌曲数据（每列是一个SongItemType数组）
  @State showList: SongItemType[][] = [[], [], [], []];
  // 用于遍历的列索引
  columnList: number[] = [0, 1, 2, 3];

  async aboutToAppear() {
    // 请求歌曲原始数据
    const songList: SongItemType[] = await getSongList() as SongItemType[];

    // 为每一列生成随机打乱的歌曲列表
    this.columnList.forEach(item => {
      this.showList[item] = songList
        .map(song => new SongItem(song)) // 转换为SongItem类实例
        .sort(() => Math.random() - 0.5); // 随机打乱
    });
  }

  build() {
    Column() {
      // ---------------- 上半部分：背景歌曲墙 ----------------
      Column() {
        GridRow({ gutter: 8 }) {
          ForEach(this.columnList, (item: number) => {
            GridCol({ span: 3 }) {
              // 引用自定义的SongCard组件
              SongCard({ songs: this.showList[item] })
            }
          })
        }
      }
      .scale({ x: 1.15, y: 1.15, centerX: '50%', centerY: '0' }) // 放大并上对齐
      .height('75%')
      .width('100%')
      .backgroundColor('#000')

      // ---------------- 下半部分：个人信息 ----------------
      Column() {
        // 头像
        Column() {
          // 需添加 logo 图标资源
          Image($r('app.media.logo'))
            .width('90%')
            .objectFit(ImageFit.Cover)
        }
        .backgroundColor(Color.Black)
        .width(80)
        .aspectRatio(1) // 正方形
        .borderRadius(80) // 圆形
        .offset({ y: -40 }) // 向上偏移，与背景重叠

        // 用户名和VIP
        Column({ space: 12 }) {
          Row({ space: 8 }) {
            Text('黑马云音乐')
              .fontColor(Color.White)
              .fontSize(20)
            // 需添加 ic_vip 图标资源
            Image($r('app.media.ic_vip'))
              .width(40)
          }
          .offset({ y: -15 })

          // 标签信息（00后、星座等）
          Row() {
            // 需添加 ic_boy 图标资源
            Image($r('app.media.ic_boy'))
              .width(14)
              .fillColor('#ff23496b')
              .margin({ right: 4 })
            Text('00后')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('双子座')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('北京')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('歌龄·2年')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
          }

          // 数据信息（关注、粉丝、赞）
          Row() {
            Text('1 关注')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('10万 粉丝')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
            Text('167万 赞')
              .fontColor('#555')
              .margin({ right: 12 })
              .fontSize(14)
          }
        }
      }
      .width('100%')
      .height('25%')
      .backgroundColor('#121215')
    }
    .width('100%')
    .height('100%')
  }
}

// ---------------- 自定义子组件：单列歌曲卡片 ----------------
@Component
struct SongCard {
  // 接收父组件传入的歌曲数组
  @Prop songs: SongItemType[] = [];

  build() {
    List({ space: 12 }) {
      ForEach(this.songs, (item: SongItemType) => {
        ListItem() {
          Stack() {
            // 只显示歌曲封面图
            Image(item.img)
              .width('100%')
              .objectFit(ImageFit.Cover)
          }
          .width('100%')
          .aspectRatio(1) // 正方形
          .borderRadius(8)
          .clip(true) // 裁剪圆角
        }
      })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off) // 隐藏滚动条
    .edgeEffect(EdgeEffect.None) // 禁用边缘效果
  }
}


