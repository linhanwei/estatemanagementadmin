package welink.customized

import grails.converters.JSON

//私人定制可以解决的问题管理
class MikuScProblemItemManageController {

    def index() {
        return []
    }

    def getProblemList(){

        Map<String,Object> returnData = new HashMap<String, Object>();
        returnData.put('status' ,1);
        returnData.put('msg' ,'获取成功');

        //可以解决的问题列表
        def scProblemItemList = MikuMineScProblemItem.findAll();
        returnData.put('result' ,scProblemItemList);

        render(returnData as JSON);
    }
}
