<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/1/23
  Time: 13:42
--%>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>


    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <asset:stylesheet src="skins/skin-blue.css"/>


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
        页面管理
        <small>运营工具</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>运营工具</a></li>
        <li class="active">页面管理</li>
    </ol>
</section>


<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">页面列表</g:link></li>
                    <li>
                        <g:link action="addPage">新增页面</g:link></li>
                    %{--<li class="active">--}%
                        %{--<g:link action="pageSetting">页面配置</g:link></li>--}%
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">

        </div><!-- /.box-header -->

        <div class="box-body">
            <div class="page-setting center-block text-center clearfix">
                <div class="item-setting">
                    <div class="center-block photo-view">
                        <div style="height: 135px"></div>
                        <div class="center-block view-wrap" id="oneLevelDiv">

                            <!-- Button trigger modal -->
                            <div class="item-view item-add text-center" data-toggle="modal" data-target="#myModal">
                                <i class="icon icon-add" style="display: inline-block;"></i>
                                <i class="icon-caret-right-wrap"><i class="icon-caret-right"></i></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modules">

                    <div class="module banner">

                        <div class="item-setting">
                            <div class="center-block area-view">
                                <div class="view-wrap">
                                    <div class="title"></div>
                                    <div id="twoLevelDiv">

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="item-setting">
                            <div class="center-block search-view">
                                <div class="view-wrap">
                                    <div class="title form-inline">
                                        %{--<form class="form-inline">--}%

                                            <div class="form-group">
                                                <input name="name" class="form-control input-search"  id="myDataContent" style="width: 190px" value="" placeholder="请输入标题...">


                                                <button class="btn btn-primary btn-submit-search"  onclick="getMyData()" ><i class="fa fa-search">查询</i></button>
                                            </div>

                                        %{--</form>--}%
                                    </div>
                                    <div id="searchResultDiv">

                                    </div>
                                    <div id="searchResultList"></div>
                                </div>
                            </div>
                        </div>

                    </div>


                </div>
            </div>
        </div><!-- /.box-body -->

    </div><!-- /.box -->
</section><!-- /.content -->

<div style="display: none;">

    <span id="mlist">${mlist}</span>
    <span id="typelist">${typelist}</span>
    <span id="viewId">${viewId}</span>

</div>

<!-- Modal -->
<div class="modal fade modal-add-activity" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="" class="form-horizontal">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增活动区</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group text-center">
                        <label class="">修改活动区名称：</label><input type="text" class="form-control input-text" name="name"/>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="addOneLevel">保存</button>
                    <button type="button" class="btn btn-default btn-cancel" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div><!-- /.Modal -->


<button id="mytwoBtn" data-toggle="modal" data-target="#myModalModify" style="display: none;"></button>

<!-- Modal -->
<div class="modal fade modal-modify-name" id="myModalModify" tabindex="-1" role="dialog" aria-labelledby="myModalModify">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="" class="form-horizontal">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalArea">编辑活动区</h4>
                </div>
                <div class="modal-body form-inline">
                    <div class="form-group text-center">
                        <label class="">修改活动区名称：</label><input type="text" class="form-control input-text" name="name" id="changeNameArea"  />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="modifyLevelName">保存</button>
                    <button type="button" class="btn btn-default btn-cancel"  id="changeNameAreaCancel"  data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div><!-- /.Modal -->


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
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>

<asset:javascript src="pages/item/publish-item-pic.js"/>
<asset:javascript src="pages/item/publish-detail-pic.js"/>



<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>



    //编辑一级类目项
    function editLevelItem(id,name) {



        console.log(4);

        var data = {
            'id': id,
            'name': name
        };


        modifyOneLevelCotent(data);

//        this.stopPropagation();

    }


    function getMyData(){
        var title=$("#myDataContent").val();
        if(title){
            searchItems(title);
        }else{
            $(".thereLevelStyle").show();
        }
    }


    //修改的内容
    $("#modifyLevelName").click(function(){
        var name = $("#changeNameArea").val();
        if(name == '') {
            alert("活动名称不能为空！");
            return false;
        }
        obj={
           id:$("#changeNameArea").attr("changeid"),
           name: name
        };
        modifyOneLevelCotent(obj);
    });



    $(function(){

        //开始加载页面
        var initData = JSON.parse($("#mlist").html()),
            typeData = JSON.parse($("#typelist").html()),
            viewId = $("#viewId").html();

//        addOneLevelContent(initData);

        var oneLevelHtml = [];activityTopHtml = [],itemHtml = [],brandHtml = [],activityHtml = [],seckillHtml = [],goodsHtml = [];
        $.each(initData,function(index,content){
            var tem = oneLevelContent(content);


//            .put(418, "顶部活动位")
//            .put(419, "类目入口")
//            .put(420, "品牌入口")
//            .put(421, "活动专区")
//            .put(422, "秒杀专区")
//            .put(423, "商品专区")
            switch (content.type) {

                case 418:
                    activityTopHtml.push(tem);
                    break;

                case 419:
                    itemHtml.push(tem);
                    break;

                case 420:
                    brandHtml.push(tem);
                    break;

                case 421:
                    activityHtml.push(tem);
                    break;

                case 422:
                    seckillHtml.push(tem);
                    break;

                case 423:
                    goodsHtml.push(tem);
                    break;
            }

        });

//        console.log(activityTopHtml,itemHtml,brandHtml,activityHtml,activityHtml,seckillHtml,goodsHtml);

        activityTopHtml = activityTopHtml.join("");
        itemHtml = itemHtml.join("");
        brandHtml = brandHtml.join("");
        activityHtml = activityHtml.join("");
        seckillHtml = seckillHtml.join("");
        goodsHtml = goodsHtml.join("");

         oneLevelHtml.push(activityTopHtml,itemHtml,brandHtml,activityHtml,seckillHtml,goodsHtml);


        $("#oneLevelDiv").prepend(oneLevelHtml.join(""));


        $(".myEdit").bind('click',function(event){
            event.stopPropagation();
            var target = $($(this).parents('.item-view')),
                    id = target.attr('selfid'),
                    name = target.attr('name'),
                    data = {
                        'id': id,
                        'name': name
                    };
            $("#changeNameArea").val(name);
            $("#changeNameArea").attr("changeid",id);
            $("#mytwoBtn").click();
//                event.preventDefault();
        });


        console.log(initData);


        //加载对应内容
        $('#oneLevelDiv').on('click', '.item-target', function(event){

            console.log($(this));

            var target=$(this);
            var flag = target.attr('flag');
            if(flag==1) {
                return false;
            }

            $(this).addClass('active').siblings().removeClass('active');

            var Id = target.attr('selfId'),
                type = target.attr('type'),
                viewId = target.attr('viewId'),
                title = target.find('.text-label').text();
                data = {
                   'oneLevelId':Id,
                   'type':type,
                   'viewId':viewId,
                   'title': title
                };

            getClickOneLevelToInitData(data);
            event.stopPropagation();    //  阻止事件冒泡

        });

        $('#oneLevelDiv .item-target').on('click', '.icon-normal', function(event) {
            event.stopPropagation();    //  阻止事件冒泡
        });



        //添加一级类目
        $('#addOneLevel').click(function(){

            var type = $("input[name='type']:checked").val(),
                    name = $("input[name='name']", '.modal-add-activity').val();

            if(type == '' || typeof(type) == 'undefined') {
                alert("请选择活动类型！");
                return false;
            }

            if (name == '') {
                alert("活动区名字不能为空!");
                return false;
            }


            switch (type) {

                case 418:
                        $('#myModal').find('div[data-type="'+ type +'"]').remove();
                    break;

                case 419:
                    $('#myModal').find('div[data-type="'+ type +'"]').remove();
                    break;

                case 420:
                    $('#myModal').find('div[data-type="'+ type +'"]').remove();
                    break;
            }

            var json = {
                'type': type,
                'name': name,
                'viewId':viewId
            };

            AddOneLevelData(json);

        });

        initSelectContent(typeData);


        $('.input-radio').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });

        $("input[name='type']").on('ifChecked', function (event) {
//            alert('ifchecked');
        });
        $("input[name='type']").on('ifUnchecked', function (event) {
//            alert('ifunchecked');
        });



        $('.search-view').on('click', '.btn-submit-search', function(event){
            event.preventDefault();
//            var $input = $('.input-search');
//            $input.blur();
//            var nickName = $.trim($input.val()+'');
//            //debugger;
//            allySearch(nickName,type);
        }).on('input propertychange', '.input-search', function(event){
            event.preventDefault();

            var $input = $('.input-search');

            var title = $.trim($input.val() + '');

            console.log(title);

//            if (title == '') {
//                $('#searchResultDiv').show();
//                $('#searchResultList').hide();
//            }


            if(title == '' || typeof(title) !== 'undefined'){
                searchItems(title);
            }else{
                $(".thereLevelStyle").show();
            }

//            searchItems(title);
        });

    });


    //初始化选择的内容的选择
    function initSelectContent(typeData){
        var alreadyContent=$(".item-target");
        $.each(typeData,function(index,content) {
            var temModal = oneLevelModal(index,content);
            var flag = 0;
            for (var j = 0; j < alreadyContent.length; j++) {
                if (parseInt($(alreadyContent[j]).attr("type")) == parseInt(index) && (parseInt($(alreadyContent[j]).attr("type")) == 418 || parseInt($(alreadyContent[j]).attr("type")) == 419 || parseInt($(alreadyContent[j]).attr("type")) == 420)) {
                    flag = 1;
                    break;
                }
            }

            if(!flag){
                $(".modal-add-activity .modal-body").prepend(temModal);
            }
        });
    }


    //搜索
    function searchItems(title) {

        var arr=[];
        $.each(MyData,function(index,content){
            if((content.title).indexOf(title)>-1){
                arr.push(content);
            }
        });

        //全部隐藏全部的div
        $(".thereLevelStyle").hide();
        for(var i=0;i<$(".thereLevelStyle").length;i++){
            var twoLevel=$($(".thereLevelStyle")[i]).attr("twolevelid");
            $.each(arr,function(index,content){
                if(content.id==twoLevel){
                    $($(".thereLevelStyle")[i]).show();
                }
            });
        }
    }



    function htmlLinks(links,template){
        var html = [];
        $.each(links, function(index, item){
            html.push(template);
        });
        return html.join('');
    }


    //加载一级类目列表
    function oneLevelContent(obj){
        var mask = '',
            hideStates = '',
            showStates = '';
        switch (obj.oneLevelStatus) {
            case 1:
                mask = 'masked';
                hideStates = 'active';
                showStates = '';
                break;
            case 2:
                mask = '';
                hideStates = '';
                showStates = 'active';
                break;
        }
        var str= "<div class='item-view item-activity item-target "+mask+"' viewId='"+obj.viewId+"' selfId='"+obj.id+"' id='onelevel_"+obj.id+"' type='"+obj.type+"'  name='"+obj.name+"' flag='"+obj.oneLevelStatus+"'>";
        str+="<span class='text-label'>";
        str+=obj.name;
        str+="</span>";
        str+="<a href='javascript:hideLevelItem("+obj.id+");' class='icon icon-normal icon-hide "+hideStates+"' data-toggle='tooltip' data-placement='left' title='隐藏'></a>";
        str+="<a href='javascript:showLevelItem("+obj.id+");' class='icon icon-normal icon-show "+showStates+"' data-toggle='tooltip' data-placement='left' title='显示'></a>";
        str+="<a href='javascript:deleteLevelItem("+obj.id+");' class='icon icon-normal icon-delete' data-toggle='tooltip' data-placement='left' title='删除'></a>";
        str+="<a href='javascript:;' class='icon icon-edit myEdit' data-toggle='modal' data-placement='left' title='编辑' data-target='#myModalModify'></a>";
        str+="<i class='icon-caret-right-wrap'><i class='icon-caret-right'></i></i><div class='mask'></div></div>";
        return str;
    }

    //隐藏一级类目项
    function hideLevelItem(id) {
        console.log(1);

        var data = {
            'id': id,
            'status': 1
        };

        ChangeOneLevelData(data);

    }

    //显示一级类目项
    function showLevelItem(id) {
        console.log(2);

        var data = {
            'id': id,
            'status': 2
        };

        ChangeOneLevelData(data);

    }

    //删除一级类目项
    function deleteLevelItem(id) {
        console.log(3);

        var data = {
            'id': id,
            'status': 0
        };

        ChangeOneLevelData(data);

    }




    //添加一级类目添加模态框模板
    function oneLevelModal(key,value){
        var str= '<div class="form-group" data-type="'+key+'"><input type="radio" class="input-radio" name="type" value="' + key + '"/>&nbsp;&nbsp;<label>' + value + '</label></div>';
        return str;
    }

    //addOneLevelContent
    function addOneLevelContent(obj) {
        var tem = oneLevelContent(obj);


        switch (obj.type) {

            case 418:
                $("#oneLevelDiv").prepend(tem);
                break;

            case 419:
                $("#oneLevelDiv").prepend(tem);
                break;

            case 420:
                $("#oneLevelDiv").prepend(tem);
                break;

            case 421:
                $("#oneLevelDiv .item-add").before(tem);
                break;

            case 422:
                $("#oneLevelDiv .item-add").before(tem);
                break;

            case 423:
                $("#oneLevelDiv .item-add").before(tem);
                break;

        }


//        $("#oneLevelDiv").prepend(tem);
//        editBindEvent();

        $(".myEdit").bind('click',function(event){
            event.stopPropagation();
            var target = $($(this).parents('.item-view')),
                    id = target.attr('selfid'),
                    name = target.attr('name'),
                    data = {
                        'id': id,
                        'name': name
                    };
            $("#changeNameArea").val(name);
            $("#changeNameArea").attr("changeid",id);
            $("#mytwoBtn").click();

        });
    }


    //添加一条One Level的数据
    function AddOneLevelData(obj){
        $.ajax({
            url: '/pageManage/oneLevelInfo',
            data: {
                'type':obj.type,
                'name':obj.name,
                'viewId':obj.viewId
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
//                var info=JSON.parse(data);
                //进行一级模板的添加

                addOneLevelContent(data);


                $('.btn-cancel').click();
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    //操作One Level状态
    function ChangeOneLevelData(obj){
        $.ajax({
            url: '/pageManage/DoOneLevelById',
            data: {
                'id':obj.id,
                'status':obj.status
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
//                var info=JSON.parse(data);
                //进行一级模板的修改[主要是看状态: 0删除  1隐藏  2显示]
                console.log(obj,data);

                if(data.oneLevelStatus == 0) {
                    $('#onelevel_' + obj.id).remove();
                } else if (data.oneLevelStatus == 1) {
                    $('#onelevel_' + obj.id +' .icon-hide').addClass('active').siblings().removeClass('active');
                    $('#onelevel_' + obj.id).addClass('masked');
                    $('#onelevel_' + obj.id).attr('flag',data.oneLevelStatus);
                } else if (data.oneLevelStatus == 2) {
                    $('#onelevel_' + obj.id +' .icon-show').addClass('active').siblings().removeClass('active');
                    $('#onelevel_' + obj.id).removeClass('masked');
                    $('#onelevel_' + obj.id).attr('flag',data.oneLevelStatus);
                }


            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }

    //点击的一级level进行查询对应类型的数据
    function getOneLevelByTypeInfo(type){
        $.ajax({
            url: '/pageManage/getContentInfo',
            data: {
                'type':type
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
                var info=JSON.parse(data);
                //根据不一样类型获取的是不一样数据列表
                $.each(info,function(index,content){
                    //下面的数据添加到查询页面的内容
                });
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    //添加二级Level内容
    function AddTwoLevelData(obj){
        $.ajax({
            url: '/pageManage/twoLevelInfo',
            data: {
                'viewId':obj.viewId,
                'oneLevelId':obj.oneLevelId,
                'twoLevelId':obj.twoLevelId,
                'type':obj.type,
                'info':obj.imginfo,
                'name':obj.name
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
                //进行二级模板的添加
                if(data) {
                    data.imginfo = obj.imginfo;
                    data.title = obj.name;
                }

                var template = addTwoLevelContent(data);

                var noRecord = $('.no-record');

                if(noRecord) {
                    noRecord.remove();
                }

                $('#twoLevelDiv').append(template);


                $('#searchResultDiv div[twolevelid='+obj.twoLevelId+']').attr('flag', 1).addClass('added');
            },
        error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }



    //操作Two Level状态
    function changeTwoLevelItem(id,status) {

        switch (status) {

            //删除二级类目项
            case 0:
                var data = {
                    'id': id,
                    'status': status
                };
                break;

            //隐藏二级类目项
            case 1:
                var data = {
                    'id': id,
                    'status': status
                };
                break;

            //显示二级类目项
            case 2:
                var data = {
                    'id': id,
                    'status': status
                };
                break;

            default :
                var data = {
                    'id': id,
                    'status': status
                };
                break;
        }

        ChangeTwoLevelData(data);
    }



    //操作Two Level状态
    function ChangeTwoLevelData(obj){
        $.ajax({
            url: '/pageManage/DoTwoLevelById',
            data: {
                'id':obj.id,
                'status':obj.status
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
//                var info=JSON.parse(data);
                //进行二级模板的修改[主要是看状态: 0删除  1隐藏  2显示]
                console.log(data);
                if(data.twoLevelStatus == 0) {
                    //删除二级类目模板
                    var changeItem = $('#twolevel_' + obj.id);
                    changeItem.remove();

                    //操作searchResultDiv  .item-view 状态
                    var twolevelid = changeItem.attr('twolevelid');
                    $('#searchResultDiv div[twolevelid='+twolevelid+']').attr('flag', 0).removeClass('added');

                } else if (data.twoLevelStatus == 1) {
                    $('#twolevel_' + obj.id).addClass('masked');
                    $('#twolevel_' + obj.id +' .icon-hide').addClass('active').siblings().removeClass('active');
                } else if (data.twoLevelStatus == 2) {
                    $('#twolevel_' + obj.id).removeClass('masked');
                    $('#twolevel_' + obj.id +' .icon-show').addClass('active').siblings().removeClass('active');
                }
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    //进行获取的是一级level的id来获取的二级level的数据
    function getTwoLevelByOneLevelId(obj){
        $.ajax({
            url: '/pageManage/getTwoLevelByOneLevelId',
            data: {
                'oneLevelId':obj.oneLevelId,
                'viewId':obj.viewId
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
                //点击第一级的level的对象获取的它本身具有的二级的数据

            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    //根据条件进行查询列表的信息
    function selectInfoByTypeAndTitle(obj){
        $.ajax({
            url: '/pageManage/getContentInfoByTitle',
            data: {
                'type':obj.type,
                'title':obj.title
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
                var info=JSON.parse(data);
                //根据不一样类型获取的是不一样数据列表
                $.each(info,function(index,content){
                    //下面的数据添加到查询页面的内容
                });
            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }



    //添加三级查询的模板
    function addSearchContent(obj,oneLevelId,type){
        var flag = '';
        if (obj.flag == 1) {
            flag = 'added';
        }
        var str="<div class='item-view item-banner clearfix  thereLevelStyle  "+flag+"' oneLevelId='"+obj.oneLevelId+"' twolevelid='"+obj.id+"'  type='"+obj.type+"' name='"+obj.name+"' flag='"+obj.flag+"'>";
        str+="<div class='col-xs-6 cover-wrap'>";
        str+="<img src='"+obj.imginfo+"' class='cover'/></div>";
        str+="<div class='col-xs-6 text-left text-wrap'>";
        str+=obj.title;
        str+="</div><i class='icon-add' data-toggle='tooltip' data-placement='top' title='添加'></i>";
        str+="<div class='mask'></div>";
        str+="</div>";

        return str;
    }


    function addTwoLevelTitle() {

    }

    //添加二级过来的二级模板[初始化的时候，还有添加的时候]
    //说明一下：这个obj具有的属性有：
    //    Long id
    //    //说明
    //    String info
    //    //图片信息
    //    String imginfo
    //    //标题
    //    String title
    //    //类型
    //    Integer type
    //    一，二，大类的id：oneLevelId  twoLevelId   viewId
    function addTwoLevelContent(obj){
        var mask = '',
            hideStates = '',
            showStates = '';
        switch (obj.twoLevelStatus) {
            case 1:
                mask = 'masked';
                hideStates = 'active';
                showStates = '';
                break;
            case 2:
                mask = '';
                hideStates = '';
                showStates = 'active';
                break;
        }
        var str="<div class='item-view "+mask+"' id='twolevel_"+obj.id+"' oneLevelId='"+obj.oneLevelId+"' twolevelid='"+obj.twoLevelId+"'  type='"+obj.type+"' viewId='"+obj.viewId+"' weight='"+obj.weight+"' targetId='"+obj.id+"'>";
        str+="<div class='col-xs-6 cover-wrap'><img src='"+obj.imginfo+"' class='cover'/></div>";
        str+="<div class='col-xs-6 text-left'>";
        str+=obj.title;
        str+="</div>";
        str+="<div class='icon-wrap'><a href='javascript:changeTwoLevelItem("+obj.id+",1);'  class='icon icon-hide "+hideStates+"' data-toggle='tooltip' data-placement='top' title='隐藏'></a>";
        str+="<a href='javascript:changeTwoLevelItem("+obj.id+",2);'  class='icon icon-show "+showStates+"' data-toggle='tooltip' data-placement='top' title='显示'></a>";
        str+="<a href='javascript:changeTwoLevelItem("+obj.id+",0);'  class='icon icon-delete' data-toggle='tooltip' data-placement='top' title='删除'></a>";
        str+="<a href='javascript:changeTwoLevelWeight(twolevel_"+obj.id+",0);'  class='icon icon-prev' data-toggle='tooltip' data-placement='top' title='上移'></a>";
        str+="<a href='javascript:changeTwoLevelWeight(twolevel_"+obj.id+",1);'  class='icon icon-next' data-toggle='tooltip' data-placement='top' title='下移'></a></div>";
        str+="<div class='mask'></div>";
        str+="</div>";

        return str;
    }

    var MyData={};


    //点击第一级的level的对象获取的它本身具有的二级的数据  + 根据类型来进行查询对应选择项的内容的获取[全部类型的内容]
    function getClickOneLevelToInitData(obj){
        $.ajax({
            url: '/pageManage/clickOneLevelToGetContent',
            data: {
                'oneLevelId':obj.oneLevelId,
                'type':obj.type,
                'viewId':obj.viewId
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
                //获取对象的里面有2个数据：initData-->二级类目的数据     searchData--->根据类型查询的初始化的数据


//                $('.view-wrap .title').text('');
                var twoLevelHtml = [],
                    searchResultHtml = [];
                $.each(data.initData,function(index,content){
                    content.imginfo=content.info;
                    content.title=content.name;
//                    content.title=obj.viewId;
                    twoLevelHtml.push(addTwoLevelContent(content));
                });

                $('.area-view .title').text(obj.title);

                if (twoLevelHtml.length){
                    $('#twoLevelDiv').html(twoLevelHtml);
                } else {
                    var noRecord = '<div class="no-record"><p>快往'+obj.title+'搬运东西吧~</p></div>';
                    $('#twoLevelDiv').html(noRecord);
                }

                MyData=data.searchData;

                $.each(data.searchData,function(index,content){

                    content.imginfo = content.imginfo.split(';')[0];

                    searchResultHtml.push(addSearchContent(content));
                });

                var serachResult = $('#searchResultDiv').html(searchResultHtml);


                //添加搜索结果到二级类目
                serachResult.off();

                serachResult.on('click', '.item-view', function() {

                    console.log($(this));

                    var target = $(this),
                            viewId = obj.viewId,
                            oneLevelId = obj.oneLevelId,
                            twoLevelId = target.attr('twoLevelId'),
                            type = obj.type,
                            title = target.find('.text-wrap').text();
                            imginfo = target.find('.cover').attr('src'),
                            flag = target.attr('flag');

                    var data = {
                        'viewId':viewId,
                        'oneLevelId':oneLevelId,
                        'twoLevelId':twoLevelId,
                        'type':type,
                        'name':title,
                        'imginfo': imginfo,
                        'flag': flag
                    };

                    if(flag == 0) {
                        AddTwoLevelData(data);
                    }

                });

            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }


    function changeTwoLevelWeight(id,status) {

        console.log(id,status);


        var target = $(id),
            prevTarget = target.prev(),
            nextTarget = target.next();

        // 0 上移   1 下移
        switch (status) {
            case 0:

                if(prevTarget.length) {

                    var targetId = target.attr('targetId'),
                            targetWeight = target.attr('weight'),
                            hwtargetId = prevTarget.attr('targetId'),
                            hwtargetWeight = prevTarget.attr('weight');

                    var targetData = {
                            'dom': target,
                            'id': targetId,
                            'weight': targetWeight
                        },
                        pxtargetData = {
                            'dom': prevTarget,
                            'id': hwtargetId,
                            'weight': hwtargetWeight
                        };

//                    if(pxBannerLocation(targetData, pxtargetData)){
//                        target.insertBefore(prevTarget);
//                    }
                    pxBannerLocation(targetData, pxtargetData,0);

                    //上移操作
                    //target.insertBefore(prevTarget);
                } else {
                    $.sticky("已置顶啦~", {autoclose: 2000, position: "top-right", type: "st-success"});
                }

                break;
            case 1:

                if(nextTarget.length) {
                    var targetId = target.attr('targetId'),
                        targetWeight = target.attr('weight'),
                        hwtargetId = nextTarget.attr('targetId'),
                        hwtargetWeight = nextTarget.attr('weight');


                    var targetData = {
                            'dom': target,
                            'id': targetId,
                            'weight': targetWeight
                        },
                        pxtargetData = {
                            'dom': nextTarget,
                            'id': hwtargetId,
                            'weight': hwtargetWeight
                        };

                    pxBannerLocation(targetData,pxtargetData,1);

                } else {
                    $.sticky("已是最后了~", {autoclose: 2000, position: "top-right", type: "st-success"});
                }

                break;
        }

    }

    //进行上下移动调用的接口
    //参数：2个
    //target:点击的二级类目    pxtarget:被移动下来的二级类目
    //二者对象需要属性：id weight
    function pxBannerLocation(target,pxtarget,flag){
        $.ajax({
            url: '/pageManage/pxBannerLocation',
            data: {
                'targetId':target.id,
                'targetWeight':target.weight,
                'hwtargetId':pxtarget.id,
                'hwtargetWeight':pxtarget.weight
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
                console.log(data);
                //可选返回对象：
                //1.true   2.map对象的2个二级类目的对象
                if(!flag) {
                    //上移操作
                    target.dom.insertBefore(pxtarget.dom);
//                    $('#twolevel_'+target.id).insertBefore($('#twolevel_'+pxtarget.id));
                    $('#twolevel_'+target.id).attr("weight",pxtarget.weight);
                    $('#twolevel_'+pxtarget.id).attr("weight",target.weight);
                    $.sticky("操作成功~", {autoclose: 2000, position: "top-right", type: "st-success"});
                    return true;
                }
                if(flag) {
                    //下移操作
                    target.dom.insertAfter(pxtarget.dom);
//                    $('div[targetid="'+target.id+'"]').insertAfter($('div[targetid="'+pxtarget.id+'"]'));
                    $('#twolevel_'+target.id).attr("weight",pxtarget.weight);
                    $('#twolevel_'+pxtarget.id).attr("weight",target.weight);
                    $.sticky("操作成功~", {autoclose: 2000, position: "top-right", type: "st-success"});
                }

            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }



    //进行对一级类目修改名称:调用2个接口
    //根据一级类目id获取一级类目的内容
    function getOneLevelById(id){
        $.ajax({
            url: '/pageManage/getOneLevelById',
            data: {
                'id':id
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
                //一级类目的对象

            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }
    //根据一级类目的id与名称来进行修改一级类目的值
    //Obj对象具有的属性有：id name
    function modifyOneLevelCotent(obj){
        $.ajax({
            url: '/pageManage/modifyOneLevelCotent',
            data: {
                'id':obj.id,
                'name':obj.name
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
                //返回的值为true:则说明修改成功
                $("#changeNameAreaCancel").click();
                $("#changeNameArea").val("");
                $($("#onelevel_"+obj.id).find(".text-label")).html(obj.name);

            },
            error: function (data) {
                $.sticky("操作失败", {autoclose: 2000, position: "top-right", type: "st-error"});
            }
        });
    }




</script>

</body>

</html>