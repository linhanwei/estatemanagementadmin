<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>米酷后台</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link rel="shortcut icon" href="http://unesmall.b0.upaiyun.com/1/LTE=/SVRFTS1QVUJMSVNI/MA==/20151118/vNTT-0-1447848511424.png">
    %{--<link rel="shortcut icon" src="icon.png">--}%
    <!-- bootstrap 3.3.1 -->
    <asset:stylesheet src="bootstrap.css"/>
    <!-- font Awesome -->
    <asset:stylesheet src="font-awesome.css"/>
    <!-- Theme style -->
    <asset:stylesheet src="AdminLTE.css"/>
    <!-- iCheck -->
    <asset:stylesheet src="iCheck/square/blue.css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <style>
    .myred{color:red}
    </style>
</head>

<body class="login-page">



<div class="login-box">

    <div class="login-logo">
        %{--<img src="http://unesmall.b0.upaiyun.com/1/LTE=/SVRFTS1QVUJMSVNI/MA==/20151118/vNTT-0-1447848511424.png" width="44px" height="44px"/>--}%
        %{--<asset:image src="icon.png" width="44px" height="44px"/>--}%
        <a href="#"><b>MIKU MINE</b></a>
    </div><!-- /.login-logo -->

    <div class="login-box-body">
        <p class="login-box-msg">登录</p>
        <g:form controller="auth" action="signIn" method="post" useToken="true">
            %{--对cookie的记录--}%
            <g:if test="${cookie(name: "mksc_User")}">
                <div class="form-group has-feedback">
                    %{--<input type="text" name="username" class="form-control" placeholder="用户名" id="username" value="root"/>--}%
                    <input type="text" name="username" class="form-control" placeholder="用户名" id="username" value="${cookie(name: "mksc_User").split("==")[0]}"/>
                    <span class="glyphicon glyphicon-user form-control-feedback"></span>
                </div>

                <div class="form-group has-feedback">
                    %{--<input type="password" name="password" class="form-control" placeholder="密码" id="password" value="wuchao080938"/>--}%
                    <input type="password" name="password" class="form-control" placeholder="密码" id="password" value="${cookie(name: "mksc_User").split("==")[1]}"/>
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
            </g:if>
            <g:else>
                <div class="form-group has-feedback">
                    %{--<input type="text" name="username" class="form-control" placeholder="用户名" id="username" value="root"/>--}%

                    <input type="text" name="username" class="form-control" placeholder="用户名" id="username" value=""/>
                    <span class="glyphicon glyphicon-user form-control-feedback"></span>
                </div>

                <div class="form-group has-feedback">
                    %{--<input type="password" name="password" class="form-control" placeholder="密码" id="password" value="wuchao080938"/>--}%
                    <input type="password" name="password" class="form-control" placeholder="密码" id="password" value=""/>
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
            </g:else>
            <span id="messageInfo"></span>
            <g:if test="${flash.message}">
                <div class="message myred">${flash.message}</div>
            </g:if>
            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <g:if test="${cookie(name: "mksc_User")}">
                                <input type="checkbox" name="rememberMe" checked>记住密码
                            </g:if>
                            <g:else>
                                <input type="checkbox" name="rememberMe" >记住密码
                            </g:else>
                        </label>
                    </div>
                </div><!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat" id="mysubmit">登录</button>
                </div><!-- /.col -->
            </div>
        </g:form>
        <div class="row">
            <div class="col-xs-8">
                %{--<a href="#">忘记密码?</a><br>--}%
            </div><!-- /.col -->
            <div class="col-xs-4">
                <g:link action="register" class="text-center pull-right">注册</g:link>
            </div><!-- /.col -->
        </div>

    </div>

    <!-- Jquery -->
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="userDo.js"/>
    <!-- Bootstrap -->
    <asset:javascript src="bootstrap.js"/>
    <!-- iCheck -->
    <asset:javascript src="iCheck/icheck.min.js" type="text/javascript"/>
    <script>
        $(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
            });


            //进行在登录的时候进行简单的校验
           var mysubmit= $('#mysubmit'), password= $('#password'), messageInfo= $('#messageInfo'),username=$('#username');
            mysubmit.click(function () {
                if(!(password.val().trim() && username.val().trim()))
                {
                    messageInfo.text('用户名与密码不能为空').css('color','red');
                    return false;
                }
            });
        });
    </script>
</body>
</html>
