package welink.system

import welink.common.MikuShareLevel

class MikuItemShareParaController {

    def index() {

    }



    //查询全部等级分类
    def  getAllFrLevel()
    {
        Byte type=params.byte('type')
        List<MikuShareLevel> mlist=new ArrayList<MikuShareLevel>()
        //正常商品
        if (type==1 as byte){
            mlist= MikuShareLevel.findAllByShareTypeAndIsDeleted(1,0 as byte)
        }
        //成为代理
        else if (type == 9 as byte){
            mlist= MikuShareLevel.findAllByShareTypeAndIsDeleted(2,0 as byte)
        }
        String content=com.alibaba.fastjson.JSON.toJSONString(mlist,true)
        render(content)
    }

}
