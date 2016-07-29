<%@ page import="com.alibaba.fastjson.JSON; com.alibaba.fastjson.TypeReference; org.apache.commons.lang3.StringUtils;org.joda.time.DateTime;" %>

<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th><i class="fa fa-bookmark"></i>标题:</th>
            <th>${item?.title}</th>
            <th><i class="fa fa-flask"></i>规格:</th>
            <th>${item?.specification}</th>
        </tr>

        <tr>

            <th><i class="fa fa-gavel"></i>销售价:</th>
            <th><span style="color: #ff0000">${(item?.price ?: 0) / 100f}</span></th>
        </tr>
        </thead>
    </table>
    <g:form action="chageTag" controller="objectTagged" params="${params}">
        <input value="${item?.id}" style="display: none" name="itemId">
        <table class="table table-bordered">
            <thead>
        <tr>
        <th>当前标:</th>
        <th>
        <g:if test="${currentTags != null}">
            <g:each in="${currentTags}" var="tag" status="i">
                <input id="${tag?.id}" type="button" name="newMainTag" value="${tag?.name}"
                       onclick="deleteItemTag(${tag?.id})"
                       style="background-color: dodgerblue;color: #ffffff"
                       class="btn tagBtn">
            </g:each>
        </g:if>
        </th>
        </tr>

        <tr>
            <th>
                <g:if test="${allTags != null}">
                    <g:each in="${allTags}" var="tag" status="i">
                    %{--<label><input type="radio" name="newTags" value="${tag?.id}">${tag?.name}</label>--}%
                        <g:if test="${currentMap.get(tag?.id)}">
                            <label><input type="checkbox" name="newTags" value="${tag?.id}" checked>${tag?.name}</label>
                        </g:if>
                        <g:else>
                            <label><input type="checkbox" name="newTags" value="${tag?.id}">${tag?.name}</label>
                        </g:else>
                    </g:each>
                </g:if>
            </th>
            <th>
                <button type="submit" class="btn btn-success pull-right" id="updateTagBtn">打标</button>
            </th>
        </tr>

        <tr>
            <th>
                <label class="control-label"><i class="fa fa-tag">限购数量(非限购不用填)</i></label>
            </th>
            <th>
                <input type="text" name="limitNum" class="input-sm"  value="${num}"
                       placeholder="限购数量">
            </th>
        </tr>


        <table class="table table-bordered text-center  qgbflagDiv" style="table-layout: fixed">
            <thead>
            <tr>
                <th>
                    <label class="control-label">销售基数</label>
                </th>
                <th>
                    <input type="text" name="baseSoldNum" class="form-control" value="${JSON.parseObject(qgobjectTagged?.kv)?.get('baseSoldNum')}"
                           placeholder="销售基数">
                </th>
                <th>
                    <label class="control-label">活动展示倍数</label>
                </th>
                <th>
                    <input type="text" name="multiple" class="form-control" value="${JSON.parseObject(qgobjectTagged?.kv)?.get('multiple')}"
                           placeholder="活动展示倍数">
                </th>
            </tr>


            <tr>
                <th>
                    <label class="control-label">活动价格</label>
                </th>
                <th >
                    <input type="text" name="activityPrice" class="input-sm form-control"
                           placeholder="活动价格" value="${JSON.parseObject(qgobjectTagged?.kv)?.get('activityPrice')?JSON.parseObject(qgobjectTagged?.kv)?.get('activityPrice')/100f:""}">
                </th>
                <th>
                    <label class="control-label">活动限量数</label>
                </th>
                <th >
                    <input type="text" name="activity_num" class="input-sm form-control"
                           placeholder="活动限量数" value="${qgobjectTagged.activityNum}">
                </th>
            </tr>

            <tr>
                <th>
                    <label class="control-label"><i class="fa fa-tag">开始时间</i></label>
                </th>
                <th colspan="2">
                    <input name="start_time"
                           class="input-sm form_datetime  form-control" value="${qgobjectTagged.startTime?new DateTime(qgobjectTagged.startTime).toString("yyyy-MM-dd HH:mm"):qgobjectTagged.startTime}" />
                </th>

            </tr>

            <tr>
                <th>
                    <label class="control-label"><i class="fa fa-tag">结束时间</i></label>
                </th>
                <th colspan="2">
                    <input name="end_time"
                           class="input-sm form_datetime  form-control" value="${qgobjectTagged.endTime?new DateTime(qgobjectTagged.endTime).toString("yyyy-MM-dd HH:mm"):qgobjectTagged.endTime}" />
                </th>
            </tr>
            </thead>
        </table>


    </g:form>
</thead>
</table>
    <div id="selectAttributes">
    </div>
</div>

%{--<!-- Bootstrap time Picker -->--}%
<asset:stylesheet src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.css"/>
%{--<!-- Jquery -->--}%
<asset:javascript src="jquery-2.1.3.js"/>
%{--<!-- jQuery UI 1.10.3 -->--}%
%{--<asset:javascript src="jQueryUI/jquery-ui-1.10.3.js"/>--}%
%{--<!-- Bootstrap -->--}%
<asset:javascript src="bootstrap.js"/>
<asset:javascript src="bootstrap-datetimepicker.min.js"/>
%{--<asset:javascript src="bootstrap-datetimepicker.zh-CN.js"/>--}%
%{--<script src="http://187.unesmall.com/h5/js/page/bootstrap-datetimepicker.min.js" type="text/javascript"></script>--}%
%{--<script src="http://187.unesmall.com/h5/js/page/bootstrap-datetimepicker.zh-CN.js"></script>--}%
%{--<!-- AdminLTE App -->--}%
%{--<asset:javascript src="app.js"/>--}%
%{--<!-- bootstrap time picker -->--}%
%{--<asset:javascript src="bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"/>--}%
%{--<asset:javascript src="bootstrap-datetimepicker/locales/bootstrap-datetimepicker.zh-CN.js"/>--}%
<script>
    (function($){
        $.fn.datetimepicker.dates['zh-CN'] = {
            days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
            daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
            daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
            months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
            monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
            today: "今日",
            suffix: [],
            meridiem: ["上午", "下午"]
        };
    }(jQuery));
</script>



<script>

    $(".form_datetime")
            .datetimepicker({format: 'yyyy-mm-dd hh:ii', language: 'zh-CN', autoclose: true})
            .on('changeDate', function (ev) {
                var value = moment(ev.date.valueOf()).subtract(8, 'hour').format("YYYY-MM-DD HH:mm")
                $('#acceptTime').val(value)
            });



    function deleteItemTag(id) {

        if (!confirm("您真的要删除这个标签么？")) {
            return;
        }
        var itemId = $("input[name='itemId']").val()

        $.ajax({
            url: '/ObjectTagged/deleteItemTag',
            data: {'tagId': id, 'itemId': itemId},
            type: "POST",
            dataType: "json",
            success: function (data) {
                window.location.reload()
            },
            error: function (data) {
                alert('撤标失败')

            }
        });
    }

    $(document).ready(function () {

        doMyTagsDiv();


        var oldValue

        $('.tagBtn').mouseover(function () {
            $(this).css({
                'backgroundColor': '#df0001',
                'color': '#fff'
            });
            oldValue = $(this).val()
            $(this).val('删除')
        });

        $('.tagBtn').mouseout(function () {
            $(this).css({
                'backgroundColor': 'dodgerblue',
                'color': '#fff'
            });
            $(this).val(oldValue)

        });


        $("#add").click(function () {

            $("#select1 option:selected").appendTo("#select2");

        });

        $("#add_all").click(function () {

            $("#select1 option").appendTo("#select2");

        });

        $("#remove").click(function () {

            $("#select2 option:selected").appendTo("#select1");

        });

        $("#remove_all").click(function () {

            $("#select2 option").appendTo("#select1");

        });

        $("#select1").dblclick(function () {

            $("#select1 option:selected").appendTo("#select2");

        });

        $("#select2").dblclick(function () {

            $("#select2 option:selected").appendTo("#select1");

        });




        //进行对抢购标的事件响应
        $("input[name=newTags]").click(function(){
//            debugger;
            var title=$(this).parent().html();
            if(title.indexOf("抢购标")>-1){
                if($(this).is(":checked")){
                    $(".qgbflagDiv").show();

                    //进行初始化的查对应的参数
//                    $.ajax({
//                        url: '/ObjectTagged/deleteItemTag',
//                        data: {'tagId': id, 'itemId': itemId},
//                        type: "POST",
//                        dataType: "json",
//                        success: function (data) {
//                            window.location.reload()
//                        },
//                        error: function (data) {
//                            alert('撤标失败')
//
//                        }
//                    });


                    initDataForDiv();
                }
                else{
                    $(".qgbflagDiv").hide();
                }
            }
        });
    });



    //遍历所有标的内容：有则显示 无则隐藏
    function doMyTagsDiv(){
        //初始化有没有抢购标
        var tags=$("input[name=newTags]");
        var flag=0
        for(var i=0;i<tags.length;i++){
            var title=$(tags[i]).parent().html();
            if($(tags[i]).is(":checked")  && title.indexOf("抢购标")>-1){
                flag=1;break;
            }
        }
        if(flag){
            $(".qgbflagDiv").show();
//            initDataForDiv();
        }
        else{
            $(".qgbflagDiv").hide();
        }
    }

    //默认初始化
    function initDataForDiv(){
        //活动价格 限量数 活动开始时间，活动结束时间（对应object_tagged表中start_time和end_time） 活动销售基数0 活动展示倍数1
        $("input[name=baseSoldNum]").val(0);
        $("input[name=multiple]").val(1);
        $("input[name=activityPrice]").val("");
        $("input[name=activity_num]").val(1);
        $("input[name=start_time]").val(CurentTime(0));
        $("input[name=end_time]").val(getNextDayByMethod(CurentTime(0))+" "+CurentTime(0).split(" ")[1]);
    }


    function CurentTime(many)
    {
        var now = new Date();

        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate()+many;            //日

        var hh = now.getHours();            //时
        var mm = now.getMinutes();          //分

        var clock = year + "-";

        if(month < 10)
            clock += "0";

        clock += month + "-";

        if(day < 10)
            clock += "0";

        clock += day + " ";

        if(hh < 10)
            clock += "0";

        clock += hh + ":";
        if (mm < 10) clock += '0';
        clock += mm;
        return(clock);
    }


    function getNextDay(){
        var info= getNextDayByMethod(new Date().getFullYear()+"-"+(new Date().getMonth() + 1)+"-"+new Date().getDate());
        info+=CurentTime(0).substring(10,16);
        return info;
    }



    //获取一天的方法
    function getNextDayByMethod(mdate){
        //获取当前值的下一天
        //获取当前的数组
        var marray = [];
        //把日期进行切割  格式为：yyyy-mm-dd
        //新的日期
        var nyear=0,nmonth=0,nday=0;
        marray = mdate.split("-");
        var year=parseInt(marray[0]);
        var month=parseInt(marray[1]);
        var day=parseInt(marray[2]);
        //判断是否月尾   ==月的尾部  年的尾部
        if(month==12 && day==31){
            nyear=year+1;
            nmonth=1;
            nday=1;
        }
        //看一下是否是月尾
        else if(day==getMonthDaysbyMoth(month) && month!=12){
            nyear=year;;
            nmonth=month+1;
            nday=1;
        }else{
            nyear=year;
            nmonth=month;
            nday=day+1;
        }
        nmonth=(nmonth<10?"0"+nmonth:nmonth);
        nday=(nday<10?"0"+nday:nday);
        return nyear+"-"+nmonth+"-"+nday;
    }


    function getMonthDaysbyMoth(month){
        //2月的判断的天数
        if (month == 2) {
            if (year % 4 == 0) {
                if (year % 100 != 0) {
                    return 29;
                }
                else {
                    if (year % 400 == 0) {
                        return 29;
                    }
                    else {
                        return 28;
                    }
                }
            }
            else {
                return 28;
            }
        }
        //如果是其他月份的判断
        if(month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12){
            return 31;
        }else{
            return 30;
        }
    }



</script>

