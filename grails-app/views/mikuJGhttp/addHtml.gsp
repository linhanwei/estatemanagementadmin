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
        添加推送消息
        <small>APP推送管理</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>APP推送管理</a></li>
        <li class="active">添加推送消息</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="index">APP推送管理</g:link></li>
                    <li class="active">
                        <g:link action="addHtml">添加推送消息</g:link></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
        </div>

        <div class="box-body">
            <g:form name="push_form" useToken="true" action="addSub">
                <div class="box-header">
                </div><!-- /.box-header -->
                <div class="box-body no-padding form-horizontal list-group"  id="tragetTable">

                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-bookmark"></i>推送标题</label>

                        <div class="col-xs-8">
                            <input type="text" name="msgTitle" class="form-control"
                                   placeholder="输入推送标题">
                        </div>
                    </div>

                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label"><i class="fa fa-edit"></i>推送内容</label>

                        <div class="col-xs-8">
                            <textarea name="msgContent" class="form-control" rows="3" placeholder="输入推送内容"></textarea>
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
                        <label class="col-xs-2 control-label"><i class="fa fa-check-square-o"></i>是否发送
                        </label>

                        <div class="col-xs-3">
                            <div class="input-group">
                                <g:checkBox name="isSend" value="1" class="input-sm jstree-checkbox"/>
                            </div>
                        </div>

                    </div>
                    <div class="list-group-item form-group">
                        <label class="col-xs-2 control-label">消息存活时间:</label>
                        <div class="col-xs-1">
                            <select name="offlineLiveTime" class="form-control" id="offlineLiveTime">
                                <option value="1">1天</option>
                                <option value="2">2天</option>
                                <option value="3">3天</option>
                                <option value="4">4天</option>
                                <option value="5" selected>5天</option>
                                <option value="6">6天</option>
                                <option value="7">7天</option>
                                <option value="8">8天</option>
                                <option value="9">9天</option>
                                <option value="10">10天</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="box-footer">
                    <div class="col-xs-offset-2">
                        <button type="submit" class="btn btn-primary" type="submit" id="bnfbTnSubmit">提交</button>
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

    $(function(){

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
