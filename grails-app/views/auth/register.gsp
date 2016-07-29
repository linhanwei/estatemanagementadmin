<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link rel="shortcut icon" href="http://unesmall.b0.upaiyun.com/1/LTE=/SVRFTS1QVUJMSVNI/MA==/20151118/vNTT-0-1447848511424.png">
    <!-- bootstrap 3.0.2 -->
    <asset:stylesheet src="bootstrap.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body class="register-page">
<div class="register-box">
    <div class="register-logo">
        <img src="http://unesmall.b0.upaiyun.com/1/LTE=/SVRFTS1QVUJMSVNI/MA==/20151118/vNTT-0-1447848511424.png" width="44px" height="44px"/>
        <a href="#">米酷商城</a>
    </div>

    <div class="register-box-body">

        <p class="login-box-msg">用户注册</p>
        <g:form action="doRegister" method="post" useToken="true">
            <g:if test="${flash.message}">
                <p class="text-danger">${flash.message}</p>
            </g:if>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="用户名" name="name"/>
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="手机号" name="phone"/>
                <span class="glyphicon glyphicon-phone form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="输入密码" name="password"/>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="再次输入密码" name="password2"/>
                <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
            </div>
            <div class="form-group">
                <g:select optionKey="id" optionValue="name" name="communityId" value="${params.communityId}"
                          class="form-control" from="${communities}" noSelection="['': '选择站点']"/>
            </div>

            <div class="row">
                <div class="col-xs-8">
                    <a href="login" class="text-center">已有账号</a>
                </div><!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">注册</button>
                </div><!-- /.col -->
            </div>
        </g:form>

    </div><!-- /.form-box -->
</div><!-- /.register-box -->

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- iCheck -->
<<asset:javascript src="iCheck/icheck.min.js"/>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>
</body>
</html>