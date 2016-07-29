import me.chanjar.weixin.mp.api.WxMpService
import me.chanjar.weixin.mp.bean.WxMpCustomMessage
import welink.system.wechat.WxMpMemcachedConfigStorage
import welink.user.ProfileWechat

WxMpService wxMpService = ctx.getBean("wxMpService")
WxMpMemcachedConfigStorage wxMpMemcachedConfigStorage = ctx.getBean("wxMpConfigStorage")

println wxMpMemcachedConfigStorage.appId
println wxMpMemcachedConfigStorage.secret
println wxMpMemcachedConfigStorage.aesKey
println wxMpMemcachedConfigStorage.token


WxMpCustomMessage.WxArticle wxArticle = new WxMpCustomMessage.WxArticle()
wxArticle.url = "http://mp.weixin.qq.com/s?__biz=MzA3MDI3OTE3MA==&mid=207236140&idx=1&sn=5840cd8c124199bf8287e43ce1f0f4d4&key=0acd51d81cb052bc401f6c04f18901729dd05a6a4e5e3dddcfe5c7bce2f3751ff04d11ec04afce8560db0aa8c2282158&ascene=0&uin=MzQ4NTI1&devicetype=iMac+MacBookPro11%2C3+OSX+OSX+10.10.4+build(14E46)&version=11020113&pass_ticket=0J7s74TuqjhXgpp2zN0vKjmENU9RTdxKVRpySe51UHk%3D"
wxArticle.description = "点击“阅读原文”立即抢购"
wxArticle.title = "高温福利｜千份果盒免费领，果格格提供，人人有份！"
wxArticle.picUrl = "https://mmbiz.qlogo.cn/mmbiz/wUk5YhXvMp6uEOtZC7ibYIz7P7eS8xBfULLP8wX71YVWp0LQE8gXDas6ia2IATlx756r7TR48cOrLeNWf6XmjAHA/0?wx_fmt=jpeg"


ProfileWechat.findAll().each {
    ProfileWechat profileWechat ->
        try {
            WxMpCustomMessage message = WxMpCustomMessage.NEWS().toUser(profileWechat.openid).addArticle(wxArticle).build();
            wxMpService.customMessageSend(message);
        } catch (Exception e) {
            log.error(e.getMessage(), e)
        }
}

