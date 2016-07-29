<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 7/10/14
  Time: 11:03
--%>

<html>
<head>
    <title>ajax file upload upyun For Jquery</title>
</head>

<body>
<div id="wrapper">
    <div id="content">
        <h1>又拍云ajax上传插件</h1>

        <p>
            <a href="https://gitcafe.com/xujif/jquery-ajaxupload-for-UPYUN">项目主页</a>
        </p>

        <p>
        <h4>使用方法：</h4>
        <pre>
            $.upload2upyun({
            bucket:"your bucket",
            fileSelector:'#uploadFile',
            policy:policy,
            signature:signature,
            success:function(url,time,sign){
            console.log(arguments)
            },
            error:function(code,msg){
            alert(msg);
            }
            })
        </pre>
    </p>

        <h2>下面是demo</h2>
        <asset:image src="loading.gif" style="display: none"/>

        <form id="form" name="form" action="" method="POST"
              enctype="multipart/form-data">
            <input id='uploadFile' type="file" name="file"/> <input
                type="button" value="提交" onclick="return upload()"/>
        </form>

        <div id="result" style="display:none">
            <p>time:<span id="time"></span></p>

            <p>sign:<span id="sign"></span></p>

            <p>url:<a id="url" target="_blank"></a></p>
        </div>
    </div>
</div>
<!-- jQuery 2.1.1 -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<asset:javascript src="plugins/file-upload/upload-upyun.js"/>
<script type="text/javascript">
    var policy = "${policy}"
    var signature = "${signature}"
    var bucket = "${bucket}";
    function upload() {

        $(document).ajaxStart(function () {
            $("#loading").show();
        });
        $(document).ajaxComplete(function () {
            $("#loading").hide();
        });


        $.upload2upyun({
            bucket: bucket,
            fileSelector: '#uploadFile',
            policy: policy,
            signature: signature,
            success: function (url, time, sign) {
                console.log(arguments);
                $('#time').text(time);
                $('#sign').text(sign);
                var fullUrl = "http://" + bucket + ".b0.upaiyun.com" + url;
                $('#url').attr('href', fullUrl).text(fullUrl);
                $('#result').show();
            },
            error: function (code, msg) {
                alert(msg);
            }
        })
        return false;
    }
</script>
</body>
</html>