<%--
  Created by IntelliJ IDEA.
  User: slimx
  Date: 12-9-12
  Time: 上午11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<%@ include file="/common/taglibs.jsp" %>
<html>
<head>
    <%@ include file="/common/meta.jsp" %>
    <title>短信群发平台</title>
    <script>
        //        客户为批量选择模式
        var batchSelectMode = true;
    </script>
    <script src="${ctx}/scripts/md5-min.js"></script>
    <script src="${ctx}/scripts/select.customer.js"></script>
    <script src="${ctx}/scripts/select.user.js"></script>
    <script src="${ctx}/scripts/select.supplier.js"></script>


    <script type="text/javascript" src="${ctx}/scripts/jquery/ui/jquery-ui-1.8.21.custom.min.js"></script>
    <script src="${ctx}/scripts/jquery/datatime/jquery-ui-timepicker-addon.js"></script>
    <script src="${ctx}/scripts/jquery/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>

    <link href="${ctx}/scripts/jquery/ui/css/smoothness/jquery-ui-1.8.21.custom.css" rel="stylesheet"/>
    <link href="${ctx}/scripts/jquery/datatime/jquery-ui-timepicker-addon.css" rel="stylesheet"/>
    <style>
        html {
            min-height: 100%;
        }

        body {
            min-height: 100%;
        }

        .main-div {
            margin: 0 auto;
            width: 800px;
            padding-top: 10px;
        }

        #content {
            width: 493px;
            height: 175px;
        }

        #_pwd, .time-input, #mobile {
            width: 500px;
        }
    </style>
</head>
<body>
<div class="x-header">短信群发平台</div>
<div class="main-div">
    <div class="">
        <form method="post" action="http://10658.com.cn/api/sendsms/">
            <table width="900" border="0" cellpadding="0" cellspacing="0" style="table-layout: fixed;">
                <input name="uid" type="hidden" id="uid" value="zjkc">
                <input name="pwd" type="hidden" id="pwd" value="">
                <input name="pid" type="hidden" id="pid" value="2">

                <tr>
                    <td align="right" style="width: 60px;">密码：</td>
                    <td style="width: 500px;">
                        <input type="password" id="_pwd" value="">
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <td align="right">短信号码：</td>
                    <td>
                        <input name="mobile" type="text" id="mobile" value="">

                    </td>
                    <td><span>　(同时发送的上限为1000人,多个号码用英文逗号分开)</span></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <button onclick="selectCustomer()" type="button" style="padding-top: 1px;padding-bottom: 1px;">
                            选择客户
                        </button>
                        <button onclick="selectSupplier()" type="button" style="padding-top: 1px;padding-bottom: 1px;">
                            选择供应商
                        </button>
                        <button onclick="selectUser()" type="button" style="padding-top: 1px;padding-bottom: 1px;">
                            选择员工
                        </button>

                    </td>
                </tr>

                <tr>
                    <td>发送时间:</td>
                    <td>
                        <input name="time" type="text" id="time" class="time-input">
                    </td>
                    <td><span>　(大于当前时间为定时发送,不填为立即发送)</span></td>
                </tr>

                <tr>
                    <td align="right" style="vertical-align: 0">内容：</td>
                    <td>
                        <textarea name="content" id="content">【河北演艺集团】</textarea>
                    </td>
                    <td style="vertical-align: 0"><span>　(超过70字会自动分为多条短信)</span></td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                <span style="width: 500px;text-align: right;display: inline-block;"><input type="submit" name="Submit"
                                                                                           value="发送" class="button">
                <input type="reset" name="Submit2" value="重置" class="button">
            </span>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script>
    var _selMap = {}
    $.timepicker.regional['zh-CN'] = {
        timeOnlyTitle:'设定时间',
        timeText:'设定时间',
        hourText:'小时',
        minuteText:'分钟',
        secondText:'秒',
        millisecText:'毫秒',
        timezoneText:'时区',
        currentText:'当前时间',
        closeText:'关闭',
        timeFormat:'hh:mm tt',
        amNames:['上午', 'A'],
        pmNames:['下午', 'P'],
        ampm:false
    };
    $.timepicker.setDefaults($.timepicker.regional['zh-CN']);

    $(function () {
        $("form").submit(function () {
            if (confirm("确定要发送吗?")) {
                var pwd = $("#_pwd").val();
                $("#pwd").val(hex_md5(pwd));
            }
            else return false;
        });
        $(".time-input").datetimepicker({
            timeFormat:'hh:mm',
            dateFormat:'yy-mm-dd'
        });
    });

    //选择客户
    function selectCustomer() {
        //客户选择窗口,过滤掉没没有移动电话号码的
        openCustomer(function () {
            var mobiles = "";
            $.each(_selMap, function (index, item) {
                if (item == null || item === "")return;
                mobiles += item + ",";
            });
            $("#mobile").val(mobiles);
        });
    }

    //选择用户
    function selectUser() {
        openSel(function (users) {
            buildMobile(users);
        })
    }

    //选择供应商
    function selectSupplier() {
        supplierChooser.open(function () {
            buildMobile(supplierChooser.selMap)

        })
    }

    //拼接号码
    function buildMobile(users) {
        var mobiles = "";
        if (users != null) {
            for (var i = 0; i < users.length; i++) {
                if (users[i] == null)continue;
                var m = users[i].mobile;
                if (m == null || m == "")continue;
                mobiles += m + ",";
            }
        }
        $("#mobile").val(mobiles);
    }
</script>
</body>
</html>