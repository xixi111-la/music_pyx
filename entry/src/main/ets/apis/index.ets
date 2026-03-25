import { http } from '@kit.NetworkKit';
// ---------------- 数据类型接口 ----------------

// 服务器基础地址（请替换为你自己的IP）
const baseUrl = 'http://172.23.0.1:3000';

/**
 * 通用网络请求方法
 * @param path 接口路径（如 '/data/swiper'）
 * @returns 服务器返回的JSON数据
 */
export const getData = async (path: string) => {
  const req = http.createHttp();
  try {
    const res = await req.request(baseUrl + path, {
      expectDataType: http.HttpDataType.OBJECT
    });
    req.destroy();
    return res.result;
  } catch (error) {
    req.destroy();
    // 简单的错误提示
    console.error(`网络请求失败：${error.code} ${error.message}`);
    throw new Error(`无法请求网络数据`);
  }
};

// ---------------- 具体接口 ----------------

// 获取轮播图数据
export const getSwiper = async () => {
  return await getData('/data/swiper');
};

// 获取每日推荐数据
export const getDailyRecommend = async () => {
  return await getData('/data/dailyRecommend');
};

// 获取推荐歌单数据
export const getRecommendList = async () => {
  return await getData('/data/recommendList');
};

