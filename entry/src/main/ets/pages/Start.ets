// 全版本兼容的标准导入方式，绝对不会报导出错误
import router from '@ohos.router';

@Entry
@Component
struct Start {
  // 定时器 id
  timerId: number = 0;

  aboutToAppear(): void {
    // 5秒后自动跳转到首页，直接用全局路由，无初始化坑
    this.timerId = setTimeout(() => {
      router.replaceUrl({ url: 'pages/Index' });
    }, 5000);
  }

  aboutToDisappear(): void {
    // 页面销毁时清除定时器，避免内存泄漏
    clearTimeout(this.timerId);
  }

  build() {
    // 根容器必须设置全屏宽高，保证内容正常渲染
    Stack({ alignContent: Alignment.TopEnd }) {
      Image($r('app.media.ad'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      Button('跳过')
        .margin(10)
        .backgroundColor('#4d000000')
        .fontColor(Color.White)
        .onClick(() => {
          // 点击跳过直接跳转
          router.replaceUrl({ url: 'pages/Index' });
        })
    }
    .width('100%')
    .height('100%')
  }
}