<%--
  Created by IntelliJ IDEA.
  User: unescc
  Date: 2016/4/15
  Time: 9:14
--%>

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
    <h1> 统计 <small>财务、采购</small> </h1>
</section>
<section class="content" style="padding-top: 0;">
    <div>
        <div id="operation">
            <div class="box box-primary " style="padding-top:10px;">
                <section class="content-header content-header1">
                    <div class="header-box" style="overflow: hidden;">
                        <form action="" class="form-inline ng-pristine ng-valid">
                            <div class="col-md-6 form-group">
                                <div class="col-md-2">
                                    <h4>维度：</h4>
                                </div>
                                <div class="col-md-5">
                                    <label class="radio-inline">
                                        <input type="radio" name="boss" id="" value="">
                                        总 </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="boss" id="" value="option2">
                                        个 </label>
                                </div>
                            </div>
                        </form>
                    </div>
                </section>
                <!-- 类、供应 -->
                <section class="content-header content-header1">
                    <div class="header-box" style="overflow: hidden;">
                        <form action="" class="form-inline ng-pristine ng-valid">
                            <div class="col-md-6 form-group">
                                <div class="col-md-2">
                                    <h4>维度：</h4>
                                </div>
                                <div class="col-md-5">
                                    <label class="radio-inline">
                                        <input type="radio" name="classification" id="">
                                        类 </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="classification" id="">
                                        供应 </label>
                                </div>
                            </div>
                        </form>
                    </div>
                </section>
                <!-- 条件总的 -->
                <section class="content-header content-header1" style="display: none;">
                    <div class="header-box" style="overflow: hidden;">
                        <form action="" class="form-inline ng-pristine ng-valid">
                            <div class="col-md-6 form-group">
                                <div class="col-md-2">
                                    <h4>条件：</h4>
                                </div>
                                <div class="col-md-5">
                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="" value="">
                                        出库 </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="" value="option2">
                                        支出 </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="" value="option3">
                                        利润 </label>
                                </div>
                            </div>
                            <div class="col-md-6 form-group">
                                <label class="control-label" style="">时间：</label>
                                <input id="wlh" type="text" class="form-control" placeholder="时间">
                                <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>统计</button>
                            </div>
                        </form>
                    </div>
                </section>
                <!-- 条件个人的 -->
                <section class="content-header content-header1">
                    <div class="header-box" style="overflow: hidden;">
                        <form action="" class="form-inline ng-pristine ng-valid">
                            <div class="col-md-6 form-group">
                                <div class="col-md-2">
                                    <h4>条件：</h4>
                                </div>
                                <div class="col-md-5">
                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="" value="">
                                        出库 </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="" value="option2">
                                        支出 </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" id="" value="option3">
                                        利润 </label>
                                </div>
                            </div>
                            <div class="col-md-6 form-group">
                                <label class="control-label" style="">时间：</label>
                                <input id="time" type="text" class="form-control" placeholder="时间">
                                <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>统计</button>
                            </div>
                        </form>
                    </div>
                </section>
                <!-- 图形 -->
                <section class="content-header content-header1">
                    <div id="main" style="height:400px;background-color: #EEE;">
                        <!-- 图形 -->
                    </div>
                </section>
                <section class="content-header content-header1">
                    <div class="table-responsive table-over1">
                        <table class="table table-hover table-bordered text-center">
                            <thead>
                            <tr>
                                <th>类目名称</th>
                                <th>类目名称</th>
                                <th>类目名称</th>
                                <th>类目名称</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>222</td>
                                <td>222</td>
                                <td>222</td>
                                <td>222</td>
                            </tr>
                            <tr>
                                <td>222</td>
                                <td>222</td>
                                <td>222</td>
                                <td>222</td>
                            </tr>
                            <tr>
                                <td>222</td>
                                <td>222</td>
                                <td>222</td>
                                <td>222</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </section>
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>
</body>
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



<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

%{--echarts--}%
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript">
    %{--ickeck--}%
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    // 路径配置
    require.config({
        paths: {
            echarts: 'http://echarts.baidu.com/build/dist'
        }
    });
    //使用
    require(
            [
                'echarts',
                'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main'));
                // object_option方法
                function objectOption(){
                    option = {
                        title : {
                            text: '某站点用户访问来源',
                            subtext: '纯属虚构',
                            x:'center'
                        },
                        tooltip : {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        legend: {
                            orient : 'vertical',
                            x : 'left',
                            data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
                        },
                        toolbox: {},
                        calculable : false,//是否启用拖拽重计算特性
                        series : [
                            {
                                name:'访问来源',
                                type:'pie',
                                radius : '80%',
                                center: ['50%', '60%'],
                                data:[
                                    {value:335, name:'直接访问'},
                                    {value:310, name:'邮件营销'},
                                    {value:234, name:'联盟广告'},
                                    {value:135, name:'视频广告'},
                                    {value:1548, name:'搜索引擎'}
                                ]
                            }
                        ]
                    };
                    return option;
                }
                myChart.setOption(objectOption());
            }
    );
</script>
</html>