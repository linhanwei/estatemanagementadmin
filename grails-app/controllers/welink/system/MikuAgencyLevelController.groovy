package welink.system

import welink.common.MikuAgencyLevel

class MikuAgencyLevelController {

    def index() {
        List<MikuAgencyLevel> list=MikuAgencyLevel.findAllByIsDeleted(0 as  byte)
        return [
                list:list
        ]
    }



    def changeName(){
        Long id=params.long('id')
        String content=params.content
        MikuAgencyLevel mikuAgencyLevel=MikuAgencyLevel.findById(id)
        mikuAgencyLevel.with {
            it.levelName=content
            it.lastUpdated=new Date()
            it.save(failOnError: true, flush: true)
        }
        render(true)
    }

}
