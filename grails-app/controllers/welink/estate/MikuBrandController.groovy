package welink.estate

import com.google.common.collect.Lists
import grails.orm.PagedResultList
import org.apache.commons.lang3.StringUtils
import welink.common.MikuBrand

class MikuBrandController {


    def index() {
        String ppname=params.ppname
        if(ppname){
            List<MikuBrand> list=MikuBrand.findAllByIsDeletedAndNameIlike(0 as byte,"%" + ppname + "%")
            params.max=list.size()
        }
        def mkBrand=MikuBrand.createCriteria()
        PagedResultList pagedResultList=mkBrand.list (max: params.max ?: 10, offset: params.offset ?: 0){
            eq('isDeleted',0 as byte)
            if(ppname){
                ilike("name", "%" + ppname + "%")
            }
        }
        return [
                total          : pagedResultList?.totalCount,
                viewTotal      : pagedResultList?.totalCount,
                params         : params,
                mlist          : pagedResultList,
        ]

    }


    //添加对应品牌
    def addOneBrand()
    {

    }


    //进行添加对应的品牌
    def doAddBrand()
    {
        def name=params.name
        def fullname=params.fullname
        def company=params.company
        def memo=params.memo
        List<String> pics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
        new MikuBrand().with {
            it.name=name
            it.fullName=fullname
            it.company=company
            it.dateCreated=new Date()
            it.memo=memo
            it.lastUpdated=new Date()
            it.isDeleted=0 as byte
            it.picture=StringUtils.join(pics, ';')
            save(failOnError: true, flush: true)
        }
        redirect(controller: 'mikuBrand', action: 'index')
        return
    }


    //进行查找对应需要更改的brand
    def edit()
    {
        def id=params.long('id')
        MikuBrand brand=MikuBrand.findById(id)
        return [
                brand:brand
        ]
    }


    //进行修改对应的Brand
    def updateBrand()
    {
        def id=params.long('id')
        def name=params.name
        def fullname=params.fullname
        def company=params.company
        def memo=params.memo
        List<String> pics = params.'item-pic' ? Lists.newArrayList(params.'item-pic') : Collections.emptyList()
        MikuBrand brand=MikuBrand.findById(id)
        brand.with {
            it.name=name
            it.fullName=fullname
            it.company=company
            it.memo=memo
            it.lastUpdated=new Date()
            it.isDeleted=0 as byte
            it.picture=StringUtils.join(pics, ';')
            save(failOnError: true, flush: true)
        }
        redirect(controller: 'mikuBrand', action: 'index')
        return
    }


    def delete()
    {
        def id=params.long('id')
        MikuBrand brand=MikuBrand.findById(id)
        brand.with {
            it.lastUpdated=new Date()
            it.isDeleted=1 as byte
            save(failOnError: true, flush: true)
        }
        redirect(controller: 'mikuBrand', action: 'index')
        return
    }


}
