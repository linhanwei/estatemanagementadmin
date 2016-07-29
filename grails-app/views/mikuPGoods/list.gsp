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
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>

    <![endif]-->
    <style>
    #table .mo_table{
        float: left;
        width: 9.090909%;
        border-right: 1px solid #F4F4F4;
        border-bottom: 1px solid #F4F4F4;
        padding: 8px;
        min-height: 37px;
    }
    #table .mo_table:last-child{
        border-right: 0;
    }
    #mbtable{
        display: none;
    }
</style>
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        完成的订单列表
        <small>订单列表</small>
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active">
                        <g:link action="list">完成订单</g:link></li>
                    <li>
                        <g:link action="cklist">出库订单</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <form action="list" class="form-inline">
                <div class="col-md-4">
                    <label class="control-label">订单号：</label>
                    <input name="tradeId" class="form-control" placeholder="订单号" value="${params.tradeId}">
                </div>
                <div class="col-md-4">
                    <label class="control-label">手机号：</label>
                    <input name="mobile" class="form-control" value="" placeholder="手机号" value="${params.mobile}">
                </div>
                <div class="col-md-4">
                    <label class="control-label">页数：</label>
                    <g:select optionKey="key" optionValue="value" name="max"
                              class="form-control" from="${PageMap}" value="${params.max}"
                              noSelection="['10': '页码']"/>
                    <button class="btn btn-primary"><i class="fa fa-search"></i>查询</button>
                    %{--<button class="btn btn-success pull-right" onclick="window.location.replace('/trade/createOneExcel')"  target="_blank" ><i class="fa fa-download"></i><g:link controller="trade" action="createOneExcel" target="_blank" class="btn btn-sm  btn-success">下载Excel模板</g:link></button>--}%
                    <div class="form-group pull-right">
                        <g:link controller="trade" action="createOneExcel" target="_blank" class="btn btn-sm btn-primary pull-right">下载Excel模板</g:link>
                        %{--<span STYLE="color:red">【请后台操作人员按照Excel格式说明进行导单操作】</span>--}%
                    </div>
                </div>
            </form>
        </div>

        <div class="box-body">
            <form action="downloadExcelByTradeId">
            <table class="table table-hover table-bordered text-center" id="table">
                <tr>
                    <th style="width: 150px"><i class="fa fa-bookmark"></i>订单号</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>收货人</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>地址</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>金额</th>
                    <th style="width: 130px"><i class="fa fa-picture-o"></i>订单详情</th>
                    <th style="width: 120px"><i class="fa fa-hand-o-down"></i>操作</th>
                    <th style="width:50px;"><input type="checkbox" id="checkAll"/></th>
                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${tagList}" var="trade">
                            <tr id="${trade?.tradeId}" class="info">
                                <td>${trade?.tradeId}
                                    <g:if test="${trade?.tradeFrom == 1 as byte}">
                                        <div style="padding-top: 10px">
                                            <span style="color: #a47e3c">IOS</span>
                                        </div>
                                    </g:if>

                                    <g:if test="${trade?.tradeFrom == 2 as byte}">
                                        <div style="padding-top: 10px">
                                            <span style="color: #a47e3c">Android</span>
                                        </div>
                                    </g:if>

                                    <g:if test="${trade?.tradeFrom == 3 as byte}">
                                        <div style="padding-top: 10px">
                                            <span style="color: #a47e3c">微信</span>
                                        </div>
                                    </g:if>

                                    <g:if test="${trade?.payType == 4 as byte}">
                                        <div style="padding-top: 10px">
                                            <span style="color: #a47e3c">未知</span>
                                        </div>
                                    </g:if>
                                    <div style="padding-top: 10px">
                                        ${trade?.id}
                                    </div>
                                </td>
                                <td>
                                    ${trade?.buyerInfo}
                                </td>
                                <td> ${trade?.address}</td>
                                <td> ${trade?.totalFee/100f}</td>
                                <td> ${trade?.memo}</td>
                                <td>
                                    <button class="btn btn-warning btn-sm" onclick="window.location.replace('/mikuPGoods/doSuccessTrades?itemShipBox=${trade?.tradeId}');return false;">出库</button>
                                    <button type="button" class="btn btn-success btn-sm"
                                            onclick="window.location.replace('/mikuPGoods/cancelOneTrade?id=${trade?.id}')">
                                        撤回
                                    </button>
                                    <button type="button" class="btn btn-info btn-sm" id="data_btn">
                                        详情
                                    </button>
                                    <button data-inum="${trade?.tradeId}"  id="library" type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">出库信息</button>
                                </td>
                                <td><input type="checkbox" name="itemShipBox" value="${trade?.tradeId}"/></td>
                            </tr>
                        <tr class="details success">
                            <td colspan="10" style="padding: 0;">
                                <div id="mbtable">
                                    <div class="mo_table">分类</div>
                                    <div class="mo_table">供应商</div>
                                    <div class="mo_table">数量</div>
                                    <div class="mo_table">邮费</div>
                                    <div class="mo_table">价格</div>
                                    <div class="mo_table">地区</div>
                                    <div class="mo_table">账期</div>
                                    <div class="mo_table">实付</div>
                                    <div class="mo_table">总价</div>
                                    <div class="mo_table">利润</div>
                                    <div class="mo_table"></div>
                        <g:each status="k" in="${map.get(trade?.id+"")}" var="list">
                                <div class="mo_table">
                                    ${list.assess}
                                </div>
                                <div class="mo_table">${list.name}</div>
                                <div class="mo_table">${list.job}</div>
                                <div class="mo_table">${list.zipcode}</div>
                                <div class="mo_table">${list.email}</div>
                                <div class="mo_table">${list.address}</div>
                                <div class="mo_table">${list.accounttime}</div>
                                <div class="mo_table">${list.sname}</div>
                                <div class="mo_table">${list.version}</div>
                                <div class="mo_table">
                                    <g:if test="${list.changeId}">
                                        ${list.changeId/100f}
                                    </g:if>
                                </div>
                                <div class="mo_table"></div>
                        </g:each>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
            </table>
                <button class="hide" type="submit" id="tragetBtn"></button>
                <button class="hide" type="submit" id="tragetBtnOutExport" formaction="doSuccessTrades"></button>
            </form>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">
            <div class="col-sm-4" style="margin: 20px 0;">
                <form action="" method="post">
                    %{--<button type="submit" class="btn btn-warning"><i class="fa fa-cloud-download"></i>批量下架</button>--}%
                    <butoton class="btn btn-success" onclick="window.location.replace('/mikuPGoods/downloadExcelByTradeId?flag=2');return false;">批量导出</butoton>
                    <butoton class="btn btn-success" onclick="outSomeExcel()">导出</butoton>
                    <button type="button" class="btn btn-info" id="ckAllbtn">批量出库</button>
                    <button type="button" class="btn btn-primary" id="inputPortExcelByTradebtn">批量导入</button>
                </form>
            </div>
            <g:if test="${total > 0}">
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                maxsteps="10" action="list" total="${total}"/>
                </div>
            </g:if>
        </div><!-- /.box-footer-->
    </div><!-- /.box -->
</section><!-- /.content -->
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">出库信息</h4>
            </div>
            <div class="modal-body">
                <div class="">
                    <table class="table table-bordered text-center">
                        <thead>
                        <tr>
                            <th>
                                <input id="title_input" type="checkbox"/>
                            </th>
                            <th>品牌名称</th>
                            <th>名称</th>
                            <th>价格</th>
                            <th>数量</th>
                        </tr>
                        </thead>
                        <tbody id="push-head">

                        </tbody>
                    </table>
                </div>
                <div class="form-inline">
                    <div class="form-group">
                        <label class="form-label">公司：</label>
                        <select id="wlcompany" class="form-control">
                            <option value="EMS">EMS</option>
                            <option value="中通速递">中通速递</option>
                            <option value="中通">中通</option>
                            <option value="申通">申通</option>
                            <option value="申通E物流">申通E物流</option>
                            <option value="邮政国内小包">邮政国内小包</option>
                            <option value="云栈百世汇通">云栈百世汇通</option>
                            <option value="百世汇通">百世汇通</option>
                            <option value="顺丰快递">顺丰快递</option>
                            <option value="圆通速递">圆通速递</option>
                            <option value="圆通">圆通</option>
                            <option value="韵达快运">韵达快运</option>
                            <option value="韵达快递">韵达快递</option>
                            <option value="韵达">韵达</option>
                            <option value="顺丰">顺丰</option>
                            <option value="天天快递">天天快递</option>
                            <option value="天天">天天</option>
                        </select>
                        %{--<input id="wlcompany" type="text" class="form-control" placeholder="公司">--}%
                    </div>
                    <div class="form-group">
                        <label class="form-label">物流号：</label>
                        <input id="wlh" type="text" class="form-control" placeholder="物流号">
                        <button id="bink_num" data-arr="" data-tradeId="" class="btn btn-primary">确定</button>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <table class="table table-bordered text-center">
                    <thead>
                    <tr>
                        <th>名称</th>
                        <th>物流公司</th>
                        <th>物流单号</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="wl_tbody">
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">关闭</button>
                %{--<button type="button" class="btn btn-primary">Save changes</button>--}%
            </div>
        </div>
    </div>
</div>

<g:uploadForm action="inputPortExcelByTrade" enctype="multipart/form-data" style="display:none">
    <input type="text" name="type" value="1"/>
    <input type="file" name="myFile" id="myFile" accept=".xls"/>
    <input type="submit" style="display: none;" id="inputPortExcelByTradeFormsubmit">
</g:uploadForm>



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
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>



<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>

    //点击批量导入的按钮
    $('#inputPortExcelByTradebtn').on("click",function(){
        $('#myFile').click();
    });
    $('#myFile').on('change',function(){
        debugger;
        //获取其文件类型
        var fileName=$("#myFile").val();
        if(fileName.length>1 && fileName)
        {
            var  index=fileName.lastIndexOf(".");
            var type=fileName.substring(index+1);
            if(type!="xls")
            {
                alert("请上传对应Excel类型的文件");
                return;
            }
            else{
                $('#inputPortExcelByTradeFormsubmit').click();
            }
        }
    });

    function outSomeExcel(){
        var tradeArr=[];
        $('input[name="itemShipBox"]:checked').each(function (index, ele) {
            tradeArr.push($(this).val());
        });
        if(!tradeArr.length)
        {
            alert("请选中对应的订单信息");
            return;
        }
        $("#tragetBtn").click();
    }


    $("#ckAllbtn").click(function(){
        var tradeArr=[];
        $('input[name="itemShipBox"]:checked').each(function (index, ele) {
            tradeArr.push($(this).val());
        });
        if(!tradeArr.length)
        {
            alert("请选中对应的订单信息");
            return;
        }
        $("#tragetBtnOutExport").click();
    });


    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });


    $("#checkAll").on('ifChecked', function (event) {
        $("input[name='itemShipBox']").each(function check() {
            $(this).iCheck('check');
        });
    });

    $("#checkAll").on('ifUnchecked', function (event) {
        $("input[name='itemShipBox']").each(function check() {
            $(this).iCheck('uncheck');
        });

    });


    $(document).on('click','#data_btn',function(){
        if($(this).parent().parent().next().children().children().is(":hidden")){
            $(this).parent().parent().siblings('.details').children().children().slideUp();
            $(this).parent().parent().next().children().children().slideDown();
        }else{
            $(this).parent().parent().siblings('.details').children().children().slideUp();
            $(this).parent().parent().next().children().children().slideUp();
        }
    }).on('click','#library',function(){//点出库信息
        $('#wl_tbody').empty();
        $('#push-head').empty();
        var tradeId=$(this).attr('data-inum');
        $('#bink_num').attr('data-tradeId',tradeId);
        $.ajax({
            url: '/mikuPGoods/getOrdersByTradeId',
            data: {'tradeId':tradeId},
            type: "POST",
            dataType: "json",
            success: function (data) {
                console.log(data)
                var template1=mb_html(data);
                $('#push-head').append(template1);
                ajax_iCheck();
            },
            error: function (data) {
            }
        });
        $.ajax({//回显
            url: '/mikuPGoods/getlogisticInfo',
            data: {'tradeId':tradeId},
            type: "POST",
            dataType: "json",
            success: function (data) {
                var template=m_html(data);
                $('#wl_tbody').append(template);
                console.log(data);
            },
            error: function (data) {
            }
        });
        debugger;
    }).on('click','#bink_num',function(){//添加物流
        if($.trim($('#wlh').val())==''){
            alert('请输入物流号！');
            return false;
        }
        var arr_obj=[];
        var tradeId=$('#bink_num').attr('data-tradeId');
        $('#back_msg').attr('data-tradeId',tradeId);
        $('#push-head  input[type="checkbox"]:checked').each(function(index,domEle){
            var str=($(domEle).attr('data-specification'));
            arr_obj.push(str);
        });
        var orders=arr_obj.join(";");
        var wlcompany=$('#wlcompany').val();
        var wlh=$('#wlh').val();
        $.ajax({//增加物流
            url: '/mikuPGoods/insertOneMikuLogistic',
            data: {'tradeId':tradeId,'orders':orders,'wlcompany':wlcompany,'wlh':wlh},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $('#wlh').val('');
                $('#wl_tbody').empty();
                $('#push-head').empty();
                $.ajax({//一部分
                    url: '/mikuPGoods/getOrdersByTradeId',
                    data: {'tradeId':tradeId},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        var template1=mb_html(data);
                        $('#push-head').append(template1);
                        ajax_iCheck();
                    },
                    error: function (data) {
                    }
                });
                $.ajax({//回现
                    url: '/mikuPGoods/getlogisticInfo',
                    data: {'tradeId':tradeId},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        var template=m_html(data);
                        $('#wl_tbody').append(template);

                    },
                    error: function (data) {
                    }
                });
            },
            error: function (data) {
            }
        });

    }).on('click','#back_msg',function(){//撤回
        var wlh=$('#back_msg').attr('data-wlh');
        var tradeId=$('#bink_num').attr('data-tradeId');
        $.ajax({
            url: '/mikuPGoods/cancelOnelogistic',
            data: {'wlh':wlh,'tradeId':tradeId},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $('#wl_tbody').empty();
                $('#push-head').empty();
                $.ajax({//一部分
                    url: '/mikuPGoods/getOrdersByTradeId',
                    data: {'tradeId':tradeId},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        var template1=mb_html(data);
                        $('#push-head').append(template1);
                        ajax_iCheck();
                    },
                    error: function (data) {
                    }
                });

                $.ajax({//回现
                    url: '/mikuPGoods/getlogisticInfo',
                    data: {'tradeId':tradeId},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        var template=m_html(data);
                        $('#wl_tbody').append(template);
                    },
                    error: function (data) {
                    }
                });
            },
            error: function (data) {
            }
        });

    }).on('ifChecked','#title_input',function(){
        $('#push-head input[type="checkbox"]').iCheck('check');
    }).on('ifUnchecked','#title_input',function(){
        $('#push-head input[type="checkbox"]').iCheck('uncheck');
    })

    function ajax_iCheck(){
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    };

    function m_html(obj){//第二部分
        var content="";
        for(var i = 0; i < obj.length; i++){
            var _html="<tr>";
            _html+="<td>"+obj[i].title+"</td>";
            _html+="<td>"+obj[i].props+"</td>";
            _html+="<td>"+obj[i].inputStr+"</td>";
            _html+="<td><button id='back_msg' data-tradeId='' data-wlh='"+obj[i].inputStr+"' class='btn btn-warning btn-sm'>撤回</button></td>";
            _html+="</tr>";
            content+=_html;

        }
        return content;
    }

    function mb_html(obj){//第一部分
        var content="";
        for(var i = 0; i < obj.length; i++){
            if(obj[i].hasInvoice==0){
                var _html="<tr>";
            }else{
                var _html="<tr class='success'>";
            }
            _html+="<td style='display: none;'>"+obj[i].specification+"</td>";
            if(obj[i].hasInvoice==0){
                _html+="<td><input data-specification='"+obj[i].specification+"' type='checkbox'/></td>";
            }else{
                _html+="<td></td>";
            }
            _html+="<td>"+obj[i].keyWord+"</td>";
            _html+="<td>"+obj[i].title+"</td>";
            _html+="<td>"+obj[i].price/100+"</td>";
            _html+="<td>"+obj[i].num+"</td>";
            _html+="</tr>";
            content+=_html;
        }
        return content;
    }




</script>


</body>

</html>
