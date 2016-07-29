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
        新添活动
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
                        <label class="col-sm-2 control-label"><i class="fa fa-tag"></i>模块类型<span style="color: red">*</span>:</label>

                        <div class="col-sm-8">
                            <div class="input-group">
                                <g:if test="${MoudleMap != null}">
                                    <g:each in="${MoudleMap}" var="tag" status="i">
                                        <g:if test="${i==0}">
                                            <input type="radio" name="ActiveType" value="${tag.key}" checked>${tag.value}
                                        </g:if>
                                        <g:else>
                                            <input type="radio" name="ActiveType" value="${tag.key}">${tag.value}
                                        </g:else>

                                    </g:each>
                                </g:if>
                            </div>
                        </div>
                    </div>

                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>标题</label>

                        <div class="col-xs-8">
                            <input type="text" name="name" class="form-control"
                                   placeholder="标题" maxlength="10">
                        </div>
                    </div>




                    <div class="list-group-item form-group datetimeDiv">
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

                    %{--<div class="list-group-item form-group">--}%
                        %{--<label class="col-sm-2 control-label"><i class="fa fa-mail-reply"></i>跳转类型:</label>--}%

                        %{--<div class="col-sm-8">--}%
                            %{--<div class="input-group">--}%
                                %{--<g:if test="${redirectTypeMap != null}">--}%
                                    %{--<g:each in="${redirectTypeMap}" var="tag" status="i">--}%
                                        %{--<input type="radio" name="type" value="${tag.key}">${tag.value}--}%
                                    %{--</g:each>--}%
                                %{--</g:if>--}%
                            %{--</div>--}%
                        %{--</div>--}%
                    %{--</div>--}%

                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-chain"></i>内容:</label>

                        <div class="col-xs-8">
                            <input type="text" name="content" class="form-control" id="ImpcontentFlag"
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
                    </div>





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
        html+="<label class='col-xs-2 control-label'>满:</label>";
        html+="<div class='col-xs-2'>";
        html+="<input type='text'  class='form-control' placeholder='最小值' name='hdmin'></div>";
        html+="<label class='col-xs-2 control-label'>减:</label><div class='col-xs-2'>";
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
                var min=parseFloat(targetModel.find("input[name=hdmin]").val());
                var value=parseFloat(targetModel.find("input[name=hdkjfee]").val());
                if(min　&&　value){
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
//        for(var j=0;j<oneJson.length-1;j++){
//            str+=(oneJson[j]['min']+"-->"+oneJson[j]['max']);
//            str+="  ";
//            if(j==(oneJson.length-2)){
//                str+=(oneJson[j+1]['min']+"-->"+oneJson[j+1]['max']);
//                str+="  ";
//            }
//            if(oneJson[j]['max']>oneJson[j+1]['min'] || oneJson[j]['max']<oneJson[j]['min']  || oneJson[j+1]['max']<oneJson[j+1]['min']){
//                //说明区间重复，需要进行修改
//                bl=false;
//            }
//        }

        debugger;
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
        $(".s425").hide();
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
