<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="org.joda.time.DateTime; com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        上架商品
        <small>商品管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>商品管理</a></li>
        <li class="active">架上商品</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">

    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <div style="margin-top: 10px"></div>
            <g:form class="form-horizontal" action="index">
                <label class="col-sm-1 control-label">一级类目</label>

                <div class="col-sm-2">
                    <g:select optionKey="id" optionValue="name" name="level1Category"
                              class="form-control" from="${categoryList}" value="${params.level1Category}"
                              noSelection="['-1': '一级类目']"/>
                </div>

                <label class="col-sm-1 control-label">二级类目</label>

                <div class="col-sm-2">
                    <select id="category" class="form-control" name="category"  bsfalg="${params.category}">
                        <option value="${params?.category ?: '-1'}">${categoryMap.get(params.long('category')) ?: '二级类目'}</option>
                    </select>
                </div>

                <label class="col-sm-1 control-label">商品名称</label>
                <div class="col-sm-2">
                    <input name="query" class="form-control" value="${params.query}">
                </div>

                <label class="col-sm-1 control-label">品牌</label>
                <div class="col-sm-2">
                    <g:select optionKey="id" optionValue="name" name="brandId"
                              class="form-control" from="${mikuBrandList}"    value="${params.brandId}"
                              noSelection="['': '请选择品牌']"/>
                </div>

                <label class="col-sm-1 control-label" style="margin-top: 10px">标签</label>
                <div class="col-sm-2" style="margin-top: 10px">
                    <g:select optionKey="id" optionValue="name" name="tagId"
                              class="form-control" from="${tagsList}"    value="${params.tagId}"
                              noSelection="['': '请选择标签']"/>
                </div>

                <label class="col-sm-1 control-label" style="margin-top: 10px">商品编码</label>
                <div class="col-sm-2" style="margin-top: 10px">
                    <input  name="itemcode" class="form-control"
                            value="${params.itemcode}"
                            placeholder="商品编码"/>
                </div>

                <span class="hide" id="fieldName">${params.fieldName}</span>
                <span class="hide" id="fieldstate">${params.fieldstate}</span>

                <label class="col-sm-1 control-label" style="margin-top: 10px">查询页码</label>
                <div class="col-sm-2" style="margin-top: 10px">
                    <g:select optionKey="key" optionValue="value" name="max"
                              class="form-control" from="${PageMap}" value="${params.max}"
                              noSelection="['10': '请选择页码']"/>
                </div>

                <div class="col-sm-2  pull-right" style="margin-top: 10px">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i> 查询</button>

                    %{--<button type="button" class="btn btn-warning"--}%
                    %{--onclick="window.location.href = '${createLink(action: 'orderingRule')}'"><i--}%
                    %{--class="fa fa-bars"></i> 排序</button>--}%
                </div>
            </g:form>
        </div>

        <div class="box-body table-responsive">
            <table class="table table-hover table-striped table-bordered text-center" id="table">
                <tr>
                    <th width="15%">标签</th>
                    <th>一级类目</th>
                    <th>二级类目</th>
                    <th>品牌</th>
                    <th width="20%">名称</th>
                    <th style="position: relative">商品编码
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('code-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right:0px;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('code-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0px;
                    cursor: pointer;
                    "></span>
                    </th>
                    %{--<th>市场价</th>--}%
                    <th style="position: relative">销售价
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('price-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right: 0;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom"  onclick="paixu('price-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th style="position: relative">库存
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('num-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right: 0;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('num-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th style="position: relative">上架时间
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('onlineStartTime-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right: 0;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('onlineStartTime-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th>销售基数</th>
                    <th style="position: relative">权重
                        <span class="glyphicon glyphicon-triangle-top" onclick="paixu('weight-asc')" aria-hidden="true" style="
                        position: absolute;
                        top: 3px;
                        right: 0;
                        cursor: pointer;
                        "></span><span class="glyphicon glyphicon-triangle-bottom" onclick="paixu('weight-desc')" aria-hidden="true" style="
                    position: absolute;
                    top: 15px;
                    right: 0;
                    cursor: pointer;
                    "></span>
                    </th>
                    <th>操作</th>
                    %{--<th>--}%
                    %{--<input type="checkbox" id="checkAll">--}%
                    %{--</th>--}%

                </tr>
                <g:if test="${total > 0}">
                    <g:each status="i" in="${itemList}" var="item">
                        <tr id="${item.id}" class="info">
                            <td>
                                <div>
                                    <g:if test="${itemTagMap.get(item?.id) != null}">
                                        <g:each status="j" in="${itemTagMap.get(item?.id)}" var="tag">
                                            <small class="label pull-left bg-blue" style="white-space: normal;">${tag?.name}
                                            <g:if test="${tag.bit == 1L}">
                                                ${JSON.parseObject(xlTagMap.get(item?.id))?.get('xgLimitNum') ?: '无'}
                                            %{--${JSON.parseObject(OtMap.get(tag.id))?.get('xgLimitNum') ?: '无'}--}%
                                            </g:if>
                                            <g:if test="${tag?.name=='抢购标'}">
                                                ${xgbTagMap.get(item?.id)}
                                            </g:if>
                                            </small>
                                        </g:each>
                                    </g:if>
                                </div>
                            </td>
                            <td>${categoryMap.get(categoryMap.get(item?.categoryId)?.parentId)?.name}</td>
                            <td>${categoryMap.get(item.categoryId)?.name}</td>
                            <td>${brandMap.get(item.brandId)?.name}</td>
                            <td>
                                <input onchange="modixsTitle('${item?.id}')" type="text"
                                       value="${item?.title}" name="${item?.id}" class="no-border" id="title${item?.id}"
                                       style="background:transparent;width: 80%;margin: auto">
                                <div style="padding-top: 10px">
                                    ${item?.id}
                                </div>
                            </td>
                            <td>${item.code}</td>
                            %{--<td>${(JSON.parseObject(item.features)?.getLongValue('referencePrice') ?: 0) / 100f}</td>--}%
                            <td>${(item.price ?: 0) / 100f}</td>
                            <td>
                                <input onchange="modixsNum('${item?.id}')" type="text"
                                       value="${item?.num}" name="${item?.id}" class="no-border" id="num${item?.id}"
                                       style="width:30px;background:transparent;">
                            </td>
                            <td>
                                ${item.onlineStartTime?new DateTime(item.onlineStartTime).toString("yyyy-MM-dd HH:mm"):""}
                            </td>
                            <td>
                                <input onchange="modixsQuantity('${item?.id}')" type="text"
                                       value="${item?.baseSoldQuantity}" name="${item?.id}" class="no-border" id="qu${item?.id}"
                                       style="width:30px;background:transparent;">
                            </td>

                            <td>
                                <input onchange="modifyweight('${item?.id}')" type="text"
                                       value="${item?.weight}" name="${item?.id}" class="no-border"  id="wi${item?.id}"
                                       style="width:30px;background:transparent;">
                            </td>
                            <td>
                                <button class="btn-sm btn-primary btn-sm"
                                        onclick="lookItemDetail('${item.id}');
                                        return false;"
                                        data-toggle="modal"
                                        data-target="#itemDetailModel"><i class="fa fa-info-circle"></i>详情</button>
                                <button type="button" class="btn btn-primary btn-sm"
                                        onclick="makeInStock(${item.id})">下架</button>
                                %{--<button type="button" class="btn btn-warning btn-sm"--}%
                                %{--onclick="copyItemToCommunity(${item.id})">同步</button>--}%
                            </td>
                            %{--<td>--}%
                            %{--<input type="checkbox" name="itemShipBox"--}%
                            %{--value="${item?.id}">--}%
                            %{--</td>--}%
                        </tr>
                    </g:each>
                </g:if>
            </table>
        </div><!-- /.box-body -->

        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <div class="pagination pull-right">
                    <g:paginate next="下一页" prev="上一页" params="${params}" max="${params.max}"
                                maxsteps="10" action="index" total="${total}"/>
                </div>
            </g:if>

        %{--<div class="row">--}%
        %{--<div class="col-sm-2">--}%
        %{--<g:form action="copyItem" controller="shopItemManager" params="${params}">--}%
        %{--<g:if test="${total > 0}">--}%
        %{--<g:each status="i" in="${itemList}" var="item">--}%
        %{--<div style="display: none">--}%
        %{--<input type="checkbox" name="copyBox" value="${item.id}">--}%
        %{--</div>--}%
        %{--</g:each>--}%
        %{--</g:if>--}%
        %{--<button type="submit" class="btn btn-warning "><i--}%
        %{--class="fa fa-cloud-download"></i>复制到本站点</button>--}%
        %{--</g:form>--}%
        %{--</div>--}%
        %{--</div>--}%
        </div>
    </div><!-- /.box -->
</section><!-- /.content -->

<div class="modal fade bs-example-modal-lg" id="itemDetailModel" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

                <h2 class="modal-title h2" id="itemId">产品ID号：</h2>
            </div>

            <div class="modal-body">
                <div id="itemDetail">
                    <g:render template="itemDetail"/>
                </div>
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
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>

<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script>


    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '10%' // optional
    });

    $("input[name='itemShipBox']").on('ifChecked', function (event) {
        var id = this.value
        $("input[name='copyBox']").each(function check() {
            if (id == this.value) {
                $(this).iCheck('check');
            }
        });
    });
    $("input[name='itemShipBox']").on('ifUnchecked', function (event) {
        var id = this.value
        $("input[name='copyBox']").each(function check() {
            if (id == this.value) {
                $(this).iCheck('uncheck');
            }
        });
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

    function lookItemDetail(id) {
        $("#itemId").text('产品ID号:' + id)
        <g:remoteFunction update="itemDetail" action="lookItemDetail" options="'[asynchronous: false]'"  params="'id='+id"/>

    }

    var num = 0

    $(function () {
        $('#level1Category').change(function () {
            num = num + 1
            var str = "";
            $("#level1Category option:selected").each(function () {
                var categoryFlag=($('#category').attr("bsfalg") && $('#category').attr("bsfalg")!=-1)?1:0;
                $('#category').find('option').remove();
                $('#category').append('<option value="-1">请选择类目...</option>');
                var id = $(this).val()
                if (id != "-1" && id != '' && id != undefined && num < 2) {
                    $.ajax({
                        url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" params="${params}"/>', // remote datasource
                        data: {'id': id},
                        type: "POST",
                        dataType: "json",
                        success: function (data) {
                            debugger;
                            if(categoryFlag){
                                $('#category').find('option').remove();
                            }
                            $.each(data, function (index, m) {
                                $('#category').append('<option value="' + m.id + '">' + m.name + '</option>');
                            })

                        }, error: function (data) { // handle server errors
                        }
                    });
                } else {
                    $.ajax({
                        url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId" />', // remote datasource
                        data: {'id': id},
                        type: "POST",
                        dataType: "json",
                        success: function (data) {
                            $.each(data, function (index, m) {
                                $('#category').append('<option value="' + m.id + '">' + m.name + '</option>');
                            })

                        }, error: function (data) { // handle server errors
                        }
                    });
                }
            });
        }).trigger('change');
    })

    function makeInStock(id) {

        if (!confirm("您真的要下架这个商品么？")) {
            return;
        }

        $.ajax({
            url: '/item/makeInStock',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#" + id).remove()
                $.sticky("操作成功", {autoclose: 2000, position: "top-right", type: "st-success"});
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

    function copyItemToCommunity(id) {

        if (!confirm("您真的要同步这个商品么？")) {
            return;
        }

        $.ajax({
            url: '/ShopItemManager/copyItemToCommunity',
            data: {'id': id},
            type: "POST",
            dataType: "json",
            success: function (data) {

                if (data.code == 1) {
                    if (!confirm("发生冲突，是否强同步(强同步将导致分仓商品下架，需要站长手动调整)!")) {
                        return;
                    }

                    $.ajax({
                        url: '/ShopItemManager/copyItemToCommunityThrough',
                        data: {'id': id},
                        type: "POST",
                        dataType: "json",
                        success: function (data) {
                            alert(JSON.stringify(data.message))
                        },
                        error: function (data) {
                            alert(JSON.stringify(data.message))
                        }
                    });


                } else {
                    alert(JSON.stringify(data.message))
                }

            },
            error: function (data) {


            }
        });
    }

    //修改对应商品权重
    function modifyweight(id) {
        //旧的名称
        var newWeight = $("#wi"+id).val().trim();
        if(!newWeight)
        {
            alert("对应的权重不能设置为空...");
            return false;
        }
        //判断是否为数字值
        var num=parseInt(newWeight);
        if(!isNaN(num))
        {
            $.ajax({
                url: '/itemInStock/updateOneItemWeight',
                data: {'id': id, 'newWeight': newWeight},
                type: "POST",
                dataType: "json",
                success: function (data) {
//                        alert(data);
                    $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                },
                error: function (data) {
                    $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
        }
        else
        {
            alert("对应的权重只能填数字类型...");
            return false;
        }
    }


    function modixsQuantity(id)
    {
        var newWeight = $("#qu"+id).val().trim();
        if(!newWeight)
        {
            alert("对应的权重不能设置为空...");
            return false;
        }
        //判断是否为数字值
        var num=parseInt(newWeight);
        if(!isNaN(num))
        {
            $.ajax({
                url: '/itemInStock/updateOneItemQuantity',
                data: {'id': id, 'qunatity': newWeight},
                type: "POST",
                dataType: "json",
                success: function (data) {
//                        alert(data);
                    $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                },
                error: function (data) {
                    $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
        }
        else
        {
            alert("对应的权重只能填数字类型...");
            return false;
        }
    }

    //修改库存
    function modixsTitle(id)
    {
        var title=$("#title"+id).val();
        if(!title)
        {
            alert("对应名称不能设置为空...");
            return false;
        }
        if(title)
        {
            $.ajax({
                url: '/itemInStock/updateOneItemTitle',
                data: {'id': id, 'title': title},
                type: "POST",
                dataType: "json",
                success: function (data) {
                    $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                },
                error: function (data) {
                    $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
        }


    }

    //修改名称
    function modixsNum(id){
        var num=$("#num"+id).val();
        if(!num)
        {
            alert("对应的库存不能设置为空...");
            return false;
        }
        //判断是否为数字值
        var num=parseInt(num);
        if(!isNaN(num))
        {
            $.ajax({
                url: '/itemInStock/updateOneItemNum',
                data: {'id': id, 'num': num},
                type: "POST",
                dataType: "json",
                success: function (data) {
//                        alert(data);
                    $.sticky("修改成功", {autoclose: 2000, position: "top-right", type: "st-success"});
                },
                error: function (data) {
                    $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
                }
            });
        }
        else
        {
            alert("对应的库存只能填数字类型...");
            return false;
        }
    }


    //进行页码数的分页
    $("#max").on("change",function(){
        var size=$(this).val();
        var level1Category=$("#level1Category").val();
        var category=$("#category").val();
        var itemcode=$("input[name=itemcode]").val();
        var query=$("input[name=query]").val();
        var brandId=$("#brandId").val();
        var tagId=$("#tagId").val();
        var str='/itemOnSale/index?max='+size+"&level1Category="+level1Category+"&category="+category+"&query="+query+"&brandId="+brandId+"&tagId="+tagId+"&itemcode="+itemcode;
        window.location.replace(str);
    });


    //进行各类的排序
    function paixu(content){
        var flag=content;
        var stateArr=content.split("-");
        var field=stateArr[0];
        var fieldstate=stateArr[1];
        //排序的字段
        $("#fieldName").html(field);
        $("#fieldstate").html(fieldstate);
        var pagesize=$("#max").val();
        var level1Category=$("#level1Category").val();
        var itemcode=$("input[name=itemcode]").val();
        var category=$("#category").val();
        var query=$("input[name=query]").val();
        var brandId=$("#brandId").val();
        var tagId=$("#tagId").val();
        var str='/itemOnSale/index?max='+pagesize+"&level1Category="+level1Category+"&category="+category+"&query="+query+"&brandId="+brandId+"&tagId="+tagId+"&fieldName="+field+"&fieldstate="+fieldstate+"&itemcode="+itemcode;
        window.location.replace(str);
    }

</script>

</body>

</html>
