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
                    <div class="header-box form-inline" style="overflow: hidden;">
                        <div class="col-md-6 form-group">
                            <div class="col-md-2">
                                <h4>维度：</h4>
                            </div>
                            <div class="col-md-5">
                                <label class="radio-inline">
                                    <input id="total" type="radio" name="boss" value="">
                                    总 </label>
                                <label class="radio-inline">
                                    <input type="radio" name="boss" id="person" value="">
                                    个 </label>
                            </div>
                        </div>
                    </div>
                </section>
                %{--年月--}%
                <section id="" class="content-header content-header1">
                    <div class="header-box form-inline" style="overflow: hidden;">
                        <div class="col-md-12 form-group">
                            <div class="col-md-1">
                                <h4>年：</h4>
                            </div>
                            <div class="col-md-5">
                                <div class="col-md-6">
                                    <label class="control-label">年：</label>
                                    <select name="" class="form-control" id="yy" style="min-width: 165px;">
                                        <option value="0">年份</option>
                                        <option value="2016">2016</option>
                                        <option value="2015">2015</option>
                                        <option value="2014">2014</option>
                                        <option value="2015">2013</option>
                                        <option value="2014">2012</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="control-label">月：</label>
                                    <select name="" class="form-control" id="mm" style="min-width: 165px;">
                                        <option value="0">月份</option>
                                        <option value="01">01</option>
                                        <option value="02">02</option>
                                        <option value="03">03</option>
                                        <option value="04">04</option>
                                        <option value="05">05</option>
                                        <option value="06">06</option>
                                        <option value="07">07</option>
                                        <option value="08">08</option>
                                        <option value="09">09</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- 类、供应 -->
                <section id="person_twolist" class="content-header content-header1" style="display: none;">
                    <div class="header-box form-inline" style="overflow: hidden;">
                        <div class="col-md-12 form-group">
                            <div class="col-md-1">
                                <h4>维度：</h4>
                            </div>
                            <div class="col-md-5">
                                <div class="col-md-6">
                                    <label class="control-label">类：</label>
                                    <select name="" class="form-control" id="" style="min-width: 165px;">
                                        <option value="1">1</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="control-label">供应：</label>
                                    <select name="" class="form-control" id="" style="min-width: 165px;">
                                        <option value="1">1</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- 条件总的 -->
                <section id="total_conditions" class="content-header content-header1" style="display: none;">
                    <div class="header-box form-inline" style="overflow: hidden;">
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
                            <button id="count_btn" type="submit" class="btn btn-primary"><i class="fa fa-search"></i>统计</button>
                        </div>
                    </div>
                </section>
                <!-- 条件个人的 -->
                <section id="personal" class="content-header content-header1" style="display: none;">
                    <div class="header-box  form-inline" style="overflow: hidden;">
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
                            <button id="count" type="submit" class="btn btn-primary"><i class="fa fa-search"></i>统计</button>
                        </div>
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
                        <table class="table table-hover table-bordered text-center" style="margin-bottom: 0;">
                            <tbody>
                                <tr>
                                    <td width="20%" id="y_title">月</td>
                                    <td width="40%">出库量</td>
                                    <td width="40%">总量占比</td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-hover table-bordered text-center">
                            <tbody id="b_data">
                            %{--图表数据--}%
                            </tbody>
                        </table>
                    </div>
                </section>
            </div>
            <!-- /.box -->
        </div>
    </div>
</section>



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

<script>
    function icheck(){
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    }
    icheck();

    $(document).on('ifChecked','#total',function(){
        $('#personal').hide();
        $('#total_conditions').show();
        $('#person_twolist').hide();
    }).on('ifChecked','#person',function(){
        $('#personal').show();
        $('#total_conditions').hide();
        $('#person_twolist').show();
    }).on('click','#count',function(){//统计

    })



</script>
%{--<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>--}%
<asset:javascript src="build/dist/echarts.js"/>
<asset:javascript src="build/dist/chart/line.js"/>
<asset:javascript src="build/dist/chart/bar.js"/>
<asset:javascript src="build/dist/chart/pie.js"/>
<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>

//    // 路径配置
//    require.config({
//        paths: {
//            echarts: 'http://echarts.baidu.com/build/dist'
//        }
//    });
//    //使用
//    require(
//            [
//                'echarts',
//                'echarts/chart/pie', // 使用柱状图就加载bar模块，按需加载
//                'echarts/chart/line',
//                'echarts/chart/bar'
//            ],
//            ////创建ECharts图表方法
//            function (ec) {
//                // 基于准备好的dom，初始化echarts图表
//                var myChart = ec.init(document.getElementById('main'));
//                // object_option方法
//                function objectOption(){
//                    option = {
//                        title : {
//                            text: '某站点用户访问来源',
//                            subtext: '纯属虚构',
//                            x:'center'
//                        },
//                        tooltip : {
//                            trigger: 'item',
//                            formatter: "{a} <br/>{b} : {c} ({d}%)"
//                        },
//                        legend: {
//                            orient : 'vertical',
//                            x : 'left',
//                            data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
//                        },
//                        toolbox: {},
//                        calculable : false,//是否启用拖拽重计算特性
//                        series : [
//                            {
//                                name:'访问来源',
//                                type:'pie',
//                                radius : '80%',
//                                center: ['50%', '60%'],
//                                data:[
//                                    {value:335, name:'直接访问'},
//                                    {value:310, name:'邮件营销'},
//                                    {value:234, name:'联盟广告'},
//                                    {value:135, name:'视频广告'},
//                                    {value:1548, name:'搜索引擎'}
//                                ]
//                            }
//                        ]
//                    };
//                    return option;
//                }
//                myChart.setOption(objectOption());
//            }
//    );
//

</script>

<!-- 参考 -->
<script type="text/javascript">

    $(document).on('click','#count_btn',function(){
        if($('#total').is(':checked')){//总的
            var yy=parseInt($('#yy').val());
            var mm=parseInt($('#mm').val());
            if(mm!==0){//年月
                var y_m='日';
                $('#y_title').text('日期（号）');
              data_ym(yy,mm,y_m);
            }else{//年
                var y_m='月';
              $('#y_title').text('月');
              data_y(yy,y_m);
            }

            function data_y(yy,y_m){//年
                var startTime=yy+'-01'+'-01'+' '+'00:00';
                var endTime=(yy+1)+'-01'+'-01'+' '+'00:00';
                var timeinfo=yy;
                var eeeDate=(yy+1)+'-01'+'-01';
                var size='12';
                var flag='Y';
                //ajax
                ajax_call(startTime,endTime,timeinfo,eeeDate,flag,size,y_m);
            }


            function data_ym(yy,mm,y_m){//年月
                if(mm<=9){
                    var startTime=yy+'-'+'0'+mm+'-01'+' '+'00:00';
                }else{
                    var startTime=yy+'-'+mm+'-01'+' '+'00:00';
                }
                if(mm==12){
                    var endTime=(yy+1)+'-'+'01'+'-01'+' '+'00:00';
                }else if(mm<9){
                        var endTime=(yy)+'-'+'0'+(mm+1)+'-01'+' '+'00:00';
                }else{
                    var endTime=(yy)+'-'+(mm+1)+'-01'+' '+'00:00';
                }
                if(mm<=9){
                    var timeinfo=yy+'-'+'0'+mm;
                }else{
                    var timeinfo=yy+'-'+mm;
                }
                if(mm==12){
                    var eeeDate=(yy+1)+'-'+'01'+'-01';
                }else{
                    if(mm<9){
                        var eeeDate=yy+'-'+'0'+(mm+1)+'-01';
                    }else{
                        var eeeDate=yy+'-'+(mm+1)+'-01';
                    }

                }
                //构造一个日期对象：
                var  day = new Date(yy,mm,0);
                //获取天数：
                var daycount = day.getDate();//共天数
                var size=daycount;
                var flag='M';
                //ajax
                ajax_call(startTime,endTime,timeinfo,eeeDate,flag,size,y_m);

            }

        }else{//个人的

        }
    });

    function ajax_call(startTime,endTime,timeinfo,eeeDate,flag,size,y_m){
        $.ajax({
            url: '/mikuPOperating/getckNumByParams',
            data: {'startTime':startTime,'endTime':endTime,'timeinfo':timeinfo,'eeeDate':eeeDate,'flag':flag,'size':size},
            type: "POST",
            dataType: "json",
            success: function (data) {
                console.log(data);
                init(data,y_m);
            },
            error: function (data) {
            }
        });
    }


    $(function(){//自加载

    //加载数据
//        $.ajax({
//            url: '/mikuPOperating/getckNumByParams',
//            data: {},
//            type: "POST",
//            dataType: "json",
//            success: function (data) {
//                console.log(data);
//                init(data);
//            },
//            error: function (data) {
//            }
//        });

    });

    //构建图形
    function init(data,y_m){
        // 路径配置
        require.config({
            paths: {
                'echarts': '../assets/plugins/build/dist'
            }
        });
        require(
                [
                    'echarts',
                    'echarts/theme/macarons',
                    'echarts/chart/bar', // 使用柱状图就加载bar模块，按需加载
                    'echarts/chart/line',
                    'echarts/chart/pie'
                ],
                function (ec) {
                    var myNewChart = ec.init(document.getElementById('main'));
                    //初始化各一级类目所有的数据
//                    var data=JSON.parse($("#datasource").html());
                    var sum=0;
//                    var zcnum=0;
//                    var sjnum=0;

                    var titleArr=['商品数量'],idArr=[],numArr=[],title='出库量';
                    $.each(data,function(index,content){
                        idArr.push(content.id+y_m);//拿key，x轴类型
                        numArr.push(content.num);//拿value，y数值
                        sum+=content.num;//总量
//                        zcnum+=content.zcnum//图表用
//                        sjnum+=content.sjnum
                    });
                    //进行表单的构建
                    dobeTableContent(data,sum);
                    myNewChart.setOption(dobeoneOption(idArr,numArr,title));
                }
        );
    }


    //生成一个option对象
    function dobeoneOption(idArr,numArr,title){
        var option = {
            tooltip : {
                trigger: 'item',
            },
            toolbox: {
                show: true,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    magicType : {show: true, type: ['line', 'bar']},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            legend: {
                data:['出库量']
            },
            xAxis : [
                {
                    type : 'category',
                    data : idArr//构建x轴类型
                },
                {//折线图x轴
                    type : 'category',
                    axisLine: {show:false},
                    axisTick: {show:false},
                    axisLabel: {show:false},
                    splitArea: {show:false},
                    splitLine: {show:false},
                    data : idArr
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    axisLabel:{formatter:'{value}'} //折线图y轴
                }
            ],
            series : [
                {
                    "name":title,
                    "type":"bar",
                    "smooth":true,
                    "data":numArr //数据
                },
            ],
        };
        return option;
    }

    //生成一个table的tr的内容
    function dobeTableContent(data,sum){
        $('#b_data').empty();
        var htmlStr="";
        $.each(data,function(index,content){
            if(content.num==0){
                htmlStr+="";
            }else{
                htmlStr+="<tr>";
                htmlStr+="<td width='20%'>"+content.id+"</td>";
                htmlStr+="<td width='40%'>"+content.num+"</td>";
                htmlStr+="<td width='40%'>"+Math.round(content.num/sum*100)+"%"+"</td>";
                htmlStr+="</tr>";
            }
        });
        $("#b_data").append(htmlStr);
    }


</script>
</body>

</html>
