package welink.system

import welink.common.MikuShareLevel

class MikuItemShareParaController {

    def index() {

    }



    //��ѯȫ���ȼ�����
    def  getAllFrLevel()
    {
        Byte type=params.byte('type')
        List<MikuShareLevel> mlist=new ArrayList<MikuShareLevel>()
        //������Ʒ
        if (type==1 as byte){
            mlist= MikuShareLevel.findAllByShareTypeAndIsDeleted(1,0 as byte)
        }
        //��Ϊ����
        else if (type == 9 as byte){
            mlist= MikuShareLevel.findAllByShareTypeAndIsDeleted(2,0 as byte)
        }
        String content=com.alibaba.fastjson.JSON.toJSONString(mlist,true)
        render(content)
    }

}
