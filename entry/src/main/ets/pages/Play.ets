// import { SongItem, PlayState } from '../models/Index';
// import { SONG_KEY } from '../constants';
// import AVPlayerManager from '../utils/AVPlayerManager';
// @Entry
// @Component
// struct Play {
//   @State panelHeight: string = '0%';
//   @StorageLink(SONG_KEY) // changed from @State
//   @Watch('changeAnimate')
//   playState: PlayState = new PlayState();
//   // @State playState: PlayState = new PlayState();
//   @State rotateAngle: number = 0;
//
//   changeAnimate() {
//     if (this.playState.isPlay) {
//       this.animatorResult.play();
//     } else {
//       this.animatorResult.pause();
//     }
//   }
//   number2time(number: number) {
//     // 判断是否大于1分钟
//     if (number >= 60 * 1000) {
//       const s = Math.ceil(number / 1000 % 60);
//       const m = Math.floor(number / 1000 / 60);
//       const second = s.toString().padStart(2, '0');
//       const minute = m.toString().padStart(2, '0');
//       return minute + ':' + second;
//     } else {
//       const s = Math.ceil(number / 1000 % 60);
//       const second = s.toString().padStart(2, '0');
//       return '00:' + second;
//     }
//   }
//
//
//
//   // 定义动画对象：实现唱片旋转效果
//   animatorResult = this.getUIContext().createAnimator({
//     duration: 1000 * 15, // 15秒转一圈
//     easing: 'linear',
//     delay: 0,
//     fill: 'none',
//     direction: 'normal',
//     iterations: -1, // 无限循环
//     begin: 0,
//     end: 360
//   })
//
//   aboutToAppear() {
//     // 监听动画帧，更新旋转角度
//     this.animatorResult.onFrame = val => {
//       this.rotateAngle = val;
//     };
//   }
//
//   build() {
//     Stack({ alignContent: Alignment.Bottom }) {
//       // ---------------- 1. 主播放区域 ----------------
//       this.PlayAreaBuilder()
//
//       // ---------------- 2. 底部弹出的播放列表 ----------------
//       Column() {
//         // 点击空白区域关闭
//         Column()
//           .width('100%')
//           .layoutWeight(1)
//           .onClick(() => {
//             this.panelHeight = '0%';
//           })
//
//         // 播放列表本体
//         Column() {
//           this.PlayListHeaderBuilder()
//           this.PlayListContentBuilder()
//         }
//         .height(400)
//       }
//       .height(this.panelHeight)
//       .animation({ duration: 300 }) // 弹出动画
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor('#333')
//   }
//
//   // ---------------- 自定义构建函数拆分 ----------------
//
//   /** 步骤5+6+7：主播放区域 */
//   @Builder
//   PlayAreaBuilder() {
//     Stack() {
//       // 1. 背景图（模糊处理）
//       Image(this.playState.img)
//         .width('100%')
//         .height('100%')
//         .blur(100) // 模糊半径
//         .objectFit(ImageFit.Cover)
//
//       // 2. 前景内容
//       Column() {
//         Column() {
//           // (1) 封面图区域（唱片+唱针）
//           this.CoverImageBuilder()
//
//           // (2) 歌曲信息区域
//           Stack() {
//             Column({ space: 8 }) {
//               Text(this.playState.title)
//                 .fontSize(28)
//                 .fontWeight(FontWeight.Bold)
//                 .fontColor(Color.White)
//               Text(this.playState.artist)
//                 .fontSize(18)
//                 .fontColor(Color.White)
//             }
//             .layoutWeight(1)
//             .justifyContent(FlexAlign.Center)
//           }
//           .layoutWeight(1)
//
//           // (3) 互动Badge区域
//           Row() {
//             Badge({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC', borderWidth: 0 } }) {
//               Image($r('app.media.ic_like'))
//                 .fillColor(Color.White)
//                 .width(24)
//                 .margin({ right: 2 })
//             }
//             Badge({ value: '10W', style: { badgeSize: 12, badgeColor: '#45cccccc', borderWidth: 0 } }) {
//               Image($r('app.media.ic_comment_o'))
//                 .fillColor(Color.White)
//                 .width(18)
//                 .margin({ right: 4 })
//             }
//             Badge({ value: 'hot', style: { badgeSize: 12, badgeColor: '#a8ff3131', borderWidth: 0 } }) {
//               Image($r('app.media.ic_bells_o'))
//                 .fillColor(Color.White)
//                 .width(24)
//             }
//             Badge({ value: 'vip', style: { badgeSize: 12, badgeColor: '#b7efd371', borderWidth: 0 } }) {
//               Image($r('app.media.ic_download_o'))
//                 .fillColor(Color.White)
//                 .width(24)
//             }
//           }
//           .width('100%')
//           .justifyContent(FlexAlign.SpaceAround)
//
//           // (4) 播放控制区域
//           this.ControllerBuilder()
//         }
//         .layoutWeight(1)
//         .width('100%')
//       }
//       .padding({ bottom: 20 })
//     }
//     .width('100%')
//     .height('100%')
//     .backgroundColor(Color.Transparent)
//   }
//
//   /** 步骤6：封面图（唱片+唱针） */
//   @Builder
//   CoverImageBuilder() {
//     Stack({ alignContent: Alignment.Top }) {
//       // 唱片
//       Row() {
//         Row() {
//           Image(this.playState.img)
//             .width('70%')
//             .borderRadius(400)
//             .objectFit(ImageFit.Cover)
//         }
//         // 需添加 ic_cd 唱片背景图资源
//         .backgroundImage($r('app.media.ic_cd'))
//         .backgroundImageSize(ImageSize.Cover)
//         .justifyContent(FlexAlign.Center)
//         .width('100%')
//         .borderRadius(400)
//         .clip(true)
//         .aspectRatio(1)
//         .rotate({ angle: this.rotateAngle }) // 绑定旋转动画
//       }
//       .margin({ top: 50 })
//       .width('90%')
//       .aspectRatio(1)
//       .justifyContent(FlexAlign.Center)
//       .padding(24)
//
//       // 唱针
//       // 需添加 ic_stylus 唱针图资源
//       Image($r('app.media.ic_stylus'))
//         .width(200)
//         .aspectRatio(1)
//         .rotate({
//           angle: this.playState.isPlay ? -45 : -55, // 播放时移入，暂停时移出
//           centerX: 100,
//           centerY: 30
//         })
//         .animation({ duration: 500 })
//     }
//   }
//
//   /** 步骤7：播放控制条 */
//   @Builder
//   ControllerBuilder() {
//     Column() {
//       // 1. 进度条区域
//       Row({ space: 4 }) {
//         Text('00:00') // 当前时间（需后续逻辑更新）
//           .fontSize(12)
//           .fontColor(Color.White)
//         Slider({ value: 0, min: 0, max: 100 })
//           .layoutWeight(1)
//           .blockColor(Color.White)
//           .selectedColor(Color.White)
//           .trackColor('#ccc5c5c5')
//           .trackThickness(2)
//         Text('00:00') // 总时长（需后续逻辑更新）
//           .fontSize(12)
//           .fontColor(Color.White)
//       }
//       .width('100%')
//       .padding(24)
//
//       // 2. 按钮控制区域
//       Row() {
//         // (1) 播放模式切换
//         if (this.playState.playMode == 'auto') {
//           // 需添加 ic_auto 图标
//           Image($r('app.media.ic_auto'))
//             .fillColor(Color.White)
//             .width(30)
//             .onClick(() => { this.playState.playMode = 'repeat'; })
//         } else if (this.playState.playMode == 'repeat') {
//           // 需添加 ic_repeat 图标
//           Image($r('app.media.ic_repeat'))
//             .fillColor(Color.White)
//             .width(30)
//             .onClick(() => { this.playState.playMode = 'random'; })
//         } else if (this.playState.playMode == 'random') {
//           // 需添加 ic_random 图标
//           Image($r('app.media.ic_random'))
//             .fillColor(Color.White)
//             .width(30)
//             .onClick(() => { this.playState.playMode = 'auto'; })
//         }
//
//         // (2) 上一首
//         // 需添加 ic_prev 图标
//         Image($r('app.media.ic_prev'))
//           .fillColor(Color.White)
//           .width(30)
//           .onClick(() => {
//             // 注意：这里需要你自己实现 AVPlayerManager
//             // AVPlayerManager.prevPlay();
//           })
//
//         // (3) 播放/暂停
//         // 需添加 ic_play / ic_paused 图标
//         Image(this.playState.isPlay ? $r('app.media.ic_paused') : $r('app.media.ic_play'))
//           .fillColor(Color.White)
//           .width(50)
//           .onClick(() => {
//             if (this.playState.isPlay) {
//               // AVPlayerManager.pause();
//               this.playState.isPlay = false;
//               this.animatorResult.pause();
//             } else {
//               // AVPlayerManager.singPlay(...);
//               this.playState.isPlay = true;
//               this.animatorResult.play();
//             }
//           })
//
//         // (4) 下一首
//         // 需添加 ic_next 图标
//         Image($r('app.media.ic_next'))
//           .fillColor(Color.White)
//           .width(30)
//           .onClick(() => {
//             // AVPlayerManager.nextPlay();
//           })
//
//         // (5) 打开播放列表
//         // 需添加 ic_song_list 图标
//         Image($r('app.media.ic_song_list'))
//           .fillColor(Color.White)
//           .width(30)
//           .onClick(() => {
//             this.panelHeight = '100%';
//           })
//       }
//       .width('100%')
//       .padding({ bottom: 24 })
//       .justifyContent(FlexAlign.SpaceAround)
//     }
//   }
//
//   /** 步骤9：播放列表头部 */
//   @Builder
//   PlayListHeaderBuilder() {
//     Row() {
//       Row() {
//         Image($r('app.media.ic_play'))
//           .width(20)
//           .fillColor('#ff5186')
//       }
//       .width(50)
//       .aspectRatio(1)
//       .justifyContent(FlexAlign.Center)
//
//       Row({ space: 8 }) {
//         Text(`播放列表 (${this.playState.playList.length})`)
//           .fontColor(Color.White)
//           .fontSize(14)
//       }
//       .layoutWeight(1)
//
//       // 关闭按钮
//       Image($r('app.media.ic_close'))
//         .fillColor('#ffa49a9a')
//         .width(24)
//         .height(24)
//         .margin({ right: 16 })
//         .onClick(() => {
//           this.panelHeight = '0%';
//         })
//     }
//     .width('100%')
//     .backgroundColor('#ff353333')
//     .padding(8)
//     .border({ width: { bottom: 1 }, color: '#12ec5c87' })
//     .borderRadius({ topLeft: 4, topRight: 4 })
//   }
//
//   /** 步骤10：播放列表内容 */
//   @Builder
//   PlayListContentBuilder() {
//     List() {
//       ForEach(this.playState.playList, (item: SongItem, index: number) => {
//         ListItem() {
//           Row() {
//             // 序号
//             Row() {
//               Text((index + 1).toString())
//                 .fontColor('#ffa49a9a')
//             }
//             .width(50)
//             .aspectRatio(1)
//             .justifyContent(FlexAlign.Center)
//
//             // 歌曲信息
//             Row({ space: 10 }) {
//               Column() {
//                 Text(item.title)
//                   .fontSize(14)
//                   .fontColor(this.playState.playIndex == index ? '#f04c7e' : '#ffa49a9a')
//                 Text(item.artist)
//                   .fontSize(12)
//                   .fontColor(this.playState.playIndex == index ? '#f04c7e' : Color.Gray)
//               }
//               .layoutWeight(1)
//               .alignItems(HorizontalAlign.Start)
//               .justifyContent(FlexAlign.Center)
//             }
//             .layoutWeight(1)
//             .onClick(() => {
//               // 点击切歌
//               // AVPlayerManager.singPlay(this.playState.playList[index]);
//               this.playState.playIndex = index;
//             })
//
//             // 更多按钮
//             Image($r('app.media.ic_more'))
//               .width(24)
//               .height(24)
//               .margin({ right: 16 })
//               .fillColor(Color.Gray)
//           }
//           .alignItems(VerticalAlign.Center)
//         }
//         .border({ width: { bottom: 1 }, color: '#12ec5c87' })
//         // 注意：如果需要侧滑删除，需自行实现 deleteButton
//       })
//     }
//     .layoutWeight(1)
//     .width('100%')
//     .height('100%')
//     .backgroundColor('#ff353333')
//   }
// }

import { SongItem, PlayState } from '../models/Index';
import { SONG_KEY } from '../constants';
import AVPlayerManager from '../utils/AVPlayerManager';

@Entry
@Component
struct Play {
  @State panelHeight: string = '0%';

  // 绑定 AppStorage 和状态监听器
  @StorageLink(SONG_KEY)
  @Watch('changeAnimate')
  playState: PlayState = new PlayState();

  @State rotateAngle: number = 0;

  // 状态变化监听器：控制唱片旋转
  changeAnimate() {
    if (this.playState.isPlay) {
      this.animatorResult.play();
    } else {
      this.animatorResult.pause();
    }
  }

  // 时间格式化工具：毫秒 -> 分:秒
  number2time(number: number) {
    // 增加判空保护，防止 number 为 undefined 报错
    if (!number) return '00:00';

    if (number >= 60 * 1000) {
      const s = Math.ceil(number / 1000 % 60);
      const m = Math.floor(number / 1000 / 60);
      const second = s.toString().padStart(2, '0');
      const minute = m.toString().padStart(2, '0');
      return minute + ':' + second;
    } else {
      const s = Math.ceil(number / 1000 % 60);
      const second = s.toString().padStart(2, '0');
      return '00:' + second;
    }
  }

  // 定义动画对象：实现唱片旋转效果
  animatorResult = this.getUIContext().createAnimator({
    duration: 1000 * 15, // 15秒转一圈
    easing: 'linear',
    delay: 0,
    fill: 'none',
    direction: 'normal',
    iterations: -1, // 无限循环
    begin: 0,
    end: 360
  })

  aboutToAppear() {
    // 监听动画帧，更新旋转角度
    this.animatorResult.onFrame = val => {
      this.rotateAngle = val;
    };
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // ---------------- 1. 主播放区域 ----------------
      this.PlayAreaBuilder()

      // ---------------- 2. 底部弹出的播放列表 ----------------
      Column() {
        // 点击空白区域关闭
        Column()
          .width('100%')
          .layoutWeight(1)
          .onClick(() => {
            this.panelHeight = '0%';
          })

        // 播放列表本体
        Column() {
          this.PlayListHeaderBuilder()
          this.PlayListContentBuilder()
        }
        .height(400)
      }
      .height(this.panelHeight)
      .animation({ duration: 300 }) // 弹出动画
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#333')
  }

  // ---------------- 自定义构建函数拆分 ----------------

  /** 主播放区域 */
  @Builder
  PlayAreaBuilder() {
    Stack() {
      // 1. 背景图（模糊处理）
      // 增加判空，防止没数据时加载报错
      if (this.playState.img) {
        Image(this.playState.img)
          .width('100%')
          .height('100%')
          .blur(100)
          .objectFit(ImageFit.Cover)
      }

      // 2. 前景内容
      Column() {
        Column() {
          // (1) 封面图区域（唱片+唱针）
          this.CoverImageBuilder()

          // (2) 歌曲信息区域
          Stack() {
            Column({ space: 8 }) {
              Text(this.playState.title || '未播放')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
              Text(this.playState.artist || '未知艺术家')
                .fontSize(18)
                .fontColor(Color.White)
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.Center)
          }
          .layoutWeight(1)

          // (3) 互动Badge区域
          Row() {
            Badge({ value: '99+', style: { badgeSize: 12, badgeColor: '#45CCCCCC', borderWidth: 0 } }) {
              Image($r('app.media.ic_like'))
                .fillColor(Color.White)
                .width(24)
                .margin({ right: 2 })
            }
            Badge({ value: '10W', style: { badgeSize: 12, badgeColor: '#45cccccc', borderWidth: 0 } }) {
              Image($r('app.media.ic_comment_o'))
                .fillColor(Color.White)
                .width(18)
                .margin({ right: 4 })
            }
            Badge({ value: 'hot', style: { badgeSize: 12, badgeColor: '#a8ff3131', borderWidth: 0 } }) {
              Image($r('app.media.ic_bells_o'))
                .fillColor(Color.White)
                .width(24)
            }
            Badge({ value: 'vip', style: { badgeSize: 12, badgeColor: '#b7efd371', borderWidth: 0 } }) {
              Image($r('app.media.ic_download_o'))
                .fillColor(Color.White)
                .width(24)
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)

          // (4) 播放控制区域
          this.ControllerBuilder()
        }
        .layoutWeight(1)
        .width('100%')
      }
      .padding({ bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
  }

  /** 封面图（唱片+唱针） */
  @Builder
  CoverImageBuilder() {
    Stack({ alignContent: Alignment.Top }) {
      // 唱片
      Row() {
        Row() {
          if (this.playState.img) {
            Image(this.playState.img)
              .width('70%')
              .borderRadius(400)
              .objectFit(ImageFit.Cover)
          }
        }
        .backgroundImage($r('app.media.ic_cd'))
        .backgroundImageSize(ImageSize.Cover)
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .borderRadius(400)
        .clip(true)
        .aspectRatio(1)
        .rotate({ angle: this.rotateAngle })
      }
      .margin({ top: 50 })
      .width('90%')
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .padding(24)

      // 唱针
      Image($r('app.media.ic_stylus'))
        .width(200)
        .aspectRatio(1)
        .rotate({
          angle: this.playState.isPlay ? -45 : -55,
          centerX: 100,
          centerY: 30
        })
        .animation({ duration: 500 })
    }
  }

  /** 播放控制条（核心修改区域） */
  @Builder
  ControllerBuilder() {
    Column() {
      // 1. 进度条区域
      Row({ space: 4 }) {
        // 当前时间
        Text(this.number2time(this.playState.time))
          .fontSize(12)
          .fontColor(Color.White)

        // 进度条
        Slider({
          value: this.playState.time,
          min: 0,
          max: this.playState.duration > 0 ? this.playState.duration : 100
        })
          .layoutWeight(1)
          .blockColor(Color.White)
          .selectedColor(Color.White)
          .trackColor('#ccc5c5c5')
          .trackThickness(2)
          .onChange(value => {
            // 拖动进度条跳转
            AVPlayerManager.player.seek(value);
          })

        // 总时长
        Text(this.number2time(this.playState.duration))
          .fontSize(12)
          .fontColor(Color.White)
      }
      .width('100%')
      .padding(24)

      // 2. 按钮控制区域
      Row() {
        // (1) 播放模式切换
        if (this.playState.playMode == 'auto') {
          Image($r('app.media.ic_auto'))
            .fillColor(Color.White)
            .width(30)
            .onClick(() => {
              this.playState.playMode = 'repeat';
              // 可选：同步修改管理器里的模式
              if(AVPlayerManager.currentSong) {
                AVPlayerManager.currentSong.playMode = 'repeat';
              }
            })
        } else if (this.playState.playMode == 'repeat') {
          Image($r('app.media.ic_repeat'))
            .fillColor(Color.White)
            .width(30)
            .onClick(() => {
              this.playState.playMode = 'random';
              if(AVPlayerManager.currentSong) {
                AVPlayerManager.currentSong.playMode = 'random';
              }
            })
        } else if (this.playState.playMode == 'random') {
          Image($r('app.media.ic_random'))
            .fillColor(Color.White)
            .width(30)
            .onClick(() => {
              this.playState.playMode = 'auto';
              if(AVPlayerManager.currentSong) {
                AVPlayerManager.currentSong.playMode = 'auto';
              }
            })
        }

        // (2) 【步骤3】上一首按钮
        Image($r('app.media.ic_prev'))
          .fillColor(Color.White)
          .width(30)
          .onClick(() => {
            AVPlayerManager.prevPlay();
          })

        // (3) 播放/暂停按钮
        Image(this.playState.isPlay ? $r('app.media.ic_paused') : $r('app.media.ic_play'))
          .fillColor(Color.White)
          .width(50)
          .onClick(() => {
            if (this.playState.isPlay) {
              AVPlayerManager.pause();
            } else {
              // 判空保护
              if (this.playState.playList && this.playState.playList.length > 0) {
                AVPlayerManager.singPlay(this.playState.playList[this.playState.playIndex]);
              }
            }
          })

        // (4) 【步骤4】下一首按钮
        Image($r('app.media.ic_next'))
          .fillColor(Color.White)
          .width(30)
          .onClick(() => {
            AVPlayerManager.nextPlay();
          })

        // (5) 打开播放列表
        Image($r('app.media.ic_song_list'))
          .fillColor(Color.White)
          .width(30)
          .onClick(() => {
            this.panelHeight = '100%';
          })
      }
      .width('100%')
      .padding({ bottom: 24 })
      .justifyContent(FlexAlign.SpaceAround)
    }
  }

  /** 播放列表头部 */
  @Builder
  PlayListHeaderBuilder() {
    Row() {
      Row() {
        Image($r('app.media.ic_play'))
          .width(20)
          .fillColor('#ff5186')
      }
      .width(50)
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)

      Row({ space: 8 }) {
        Text(`播放列表 (${this.playState.playList ? this.playState.playList.length : 0})`)
          .fontColor(Color.White)
          .fontSize(14)
      }
      .layoutWeight(1)

      // 关闭按钮
      Image($r('app.media.ic_close'))
        .fillColor('#ffa49a9a')
        .width(24)
        .height(24)
        .margin({ right: 16 })
        .onClick(() => {
          this.panelHeight = '0%';
        })
    }
    .width('100%')
    .backgroundColor('#ff353333')
    .padding(8)
    .border({ width: { bottom: 1 }, color: '#12ec5c87' })
    .borderRadius({ topLeft: 4, topRight: 4 })
  }

  /** 播放列表内容 */
  @Builder
  PlayListContentBuilder() {
    List() {
      // 判空保护
      if (this.playState.playList && this.playState.playList.length > 0) {
        ForEach(this.playState.playList, (item: SongItem, index: number) => {
          ListItem() {
            Row() {
              // 序号
              Row() {
                Text((index + 1).toString())
                  .fontColor('#ffa49a9a')
              }
              .width(50)
              .aspectRatio(1)
              .justifyContent(FlexAlign.Center)

              // 歌曲信息
              Row({ space: 10 }) {
                Column() {
                  Text(item.title)
                    .fontSize(14)
                    .fontColor(this.playState.playIndex == index ? '#f04c7e' : '#ffa49a9a')
                  Text(item.artist)
                    .fontSize(12)
                    .fontColor(this.playState.playIndex == index ? '#f04c7e' : Color.Gray)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.Center)
              }
              .layoutWeight(1)
              .onClick(() => {
                // 点击切歌
                AVPlayerManager.singPlay(this.playState.playList[index]);
              })

              // 更多按钮
              Image($r('app.media.ic_more'))
                .width(24)
                .height(24)
                .margin({ right: 16 })
                .fillColor(Color.Gray)
            }
            .alignItems(VerticalAlign.Center)
          }
          .border({ width: { bottom: 1 }, color: '#12ec5c87' })
        })
      }
    }
    .layoutWeight(1)
    .width('100%')
    .height('100%')
    .backgroundColor('#ff353333')
  }
}