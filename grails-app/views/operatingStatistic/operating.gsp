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
        统计中心
        <small>每日数据</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>每日报表</a></li>
        <li class="active">发货数据</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class='col-xs-12'>
            <g:form action="index" class="form-inline" useToken="true">
                <div class="input-group no-padding">
                    <div class="input-group-addon">
                        <i class="fa fa-clock-o"></i>日期:
                    </div><input value="${params.selectedTime}"
                                 name="selectedTime"
                                 class="input-sm form_datetime"
                                 style="width: 130px"
                                 readonly/>
                </div><!-- /.input group -->


                <g:select optionKey="id" optionValue="name" name="communityId"
                          value="${params.communityId}"
                          class="form-control" from="${communityList}" noSelection="['': '选择站点：']"/>

                <button type="submit"
                        class="btn btn-primary"><i
                        class="fa fa-search">查询</i></button>
            </g:form>
        </div>
    </div>

    <!-- Default box -->
    <div class="box">
        <div class="box-header">
            <i class="fa fa-bar-chart-o"></i>

            <h3 class="box-title">每日发货订单统计（参考）</h3>

            <div class="box-tools pull-right">
                实时统计
            </div>
        </div>

        <div class="box-body">
            <div id="interactive" style="min-width: 500px; height: 400px; margin: 0 auto"></div>
        </div><!-- /.box-body -->
        <div class="box-footer clearfix">

        </div><!-- /.box-footer-->
    </div><!-- /.box -->
    <div class="box box-primary">
        <div class="box-header">
            <i class="fa fa-bar-chart-o"></i>

            <h3 class="box-title">昨日发货订单统计（参考）</h3>

            <div class="box-tools pull-right">
                24小时统计
            </div>
        </div>

        <div class="box-body">
            <div id="interactive2" style="min-width: 500px; height: 400px; margin: 0 auto"></div>
        </div><!-- /.box-body-->
    </div><!-- /.box -->

    <div class="box box-primary">
        <div class="box-header">
            <i class="fa fa-bar-chart-o"></i>

            <h3 class="box-title">每周线上支付数据</h3>
        </div>

        <div class="box-body">
            <div id="line-chart" style="height: 300px;"></div>
        </div><!-- /.box-body-->
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
<asset:javascript src="iCheck/icheck.min.js"/>
<!-- high chart -->
<asset:javascript src="third-party/highcharts/highcharts.js"/>
<asset:javascript src="third-party/highcharts/exporting.js"/>

<!-- bootstrap time picker -->
<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>
<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>

<!-- notify -->
<asset:javascript src="growl/bootstrap-growl.min.js"/>


<!-- tdist.js -->
<script src="http://a.tbcdn.cn/p/address/120214/tdist.js"></script>

<script type="text/javascript">
    $(function () {
        var data
        <g:if test="${retYestoday != null}">
        data = ${raw(retYestoday)}
                </g:if>

                $('#interactive2').highcharts({
                    chart: {
                        type: 'column'
                    },
                    title: {
                        text: ''
                    },
                    subtitle: {
                        text: ''
                    },
                    xAxis: {
                        type: 'category',
                        labels: {
                            rotation: -45,
                            style: {
                                fontSize: '13px',
                                fontFamily: 'Verdana, sans-serif'
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: '商品购买数 (笔)'
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    tooltip: {
                        pointFormat: '昨日订单: <b>{point.y} 笔</b>'
                    },
                    series: [{
                        name: '订单统计',
                        data: data,
                        dataLabels: {
                            enabled: true,
                            rotation: -90,
                            color: '#FFFFFF',
                            align: 'right',
                            x: 4,
                            y: 10,
                            style: {
                                fontSize: '13px',
                                fontFamily: 'Verdana, sans-serif',
                                textShadow: '0 0 3px black'
                            }
                        }
                    }]
                });

    });
</script>

<script type="text/javascript">
    $(function () {
        var data
        <g:if test="${retList != null}">
        data = ${raw(retList)}
                </g:if>

                $('#interactive').highcharts({
                    chart: {
                        type: 'column'
                    },
                    title: {
                        text: ''
                    },
                    subtitle: {
                        text: ''
                    },
                    xAxis: {
                        type: 'category',
                        labels: {
                            rotation: -45,
                            style: {
                                fontSize: '13px',
                                fontFamily: 'Verdana, sans-serif'
                            }
                        }
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: '商品购买数 (笔)'
                        }
                    },
                    legend: {
                        enabled: false
                    },
                    tooltip: {
                        pointFormat: '今日订单: <b>{point.y} 笔</b>'
                    },
                    series: [{
                        name: '订单统计',
                        data: data,
                        dataLabels: {
                            enabled: true,
                            rotation: -90,
                            color: '#FFFFFF',
                            align: 'right',
                            x: 4,
                            y: 10,
                            style: {
                                fontSize: '13px',
                                fontFamily: 'Verdana, sans-serif',
                                textShadow: '0 0 3px black'
                            }
                        }
                    }]
                });

        $('#line-chart').highcharts({
            chart: {
                type: 'line'
            },
            title: {
                text: ''
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                categories: ${incomeList.categories}
            },
            yAxis: {
                title: {
                    text: '收入 (元)'
                }
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: false
                }
            },
            series: [{
                name: '线上收入',
                data: ${incomeList.values}
            }]
        });
    });

    $(".form_datetime")
            .datetimepicker({format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD")
                $('#acceptTime').val(value)
            });
</script>

</body>

</html>
