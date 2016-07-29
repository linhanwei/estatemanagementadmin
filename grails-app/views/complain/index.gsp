<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <title>投诉建议</title>
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

    <!-- sticky -->
    <asset:stylesheet src="sticky/sticky.css"/>


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

</head>


<!-- Content Header (Page header) -->
<section class="content-header"></section>

<!-- Main content -->
<section class="content">
    <div class='col-xs-12'>
        <div class="row">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><a href="#waitToDeal" data-toggle="tab">待处理</a></li>
                    <li><a href="#ComplaininHand" data-toggle="tab">处理中</a></li>
                    <li><a href="#finishedComplain" data-toggle="tab">已完结</a></li>
                </ul>

                <div class="tab-content">
                    <div class="tab-pane active" id="waitToDeal">

                        <g:render template="waitDeal"/>

                    </div>

                    <div class="tab-pane" id="ComplaininHand">

                        <g:render template="inHandComplain"/>

                    </div>

                    <div class="tab-pane" id="finishedComplain">

                        <g:render template="finishComplain"/>

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

<asset:javascript src="plugins/bootstrapValidator/bootstrapValidator.min.js"/>
<asset:javascript src="plugins/bootstrapValidator/language/zh_CN.js"/>

<asset:javascript src="moment-with-locales.js"/>

<!-- InputMask -->
<asset:javascript src="plugins/input-mask/jquery.inputmask.js"/>

<!-- sticky -->
<asset:javascript src="plugins/sticky/sticky.js"/>

<script>

    function dealSuccessNotify() {

        $.sticky("该投诉已处理", {autoclose: 2000, position: "top-right", type: "st-success"});

    }

    function FinishNotify() {

        $.sticky("该投诉已完结", {autoclose: 2000, position: "top-right", type: "st-success"});

    }


    $(document).ready(function () {
        <g:remoteFunction onComplete="loadSuccess()" action="queryComplainList" options="'[asynchronous: false]'"  update="waitToDeal" />
        <g:remoteFunction onComplete="InHandLoadSuccess()" action="queryInHandComplain" options="'[asynchronous: false]'"  update="ComplaininHand"/>
        <g:remoteFunction onComplete="finishLoadSuccess()" action="queryFinishComplainList" options="'[asynchronous: false]'"  update="finishedComplain"/>

    });

    $('#myTab a[href="#waitToDeal"]').click(function () {
        <g:remoteFunction onComplete="loadSuccess()" action="queryComplainList" options="'[asynchronous: false]'"  update="waitToDeal"/>
    });

    $('#myTab a[href="#ComplaininHand"]').click(function () {
        <g:remoteFunction onComplete="InHandLoadSuccess()" action="queryInHandComplain" options="'[asynchronous: false]'"  update="ComplaininHand"/>
    });

    $('#myTab a[href="#finishedComplain"]').click(function () {
        <g:remoteFunction onComplete="finishLoadSuccess()" action="queryFinishComplainList" options="'[asynchronous: false]'"  update="finishedComplain"/>
    });

    function finishLoadSuccess() {

        $("#finishComplainSearch").click(function () {

            var query = $("#finishComplainSearchText").val()

            <g:remoteFunction onComplete="finishLoadSuccess()" action="queryFinishComplainList" options="'[asynchronous: false]'"  params="{'query':query}" update="finishedComplain" />

        });

    }

    function lookComplainDetail(id) {
        <g:remoteFunction action="dealComplainHtml" params="{'complainId':id}" update="finishedComplainNotes" options="'[asynchronous: false]'"/>
    }

    function loadSuccess() {
        $("#mobile").inputmask();

        $("#mobile").keyup(function () {
            var mobile = $("#mobile").val();

            var lastNum = $(this).val().charAt(12)

            if (!(lastNum == '_')) {

            }
        });

        $("#buildingRoomNumber").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: '<g:createLink controller="building" action="searchByRoomNumber"/>', // remote datasource
                    data: request,
                    type: 'POST',
                    success: function (data) {
                        response(data); // set the response
                    }, error: function (data) { // handle server errors
                        console.log(data)
                    }
                });
            },
            messages: {
                noResults: '',
                results: function () {
                }
            },
            minLength: 1, // triggered only after minimum 2 characters have been entered.
            select: function (event, ui) { // event handler when user selects a company from the list.
                console.log($('#buildingId').val())
                console.log(ui.item.id)
                $('#buildingId').val(ui.item.id); // update the hidden field.
                console.log($('#buildingId').val())
            }
        }).addClass("form-control").removeClass("ui-autocomplete-input");

        // validation
        $('#createComplain_form').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                profileName: {
                    trigger: 'blur',
                    validators: {
                        notEmpty: {
                            message: '请输入投诉人姓名'
                        }

                    }
                },
                complainContent: {
                    trigger: 'blur',
                    validators: {
                        notEmpty: {
                            message: '请输入投诉内容'
                        }

                    }
                },
                complainTitle: {
                    trigger: 'blur',
                    validators: {
                        notEmpty: {
                            message: '选择投诉类型'
                        }

                    }
                },
                buildingRoomNumber: {
                    trigger: 'blur',
                    message: '请选择房号',
                    validators: {
                        notEmpty: {
                            message: '输入搜索，并选取房号'
                        },
                        remote: {
                            url: '<g:createLink controller="building" action="validate"/>',
                            // Send { email: 'its value', username: 'its value' } to the back-end
                            data: function (validator) {
                                return {
                                    id: $('#buildingId').val(),
                                    term: $('#buildingRoomNumber').val()
                                };
                            },
                            type: 'POST',
                            message: '房号只能够选取，不能够修改'
                        }
                    }
                },
                mobile: {
                    trigger: 'blur',
                    validators: {
                        notEmpty: {
                            message: '请输入业主的手机号码'
                        },
                        regexp: {
                            regexp: /^[0-9-]{13}$/,
                            message: '请输入11位手机号码'
                        }
                    }
                }

            }
        });


        $("#ComplainWaitToDealSearch").click(function () {

            var query = $("#ComplainWaitToDealSearchText").val()

            <g:remoteFunction onComplete="loadSuccess()" action="queryComplainList"  options="'[asynchronous: false]'"  params="{'query':query}" update="waitToDeal" />

        });
    }
    function InHandLoadSuccess() {
        $("#ComplainInHandSearch").click(function () {

            var query = $("#ComplainInHandText").val()

            <g:remoteFunction onComplete="InHandLoadSuccess()" action="queryInHandComplain" options="'[asynchronous: false]'"  params="{'query':query}" update="ComplaininHand" />

        });
    }

    function dealInHand(id) {

        $("#currentComplainInHand").val(id)

        <g:remoteFunction  action="dealComplainHtml" params="{'complainId':id}" update="inHandNotes" options="'[asynchronous: false]'"/>
    }

    function closealldtBox() {

        $("[id=dtBox]").each(function () {

            $(this).parent().parent().remove()
        });

    }
</script>







<script>


    function finishComplain(id) {

        if (!confirm("您确定要完结该投诉吗？")) {
            return;
        }

        <g:remoteFunction onSuccess="FinishNotify()" onComplete="loadSuccess()" action="finishComplain" params="{'complainId':id}" update="waitToDeal" options="'[asynchronous: false]'"/>
    }

    function dealComplaine(id) {
        $("#currentComplain").val(id)
        <g:remoteFunction action="dealComplainHtml" params="{'complainId':id}" update="inHandComplainNotes" options="'[asynchronous: false]'"/>
    }


</script>

<script>
    function finishInHand(id) {

        if (!confirm("您确定要关闭该投诉吗？")) {
            return;
        }

        <g:remoteFunction onSuccess="FinishNotify()" onComplete="InHandLoadSuccess()" action="finishComplainInHand" params="{'complainId':id}"  options="'[asynchronous: false]'" update="ComplaininHand"/>

    }

    function dealInHandSuccess() {

        $('#myModal').modal('hide')

        $('.modal-backdrop').remove()

        <g:remoteFunction onSuccess="dealSuccessNotify()" onComplete="InHandLoadSuccess()" action="queryInHandComplain" options="'[asynchronous: false]'"  update="ComplaininHand"/>

    }

    function dealwaitSuccess() {
        $('#suggestion').modal('hide')

        $('.modal-backdrop').remove()

        <g:remoteFunction onSuccess="dealSuccessNotify()" onComplete="loadSuccess()" action="queryComplainList" options="'[asynchronous: false]'"  update="waitToDeal"/>


    }

</script>




