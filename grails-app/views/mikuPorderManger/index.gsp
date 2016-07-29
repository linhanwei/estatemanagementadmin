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
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <asset:stylesheet src="skins/skin-blue.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <style>
        #top-left{height: 191.5px;overflow-y: scroll;}
        #top-right{height: 246.5px;  overflow-y: scroll;border-top: none;padding: 0;}
        #operation #bottom{height: 417.5px;overflow-y: scroll;margin-bottom: 10px;  }
        #t-boxhead{padding-right: 17px;  color: #0044cc;}
        #t-boxhead table{margin-bottom: 0;}
        #t-rhead{background-color: white;margin-right: 17px;border-top:3px solid #d5d5d5;border-radius: 3px;color: #0044cc;}
        #t-rhead table{margin-bottom: 0;}
        #order{margin-bottom: 0;}
        #b-thead table{margin-bottom: 0;}
        #b-thead{padding-right: 17px;color: #0044cc;}
    </style>
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
       订单分拆界面
        <small>ERP</small>
        <button id="translate" class="btn btn-success">同步订单</button>

    </h1>
</section>
<!-- Content Header (Page header) -->
<section class="content-header">
    <div class="header-box" style="overflow: hidden;">
        <div class="row">
            <div class="col-md-4" style="padding-right: 2px;">


                <div class="table-responsive box" style="padding-top:10px;margin-bottom: 4px;">
                    <div class="row" style="margin-right: 0;">
                        <div class="col-lg-6">
                            <div class="input-group">
                                <form action="index" class="form-inline">
                                        <input type="text" class="form-control" style="width:70%;" placeholder="订单ID" name="tradeId" value="${params.tradeId}">
                                        <button class="btn btn-default" type="submit">确定</button>
                                </form>
                            </div><!-- /input-group -->
                        </div><!-- /.col-lg-6 -->
                        <div class="col-lg-6">
                        %{--<div class="pagination pull-right" style="margin: 0;">--}%
                            %{--<span class="currentStep">1</span><a href="/mikuBrand/index?format=&amp;offset=10&amp;max=10" class="step">2</a><a href="/mikuBrand/index?format=&amp;offset=20&amp;max=10" class="step">3</a><a href="/mikuBrand/index?format=&amp;offset=20&amp;max=10" class="step">4</a><a href="/mikuBrand/index?format=&amp;offset=10&amp;max=10" class="nextLink">下一页</a>--}%
                        %{--</div>--}%
                        <div class="box-footer clearfix" style="padding: 0;border-top: none;">
                            <g:if test="${total > 0}">
                                <div class="pagination pull-right" style="margin: 0;">
                                    <g:paginate next="下" prev="上" params="${params}"
                                                maxsteps="1" action="index" total="${total}"/>
                                </div>
                            </g:if>
                        </div><!-- /.box-footer-->
                        </div><!-- /.col-lg-6 -->
                    </div><!-- /.row -->


                    %{--第一区--}%
                    <div id="t-boxhead">
                        <table class="table table-hover table-bordered text-center">
                            <tr>
                                <td width="30%">日期</td>
                                <td width="40%">订单</td>
                                <td width="40%">需求</td>
                            </tr>
                        </table>
                    </div>
                    <div id="top-left">
                        <table id="order" class="table table-hover table-bordered text-center">
                            <tbody>
                            <g:each status="i" in="${list}" var="li">
                                <tr style="cursor: pointer;">
                                    <td width="30%">
                                        ${li?.dateCreated?new org.joda.time.DateTime(li?.dateCreated).toString("yyyy-MM-dd HH:mm"):""}
                                    </td>
                                    <td width="40%;">${li.tradeId}</td>
                                    <td width="40%">${li.buyerMessage}</td>
                                </tr>
                            </g:each>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-8" style="padding-left: 2px;">
                <div id="t-rhead">
                    <table class="table table-hover table-bordered text-center">
                        <tr>
                            <td width="20%">米酷码</td>
                            <td width="25%">名称</td>
                            <td width="10%">数量</td>
                            <td width="15%">地区</td>
                            <td width="7%">价格(元)</td>
                            <td width="7%">邮费(元)</td>
                            <td width="8%">规格</td>
                            <td width="8%">是否退款</td>
                        </tr>
                    </table>
                </div>
                <div id="top-right" class="table-responsive box" style="margin-bottom: 4px;">
                    %{--第二区--}%
                    <table class="table table-hover table-bordered text-center">
                        <tbody id="data-bug-con" data-num="">
                        %{--订单data--}%
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Main content -->
<section class="content" style="padding-top: 0;">
    <div>
        <div id="operation">
            <div class="box box-primary " style="padding-top:10px;">
                <div class="container-fluid">
                    <div class="col-md-4 pull-left text-left" style="margin-top: 6px;">
                        <label>
                            已选供应商
                            <button class="btn" style="background-color: #DFF0D8;"></button>
                        </label>
                        <label>
                            供应商库存为0
                            <button class="btn" style="background-color: #F2DEDE;"></button>
                        </label>
                    </div>
                    <div class="col-md-8 pull-right text-right" style="padding-bottom: 10px;">
                        <label>
                            价格
                            <input type="checkbox" id="price">
                        </label>
                        %{--<label>--}%
                            %{--地区--}%
                            %{--<input type="checkbox">--}%
                        %{--</label>--}%
                        <label>
                            邮费
                            <input type="checkbox" id="postfee">
                        </label>
                        <label>
                            对账日期
                            <input type="checkbox" id="assess">
                        </label>
                        <label>
                            库存
                            <input type="checkbox" id="stock">
                        </label>
                        <button id="condition-btn" type="submit" class="btn btn-primary" style="margin-left: 30px;">确定</button>
                    </div>
                </div>
                <div id="b-thead">
                    <table class="table table-hover table-bordered text-center">
                        <tr>
                            <td width="15%">供应商名称</td>
                            <td width="15%">供应商品名称</td>
                            <td width="8%">地区</td>
                            <td width="8%">价格</td>
                            <td width="8%">邮费</td>
                            <td width="8%">库存</td>
                            <td width="8%">对账日期(天)</td>
                            <td width="10%">备注内容</td>
                            <td width="10%">选择供应商</td>
                        </tr>
                    </table>
                </div>
                <div id="bottom" class="table-responsive">
                    %{--第三区--}%
                    <table class="table table-hover table-bordered text-center">
                        <tbody id="supplier" data-num="">
                        %{--供应商商品--}%
                        </tbody>
                    </table>
                </div>
                <div id="bottom-ok" class="text-right" style="margin-right: 10px;display: none;">
                    <button id="check-supplier" type="submit" class="btn btn-primary">确定</button>
                </div>
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
%{--隐藏数据--}%
<g:form action="doOnePOrder">
    <table style="display: none;">
        <tr>
            <td><input id="tradeId" name="tradeId"></td>
            <td><input id="orderId" name="orderId"></td>
            <td><input id="pId" name="pitemId"></td>
            <td><input id="pselectitemIds" name="pselectitemIds"></td>
        </tr>
    </table>
    <input type="submit" id="up-btn" style="display: none;"/>
</g:form>
%{--第二区要货数--}%
<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.js"/>
<!-- art-template -->
<asset:javascript src="art-template/art-template.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '10%' // optional
    });

    //table
    $(document).on('click','#order tbody tr',function(){//商品
        var tradeId=$.trim($(this).children('td').eq(1).text());
        $('#tradeId').val(tradeId);
        $.ajax({
            url: '/mikuPorderManger/selectTradeOrders',
            data: {'tradeId':tradeId},
            type: "POST",
            dataType: "json",
            success: function (data) {
                console.log(data);
                var coo_arr = new Array();
                for (var i = 0; i < data.length; i++){
                    data[i].type==1 ? coo_arr.push('<tr class="success" style="cursor: pointer;">') : coo_arr.push('<tr style="cursor: pointer;">');
                    coo_arr.push('<td id="shopId" style="display: none;">'+data[i].shopId+'</td>');
                    coo_arr.push('<td width="20%">'+data[i].code+'</td>');
                    coo_arr.push('<td width="25%">'+data[i].title+'</td>');
                    coo_arr.push('<td width="10%">'+data[i].num+'</td>');
                    coo_arr.push('<td width="15%">'+data[i].address+'</td>');
                    coo_arr.push('<td width="7%">'+data[i].price/100+'</td>');
                    data[i].postFee==null ? coo_arr.push('<td width="7%">0</td>') : coo_arr.push('<td width="7%">'+data[i].postFee/100+'</td>');
                    coo_arr.push('<td width="8%">'+data[i].specification+'</td>');
                    data[i].isrefund==0 ? coo_arr.push('<td width="8%">不退款</td>') : coo_arr.push('<td width="8%">退款</td>');
                    coo_arr.push('</tr>');
                }
                document.getElementById('data-bug-con').innerHTML = coo_arr.join('');
            },
            error: function (data) {
            }
        });
    }).on('click','#data-bug-con tr',function(){//供应商
        var code=$.trim($(this).children('td').eq(1).text());
        var orderId=$.trim($(this).children('td').eq(0).text());
        $('#orderId').val(orderId);
        var data_num=$.trim($(this).children('td').eq(3).text());//要货数
        $('#data-bug-con').attr('data-num',data_num);//第二区num
        $.ajax({
            url: '/mikuPorderManger/getInfoByCode',
            data: {'code':code,'orderId':orderId},
            type: "POST",
            dataType: "json",
            success: function (data) {
                console.log(data);
                if(data.length>0){
                    $('#bottom-ok').show();
                }else{
                    $('#bottom-ok').hide();
                }
                var html_arr = new Array();
                for (var i = 0; i < data.length; i++){
                    if(data[i].rknum==0 && data[i].status==0){//库存0并没选,颜色danger
                        html_arr.push('<tr class="danger" style="cursor: pointer;">');
                    }else if(data[i].rknum!==0 && data[i].status==1){//库存不为0并已选，颜色success
                        html_arr.push('<tr class="success" style="cursor: pointer;">');
                    }else if(data[i].status==1){//已选，颜色success
                        html_arr.push('<tr class="success" style="cursor: pointer;">');
                    }else{
                        html_arr.push('<tr style="cursor: pointer;">');
                    }
                    html_arr.push('<td style="display: none;" id="pitemId">'+data[i].id+'</td>');
                    html_arr.push('<td width="15%">'+data[i].memo+'</td>');
                    html_arr.push('<td width="15%">'+data[i].title+'</td>');
                    html_arr.push('<td width="8%">'+data[i].area+'</td>');
                    html_arr.push('<td width="8%">'+data[i].price/100+'</td>');
                    html_arr.push('<td width="8%">'+data[i].postFee/100+'</td>');
                    html_arr.push('<td width="8%">'+data[i].rknum+'</td>');
                    html_arr.push('<td width="8%">'+data[i].assess+'</td>');
                    if(data[i].logisticDestrion==0){
                        html_arr.push('<td width="10%"></td>');
                    }else{
                        if(data[i].changeId==1){
                            html_arr.push('<td width="10%">此供应商已被选中</td>');
                        }else{
                            html_arr.push('<td width="10%"></td>');
                        }
                    }
                    if(data[i].rknum<data_num){
                        if(data[i].status==1){
                            html_arr.push('<td width="10%"></td>');
                        }else{
                            if(data[i].rknum==0){
                                html_arr.push('<td width="10%"><div class="input-group" style="margin: 0 auto;">\
                                                                </div>\
                                    <div class="input-group select_s" style="margin: 0 auto;display: none;">\
                                    <button class="btn btn-primary btn-sm decrease" type="button">-</button>\
                                     <input type="text" placeholder="数量" value="'+data[i].rknum+'" class="num" name="weight" readonly="" style="width: 30px;text-align: center;border: navajowhite;">\
                                    <button class="btn btn-primary btn-sm insert" type="button">+</button>\
                                    </div>\
                               </td>');
                        }else{
                                html_arr.push('<td width="10%"><div class="input-group" style="margin: 0 auto;">\
                                    <input value="'+data[i].id+'" data-val="'+data[i].rknum+'" pid="'+data[i].id+'" id="label-check" type="checkbox" name="checks">\
                                    </div>\
                                    <div class="input-group select_s" style="margin: 0 auto;display: none;">\
                                    <button class="btn btn-primary btn-sm decrease" type="button">-</button>\
                                     <input type="text" placeholder="数量" value="'+data[i].rknum+'" class="num" name="weight" readonly="" style="width: 30px;text-align: center;border: navajowhite;">\
                                    <button class="btn btn-primary btn-sm insert" type="button">+</button>\
                                    </div>\
                               </td>');
                            }
                        }
                    }else{
                        if(data[i].status==1){
                            html_arr.push('<td width="10%"></td>');
                        }else{
                            if(data[i].rknum==0){
                                html_arr.push('<td width="10%"></td>');
                            }else{
                                html_arr.push('<td width="10%"><div class="input-group" style="margin: 0 auto;">\
                                    <input id="label-check" type="radio" name="checkone">\
                                    </div>\
                               </td>');
                            }
                        }
                    }

                    html_arr.push('</tr>');
                }
                document.getElementById('supplier').innerHTML = html_arr.join('');
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '10%' // optional
                });
                $('#supplier input[type="radio"]').on('ifChecked', function(event){ //点击input回调
                    var pId=$(this).parent().parent().parent().parent().children('td').eq(0).text();
                    $('#pId').val(pId);
                });



                //条件排序
                $(document).on('click','#condition-btn',function(){
                    getInfoByCondition(data);
                })
            },
            error: function (data) {
            }
        });
    }).on('click','#check-supplier',function(){//供应商确认
        var arr=[];
        var sum=0;
        $('.input-group input[type="checkbox"]:checked').each(function(index,domEle){
            sum+=parseInt($(domEle).attr('data-val'));
            var str=($(domEle).attr('pId')+"#"+$(domEle).attr('data-val'));
            arr.push(str);
        });
        var result=arr.join(";");

        if($('.input-group input[type="radio"]:checked').length>0){
            $('#up-btn').click();
//            alert("选择供应商成功.")
        }else if($('.input-group input[type="checkbox"]:checked').length>0){
            var targetNum=$("#data-bug-con").attr("data-num");
            if(sum==targetNum){
                $('#pselectitemIds').val(result);
//                alert(result);
                $('#up-btn').click();
//                alert("选择成功.");
            }else{
                alert("不正确的数据.");
                return false;
            }

        }


    }).on('click','#translate',function(){
        window.location.replace('/mikuPorderManger/SyncData');
    }).on('click','#order tbody tr',function(){//第一区
        $(this).addClass('warning').siblings().removeClass('warning');
    }).on('click','#data-bug-con tr',function(){//第二区
        $(this).addClass('warning').siblings().removeClass('warning');
    }).on('click','#supplier tr',function(){//第三区
        $(this).addClass('warning').siblings().removeClass('warning');
    }).on('click','.decrease',function(){
        var now = $(this).nextAll('input').val();
        now = now * 1 - 1;
        if (now > 0) {
            $(this).nextAll('input').val(now);
        }
        $(this).parent().prevAll('div').children().children('input').attr('data-val',now);
    }).on('click','.insert',function(){
        var now = $(this).prevAll('input').val();
        var max_data= parseInt($.trim($(this).parent().parent().siblings().eq(6).text()));
        now = now * 1 + 1;
        if (now < max_data) {
            $(this).prevAll('input').val(now);
        }else{
            $(this).prevAll('input').val(max_data);
        }
        $(this).parent().prevAll('div').children().children('input').attr('data-val',now);
    }).on('click','#s_click',function(){
        $('#myModal').modal('hide');
    }).on('ifChecked','#supplier input',function(){
        $(this).parent().parent().nextAll('div').show();
    }).on('ifUnchecked','#supplier input',function(){
        $(this).parent().parent().nextAll('div').hide();
    })


    //进行添加对应的模板
    function getInfoByCondition(data){
        var obj=[],weightObj=[];
        var postFee=$('#postfee').is(':checked');
        var price=$('#price').is(':checked');
        var assess=$('#assess').is(':checked');
        var stock=$('#stock').is(':checked');
        var data_num=$('#data-bug-con').attr('data-num');//要货数
        //少了一个对账日期
        if(postFee){
            obj.push("postFee");
        }
        if(price){
            obj.push("price");
        }
        if(assess){
            obj.push("assess");
        }
        if(stock){
            obj.push("num");
        }
        //进行对各个参数进行添加对应的权重
        $.each(data,function(index,value){
            var lobj={};
            lobj["id"]=value.id;
            lobj["weight"]=0;
            weightObj.push(lobj);
        });

        for(var i=0;i<obj.length;i++){
            var arrjson=data.sort(function(a,b){
                if(obj[i]=="assess" || obj[i]=="num"){
                    return (b[obj[i]] - a[obj[i]]);
                }else{
                    return (a[obj[i]] - b[obj[i]]);
                }
            });
            $.each(arrjson,function(index,value){
                for(var j=0;j<weightObj.length;j++){
                    if(weightObj[j]["id"]==value.id){
                        weightObj[j]["weight"]= weightObj[j]["weight"]+index;
                    }
                }
            });
        }
        var newJson=weightObj.sort(function(a,b){
            return (a['weight'] - b['weight']);
        });
        debugger;

        var finalData=[];
        //进行最终的排序
        $.each(newJson,function(index,value){
            for(var j=0;j<data.length;j++){
                if(data[j].id==value.id){
                    finalData.push(data[j]);
                }
            }
        });
        var html4_arr=[];
        $.each(finalData,
                function(index, value)
                {

                    if(value.rknum==0 && value.status==0){//库存0并没选,颜色danger
                        html4_arr.push('<tr class="danger" style="cursor: pointer;">');
                    }else if(value.rknum!==0 && value.status==1){//库存不为0并已选，颜色success
                        html4_arr.push('<tr class="success" style="cursor: pointer;">');
                    }else if(value.status==1){//已选，颜色success
                        html4_arr.push('<tr class="success" style="cursor: pointer;">');
                    }else{
                        html4_arr.push('<tr style="cursor: pointer;">');
                    }
                    html4_arr.push('<td style="display: none;" id="pitemId">'+value.id+'</td>');
                    html4_arr.push('<td width="15%">'+value.memo+'</td>');
                    html4_arr.push('<td width="15%">'+value.title+'</td>');
                    html4_arr.push('<td width="8%">'+value.area+'</td>');
                    html4_arr.push('<td width="8%">'+value.price/100+'</td>');
                    html4_arr.push('<td width="8%">'+value.postFee/100+'</td>');
                    html4_arr.push('<td width="8%">'+value.rknum+'</td>');
                    html4_arr.push('<td width="8%">'+value.assess+'</td>');
                    if(value.logisticDestrion==0){
                        html4_arr.push('<td width="10%"></td>');
                    }else{
                        if(value.changeId==1){
//                            html_arr.push('<td width="10%">'+value.logisticDestrion+'<br/>'+value.pitemCode+'</td>');
                            html4_arr.push('<td width="10%">此供应商已被选中</td>');
                        }else{
                            html4_arr.push('<td width="10%"></td>');
//                            html4_arr.push('<td width="10%">'+value.logisticDestrion+'</td>');
                        }
                    }
                    if(value.rknum<data_num){
                        if(value.status==1){
                            html4_arr.push('<td width="10%"></td>');
                        }else{
                            if(value.rknum==0){
                                html4_arr.push('<td width="10%"><div class="input-group" style="margin: 0 auto;">\
                                                                </div>\
                                    <div class="input-group select_s" style="margin: 0 auto;display: none;">\
                                    <button class="btn btn-primary btn-sm decrease" type="button">-</button>\
                                     <input type="text" placeholder="数量" value="'+value.rknum+'" class="num" name="weight" readonly="" style="width: 30px;text-align: center;border: navajowhite;">\
                                    <button class="btn btn-primary btn-sm insert" type="button">+</button>\
                                    </div>\
                               </td>');
                            }else{
                                html4_arr.push('<td width="10%"><div class="input-group" style="margin: 0 auto;">\
                                    <input value="'+value.id+'" data-val="'+value.rknum+'" pid="'+value.id+'" id="label-check" type="checkbox" name="checks">\
                                    </div>\
                                    <div class="input-group select_s" style="margin: 0 auto;display: none;">\
                                    <button class="btn btn-primary btn-sm decrease" type="button">-</button>\
                                     <input type="text" placeholder="数量" value="'+value.rknum+'" class="num" name="weight" readonly="" style="width: 30px;text-align: center;border: navajowhite;">\
                                    <button class="btn btn-primary btn-sm insert" type="button">+</button>\
                                    </div>\
                               </td>');
                            }
                        }
                    }else{
                        if(value.status==1){
                            html4_arr.push('<td width="10%"></td>');
                        }else{
                            if(value.rknum==0){
                                html4_arr.push('<td width="10%"></td>');
                            }else{
                                html4_arr.push('<td width="10%"><div class="input-group" style="margin: 0 auto;">\
                                    <input id="label-check" type="radio" name="checkone">\
                                    </div>\
                               </td>');
                            }
                        }
                    }

                    html4_arr.push('</tr>');

                });
        $("#supplier").html(html4_arr.join(''));
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '10%' // optional
        });

        $('#supplier input[type="radio"]').on('ifChecked', function(event){ //点击input回调
            var pId=$(this).parent().parent().parent().parent().children('td').eq(0).text();
            $('#pId').val(pId);
        });



    }

    //点确认定单数<选择供应商库存
    function checkMin(msg){
        $('#myModal .modal-body').html('<p>'+msg+'</p>');
    }


</script>


</body>

</html>
