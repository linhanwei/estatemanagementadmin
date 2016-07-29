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
        新增Banner
        <small>Banner管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Banner管理</a></li>
        <li class="active">新增Banner</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">Banner列表</g:link></li>
                    <li class="active">
                        <g:link action="addBannerHtml">新增Banner</g:link></li>
                    %{--<li><g:link action="list">满减活动</g:link></li>--}%
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
        </div>

        <div class="box-body">
            <g:form name="banner_form" useToken="true" action="addBanner">
                <div class="box-header">
                </div><!-- /.box-header -->
                <div class="box-body no-padding form-horizontal list-group"  id="tragetTable">

                    <div class="list-group-item form-group">
                        <label class="col-sm-2 control-label"><i class="fa fa-tag"></i>模块类型<span style="color: red">*</span>:</label>

                        <div class="col-sm-8">
                            <div class="input-group">
                                <g:if test="${MoudleMap != null}">
                                    <g:each in="${MoudleMap}" var="tag" status="i">
                                        <g:if test="${i==0}">
                                            <input type="radio" name="moduleType" value="${tag.key}" checked>${tag.value}
                                        </g:if>
                                        <g:else>
                                            <input type="radio" name="moduleType" value="${tag.key}">${tag.value}
                                        </g:else>

                                    </g:each>
                                </g:if>
                            </div>
                        </div>
                    </div>


                    <div class="list-group-item form-group lmcontent">
                        <label class="col-xs-2 control-label"><i class="fa fa-list-ul"></i>一级类目<span style="color: red">*</span>:</label>

                        <div class="col-xs-3">
                            <g:select optionKey="id" optionValue="name" name="level1Category"
                                      class="form-control" from="${categoryList}"
                                      noSelection="['': '请选择一级类目']"/>
                        </div>

                        %{--<label class="col-xs-2 control-label"><i class="fa fa-list"></i>类目<span style="color: red">*</span>:</label>--}%

                        %{--<div class="col-xs-3">--}%
                        %{--<select id="category" class="form-control" name="category">--}%
                        %{--<option value="-1">请选择类目...</option>--}%
                        %{--</select>--}%
                        %{--</div>--}%
                    </div>

                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>标题</label>

                        <div class="col-xs-8">
                            <input type="text" name="title" class="form-control"
                                   placeholder="标题">
                        </div>
                    </div>

                    <span id="typefalg" class="hide"></span>
                    <span id="showTextfalg" class="hide"></span>

                    <div class="list-group-item form-group">
                        <label class="col-sm-2 control-label"><i class="fa fa-tag"></i>类型<span style="color: red">*</span>:</label>

                        <div class="col-sm-8">
                            <div class="input-group">
                                <g:if test="${typeMap != null}">
                                    <g:each in="${typeMap}" var="tag" status="i">
                                        <span class="onecontentdiv s${tag.key}">
                                            <input type="radio" name="type" value="${tag.key}">${tag.value}
                                        </span>
                                    </g:each>
                                </g:if>
                            </div>
                        </div>
                    </div>


                    <div class="list-group-item form-group datetimeDiv" style="display: none;">
                        <label class="col-xs-2 control-label"><i class="fa fa-calendar"></i>开始时间</i>
                        </label>

                        <div class="col-xs-3">
                            <input type="text"  value="${params.startTime}"
                                   name="startTime"
                                   class="form-control form_datetime"

                                   readonly/>
                        </div>

                        <label class="col-xs-2 control-label"><i class="fa fa-calendar"></i>结束时间</i>
                        </label>

                        <div class="col-xs-3">
                            <input type="text" value="${params.endTime}"
                                   name="endTime"
                                   class="form-control form_datetime"

                                   readonly/>
                        </div>
                    </div>



                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-picture-o"></i>Banner主图<span style="color: red">*</span>:
                        </label>

                        <div class="col-sm-8">
                            %{--<!--dom结构部分-->--}%
                            <div id="uploader" class="queueList">

                                <!--用来存放item-->

                                <ul id="fileList" class="filelist">

                                </ul>

                                <div id="filePicker">选择图片</div>
                            </div>

                        </div>
                    </div>


                    <div class="list-group-item form-group">
                        <label class="col-xs-5 control-label">
                            <span id="imgInfo"></span>
                        </label>
                    </div>

                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-edit"></i>Banner描述</label>

                        <div class="col-xs-8">
                            <textarea name="description" class="form-control" rows="3"></textarea>
                        </div>
                    </div>

                    <div class="list-group-item form-group wenziShowDiv" style="display: none;">
                        <label class="col-xs-2 control-label"><i class="fa fa-check-square-o"></i>文字是否展示:
                        </label>

                        <div class="col-xs-3">
                            <div class="input-group">
                                <g:checkBox name="ShowText" class="input-sm jstree-checkbox"/>
                            </div>
                        </div>
                    </div>

                    <div class="list-group-item form-group">
                        <label class="col-sm-2 control-label"><i class="fa fa-mail-reply"></i>跳转类型:</label>

                        <div class="col-sm-8">
                            <div class="input-group">
                                <g:if test="${redirectTypeMap != null}">
                                    <g:each in="${redirectTypeMap}" var="tag" status="i">
                                        <input type="radio" name="redirectType" value="${tag.key}">${tag.value}
                                    </g:each>
                                </g:if>
                            </div>
                        </div>
                    </div>


                    %{--<div class="list-group-item form-group">--}%
                        %{--满减商品Id值集合[以;隔开;例如(56;98;63)]--}%
                    %{--</div>--}%

                    <span class="hide" id="typeFlagContent"></span>

                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-chain"></i>跳转URL/ID/搜索关键字:</label>

                        <div class="col-xs-8">
                            <input type="text" name="target" class="form-control" id="ImpcontentFlag"
                                   placeholder="链接/ID/满减商品Id值集合[以;隔开;例如(56;98;63)]">
                        </div>
                    </div>

                    <input type="text" value="" id="activeParameters" name="activeParameters"/>
                    
                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-check-square-o"></i>是否展示
                        </label>

                        <div class="col-xs-3">
                            <div class="input-group">
                                <g:checkBox name="showStatus" class="input-sm jstree-checkbox"/>
                            </div>
                        </div>

                        <label class="col-xs-2 control-label"><i class="fa  fa-sort-numeric-asc"></i>权重:
                        </label>

                        <div class="col-xs-3">
                            <div class="form-group">
                                <button class="btn btn-primary btn-sm" type="button" id="decrease">-</button>
                                <input type="text" placeholder="数量" value="1" id="num" name="weight"
                                       readonly style="width: 30px;text-align: center;">
                                <button class="btn btn-primary btn-sm" type="button" id="insert">+</button>
                            </div>
                        </div>
                    </div>


                    <div class="list-group-item form-group activeDiv" style="display: none;">
                        <div class="col-xs-1">
                            <button class="btn btn-primary btn-sm" type="button"  id="minuteActiveTip">-</button>
                            <button class="btn btn-primary btn-sm" type="button" id="addActiveTip">+</button>
                        </div>
                        <label class="col-xs-2 control-label">商品最小值:</label>
                        <div class="col-xs-1">
                            <input type="text"  class="form-control" placeholder="商品最小值" name="hdmin">
                        </div>
                        <label class="col-xs-2 control-label">商品最大值:</label>

                        <div class="col-xs-1">
                            <input type="text"  class="form-control" placeholder="商品最大值"  name="hdmax">
                        </div>

                        <label class="col-xs-2 control-label">可减金额:</label>

                        <div class="col-xs-1">
                            <input type="text"  class="form-control" placeholder="可减金额"  name="hdkjfee">
                        </div>
                    </div>



                </div>

                <div class="box-footer">
                    <div class="col-xs-offset-2">
                        <button type="submit" class="btn btn-primary" type="submit" id="bnfbTnSubmit">发布</button>
                        <button class="btn btn-default" type="reset">取消</button>
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

    //进行活动参数添加
    $("#addActiveTip").click(function(){
        $('#tragetTable').append(ContentStrToPing());
    });
    $("#minuteActiveTip").click(function(){
        var size=$(".addModel").length;
        if(size>=1){
            $($(".addModel")[size-1]).detach();
        }
    });

    //模板的添加
    //进行字符串的拼接
    function ContentStrToPing(){
        var html="<div class='list-group-item form-group activeDiv addModel'>";
        html+="<div class='col-xs-1'></div>";
        html+="<label class='col-xs-2 control-label'>商品最小值:</label>";
        html+="<div class='col-xs-1'>";
        html+="<input type='text'  class='form-control' placeholder='商品最小值' name='hdmin'></div>";
        html+="<label class='col-xs-2 control-label'>商品最大值:</label><div class='col-xs-1'>";
        html+="<input type='text'  class='form-control' placeholder='商品最大值'  name='hdmax'></div>";
        html+="<label class='col-xs-2 control-label'>可减金额:</label><div class='col-xs-1'>";
        html+="<input type='text'  class='form-control' placeholder='可减金额'  name='hdkjfee'></div></div>";
        return html;
    }


    //进行活动的价位参数组拼的校验
    function checkActiveData(){
        var addpart=$(".addModel");
        var allInfo=$(".activeDiv");
        var arr=[];
            //就是多个活动模块
            for(var i=0;i<allInfo.length;i++){
                var targetModel=$(allInfo[i]);
                var max=parseFloat(targetModel.find("input[name=hdmax]").val());
                var min=parseFloat(targetModel.find("input[name=hdmin]").val());
                var value=parseFloat(targetModel.find("input[name=hdkjfee]").val());
                if(max &&　min　&&　value){
                    var obj={
                        "max":max,
                        "min":min,
                        "value":value
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
        for(var j=0;j<oneJson.length-1;j++){
            str+=(oneJson[j]['min']+"-->"+oneJson[j]['max']);
            str+="  ";
            if(j==(oneJson.length-2)){
                str+=(oneJson[j+1]['min']+"-->"+oneJson[j+1]['max']);
                str+="  ";
            }
            if(oneJson[j]['max']>oneJson[j+1]['min'] || oneJson[j]['max']<oneJson[j]['min']  || oneJson[j+1]['max']<oneJson[j+1]['min']){
                //说明区间重复，需要进行修改
                bl=false;
            }
        }

        Bigstr=str;
        if(bl){
            $("#activeParameters").val(JSON.stringify(oneJson));
        }
        return bl;
    }





    $(function(){
        //首页选择
        $(".lmcontent").hide();
        $(".s419").show();
        $(".s420").hide();
    });



    //进行radio的按钮的全选事件
    $("input[name='moduleType']").on('ifChecked', function(){
        //主页
        var content=$(this).val().trim();
        $('.allcontentdiv').hide();
        $(".s418").show();
        $(".s419").show();
        $(".s420").show();
        $(".s421").show();
        $(".s422").show();
        $(".datetimeDiv").hide();
        $(".activeDiv").hide();
        if(content=="0")
        {
            $(".lmcontent").hide();
//            $(".s419").show();
            $(".s420").hide();
        }
        else if(content=="1" )
        {
            $(".lmcontent").show();
            $(".s419").hide();
            $(".s420").hide();
        }
        else if(content=="2")
        {
            $(".lmcontent").hide();
//            $(".s419").show();
//            $(".s420").show();
        }
        else if(content=="3" || content=="4" || content=="5")
        {
            $(".lmcontent").hide();
            $(".s419").hide();
            $(".s420").hide();
            $(".s421").hide();
            $(".s422").hide();
        }else if( content=="6"){
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


    //进行类目动态变化
    $('#level1Category').change(function () {
        var str = "";
        $("#level1Category option:selected").each(function () {
            $('#category').find('option').remove();
            $('#category').append('<option value="-1">请选择类目...</option>');
            var id = $(this).val()
            if (id != "-1" && id != '' && id != undefined) {
                $.ajax({
                    url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId"/>', // remote datasource
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



    //类别的选取
    $("input[name='type']").on('ifChecked',function(){
        var content=$(this).val().trim();
        var target=$("#imgInfo");
        var showtextFalg=$("#showTextfalg").html();
        if(content)
        {
            if(content=="418"){
                getSizeStr(target,"顶部活动位",750,300);
                $(".datetimeDiv").hide();
                $(".wenziShowDiv").hide();
                $("#typefalg").html("418");
            }
            else if(content=="419"){
                getSizeStr(target,"类目入口",94,94);
                $(".datetimeDiv").hide();
                $(".wenziShowDiv").hide();
                $("#typefalg").html("419");
            }
            else if(content=="420"){
                getSizeStr(target,"品牌入口",164,164);
                $(".datetimeDiv").hide();
                $(".wenziShowDiv").hide();
                $("#typefalg").html("420");
            }
            else if(content=="421"){
                if(showtextFalg=="1"){
                    getSizeStr(target,"活动专区",730,314);
                }else{
                    getSizeStr(target,"活动专区",730,386);
                }
                $(".datetimeDiv").show();
                $(".wenziShowDiv").show();
                $("#typefalg").html("421");
            }
            else if(content=="422"){
                if(showtextFalg=="1"){
                    getSizeStr(target,"秒杀专区",730,314);
                }else{
                    getSizeStr(target,"秒杀专区",730,386);
                }
                $(".datetimeDiv").show();
                $(".wenziShowDiv").show();
                $("#typefalg").html("422");
            }
        } else{
            target.html();
            $("#typefalg").html("");
        }
    });

    //跳转类型的限制
    $("input[name='redirectType']").on('ifChecked',function(){
        var content=$(this).val().trim();
        var target=$("#typeFlagContent");
        if(content)
        {
            if(content=="311" || content=="312" || content=="313" || content=="316" || content=="319"){
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
        var target=$("#typeFlagContent").html();
        var ImpcontentFlag=$("#ImpcontentFlag").val();
        if(target){
            if(target.trim()=="num")
            {
                if(ImpcontentFlag && !isNaN(ImpcontentFlag)){
                }else{
                    alert("请填入对应相应商品数字类型的ID")
                    return false;
                }
            }
            else if(target.trim()=="url")
            {
//                if(!IsURL(ImpcontentFlag))
                if(!(ImpcontentFlag.indexOf("http://")==0))
                {
                    alert("请填入对应相应类型的url(http://开头)")
                    return false;
                }
            }
        }


        //进行满减操作校验



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
