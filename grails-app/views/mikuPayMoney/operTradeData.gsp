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
    <style>
    .mt5{margin-top: 5px;}
    .table_over{
        max-height: 139px;
        overflow-y: scroll;
        overflow-x: hidden;
    }
    #main{height:400px;background-color: #EEE;}
    #main1{height:400px;background-color: #EEE;}
    </style>
</head>
<body>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1> 平台统计信息 <small>平台信息</small> </h1>
</section>
<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs" id="myTab">
                    <li>
                        <g:link action="getRefund" controller="mikuPayMoney">平台退款详情</g:link>
                    </li>
                    <li>
                        <g:link action="getSharePay" controller="mikuPayMoney">平台分润提现支出</g:link>
                    </li>
                    <li>
                        <g:link action="index" controller="mikuPayMoney">平台支出详情</g:link>
                    </li>
                    <li>
                        <g:link action="list" controller="mikuPayMoney">平台统计信息</g:link>
                    </li>
                    <li class="active">
                        <g:link action="operTradeData" controller="mikuPayMoney">统计</g:link>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- Default box -->
    <div class="box">
        <div class="box-body">
            <section id="" class="content-header content-header1">
                <div class="header-box form-inline" style="overflow: hidden;">
                    <div class="col-lg-12 form-group">
                        <label class="control-label">订单数/金额：</label>
                        <select name="" class="form-control" id="order_money" style="min-width: 165px;">
                            <option value="Num">订单数</option>
                            <option value="Fee">金额</option>
                            <option value="Frun">分润</option>
                            <option value="FrunNum">分润总数</option>
                        </select>
                    </div>
                    <div class="col-lg-6 form-group mt5">
                        <label class="control-label">　　 年　份：</label>
                        <select name="" class="form-control" id="yy" style="min-width: 165px;">
                            <option value="2016">2016</option>
                            <option value="2015">2015</option>
                            <option value="2014">2014</option>
                            <option value="2015">2013</option>
                            <option value="2014">2012</option>
                        </select>
                    </div>
                    <div class="col-lg-6 form-group mt5">
                        <label class="control-label">月份：</label>
                        <select name="" class="form-control" id="mm" style="min-width: 165px;">
                            <option value="">月份</option>
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
                        <button id="count_btn" type="submit" class="btn btn-primary"><i class="fa fa-search"></i>统计</button>
                    </div>
                </div>
            </section>
            <!-- 图形 -->
            <section class="content-header content-header1">
                <div id="main1">
                    %{--饼状图--}%
                </div>
                <div id="main">
                    <!-- 柱状、折线 -->
                </div>
            </section>
            %{--表格--}%
            <section class="content-header content-header1">
                <div class="table-responsive table-over1">
                    <div style="padding-right: 17px;">
                        <table class="table table-hover table-bordered text-center" style="margin-bottom: 0;">
                            <tbody>
                            <tr>
                                <td width="20%" id="y_title">年</td>
                                <td width="40%" id="orderormoney">订单数</td>
                                <td width="40%">占比</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="table_over">
                        <table class="table table-hover table-bordered text-center">
                            <tbody id="b_data">

                            %{--图表数据--}%
                            </tbody>

                        </table>
                    </div>
                </div>
            </section>
        </div>
    </div>
    <!-- /.box-body -->
    <!-- /.box -->
</section>
<!-- /.content -->
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
%{--echarts--}%
%{--<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>--}%
<asset:javascript src="build/dist/echarts.js"/>
<asset:javascript src="build/dist/chart/line.js"/>
<asset:javascript src="build/dist/chart/bar.js"/>
<asset:javascript src="build/dist/chart/pie.js"/>
<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>
<script>

    //初始加载
    $(function(){
        var type='Num';
        var typetitle='订单数';
        var yy='2016';
        var  flag='Y';
        var type_ym='年';
        var time=yy;
        var data={
            "flag":flag,
            "type":type,
            "time":time
        }
        ajax_call(data,typetitle,type_ym);
    });
    //    统计
    $(document).on('click','#count_btn',function(){
        var type=$('#order_money').val();
        if(type=='Fee'){
            var typetitle='金额';
        }
        if(type=='Num'){
            var typetitle='订单数';
        }
        if(type=='Frun'){
            var typetitle='分润';
        }
        if(type=='FrunNum'){
            var typetitle='分润总数';
        }
        $('#orderormoney').text(typetitle);
        var yy=$('#yy').val();
        var mm=$('#mm').val();
        var  flag='Y';
        var time=yy;
        if(mm) {
            $('#y_title').text('月');
            var type_ym='月';
            flag = 'M';
            time+=("-"+mm);
        }else{
            $('#y_title').text('年');
            var type_ym='年';
        }
        var data={
                "flag":flag,
                "type":type,
                "time":time
        }
        ajax_call(data,typetitle,type_ym);

    });

    function ajax_call(data,typetitle,type_ym){
        $.ajax({
            url: '/mikuPayMoney/opratingTradeData',
            data: data,
            type: "POST",
            dataType: "json",
            success: function (data) {
                console.log(data);
                init(data,typetitle,type_ym);
            },
            error: function (data) {
            }
        });
    }

    //构建图形
    function init(data,typetitle,type_ym){
        // 路径配置
        require.config({
            paths: {
//                echarts: 'http://echarts.baidu.com/build/dist'
                'echarts': '../assets/plugins/build/dist',
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
                    var myNewChart = ec.init(document.getElementById('main'),'macarons');
                    var myNewChart1 = ec.init(document.getElementById('main1'),'macarons');
                    //初始化各一级类目所有的数据
                    //                    var data=JSON.parse($("#datasource").html());
                    var sum=0;
                    //                    var zcnum=0;
                    //                    var sjnum=0;

                    var titleArr=[],nameArr=[],numArr=[],title=typetitle,conArr=[],num;
                    $.each(data,function(index,content){
                        nameArr.push(content.name);//拿key，x轴类型
                        num=content.num;
                        if(typetitle=='金额'){
                            num=content.num/100;
                        }
                        if(typetitle=='分润'){
                            var num=content.num/100;
                        }
                        conArr.push({"value":num,"name":content.name});
                        numArr.push(num);//拿value，y数值
                        sum+=content.num;//总量
                        //                        zcnum+=content.zcnum//图表用
                        //                        sjnum+=content.sjnum
                    });


                    //进行表单的构建
                    dobeTableContent(data,sum,typetitle);

                    myNewChart.setOption(dobeoneOption(nameArr,numArr,title,typetitle));
                    myNewChart1.setOption(dobeoneOption1(nameArr,typetitle,conArr,type_ym));//饼状图
                    setTimeout(function (){
                        window.onresize = function () {
                            myNewChart.resize();
                            myNewChart1.resize();
                        }
                    },200)
                }
        );
    }

    //生成一个option对象，柱和折线图
    function dobeoneOption(nameArr,numArr,title,typetitle){
        var option = {
            tooltip : {
                trigger: 'item',
            },
            toolbox: {
                show: true,
                feature : {
                    mark : {show: false},
                    dataView : {show: true, readOnly: false},
                    magicType : {
                        show: true,
                        type: ['line', 'bar'],
                        option: {
                            // line: {...},
                            // bar: {...},
                            // stack: {...},
                            // tiled: {...},
                            // force: {...},
                            // chord: {...},
                             pie: {

                             },
                            // funnel: {...}
                        }

                    },
//                    myTool2: {
//                        show: true,
//                        title: '饼图切换',
//                        icon: 'image://http://echarts.baidu.com/images/favicon.png',
//                        onclick: function (){
//                           alert()
//                        }
//                    },
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            legend: {
                data:[typetitle]
            },
            xAxis : [
                {
                    type : 'category',
                    data : nameArr//构建x轴类型
                },
                {//折线图x轴
                    type : 'category',
                    axisLine: {show:false},
                    axisTick: {show:false},
                    axisLabel: {show:false},
                    splitArea: {show:false},
                    splitLine: {show:false},
                    data : nameArr
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
                    "data":numArr, //数据
                    markPoint : {
                        data : [
                            {type : 'max', name: '最大值'},
                            {type : 'min', name: '最小值'}
                        ]
                    },
                    markLine : {
                        data : [
                            {type : 'average', name: '平均值'}
                        ]
                    }
                },
            ],
        };
        return option;
    }

//    饼状图
    function dobeoneOption1(nameArr,typetitle,conArr,type_ym){
        var option1 = {
            title : {
                text: typetitle,
                subtext: type_ym,
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            toolbox: {
                show : true,
                feature : {
                    mark : {show: false},
                    dataView : {show: true, readOnly: false},
                    magicType : {
                        show: true,
                        type: [],
                        option: {
                            funnel: {
                                x: '25%',
                                width: '50%',
                                funnelAlign: 'left',
                                max: 1548
                            }
                        }
                    },
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            legend: {
                orient : 'vertical',
                x : 'left',
                data:nameArr
            },
            calculable : false,
            series : [
                {
                    name:typetitle,
                    type:'pie',
                    radius : '55%',
                    center: ['50%', 230],
                    data:conArr
                }
            ]
        };
        return option1;
    }


    //生成一个table的tr的内容
    function dobeTableContent(data,sum,typetitle){
        $('#b_data').empty();
        var htmlStr="";
        var sum=0;
        $.each(data,function(index,content){
            sum+=parseInt(content.num);
        });
        $.each(data,function(index,content){
            var num=content.num;
            if(typetitle=='金额'){
                var num=num/100;
            }
            if(typetitle=='分润'){
                var num=num/100;
            }
            if(num==0){
                htmlStr+="";
            }else{
                htmlStr+="<tr>";
                htmlStr+="<td width='20%'>"+content.name+"</td>";
                htmlStr+="<td width='40%'>"+num+"</td>";
                htmlStr+="<td width='40%'>"+(content.num/sum*100).toFixed(2)+"%"+"</td>";
                htmlStr+="</tr>";
            }
        });
        if(typetitle=='金额'){
            var sum=sum/100;
        }
        if(typetitle=='分润'){
            var sum=sum/100;
        }
        htmlStr+="<tr class='success'>";
        htmlStr+="<td width='20%'>总量</td>";
        htmlStr+="<td width='40%'>"+sum+"</td>";
        htmlStr+="<td width='40%'>"+100.00+"%"+"</td>";
        htmlStr+="</tr>";
        $("#b_data").append(htmlStr);
    }

</script>
</body>
</html>
