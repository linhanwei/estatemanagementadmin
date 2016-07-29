package welink.customized

import grails.converters.JSON

//解决问题的思路管理
class MikuScThinkingItemManageController {

    def index() {
        return []
    }

    def getscThinkingItemList(){
        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,1);
        returnData.put('msg' ,'获取成功');

        def scThinkingItemList = MikuMineScThinkingItem.findAll();

        returnData.put('result' ,scThinkingItemList);

        render(returnData as JSON);
    }
}
