import { SAFE_TOP } from '../constants';
import router from '@ohos.router';

@Entry
@Component
struct Start {
  // 读取顶部安全区域高度
  @StorageProp(SAFE_TOP) safeTop: number = 0;

  build() {
    Column() {
      // 右上角“跳过”按钮
      Row() {
        Button('跳过')
          .fontSize(14)
          .fontColor('#fff')
          .backgroundColor('#e4608b')
          .onClick(() => {
            // 跳转到主页面（替换当前页，避免返回启动页）
            router.replaceUrl({ url: 'pages/Index' });
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ right: 10, top: this.safeTop + 10 })

      // 启动页中间内容（可替换为Logo、广告图等）
      Column() {
        Text('启动页')
          .fontSize(28)
          .fontColor('#fff')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#131215')
  }
}