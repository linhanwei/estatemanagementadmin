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
    <h1>
        运营统计
        <small>数据统计</small>
    </h1>

</section>
<section class="content">

    <div class="box">
        <div class="box-header clearfix">

            <g:form name="stockGoodsForm" class="form-inline" action="index">
                <div class="row">

                    <h4 class="col-sm-2">条件:</h4>

                    <div class="col-sm-5 col-md-3 form-group">
                        <label class="control-label">一级类目：</label>

                        <g:select optionKey="id" optionValue="name" name="level1Category"
                                  class="form-control" from="${categoryList}" value="${params.level1Category}"
                                  noSelection="['-1': '一级类目...']"/>
                    </div>

                    <div class="col-sm-5 col-md-3 form-group">
                        <label class="control-label">二级类目：</label>

                        <select id="category" class="form-control" name="category" bsfalg="${params.category}">
                        </select>

                    </div>

                    %{--<div class="col-sm-5 col-md-3 form-group">--}%
                        %{--<label class="control-label">三级类目：</label>--}%

                        %{--<select id="" class="form-control" name="category" bsfalg="${params.category}">--}%
                        %{--</select>--}%

                    %{--</div>--}%

                </div>

                <div class="row">

                    <h4 class="col-sm-2">维度:</h4>

                    <div class="col-sm-5 col-md-4 form-group" style="margin-top: 5px;">
                        <input type="checkbox" name="ShipBox"
                               value="0">&nbsp;&nbsp;类目
                    </div>

                    <div class="col-sm-5 col-md-4 form-group" style="margin-top: 5px;">
                        <input type="checkbox" name="ShipBox"
                               value="1">&nbsp;&nbsp;品牌
                    </div>

                    <div class="col-sm-2 pull-right">
                        <input type="text" style="display: none" id="lminput" value="0"/>
                        <input type="text" style="display: none" id="ppinput" value="0"/>

                        <span id="ShipBoxfalg"></span>

                        <div class="col-sm-3 col-md-4 form-group">
                            <input type="button" value="统计" id="tongjiBtn" class="btn btn-primary"/>
                        </div>

                        <span id="datasource" class="hide"> ${listr}</span>
                    </div>

                </div>

            </g:form>



        </div>
        <div id="main" class="box-body clearfix" style="height:400px"></div>


        <table style="width: 90%; margin: 0 auto;" class="table table-hover table-bordered text-center">
            <tr >
                <td>类目名称</td>
                <td>商品数量</td>
                <td>总仓数量</td>
                <td>上架数量</td>
                <td>总量占比</td>
            </tr>
            <tbody class="mytable">

            </tbody>
        </table>

    </div>

</section>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<!-- sticky -->
<asset:javascript src="sticky/sticky.js"/>
<!-- iCheck -->
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- high chart -->
<asset:javascript src="third-party/highcharts/highcharts.js"/>
%{--<asset:javascript src="third-party/highcharts/exporting.js"/>--}%

<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>

<!-- notify -->
<asset:javascript src="growl/bootstrap-growl.min.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<!-- ECharts单文件引入 -->
<asset:javascript src="build/dist/echarts.js"/>
%{--<asset:javascript src="build/dist"/>--}%
%{--<asset:javascript src="build/dist/echarts-all.js"/>--}%
<asset:javascript src="build/dist/chart/bar.js"/>
<asset:javascript src="build/dist/theme/macarons.js"/>
%{--<script src="echarts/src/echarts.js"></script>--}%
<script type="text/javascript">
    $(function(){
        init();
    });

    //进行条件查询
    $("#tongjiBtn").click(function () {
        //分为4情况：类目 + 品牌
        var level1Category=$("#level1Category").val(), category=$("#category").val();
        //维度:类目  品牌
        var lmfalg=$("#lminput").val(), ppfalg=$("#ppinput").val(),bzfalg="0",lmbzflag="0";
        if(lmfalg=="0" && ppfalg=="0"){
            //全不选
            bzfalg="0";
        }
        else if(lmfalg=="1" && ppfalg=="0"){
            //选类目
            bzfalg="1";
        }
        else if(lmfalg=="0" && ppfalg=="1"){
            //选品牌
            bzfalg="2";
        }
        else if(lmfalg=="1" && ppfalg=="1"){
            //选品牌 类目
            bzfalg="3";
        }

        //全不选的时候
        if(level1Category=="-1" && category=="-1")
        {
            lmbzflag="1";
        }

        $.ajax({
            url: '<g:createLink controller="operatingStatistic" action="getcomdition"/>', // remote datasource
            data: {
                'onelevel': level1Category,
                'twolevel': category,
                'falg': bzfalg,
                'lmbzflag':lmbzflag
            },
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#datasource").html(JSON.stringify(data));
                $(".mytable").html("");
                init();
            }, error: function (data) { // handle server errors
            }
        });

    });



    function init(){
        // 路径配置
        require.config({
            paths: {
                'echarts': '../assets/plugins/build/dist',
//                'chart/bar': '../assets/plugins/build/dist/chart/bar',
//                'theme/macarons': '../assets/plugins/build/dist/theme/macarons'
//                'theme/macarons': '../assets/plugins/build/dist/theme/macarons'
//
            }
        });
        require(
                [
                    'echarts',
                    'echarts/theme/macarons',
                    'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
                ],
                function (ec) {
                    var myNewChart = ec.init(document.getElementById('main'),'macarons');
                    //初始化各一级类目所有的数据
                    var data=JSON.parse($("#datasource").html());
                    var sum=0;
                    var zcnum=0;
                    var sjnum=0;
                    debugger;
                    var titleArr=['商品数量'],nameArr=[],numArr=[],title='商品数量';
                    $.each(data,function(index,content){
                        nameArr.push(content.name);
                        numArr.push(content.num);
                        sum+=content.num;
                        zcnum+=content.zcnum
                        sjnum+=content.sjnum
                    });
                    //进行表单的构建
                    dobeTableContent(data,sum,zcnum,sjnum);
                    myNewChart.setOption(dobeoneOption(nameArr,numArr,title));
                }
        );
    }

    //生成一个table的tr的内容
    function dobeTableContent(data,sum,zcnum,sjnum){
        var htmlStr="";
        $.each(data,function(index,content){
            htmlStr+="<tr><td>";
            htmlStr+=content.name;
            htmlStr+="</td><td>";
            htmlStr+=content.num;
            htmlStr+="</td><td>";
            htmlStr+="<a href='";
            htmlStr+=content.zccodition;
            htmlStr+="'  target='_blank' >";
//            htmlStr+="<a href='/itemInStock/index.gsp' target='_blank' >";
            htmlStr+=content.zcnum;
            htmlStr+="</a>";
            htmlStr+="</td><td>";
            htmlStr+="<a href='";
            htmlStr+=content.sjcondition;
            htmlStr+="'  target='_blank' >";
//            htmlStr+="<a href='/itemInStock/index.gsp' target='_blank' >";
            htmlStr+=content.sjnum;
            htmlStr+="</a>";
//            htmlStr+=content.sjnum;
            htmlStr+="</td><td>";
            htmlStr+=((content.num/sum)*100).toFixed(1);
            htmlStr+="%</td></tr>";
        });
        htmlStr+="<tr class='success'><td>总量</td><td>";
        htmlStr+=sum;
        htmlStr+="</td><td>";
        htmlStr+=zcnum;
        htmlStr+="</td><td>";
        htmlStr+=sjnum;
        htmlStr+="</td><td>";
        htmlStr+="100%</td></tr>";
        $(".mytable").append(htmlStr);
    }

    //生成一个option对象
    function dobeoneOption(nameArr,numArr,title){
        var option = {
            tooltip: {
                show: true,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    magicType : {show: true, type: ['line', 'bar']},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            toolbox: {
                show: true,
                feature : {
                    mark : {show: false},
                    dataView : {show: true, readOnly: false},
                    magicType : {
                        show: true,
                        type: [ ],
                        option: {
                            // line: {...},
                            // bar: {...},
                            // stack: {...},
                            // tiled: {...},
                            // force: {...},
                            // chord: {...},
                            // pie: {...},
                            // funnel: {...}
                        }
                    },
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            legend: {
                data:['商品数量']
            },
            xAxis : [
                {
                    type : 'category',
                    data : nameArr
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    "name":title,
                    "type":"bar",
                    "data":numArr
                }
            ]
        };
        return option;
    }

    //进行类目动态变化
    $('#level1Category').change(function () {
        var str = "";
        $("#level1Category option:selected").each(function () {
            $('#category').find('option').remove();
            $('#category').append('<option value="-1">请选择类目...</option>');
            var id = $(this).val()
            if (id != "-1" && id != '' && id != undefined) {
                $.ajax({
                    url: '<g:createLink controller="itemCategory" action="queryCategoryByParentId"/>', // remote datasource
                    data: {'id': id},
                    type: "POST",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (index, m) {
                            $('#category').append('<option value="' + m.id + '">' + m.name + '</option>');
                        })
                    }, error: function (data) { // handle server errors

                    }
                });
            }
        });
    }).trigger('change');

    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });

    $("input[name='ShipBox']").on('ifChecked', function (event) {
        var id = this.value;
        if(id=="0"){
            $("#lminput").val("1");
        }else if(id=="1"){
            $("#ppinput").val("1");
        }
    });
    $("input[name='ShipBox']").on('ifUnchecked', function (event) {
        var id = this.value;
        if(id=="0"){
            $("#lminput").val("0");
        }else if(id=="1"){
            $("#ppinput").val("0");
        }
    });

</script>

</body>

</html>
