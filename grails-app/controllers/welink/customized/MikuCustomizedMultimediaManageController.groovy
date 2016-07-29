package welink.customized

import com.google.common.collect.ImmutableMap
import com.google.common.collect.Lists
import grails.converters.JSON
import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
//私人定制多媒体(图像,音频,视频)管理
class MikuCustomizedMultimediaManageController {

    //定制类型：
    static ImmutableMap<Byte, String> mineTypeMap = ImmutableMap.builder()
            .put(0 as byte, "不限")
            .put(1 as byte, "护肤定制类")
            .put(2 as byte, "私密护理类")
            .put(3 as byte, "减肥定制类")
            .put(4 as byte, "脱发定制类")
//            .put(5, "待扩展")
            .build()

    //资源类型：
    static ImmutableMap<Byte, String> resTypeMap = ImmutableMap.builder()
            .put(1 as byte, "视频")
            .put(2 as byte, "音频")
            .put(3 as byte, "图片")
//            .put(4, "待扩展")
            .build()

    //分页数
    static ImmutableMap<Integer, String> PageMap = ImmutableMap.builder()
            .put(5, "5")
            .put(10, "10")
            .put(20, "20")
            .put(30, "30")
            .put(40, "40")
            .put(50, "50")
            .put(100, "100")
            .put(200, "200")
            .put(500, "500")
            .build()

    //列表
    def index() {

        String resName = params.resName;
        Byte mineType = params.byte('mineType');
        Byte resType = params.byte('resType');

        def mikuMineMultimediaRes = MikuMineMultimediaRes.createCriteria();
        PagedResultList pagedResultList = mikuMineMultimediaRes.list(max: params.max ?:10, offset: params.offset ?: 0) {

            if(resName){
                ilike('resName',"%"+resName+"%")
            }

            if(mineType >= (0 as byte)){
                eq('mineType',mineType)
            }

            if(resType > (0 as byte)){
                eq('resType',resType)
            }

            order("lastUpdated","desc")
        }

        pagedResultList.each {
            MikuMineMultimediaRes item->
                item.resTime = (item.resTime/60L);
        }

        return [
                params      : params,
                PageMap      : PageMap,
                total       : pagedResultList?.totalCount,
                list:pagedResultList,
                mineTypeMap:mineTypeMap,
                resTypeMap:resTypeMap
        ]
    }

    //添加页面
    def addView(){

        return [
            mineTypeMap:mineTypeMap,
            resTypeMap:resTypeMap
        ]
    }

    //添加
    def add(){
        Long id = params.long('id');
        Byte mineType = params.byte('mineType');
        Byte resType = params.byte('resType');
        String resName = params.resName;
        String resShortName = params.resShortName;
        List<String> itemPics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList();
        String resUrl = params.resUrl;
        Long resTime = params.resTime ? params.long('resTime')*60L : 0L;
        String  resUseRemind = params.resUseRemind;

        MikuMineMultimediaRes mikuMineMultimediaRes = new MikuMineMultimediaRes();
        if(id){
            mikuMineMultimediaRes = MikuMineMultimediaRes.findById(id);
        }

        mikuMineMultimediaRes.with {

            it.mineType = mineType
            it.resType = resType
            it.resName = resName
            it.resShortName = resShortName
            it.resTime = resTime
            it.resUseRemind = resUseRemind

            if(resType == (3 as byte)){
                it.resUrl = StringUtils.join(itemPics, ';')
            }else{
                it.resUrl = resUrl;
            }

            if(!id){
                it.dateCreated = new Date();
            }

            it.lastUpdated = new Date();
            it.save(failOnError: true, flush: true);
        }

        redirect(action: 'index');
    }

    //修改页面
    def editView(){
        Long id = params.long('id');
        List<String> picList = new ArrayList<>();

        def info = MikuMineMultimediaRes.findById(id);

        if(info){
            if (info.resType == (3 as byte) && info.resUrl){
                info.resUrl.split(";").each {
                    picList.add(it);
                }
            }

            info.resTime = (info.resTime/60L)
        }

        return [
            info:info,
            mineTypeMap:mineTypeMap,
            resTypeMap:resTypeMap,
            picList:picList

        ]
    }

    //删除
    def del(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,0);
        returnData.put('msg' ,'删除失败');

        def id = params.long('id');

        if(!id){
            returnData.put('msg' ,'请选择产品');
            render(returnData as JSON);
        }

        MikuMineMultimediaRes info = MikuMineMultimediaRes.findById(id);
        if(info){
            info.delete(flush:true);

            returnData.put('status' ,1);
            returnData.put('msg' ,'删除成功');
        }

        render(returnData as JSON);
    }

    //获取视频列表
    def getAllList(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,1);
        returnData.put('msg' ,'获取成功');

        def list = MikuMineMultimediaRes.findAll();
        returnData.put('result' ,list);

        render(returnData as JSON);
    }

}
