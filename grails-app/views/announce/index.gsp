<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 8/9/14
  Time: 18:17
--%>

<%@ page import="welink.common.Announce" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <title>发布公告</title>
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.min.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.min.css"/>
    <!-- Ionicons -->
    <asset:stylesheet src="ionicons.min.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>

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

</section>

<!-- Main content -->
<section class="content">
    <div class='col-xs-12'>
        <div class="row">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><a href="#announceCreate" data-toggle="tab">发布公告</a></li>
                    <li><a href="#announceList" data-toggle="tab" id="tab-1">公告列表</a></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active" id="announceCreate">
                        <div class="box">
                            <div class="box-header">
                                <div class="box-tools">
                                    <div class="input-group">
                                        <g:formRemote id="'createAnnounce'" name="announce_form"
                                                      onSuccess="announceSubmitSuccess('createAnnounce')"
                                                      onFailure="announceSubmitFailure('createAnnounce')"
                                                      url="[controller: 'announce', action: 'createCommunityAnnounce']">
                                            <div class="col-md-12">

                                                <div class="box box-primary" style="height: 36px;width: 400px">
                                                    <g:textField name="title" class="form-control" placeholder="标题："
                                                                 value="${announce?.title}" id="title"/>
                                                </div><!-- /.box -->
                                                <div class="box box-primary" style="height: 300px;width: 800px">

                                                    <!-- 加载编辑器的容器 -->
                                                    <script id="container" class="col-sm-13" name="content"
                                                            type="text/plain"></script>

                                                </div><!-- /.box -->
                                                <input name="addContentHtml" id="addContentHtml" style="display: none"/>
                                                <input name="addContentTxt" id="addContentTxt" style="display: none"/>

                                                <button id="newAnnounce" type="submit" class="btn btn-primary"
                                                        onclick="setContent()">发布公告</button>

                                            </div>
                                        </g:formRemote>
                                    </div>

                                </div>
                            </div><!-- /.box-header -->
                        </div><!-- /.box -->
                    </div>

                    <div class="tab-pane" id="announceList">
                        <div class="box">
                            <div class="box-header">
                                <div class="box-tools">
                                    <div class="input-group">
                                        本小区公告列表:
                                        <input type="text" name="announce_search"
                                               class="form-control input-sm pull-right" style="width: 150px;"
                                               placeholder="部门、编号、姓名"/>

                                        <div class="input-group-btn">
                                            <button class="btn btn-sm btn-default"><i class="fa fa-search">搜索</i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div id="contentannounceList">
                                    <g:render template="announceList"></g:render>
                                </div>
                            </div><!-- /.box-header -->
                        </div><!-- /.box -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- /.content -->


<!-- jQuery 2.1.1 -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<!-- jQuery UI 1.10.3 -->
<asset:javascript src="jquery-ui-1.10.3.min.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.min.js"/>
<!-- AdminLTE App -->
<asset:javascript src="AdminLTE/app.js"/>

<!-- 配置文件 -->
<asset:javascript src="ueditor.config.js"/>
<!-- 编辑器源码文件 -->
<asset:javascript src="ueditor.all.js"/>
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<asset:javascript src="lang/zh-cn/zh-cn.js" charset="utf-8"/>
<!-- web uploader -->
<asset:javascript src="/third-party/webuploader/webuploader.js"/>
<!-- 实例化编辑器 -->
<script type="text/javascript">
    window.UEDITOR_CONFIG.serverUrl = "${g.createLink(controller: 'itemPublish', action: 'handle')}";
    var ue = UE.getEditor('container', {
        toolbars: [
            [
                'fontsize', //字号
                'paragraph', //段落格式
                'undo', //撤销
                'redo', //重做
                'bold', //加粗
                'indent', //首行缩进
                'italic', //斜体
                'underline', //下划线
                'strikethrough', //删除线
                'fontborder', //字符边框
                'justifyleft', //居左对齐
                'justifyright', //居右对齐
                'justifycenter', //居中对齐
                'justifyjustify', //两端对齐
                'forecolor', //字体颜色
                'backcolor', //背景色
                'insertorderedlist', //有序列表
                'insertunorderedlist' //无序列表
            ]
        ],
        autoHeightEnabled: true,
        autoFloatEnabled: false,
        elementPathEnabled: false,
        enableAutoSave: false,
        initialFrameWidth: 800,
        initialFrameHeight: 250
    });

    function setContent() {

        var html = ue.getContent()
        var txt = ue.getContentTxt()
        $("#addContentHtml").val(html.toString())
        $("#addContentTxt").val(txt.toString())

    }

</script>


<script>
    $(document).ready(function () {
        $('#tab-1').click(function () {
            <g:remoteFunction action="queryCommunityAnnounce" options="'[asynchronous: false]'"  update="contentannounceList"/>
        });
        $('#myTab a[href="#announceCreate"]').click(function () {
            $("#title").val("");
            $("#content").val("");
            $(this).tab('show');
        });
    });
    //this will hold currently focused tab
    var currentTab;
    var composeCount = 0;
    //initilize tabs
    $(function () {
        //when ever any tab is clicked this method will be call
        $("#householdTab").on("click", "a", function (e) {
            e.preventDefault();
            $(this).tab('show');
            $currentTab = $(this);
        });
    });

    //shows the tab with passed content div id..paramter tabid indicates the div where the content resides
    function showTab(tabId) {
        $('#myTab a[href="#' + tabId + '"]').tab('show');
    }
    //return current active tab
    function getCurrentTab() {
        return currentTab;
    }
    //this will return element from current tab
    //example : if there are two tabs having  textarea with same id or same class name then when $("#someId") whill return both the text area from both tabs
    //to take care this situation we need get the element from current tab.
    function getElement(selector) {
        var tabContentId = $currentTab.attr("href");
        return $("" + tabContentId).find("" + selector);
    }

    function lookAnnounceInfo(id, title) {
        var tabId = "compose" + composeCount; //this is id on tab content div where the
        composeCount = composeCount + 1; //increment compose count
        $('.nav-tabs').append('<li><a href="#' + tabId + '"><button class="close closeTab" type="button" id="button' + tabId + '">&nbsp;×</button> ' + title + '</a></li>');
        $('.tab-content').append('<div class="tab-pane" id="' + tabId + '"><div id="Content' + tabId + '"></div></div>');
        <g:remoteFunction action="lookAnnounceInfoHTML" options="'[asynchronous: false]'" params="{'announceId':id}" update="Content' + tabId + '"/>
        $(this).tab('show');
        showTab(tabId);
        registerCloseEvent();
    }
    function registerCloseEvent() {
        $(".closeTab").click(function () {
            //there are multiple elements which has .closeTab icon so close the tab whose close icon is clicked
            var tabContentId = $(this).parent().attr("href");
            $(this).parent().parent().remove(); //remove li of tab
            $('#myTab a:last').tab('show'); // Select first tab
            $(tabContentId).remove(); //remove respective tab content

        });
    }
    function announceSubmitSuccess(tabId) {

        <g:remoteFunction action="queryCommunityAnnounce" options="'[asynchronous: false]'"  update="contentannounceList"/>
        $('#tab-1').tab('show');
        $currentTab = $(this);

    }

    function announceSubmitFailure(tabId) {
        <g:remoteFunction action="queryCommunityAnnounce" options="'[asynchronous: false]'"  update="contentannounceList"/>
        $('#tab-1').tab('show');
        $currentTab = $(this);
    }


</script>

</body>
</html>