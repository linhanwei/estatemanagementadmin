<%@ page import="welink.complain.Complain" %>
<!--模态框1-->
<div class="modal fade" id="suggestion" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <g:formRemote name="dealComplain" url="[controller: 'complain', action: 'dealComplain']"
                          onSuccess="window.location.reload()" onFailure="window.location.reload()">

                <div class="modal-header bg-maroon-gradient">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">处理意见</h4>
                </div>


                <div class="modal-body">

                    <div class="row">

                        <div id="inHandComplainNotes">
                            <g:render template="complainDetails"/>
                        </div>

                        <div class="row">
                            <label class="col-sm-2 control-label"><i class="fa fa-edit"></i>我的建议:</label>

                            <div class="col-sm-9">
                                <input id="currentComplain" name="currentComplain" style="display: none"/>
                                <textarea rows="5" name="dealcontent" class="form-control" id="dealcontent"
                                          placeholder=""></textarea>
                            </div>
                        </div>

                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
                    <button type="submit" class="btn btn-primary">确定</button>
                </div>
            </g:formRemote>

        </div>
    </div>
</div>

<!--模态框2,用于创建投诉-->
<div class="modal fade bs-example-modal-lg" id="createSuggestion" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-maroon-gradient">
                <button type="button" class="close" data-dismiss="modal"><span
                        aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>

                <h2 class="modal-title h2" id="myModalLabel">创建投诉</h2>
            </div>

            <div class="modal-body">

                <g:form name="createComplain_form" class="form-horizontal" useToken="true"
                        onSuccess="window.location.reload()"
                        onFailure="window.location.reload()"
                        url="[controller: 'complain', action: 'addComplain']">

                    <div class="form-group">
                        <label class="col-sm-3 control-label">投诉人:<span class="f_req">*</span></label>

                        <div class="col-sm-8">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-phone"></i>
                                </div>
                                <input type="text" id="mobile" name="mobile" class="form-control"
                                       data-inputmask='"mask": "999-9999-9999"' data-mask="true"/>
                            </div><!-- /.input group -->
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-sm-3 control-label">投诉类目:<span class="f_req">*</span></label>

                        <div class="col-sm-8">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <i class="fa fa-tags"></i>
                                </div>
                                <input type="text" class="form-control" name="complainTitle">

                            </div><!-- /.input group -->
                        </div>
                    </div>

                    <div class="form-group">

                        <label class="col-sm-3 control-label">投诉建议:<span class="f_req">*</span></label>

                        <div class="col-sm-8">
                            <textarea rows="5" name="complainContent" class="form-control" id="textarea"></textarea>

                        </div>
                    </div>

                    <div class="form-group">
                        <div class="row">
                            <div class="col-xs-12 col-xs-offset-3">

                                <g:submitToRemote

                                        url="[controller: 'complain', action: 'addComplain']"
                                        asynchronous="false" onSuccess="window.location.reload()"
                                        class="btn btn-primary "
                                        value="确定"/>

                                <button type="reset"
                                        class="btn btn-warning col-xs-1 col-xs-offset-1"
                                        data-dismiss="modal">取消</button>
                            </div>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>


<!--主体部分-->
<div class="box">
    <div class="box-header">
        <div class="box-tools">
            <div class="row">
                <div class="col-xs-6">
                    <div class="input-group">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#createSuggestion"
                                type="button" id="createComplain">创建投诉</button>
                    </div><!-- /input-group -->
                </div><!-- /.col-lg-6 -->
                <div class="col-xs-6">
                    <div class="input-group">
                        <input type="text" class="form-control"
                               value="${(params.query == null || (params.query == 'null')) ? '' : params.query}"
                               placeholder="投诉人号码" id="ComplainWaitToDealSearchText"/>
                        <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" id="ComplainWaitToDealSearch">搜索</button>
                        </span>
                    </div><!-- /input-group -->
                </div><!-- /.col-lg-6 -->
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <table class="table table-bordered table-hover text-center vertical-middle-sm">
            <thead>
            <tr>
                <th>投诉人</th>
                <th>投诉类目</th>
                <th>投诉内容</th>
                <th>投诉时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <g:if test="${total > 0}">
                <g:each in="${complainList}" var="record" status="i">
                    <tr>
                        <td>${profileMobileMap.get(record.id)}</td>
                        <td>${record.title}</td>
                        <td>${record.content}</td>
                        <td>${record.dateCreated.toString().substring(0, 16)}</td>
                        <td class=".warning">
                            <button type="button" class="btn btn-primary " data-toggle="modal"
                                    data-target="#suggestion" name="${record?.id}"
                                    onclick="dealComplaine('${record.id}')">处理</button>
                            <button type="button" class="btn btn-success "
                                    onclick="finishComplain('${record.id}')">完结</button>
                        </td>
                    </tr>
                </g:each>
            </g:if>
            </tbody>
        </table>

        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <ul class="pagination pull-right">
                    <util:remotePaginate total="${total}" action="queryComplainList" params="${[query: params.query]}"
                                         update="waitToDeal"
                                         next="下一页" prev="上一页"/>
                </ul>
            </g:if>
        </div>
    </div>
</div>


