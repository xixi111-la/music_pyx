import { getMomentList } from '../apis';
import { MomentListType } from '../models/Index';

@Component
export default struct Moment {
  // 状态变量：动态列表数据
  @State momentList: MomentListType[] = [];

  async aboutToAppear() {
    // 请求动态列表数据
    this.momentList = await getMomentList() as MomentListType[];
  }

  build() {
    Column() {
      // 顶部标题
      Text('互动广场')
        .fontColor('#fff')
        .width('100%')
        .margin({ top: 10, bottom: 10 })
        .textAlign(TextAlign.Center)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 动态列表
      List({ space: 12 }) {
        ForEach(this.momentList, (item: MomentListType) => {
          ListItem() {
            Row({ space: 12 }) {
              // 左侧：用户头像
              Row() {
                Image(item.avatar)
                  .borderRadius(40)
                  .width(40)
                  .aspectRatio(1)
                  .objectFit(ImageFit.Cover)
              }

              // 右侧：动态内容
              Column({ space: 12 }) {
                // 1. 作者名
                Text(item.author)
                  .fontColor('#e9e9e7')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                // 2. 动态文字内容
                Text(item.content)
                  .fontColor('#aaa9af')
                  .fontSize(12)
                  .width('100%')

                // 3. 关联的歌曲卡片
                Row() {
                  // 歌曲封面
                  Image(item.song.img)
                    .width(60)
                    .aspectRatio(1)
                    .objectFit(ImageFit.Cover)

                  // 歌曲信息（标题+歌手）
                  Column({ space: 10 }) {
                    Text(item.song.title)
                      .fontColor('#f4f4f6')
                      .fontSize(12)
                    Text(item.song.artist)
                      .fontColor('#a8a8ad')
                      .fontSize(10)
                  }
                  .layoutWeight(1)
                  .height(60)
                  .alignItems(HorizontalAlign.Start)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .padding(12)

                  // 播放按钮
                  // 需添加 ic_single_play 图标资源
                  Image($r('app.media.ic_single_play'))
                    .width(20)
                    .fillColor('#ececec')
                    .margin({ right: 12 })
                }
                .backgroundColor('#46474c')
                .width('100%')
                .borderRadius(8)
                .clip(true)

                // 4. 底部互动栏（分享、评论、点赞）
                Row({ space: 20 }) {
                  // 分享
                  Row() {
                    // 需添加 ic_share 图标资源
                    Image($r('app.media.ic_share'))
                      .width(20)
                      .fillColor('#c9c8cd')
                    Text('分享')
                      .fontColor('#9e9da2')
                      .fontSize(12)
                      .margin({ left: 4 })
                  }

                  // 评论
                  Row() {
                    // 需添加 ic_comment_o 图标资源
                    Image($r('app.media.ic_comment_o'))
                      .width(20)
                      .fillColor('#c9c8cd')
                    Text(item.comment.toString())
                      .fontColor('#9e9da2')
                      .fontSize(12)
                      .margin({ left: 4 })
                  }

                  // 点赞
                  Row() {
                    // 需添加 ic_like 图标资源
                    Image($r('app.media.ic_like'))
                      .width(20)
                      .fillColor('#c9c8cd')
                    Text(item.like.toString())
                      .fontColor('#9e9da2')
                      .fontSize(12)
                      .margin({ left: 4 })
                  }
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .alignItems(VerticalAlign.Top)
            .padding({ top: 24, bottom: 24 })
            .borderWidth({ bottom: 1 })
            .borderColor('#292931')
          }
        })

        // 底部“到底了”提示
        ListItem() {
          Row() {
            Text('到底了~')
              .fontColor(Color.Gray)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding(16)
        }
      }
      .width('100%')
      .height('100%')
      .padding({ right: 32, left: 16 })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(8)
    .backgroundColor('#000')
  }
}