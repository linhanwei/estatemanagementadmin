<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
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
    <!-- Bootstrap time Picker -->
    <asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
    <!-- web uploader -->
    <asset:stylesheet src="third-party/webuploader/webuploader.css"/>
    <asset:stylesheet src="third-party/webuploader/style.css"/>
    <asset:stylesheet src="third-party/webuploader/style2.css"/>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
      活动编辑
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li><g:link action="list">满减活动</g:link></li>
                    <li  class="active"><g:link action="addBannerHtml">新增活动</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
        </div>

        <div class="box-body">
            <g:form name="banner_form" useToken="true" action="doEditOneActive" controller="mikuActiveTopic">
                <div class="box-header">
                </div><!-- /.box-header -->
                <div class="box-body no-padding form-horizontal list-group"  id="tragetTable">


                    <div class="list-group-item form-group">
                        <label class="col-sm-2 control-label"><i class="fa fa-tag"></i>模块类型:</label>

                        <div class="col-sm-8">
                            <div class="input-group">
                                <g:if test="${MoudleMap != null}">
                                    <g:each in="${MoudleMap}" var="tag" status="i">
                                        %{--${banner.ActiveType==tag.key}--}%
                                        %{--${banner.ActiveType}--}%
                                        %{--${tag.key}--}%
                                        <g:if test="${banner.ActiveType==tag.key}">
                                            <input type="radio" name="ActiveType" value="${tag.key}" checked>${tag.value}
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                        </g:if>
                                        <g:else>
                                            <input type="radio" name="ActiveType" value="${tag.key}">${tag.value}
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                        </g:else>
                                    </g:each>
                                </g:if>
                            </div>
                        </div>
                    </div>

                    <input type="text" name="id" value="${banner.id}" style="display: none"/>



                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>标题</label>

                        <div class="col-xs-8">
                            <input type="text" name="name" class="form-control" value="${banner.name}"
                                   placeholder="标题" maxlength="10">
                        </div>
                    </div>


                    <div class="list-group-item form-group datetimeDiv">
                        <label class="col-xs-2 control-label"><i class="fa fa-calendar"></i>开始时间</i>
                        </label>

                        <div class="col-xs-3">
                            <g:if test="${banner.startTime}">
                                <input type="text"  value="${new DateTime(banner.startTime).toString("yyyy-MM-dd HH:mm")}"
                                       name="startTime"
                                       class="form-control form_datetime"
                                       readonly/>
                            </g:if>
                            <g:else>
                                <input type="text"
                                       name="startTime"
                                       class="form-control form_datetime"
                                       readonly/>
                            </g:else>

                        </div>

                        <label class="col-xs-2 control-label"><i class="fa fa-calendar"></i>结束时间</i>
                        </label>

                        <div class="col-xs-3">

                            <g:if test="${banner.endTime}">
                                <input type="text"  value="${new DateTime(banner.endTime).toString("yyyy-MM-dd HH:mm")}"
                                       name="endTime"
                                       class="form-control form_datetime"
                                       readonly/>
                            </g:if>
                            <g:else>
                                <input type="text"
                                       name="endTime"
                                       class="form-control form_datetime"
                                       readonly/>
                            </g:else>
                        </div>
                    </div>


                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-picture-o"></i>Banner主图
                        </label>

                        <div class="col-sm-8">
                            %{--<!--dom结构部分-->--}%
                            <div id="uploader" class="queueList">

                                <!--用来存放item-->
                                <ul id="fileList" class="filelist">
                                    <g:if test="${banner.picUrls}">
                                        <li id="WU_FILE_991" class="state-complete">
                                            <p class="title"></p>
                                            <p class="imgWrap">
                                                <img src="${banner.picUrls}">
                                                <input name="item-pic" value="${banner.picUrls}" style="display: none">
                                            </p>

                                            <div class="file-panel">
                                                <span class="cancel">删除</span>
                                                <span class="rotateLeft">向左移动</span>
                                                <span class="rotateRight">向右移动</span>
                                            </div>
                                            <span class="success"/>
                                        </li>
                                    </g:if>
                                </ul>

                                <div id="filePicker">选择图片</div>
                            </div>

                        </div>
                    </div>
                    %{--<div class="list-group-item form-group">--}%
                        %{--<label class="col-sm-2 control-label"><i class="fa fa-mail-reply"></i>跳转类型:</label>--}%

                        %{--<div class="col-sm-8">--}%
                            %{--<div class="input-group">--}%
                                %{--<g:if test="${redirectTypeMap != null}">--}%
                                    %{--<g:each in="${redirectTypeMap}" var="tag" status="i">--}%
                                        %{--<g:if test="${banner.type==tag.key}">--}%
                                            %{--<input type="radio" name="redirectType" value="${tag.key}" checked>${tag.value}--}%
                                        %{--</g:if>--}%
                                        %{--<g:else>--}%
                                            %{--<input type="radio" name="redirectType" value="${tag.key}">${tag.value}--}%
                                        %{--</g:else>--}%
                                    %{--</g:each>--}%
                                %{--</g:if>--}%
                            %{--</div>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-chain"></i>内容:</label>

                        <div class="col-xs-8">
                            <input type="text" name="content" class="form-control" value="${banner.content}" id="ImpcontentFlag"
                                   placeholder="链接/ID/满减商品Id值集合[以;隔开;例如(56;98;63)]">
                        </div>
                    </div>
                    <g:if test="${banner.type==311 || banner.type==312 || banner.type==313 || banner.type==316}">
                        <span class="hide" id="typeFlagContent">num</span>
                    </g:if>
                    <g:elseif test="${banner.type==317 || banner.type==321 || banner.type==320}">
                        <span class="hide" id="typeFlagContent">str</span>
                    </g:elseif>
                    <g:else>
                        <span class="hide" id="typeFlagContent">url</span>
                    </g:else>


                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-check-square-o"></i>是否展示
                        </label>

                        <div class="col-xs-3">
                            <div class="input-group">
                                <g:if test="${banner.status==1}">
                                    <g:checkBox name="showStatus" class="input-sm jstree-checkbox" checked="true"/>
                                </g:if>
                                <g:if test="${banner.status==0}">
                                    <g:checkBox name="showStatus" class="input-sm jstree-checkbox"/>
                                </g:if>
                            </div>
                        </div>
                    </div>
                    <input type="text" value="" id="activeParameters" name="activeParameters" class="hide"/>
                    <div class="list-group-item form-group activeDiv">
                        <div class="col-xs-1">
                            <button class="btn btn-primary btn-sm" type="button"  id="minuteActiveTip">-</button>
                            <button class="btn btn-primary btn-sm" type="button" id="addActiveTip">+</button>
                        </div>
                        <label class="col-xs-2 control-label">满:</label>
                        <div class="col-xs-2">
                            <input type="text"  class="form-control" placeholder="最小值" name="hdmin">
                        </div>

                        <label class="col-xs-2 control-label">减:</label>

                        <div class="col-xs-2">
                            <input type="text"  class="form-control" placeholder="可减金额"  name="hdkjfee">
                        </div>
                    </div>



                </div>

                <div class="box-footer">
                    <div class="col-xs-offset-2">
                        <button type="submit" class="btn btn-primary" type="submit" id="bnfbTnSubmit">发布</button>
                    </div>
                </div>
            </g:form>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">

        </div><!-- /.box-footer-->
    </div><!-- /.box -->
</section><!-- /.content -->




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
<<asset:javascript src="iCheck/icheck.min.js"/>
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




    var Bigstr="";

    //进行活动的价位参数组拼的校验
    function checkActiveData(){
        var addpart=$(".addModel");
        var allInfo=$(".activeDiv");
        var arr=[];
        //就是多个活动模块
        for(var i=0;i<allInfo.length;i++){
            var targetModel=$(allInfo[i]);
            var min=parseFloat(targetModel.find("input[name=hdmin]").val());
            var value=parseFloat(targetModel.find("input[name=hdkjfee]").val());
            if(　min　&&　value){
                var obj={
                    "min":min*100,
                    "value":value*100
                };
                arr.push(obj);
            }
        }
        //进行排序
        var oneJson=arr.sort(function(a,b){
            return (a['min'] - b['min']);
        });
        var bl=true;
        var str="";
        Bigstr=str;
        if(bl){
            $("#activeParameters").val(JSON.stringify(oneJson));
        }
        return bl;
    }






    //进行活动参数添加
    $("#addActiveTip").click(function(){
        $('#tragetTable').append(ContentStrToPing(false,""));
    });
    $("#minuteActiveTip").click(function(){
        var size=$(".addModel").length;
        if(size>=1){
            $($(".addModel")[size-1]).detach();
        }
    });

    //模板的添加
    //进行字符串的拼接
    function ContentStrToPing(flag,data){
        var html="";
        if(flag){
            for(var i=1;i<data.length;i++){
                html+="<div class='list-group-item form-group activeDiv addModel'>"
                html+="<div class='col-xs-1'></div>";
                html+="<label class='col-xs-2 control-label'>满:</label>";
                html+="<div class='col-xs-2'>";
                html+="<input type='text'  class='form-control' placeholder='最小值' name='hdmin' value='"+(parseFloat(data[i].min)/100)+"'></div>";
                html+="<label class='col-xs-2 control-label'>减:</label><div class='col-xs-2'>";
                html+="<input type='text'  class='form-control' placeholder='可减金额'  name='hdkjfee' value='"+(parseFloat(data[i].value)/100)+"'></div></div>";
            }
        }else{
            html+="<div class='list-group-item form-group activeDiv addModel'>"
            html+="<div class='col-xs-1'></div>";
            html+="<label class='col-xs-2 control-label'>满:</label>";
            html+="<div class='col-xs-2'>";
            html+="<input type='text'  class='form-control' placeholder='最小值' name='hdmin'></div>";
            html+="<label class='col-xs-2 control-label'>减:</label><div class='col-xs-2'>";
            html+="<input type='text'  class='form-control' placeholder='可减金额'  name='hdkjfee'></div></div>";
        }
        return html;
    }









    $(function(){
        var flg=$("#moduleFlag").html();
        if( flg=="6"){
            $(".lmcontent").hide();
            $(".s419").hide();
            $(".s420").hide();
            $(".s421").hide();
            $(".s422").hide();
            $(".s423").hide();
            $(".s424").hide();
            $(".s425").show();
            $(".datetimeDiv").show();
            $(".activeDiv").show();
        }

        <g:if test="${banner}">
        <g:if test="${banner.parameter}" >
            var newData=${banner.parameter};
            if(newData.length>0) {
                $($("input[name=hdmin]")[0]).val((parseFloat(newData[0].min)/100));
                $($("input[name=hdkjfee]")[0]).val(parseFloat(newData[0].value)/100);
                if (newData.length > 1) {
                    $('#tragetTable').append(ContentStrToPing(true, newData));
                }
            }
        </g:if>
        </g:if>
    });





    $("#decrease").click(function () {
        var now = $("#num").val();
        now = now * 1 - 1
        if (now > 0) {
            $("#num").val(now);
        }
    });
    $("#insert").click(function () {
        var now = $("#num").val();
        now = now * 1 + 1
        if (now > 0) {
            $("#num").val(now);
        }
    });

    $('.dropdown-toggle').dropdown()

    $(".form_datetime")
            .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                $('#acceptTime').val(value)
            });

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });


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

    //当选择文字显示时候
    $("input[name='ShowText']").on('ifChecked',function(){
        $("#showTextfalg").html("1");
        var content=$("#typefalg").html();
        var target=$("#imgInfo");
        if(content=="421")
        {
            getSizeStr(target,"活动专区",730,314);
        }
        else if(content=="422")
        {
            getSizeStr(target,"秒杀专区",730,314);
        }
    });
    $("input[name='ShowText']").on('ifUnchecked',function(){
        $("#showTextfalg").html("0");
    });



    //跳转类型的限制
    $("input[name='redirectType']").on('ifChecked',function(){
        var content=$(this).val().trim();
        var target=$("#typeFlagContent");
        if(content)
        {
            if(content=="311" || content=="312" || content=="313" || content=="316"  || content=="319"){
                writeContent(target,"num");
            }else if(content=="310" || content=="314" || content=="315"){
                writeContent(target,"url");
            }else{
                writeContent(target,"str");
            }
        }
    });

    //进行提交对应banner的数据进行校验
    $("#bnfbTnSubmit").click(function(){
        var flg=checkActiveData();
        if(!flg){
            alert("商品的价格区间有重叠..."+Bigstr);
            return false;
        }
    });






    function getSizeStr(target,title,height,width)
    {
        var str=title+"的图片尺寸建议高为"+height+"像素,宽为"+width+"像素";
        target.html(str).css('color','red');
    }

    function writeContent(target,content)
    {
        target.html(content);
    }


    function IsURL (str_url) {
        var strRegex = '^((https|http|ftp|rtsp|mms)?://)'
                + '?(([0-9a-z_!~*\'().&=+$%-]+: )?[0-9a-z_!~*\'().&=+$%-]+@)?' //ftp的user@
                + '(([0-9]{1,3}.){3}[0-9]{1,3}' // IP形式的URL- 199.194.52.184
                + '|' // 允许IP和DOMAIN（域名）
                + '([0-9a-z_!~*\'()-]+.)*' // 域名- www.
                + '([0-9a-z][0-9a-z-]{0,61})?[0-9a-z].' // 二级域名
                + '[a-z]{2,6})' // first level domain- .com or .museum
                + '(:[0-9]{1,4})?' // 端口- :80
                + '((/?)|' // a slash isn't required if there is no file name
                + '(/[0-9a-z_!~*\'().;?:@&=+$,%#-]+)+/?)$';
        var re=new RegExp(strRegex);
        if (re.test(str_url)) {
            return (true);
        } else {
            return (false);
        }
    }




</script>


</body>

</html>
