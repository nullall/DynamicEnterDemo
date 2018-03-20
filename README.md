# DynamicEnterDemo

说是动态显示功能模块入口，但其实是做了一个算是APP主页的小demo了。


### 动态显示功能入口

这部分代码已经抽取出来放在一个View（`ModeuleView`）里，可传入参数调用。


#### 主要思路

##### 跳转方法

从服务器端请求放着类名、图标地址等信息的数据，解析后画成按钮，点击其中一个后，调用一个统一的方法，传入类名等数据：

```
/**
进入功能模块

@param className 模块类名
*/
-(void)enterModule:(NSString*)className{
Class c =NSClassFromString(className);
UIViewController *controller;

#if __has_feature(objc_arc)

controller = [[c alloc]init];

#else

controller = [[[c alloc] init] autorelease];

#endif

[self.navigationController pushViewController:controller animated:YES];
}
```
##### 入口

按钮本来想放在`CollectionView`里，但原项目中按钮图标那块是左右滑动的，用`CollectionView`不大好实现效果。因此，如果是上下滑动的，可以用`CollectionView`去处理，而左右滑动的话，可能还是需要自己手动去绘制，然后放在`ScrollView`里。

在其中一个页面上也尝试了一下`CollectionView`的效果。这里就不多赘述了。

##### 特殊情况

针对某些特殊的功能，在跳转界面之前，可能需要做其他一些操作，传入一些什么数据，目前的想法是，这种情况出现的应该不会很多，大概只有少数几个功能模块会这样，那么就特殊情况特殊处理，当遇到这个模块的时候，就直接判断跳转调用相应方法。

> 实际应用的时候，肯定需要有个默认图标（默认加载失败的图标，每个入口都应该有它自己专属的，图片名用类名应该就可以了）

这样，届时平台就可以根据权限进行配置，然后服务器“推送”该用户可使用的（可能APP端用户权限的判断就不需要了，**不过服务器配置错了怎么办？** 另，服务器有问题时默认放出基础功能？）。


##### JSON
json格式暂时如下，主题颜色其实也可以不需要：

```
{
"themeColors": "AB1235 ",   //主题颜色
"banners":[],               //轮播图地址
"founctions": [{
"className": "",   //类名
"iconUrl": "",         //图标
"iconPressedUrl":"",
"title": "",        //功能名称
"value": "",        //值，可能也用不到，暂时先放着；届时传值可以用NSUserDefaults传值方式传递
"badge": 5,          //角标
"iconWidth":"",     //图片宽
"iconHeight":""     //图片高
}]
}
```

#### 首页面图标绘制思路

##### 设定参数

> 都是`int`类型

- 行数`rowNum`
- 列数`colNum`
- 一页的总数（`amount`）=行数*页数
- 总的页数（`pageNum`）=模块总数/`amount`+1

则scrollview的宽度范围便是：屏幕宽度*总的页数。

在for循环中绘制每页内容，共绘制`pageNum`页：

```
for (int i=0; i<pageNum; i++) {}
```
在每页上添加按钮：

```
for (int j=amount*i; j<MIN(amount*(i+1), self.moduleArray.count); j++) {}
```

绘制按钮时：
- 模块在数组里的位置`index`
- 按钮的宽（``btnWidth``）=屏幕宽度/列数
- 按钮的高（`btnHeight`）=scrollView.height/行数
- 按钮的x=`(index%colNum)*btnWidth`
- 按钮的y=`((index/colNum)%rowNum)*btnHeight`



##### 使用：

```
-(void)initModuleView{
ModeuleView *moduleView = [[ModeuleView alloc]initWithFrame:CGRectMake(0, 210, screenWidth, 240+37)];
moduleView.rowNum=3;
moduleView.colNum=4;
moduleView.moduleArray=self.moduleArray;
moduleView.viewController=self;
[self.view addSubview:moduleView];
}
```

### 轮播图

`BannerView`

可传入图片地址数组、UIimage数组、UIImageView数组。

可以自己调整`pageControl`的颜色设置。

##### 使用：

```
/**
用URL加载
*/
-(void)bannerLoadWithUrl{
BannerView *bannerV =[[BannerView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 200)];
bannerV.failedImage=@"bannerFailed";
bannerV.imageUrlArray=self.bannerArray;
[self.view addSubview:bannerV];
}
```




---
### 准备工作
#### 需要用到的第三方框架

- AFNetWorking
- SDWebImage
- MBProgressHUD

用cocoapods导入即可。

AFNetWorking的话，还要再拖个集成好的类进来，用之前的项目里的应该就可以了。

Podfile文件：
```
platform :ios, '8.0'
use_frameworks!

target 'DynamicEnterDemo' do
pod 'SDWebImage', '~> 4.0'
pod 'AFNetworking'

end
```
MBProgressHUD因为某些原因还是直接用了之前项目里的。手动拖了进来，这里不需要再做什么了。

#### demo里其他需要准备的东西

- 一堆的伪功能页面。新建完毕后随便放些控件上去即可（以示区别）。
- 一些方便代码编写的扩展类方法，从之前的项目里导入
- 设置Prefix.pch文件
- Define.h
- 加载失败图片
- 配置下本地服务器，弄好json文件、图片，用来网络请求用

> josn文件已经准备好了
