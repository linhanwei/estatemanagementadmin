<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>

    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>

    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <style>
    .lineDiv
    {
        position: relative;
        border-bottom: 1px solid #eee;
        height: 30px;
        margin: 10px 0;
    }

    .title
    {
        position: absolute;
        width: 200px;
        height: 30px;
        line-height: 30px;
        text-align: center;
        left: 50%;
        top: -3px;
        /*background-color: #fff;*/
        margin-left: -100px;
        font-size: large;
        font-weight: 200;
    }

    .tipeHide{display: none;color: red}

    /*搜索*/
    ::-webkit-scrollbar-track {
        background-color: rgba(0, 0, 0, 0);
    }

    ::-webkit-scrollbar {
        width: 0px;
        background-color: rgba(0, 0, 0, 0);
    }

    ::-webkit-scrollbar-thumb {
        background-color: rgba(0, 0, 0, 0);
    }

    .row{position: relative;}
    .searchBox{border:1px solid #e5e5e5;padding:5px;position:absolute;
        top:34px;
        width:92.5%;z-index: 9;background-color: #fff;
    }
    .searchBox dl{max-height:100px;overflow-y: auto;margin-bottom: 0}
    .searchBox dd{padding:2px 3px;font-size: 14px;}
    .searchBox .close{position:absolute;top:5px;right:5px}
    .searchBox dd:hover{background-color: #1094fa;
        color: #fff;}


    .inputClose{ position: absolute; right: 22px;top: 6px;font-size: 18px;cursor: pointer;}
    </style>

</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        私人订制
        <small>产品管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>产品管理</a></li>
        <li class="active">增加产品</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-xs-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="index">产品列表</g:link></li>
                    <li class="active"><g:link action="addView">编辑产品</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <g:form name="item_form" useToken="true" action="add">
            <input type="hidden" id="hidden_id" name="id" value="${info.id}"/>
            <div class="box-header">
            </div>

            <div class="box-body no-padding form-horizontal list-group">

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">产品名：</label>

                    <div class="col-xs-3">
                        <input type="text" id="prodName" name="prodName" class="form-control"
                               placeholder="产品名" value="${info.prodName}">
                    </div>

                    <label class="col-xs-2 control-label">产品类型：</label>
                    <div class="col-xs-3">
                        <g:select optionKey="key" optionValue="value" name="prodType"
                                  class="form-control" from="${prodTypeMap}" value="${info.prodType}"
                                  noSelection="['': '请选择']"/>
                    </div>

                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">产品规格：</label>
                    <div class="col-xs-3">
                        <input type="text" id="prodSpec" name="prodSpec" class="form-control"
                               placeholder="产品规格" value="${info.prodSpec}" >
                    </div>

                    <label class="col-xs-2 control-label">产品包装：</label>

                    <div class="col-xs-3">
                        <input type="text" id="prodPack" name="prodPack" class="form-control"
                               placeholder="产品包装" value="${info.prodPack}" >
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">定制类型：</label>

                    <div class="col-xs-3">
                        <g:select optionKey="key" optionValue="value" name="mineType"
                                  class="form-control" from="${mineTypeMap}" value="${info.mineType}"
                                  noSelection="['': '请选择']"/>
                    </div>

                    <label class="col-xs-2 control-label">多媒体：</label>

                    <div class="col-xs-3" id="mul_add_list" data_id="${info.multimediaResId}">
                        %{--<g:select optionKey="key" optionValue="value" name="prodUseStandardPeriod"--}%
                                  %{--class="form-control" from="${prodUseStandardPeriodMap}" value="${info.prodUseStandardPeriod}"--}%
                                  %{--noSelection="['': '请选择']"/>--}%
                        %{--${multimediaInfo.resName}--}%
                    </div>
                </div>

                %{--<input type="text" class="hide" name="brandId" id="tagetBrand"/>--}%
                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">产品成分：</label>

                    <div class="col-xs-3">
                        <textarea rows="3" id="prodIngredient" name="prodIngredient" class="form-control" placeholder="产品成分">${info.prodIngredient}</textarea>
                    </div>
                    <label class="col-xs-2 control-label">产品可以使用的问题：</label>
                    <div class="col-xs-3">

                        <button class="btn btn-primary" id="products_use_problem" type="button">选择</button>

                        <textarea rows="3" name="" id="use_problem" class="form-control" data_id="${info.prodAimProblemIds}" placeholder="产品可以使用的问题" readonly>${problemNameList}</textarea>
                        <input type="hidden" name="prodAimProblemIds"/>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">产品功效：</label>

                    <div class="col-xs-3">
                        <button class="btn btn-primary" id="product_efficacy" type="button">选择</button>
                        <textarea rows="3" name="" id="use_efficacy" data_id="${info.prodAimThinkingIds}" class="form-control" placeholder="产品功效" readonly>${thinkingNameList}</textarea>
                        <input type="hidden" name="prodAimThinkingIds"/>
                    </div>
                    <label class="col-xs-2 control-label">成本价：</label>
                    <div class="col-xs-3">
                        <input type="number" id="prodCostPrice" name="prodCostPrice" class="form-control"
                               placeholder="成本价" value="${(info?.prodCostPrice?:0)/100f}">
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">建议零售价：</label>

                    <div class="col-xs-3">
                        <input name="prodRetailPrice" id="prodRetailPrice" class="form-control" placeholder="建议零售价" type="number" value="${(info?.prodRetailPrice?:0)/100f}"/>
                    </div>
                    <label class="col-xs-2 control-label">产品效果：</label>
                    <div class="col-xs-3">
                        <textarea rows="3" id="prodResult" name="prodResult" class="form-control" placeholder="产品效果">${info.prodResult}</textarea>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">产品用途：</label>

                    <div class="col-xs-3">
                        <textarea rows="3" id="prodPurpose" name="prodPurpose" class="form-control" placeholder="产品用途">${info.prodPurpose}</textarea>
                    </div>
                    <label class="col-xs-2 control-label">产品状态：</label>
                    <div class="col-xs-3">
                        <g:select optionKey="key" optionValue="value" name="prodShowStatus"
                                  class="form-control" from="${prodShowStatusMap}" value="${info.prodShowStatus}"
                                  noSelection="['': '请选择']"/>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">产品适用肤质：</label>

                    <div class="col-xs-3" id="_prodSkinApplys">
                        <g:each  in="${prodSkinApplysMap}" var="prodSkinApply">
                            <g:if test="${prodSkinIdList}">
                                <g:if test="${prodSkinIdList.contains(prodSkinApply.key)}">
                                    <g:checkBox name="prodSkinApplys" value="${true}" data_id="${prodSkinApply.key}"  class="mycheckbox" checkedFlg="1"/>${prodSkinApply.value}
                                </g:if>
                                <g:else>
                                    <g:checkBox name="prodSkinApplys" data_id="${prodSkinApply.key}"  class="mycheckbox" checkedFlg="0"/>${prodSkinApply.value}
                                </g:else>
                            </g:if>
                            <g:else>
                                <g:checkBox name="prodSkinApplys" data_id="${prodSkinApply.key}"  class="mycheckbox" checkedFlg="0"/>${prodSkinApply.value}
                            </g:else>
                        </g:each>
                    </div>
                    <label class="col-xs-2 control-label">使用条件：</label>
                    <div class="col-xs-3">
                        <g:select optionKey="key" optionValue="value" name="prodUseStandardCondition"
                                  class="form-control" from="${prodUseStandardConditionMap}" value="${info.prodUseStandardCondition}"
                                  noSelection="['': '请选择']"/>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">使用周期：</label>

                    <div class="col-xs-3">
                        <g:select optionKey="key" optionValue="value" name="prodUseStandardPeriod"
                                  class="form-control" from="${prodUseStandardPeriodMap}" value="${info.prodUseStandardPeriod}"
                                  noSelection="['': '请选择']"/>
                    </div>
                    <label class="col-xs-2 control-label">使用频率：</label>
                    <div class="col-xs-3">
                        <g:select optionKey="key" optionValue="value" name="prodUseStandardFrequency"
                                  class="form-control" from="${prodUseStandardFrequencyMap}" value="${info.prodUseStandardFrequency}"
                                  noSelection="['': '请选择']"/>
                    </div>
                </div>

                <div class="list-group-item form-group">
                    <label class="col-xs-2 control-label">产品图：</label>

                    <div class="col-sm-8">
                        %{--<g:if test="${picList}">--}%
                            <div class="col-sm-8" id="pic_show">
                                <!--dom结构部分-->

                                <div id="uploader" class="queueList">
                                    <!--用来存放item-->
                                    <ul id="fileList" class="filelist">

                                        <g:each status="i" in="${picList}" var="picUrl">
                                            <li id="WU_FILE_11${i}" class="state-complete">
                                                <p class="title"></p>

                                                <p class="imgWrap">
                                                    <img src="${picUrl}">
                                                    <input name="item-pic" value="${picUrl}" style="display: none">
                                                </p>

                                                <div class="file-panel">
                                                    <span class="cancel">删除</span>
                                                    <span class="rotateLeft">向左移动</span>
                                                    <span class="rotateRight">向右移动</span>
                                                </div>
                                                <span class="success"/>
                                            </li>
                                        </g:each>

                                    </ul>

                                    <div id="filePicker">选择图片</div>
                                </div>

                            </div>
                        %{--</g:if>--}%
                    </div>

                </div>

                <div class="list-group-item form-group">


                    <label class="col-xs-2 control-label">产品备注：</label>

                    <div class="col-xs-3">
                        <textarea rows="3" id="prodNote" name="prodNote" class="form-control" placeholder="产品备注">${info.prodNote}</textarea>
                    </div>
                </div>


            </div>

            <div class="box-footer clearfix">
                <div class="col-xs-offset-2">
                    <button type="button" class="btn btn-primary" type="submit" id="fbBtn">确定</button>
                </div>
            </div><!-- /.box-footer-->
        </g:form>

    </div><!-- /.box -->
</section><!-- /.content -->


<!-- Modal -->
<div class="modal fade bs-example-modal-lg" id="myShow" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title"></h3>
            </div>
            <div class="modal-body">
                <div class="select_con">

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary determine" id="">确定</button>
                %{--<button type="button" class="btn btn-primary">Save changes</button>--}%
            </div>
        </div>
    </div>
</div>



<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script>

    var Arry_efficacye_id = [];
    var Arry_problem_id = [];

    $(document).on('click','#products_use_problem',function(){
        $('#myShow .modal-title').text('产品可以使用的问题');
        var data={};
        $('.determine').attr('id','determine_products');
        ajax_call(getProblemList_success,'/mikuScProblemItemManage/getProblemList',data,nf);
        $('#myShow').modal('show');
    }).on('click','#product_efficacy',function(){
        $('#myShow .modal-title').text('产品功效');
        var data={};
        $('.determine').attr('id','determine_efficacy');
        ajax_call(getscThinkingItemList_success,'/mikuScThinkingItemManage/getscThinkingItemList',data,nf);
        $('#myShow').modal('show');
    }).on('click','#determine_products',function(){
        var input_check=$('.select_con input:checked');
        var Arry_problem=[];
        $.each(input_check,function(index,element){
            Arry_problem.push($(this).attr('data_value').trim());
            Arry_problem_id.push($(this).attr('data_id').trim());
        });
        var arrStr=Arry_problem.join("，");
        $('#use_problem').text(arrStr);
        $('#myShow').modal('hide');
    }).on('click','#determine_efficacy',function(){
        var input_check=$('.select_con input:checked');
        var Arry_efficacye=[];
        $.each(input_check,function(index,element){
            Arry_efficacye.push($(this).attr('data_value').trim());
            Arry_efficacye_id.push($(this).attr('data_id').trim());
        });
        var arrStr=Arry_efficacye.join("，");
        $('#use_efficacy').text(arrStr);
        $('#myShow').modal('hide');
    })



    //视频列表

    $(document).ready(function(){
        var data={};
        ajax_call(v_list,'/mikuCustomizedMultimediaManage/getAllList',data,nf);
    });

    //视频
    function v_list(data){
        console.log(data);
        var data=data.result;
        var tp=v_list_html(data);
        $('#mul_add_list').append(tp);
    }

    //视频list模板
    function v_list_html(data){
        var html='<select class="form-control" id="multimediaResId" name="multimediaResId">';
        html+='<option value="">请选择</option>';
        var mul_add_list=$('#mul_add_list').attr('data_id');
        for(var i=0;i<data.length;i++){

            if(mul_add_list==data[i].id){
                html+='<option selected="selected" value="'+data[i].id+'">'+data[i].resName+'</option>';
            }else{
                html+='<option value="'+data[i].id+'">'+data[i].resName+'</option>';
            }

        }
        html+='</select>';
        return html;
    }




    //        ajax
    function ajax_call(success,url,data,error) {
        $.ajax({
            url: url,
            data: data,
            type: "POST",
            dataType: "json",
            success: function (data) {
                success(data);
            },
            error: function (data) {
                error(data)
            }
        });
    }

    //mikuScProblemItemManage/getProblemList
    function getProblemList_success(data){
        console.log(data);
        var data=data.result;

        var tp=checkbox_html(data);
        $('.select_con').empty();
        $('.select_con').append(tp);

        checkbox();

    }


    // mikuScThinkingItemManage/getscThinkingItemList
    function getscThinkingItemList_success(data){
        console.log(data);
        var data=data.result;

        var tp=checkbox_efficacy_html(data);
        $('.select_con').empty();
        $('.select_con').append(tp);

        checkbox();
    }


    //    //checkbox模板---产品可以使用的问题
    function checkbox_html(data){
        var tp='';
        for(var i=0;i<data.length;i++){
            var html='<input type="checkbox" data_value="'+data[i].scProblemShortName+'" data_id="'+data[i].id+'"/>';
            html+=''+data[i].scProblemShortName+'&nbsp';
            tp+=html;
        }
        return tp;
    }

    //    //checkbox模板--产品功效
    function checkbox_efficacy_html(data){
        var tp='';
        for(var i=0;i<data.length;i++){
            var html='<input type="checkbox" data_value="'+data[i].scThinkingName+'" data_id="'+data[i].id+'"/>';
            html+=''+data[i].scThinkingName+'&nbsp';
            tp+=html;
        }
        return tp;
    }


    //空方法
    function nf(){}




    //进行提交
    $("#fbBtn").on('click',function(){
        var obj={};
        var arr=[];
        var arrlist=[];
        var id=$('#hidden_id').val();
        obj.id=id;//id
        obj.prodName=$('#prodName').val();//产品名
        obj.prodType=$('#prodType').val();//产品类型
        obj.prodSpec=$('#prodSpec').val();//产品规格
        obj.prodPack=$('#prodPack').val();//产品包装
        if(Arry_problem_id.join(',')){
            obj.prodAimProblemIds=Arry_problem_id.join(',');//产品可以使用的问题
        }else{
            var pro_list=[];
            pro_list=$('#use_problem').attr('data_id');
            obj.prodAimProblemIds=pro_list;//产品可以使用的问题
        }
        if(Arry_efficacye_id.join(',')){
            obj.prodAimThinkingIds=Arry_efficacye_id.join(',');//产品功效
        }else{
            var eff_list=[];
            eff_list=$('#use_efficacy').attr('data_id');
            obj.prodAimThinkingIds=eff_list;//产品可以使用的问题
        }

        obj.prodIngredient=$('#prodIngredient').val();//产品成分
        obj.prodCostPrice=$('#prodCostPrice').val();//成本价
        obj.prodRetailPrice=$('#prodRetailPrice').val();//建议零售价

        obj.prodResult=$('#prodResult').val();//产品效果

        obj.prodPurpose=$('#prodPurpose').val();//产品用途
        obj.prodShowStatus=$('#prodShowStatus').val();//产品状态

        var html=$('#_prodSkinApplys .icheckbox_square-blue input:checked');
        $.each(html,function(index,element){
            arr.push($(this).attr('data_id').trim());
        });

        obj.prodSkinApplys=arr.join(',');//产品适用肤质
        obj.prodUseStandardCondition=$('#prodUseStandardCondition').val();;//产品规则-使用条件
        obj.prodUseStandardPeriod=$('#prodUseStandardPeriod').val();//产品规则-使用周期
        obj.prodUseStandardFrequency=$('#prodUseStandardFrequency').val();//产品规则-使用频率

        var htmllist=$('#fileList img');
        $.each(htmllist,function(index,element){
            arrlist.push($(this).attr('src').trim());
        });

        obj.prodPicUrls=arrlist.join(";");//产品图

        obj.prodNote=$('#prodNote').val();//产品备注
        obj.mineType=$('#mineType').val();//定制类型
        obj.multimediaResId=$('#multimediaResId').val();//多媒体
        console.log(obj)

        ajax_call(p_success,'/mikuCustomizedProductManage/add',obj,nf)

    });


    //图片管理开始
    $('.dropdown-toggle').dropdown()

    $("[id^='WU_FILE_']").each(function () {

        var id = this.id
        var $btn = $(this).find('.file-panel')

        $(this).on('mouseenter', function () {
            $btn.stop().animate({height: 30});
        });

        $(this).on('mouseleave', function () {
            $btn.stop().animate({height: 0});
        });

        $btn.on('click', 'span', function () {

            var index = $(this).index(),
                    deg;

            switch (index) {
                case 0:
                    $('#' + id).remove()
                    return;
                case 1:
                    console.log(id)
                    moveDown($('#' + id))
                    break;
                case 2:
                    moveUp($('#' + id))
                    break;

            }

        });

        function moveUp($item) {
            $before = $item.prev();
            $item.insertBefore($before);
        }

        function moveDown($item) {
            $after = $item.next();
            $item.insertAfter($after);
        }
    });
    //图片管理结束



    //产品添加成功
    function p_success(data){
        if(data){
            alert('编辑成功！');
            var hostUrl=window.location.host;
            window.location.href='http://'+hostUrl+'/mikuCustomizedProductManage/index';
        }
    }


    //*************************************************

    checkbox();

    function checkbox(){
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '10%' // optional
        });
    }


    $('.dropdown-toggle').dropdown()



</script>

</body>

</html>
