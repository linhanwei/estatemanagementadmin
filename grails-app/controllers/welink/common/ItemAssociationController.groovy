package welink.common

import com.google.common.collect.Lists

class ItemAssociationController {

    def addAssociation() {
        Long itemId = params.long('itemId')

        List<String> associationSelects = params.associationSelect ? Lists.newArrayList(params.associationSelect) : Collections.emptyList()

        def oldassociations=ItemAssociation.withCriteria {
            eq('itemId',itemId)
            eq('status',1 as byte)
        }
        oldassociations.iterator().each {
            ItemAssociation itemAssociation->
                itemAssociation.status=0
                itemAssociation.save(failOnError: true,flush: true)
        }

        associationSelects.eachWithIndex {
            String it,int index->
                new ItemAssociation(
                        itemId: itemId,
                        targetId: Long.parseLong(it),
                        status: 1 as byte,
                        weight: index+1
                ).save(failOnError: true,flush: true)
        }

        redirect(url: '/itemPublish/edit?id='+itemId)

    }

    def queryItemAssociations() {
        Long id = params.long('id')

        def itemAssociations = ItemAssociation.findAllByItemIdAndStatus(id, 1 as byte)

        def allItems = Item.withCriteria {
            "in"('categoryId', [20000025L,20000026L])
            notEqual("approveStatus", -1 as byte)
        }

        ArrayList<Item> associationItems=Item.withCriteria {
            notEqual("approveStatus", -1 as byte)
            if(itemAssociations){
                'in'("id",itemAssociations*.targetId)
            }else {
                eq('id',-1L)
            }

        }
        render(template: 'associationItems', model: [
                allItems        : allItems,
                associationItems: associationItems*.title
        ])
    }

    def index() {}
}
