<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";

%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>mytitle</title>
    <script src="ECharts/echarts.min.js"></script>
    <script src="jquery/jquery-1.11.1-min.js"></script>

    <script>

        $(function () {

            //页面加载完毕后，绘制统计图表
            getCharts();

        })

        function getCharts() {
            $.ajax({
                url: "workbench/transaction/getCharts.do",
                dataType: "json",
                type: "get",
                success: function (data) {
                /*
                data:{"total":total,"datalist":[{1}{2}...]}
                 */


                    var myChart = echarts.init(document.getElementById('main'));
                    var option = {
                        title: {
                            text: '交易漏斗图',
                            subtext: '统计交易阶段数量的漏斗图'
                        },

                        toolbox: {
                            feature: {
                                dataView: { readOnly: false },
                                restore: {},
                                saveAsImage: {}
                            }
                        },
                        legend: {
                            data: ['Show', 'Click', 'Visit', 'Inquiry', 'Order']
                        },
                        series: [
                            {
                                name: 'Funnel',
                                type: 'funnel',
                                left: '10%',
                                top: 60,
                                bottom: 60,
                                width: '80%',
                                min: 0,
                                max: data.total,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data:data.datalist
                                //     [
                                //     // { value: 60, name: 'Visit' },
                                //     // { value: 40, name: 'Inquiry' },
                                //     // { value: 20, name: 'Order' },
                                //     // { value: 80, name: 'Click' },
                                //     // { value: 100, name: 'Show' }
                                // ]
                            }
                        ]
                    };
                    myChart.setOption(option);
                }

            })







        }

    </script>
</head>
<body>

    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div id="main" style="width: 600px;height:400px;"></div>

</body>
</html>



























































