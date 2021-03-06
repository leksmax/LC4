<% do_pagehead1(); %>
<html>
    <head>
    <title><% nv_get("model"); %> - Graph</title>
    <%do_headmeta();%>

    <%do_basic_css();%>
    <%do_custom_css();%>

    <%do_custom_js();%>
    <%do_basic_js();%>

    <link rel='stylesheet' type='text/css' href='ext/css/jquery.jqplot.css' />
    <!--[if lt IE 9]><script language='javascript' type='text/javascript' src='ext/js/jqPlot/excanvas.js'></script><![endif]-->
    <script language='javascript' type='text/javascript' src='ext/js/date.js'></script>
    <script language='javascript' type='text/javascript' src='ext/js/jqPlot/jquery.jqplot.min.js'></script>
    <script language='javascript' type='text/javascript' src='ext/js/jqPlot/plugins/jqplot.highlighter.min.js'></script>
    <script language='javascript' type='text/javascript' src='ext/js/jqPlot/plugins/jqplot.cursor.min.js'></script>
    <script language='javascript' type='text/javascript' src='ext/js/jqPlot/plugins/jqplot.dateAxisRenderer.min.js'></script>

    <script type="text/javascript">
        function SelInterval(F) {
            F.submit_button.value = "st_ct";
            F.action.value = "Gozila";
            F.submit();
        }
        function init(){
            try {
            <%st_mrtg_show("graph", "ct");%>
            var Interval_Sec = $('select#stats_interval option:selected').val();

            /* ##### Total Connection ##### */
            var NowTime_total = Date.parse("now");
            var DataArray_total = new Array();
            var X_DATA_total = new Array();
            var Y_DATA_total = new Array();
                
            var StartTime_total = NowTime_total.add({seconds: -1 * Interval_Sec * mrtg_data['total'].points_0.length });

            for (i=0;i<mrtg_data['total'].points_0.length;i++ ){
                Tmp_Time_total = StartTime_total.add({seconds: Interval_Sec});
                X_DATA_total_Tmp = Tmp_Time_total.toString("yyyy-MM-dd HH:mm:ss"); 
                Y_DATA_total_Tmp =  mrtg_data['total'].points_1[i];
                X_DATA_total[i] = X_DATA_total_Tmp;
                Y_DATA_total[i] = Y_DATA_total_Tmp;
                DataArray_total[i] = [ X_DATA_total_Tmp, Y_DATA_total_Tmp];
            }//End for
                
            DateTime_Min = X_DATA_total[0];
            DateTime_Max = X_DATA_total[mrtg_data['total'].points_1.length-1];

            var Y_DATA_total_Min = Math.min.apply(Math, Y_DATA_total);
            var Y_DATA_total_Max = Math.max.apply(Math, Y_DATA_total);

            /* ##### tcp Connection ##### */
            var NowTime_tcp = Date.parse("now");
            var DataArray_tcp=new Array();
            var X_DATA_tcp = new Array();
            var Y_DATA_tcp = new Array();
            var StartTime_tcp = NowTime_tcp.add({seconds: -1 * Interval_Sec * mrtg_data['tcp'].points_1.length });

            for (i=0;i<mrtg_data['tcp'].points_1.length;i++ ){
                Tmp_Time_tcp = StartTime_tcp.add({seconds: Interval_Sec});
                X_DATA_tcp_Tmp = Tmp_Time_tcp.toString("yyyy-MM-dd HH:mm:ss");
                Y_DATA_tcp_Tmp = mrtg_data['tcp'].points_1[i];
                X_DATA_tcp[i] = X_DATA_tcp_Tmp;
                Y_DATA_tcp[i] = Y_DATA_tcp_Tmp;
                DataArray_tcp[i] = [X_DATA_tcp_Tmp, Y_DATA_tcp_Tmp];
            }//End for

            var Y_DATA_tcp_Min = Math.min.apply(Math, Y_DATA_tcp);
            var Y_DATA_tcp_Max = Math.max.apply(Math, Y_DATA_tcp);


            /* ##### udp Connection ##### */
            var NowTime_udp = Date.parse("now");
            var DataArray_udp=new Array();
            var X_DATA_udp = new Array();
            var Y_DATA_udp = new Array();

            var StartTime_udp = NowTime_udp.add({seconds: -1 * Interval_Sec * mrtg_data['udp'].points_1.length });
            for (i=0;i<mrtg_data['udp'].points_1.length;i++ ){
                Tmp_Time_udp = StartTime_udp.add({seconds: Interval_Sec});
                X_DATA_udp_Tmp = Tmp_Time_udp.toString("yyyy-MM-dd HH:mm:ss");
                Y_DATA_udp_Tmp = mrtg_data['udp'].points_1[i];
                X_DATA_udp[i] = X_DATA_udp_Tmp;
                Y_DATA_udp[i] = Y_DATA_udp_Tmp;
                DataArray_udp[i] = [X_DATA_udp_Tmp, Y_DATA_udp_Tmp];
            }//End for

            var Y_DATA_udp_Min = Math.min.apply(Math, Y_DATA_udp);
            var Y_DATA_udp_Max = Math.max.apply(Math, Y_DATA_udp);

            /* ##### icmp Connection ##### */
            var NowTime_icmp = Date.parse("now");
            var DataArray_icmp=new Array();
            var X_DATA_icmp = new Array();
            var Y_DATA_icmp = new Array();

            var StartTime_icmp = NowTime_icmp.add({seconds: -1 * Interval_Sec * mrtg_data['icmp'].points_1.length });

            for (i=0;i<mrtg_data['icmp'].points_1.length;i++ ){
                Tmp_Time_icmp = StartTime_icmp.add({seconds: Interval_Sec});
                X_DATA_icmp_Tmp = Tmp_Time_icmp.toString("yyyy-MM-dd HH:mm:ss");
                Y_DATA_icmp_Tmp = mrtg_data['icmp'].points_1[i];
                X_DATA_icmp[i] = X_DATA_icmp_Tmp;
                Y_DATA_icmp[i] = Y_DATA_icmp_Tmp;
                DataArray_icmp[i] = [X_DATA_icmp_Tmp, Y_DATA_icmp_Tmp];
            }//End for

            var Y_DATA_icmp_Min = Math.min.apply(Math, Y_DATA_icmp);
            var Y_DATA_icmp_Max = Math.max.apply(Math, Y_DATA_icmp);

            /* ##### Start Draw Graph ##### */
            var Y_DATA_Min = Math.min(Y_DATA_total_Min, Y_DATA_tcp_Min, Y_DATA_udp_Min, Y_DATA_icmp_Min);
            var Y_DATA_Max = Math.max(Y_DATA_total_Max, Y_DATA_tcp_Max, Y_DATA_udp_Max, Y_DATA_icmp_Max);
            var colors = ['#6495ed', '#118811', '#cf0000', '#b8860b', '#ff0000'];

            var plot1 = $.jqplot('graph', [DataArray_total,DataArray_tcp,DataArray_udp,DataArray_icmp], {
                //title:'Data Point Highlighting',
                seriesColors: colors,				
                series:[ 
                    {
                        showMarker:false,
                        lineWidth:2, 
                    }, 
                    {
                        showMarker:false,
                        lineWidth:2, 
                    }, 
                    {
                        showMarker:false,
                        lineWidth:2, 
                    }, 
                    {
                        showMarker:false,
                        lineWidth:2, 
                    }
                ],

                axes:{
                    xaxis:{
                        renderer:$.jqplot.DateAxisRenderer,
                        min:DateTime_Min,
                        max:DateTime_Max,
                            tickOptions:{show: false, formatString:'%m/%d %X'},
                        //tickInterval:'6 hour'
                       },
                       yaxis:{
                        min:Y_DATA_Min,
                        max:Y_DATA_Max,
                        tickOptions:{formatString:'%d'}
                        //tickInterval:'0.1'
                    }
                },
                highlighter: {
                        show: false,
                    sizeAdjust: 7.5
                },
                cursor: {
                    show: true,
                    tooltipLocation:'sw'
                }
            }); //End plot1
            
            $("#total-current").html(mrtg_data['total'].cur);
            $("#total-max-seen-life-time").html(mrtg_data['total'].lifetime_max);
            $("#total-max-seen").html(mrtg_data['total'].max);
            $("#total-opened").html(mrtg_data['total'].opened);
            $("#total-closed").html(mrtg_data['total'].opened - mrtg_data['total'].cur);
            $("#tcp-current").html(mrtg_data['tcp'].cur);
            $("#tcp-max-seen-life-time").html(mrtg_data['tcp'].lifetime_max);
            $("#tcp-max-seen").html(mrtg_data['tcp'].max);
            $("#tcp-opened").html(mrtg_data['tcp'].opened);
            $("#tcp-closed").html(mrtg_data['tcp'].opened - mrtg_data['tcp'].cur);
            $("#udp-current").html(mrtg_data['udp'].cur);
            $("#udp-max-seen-life-time").html(mrtg_data['udp'].lifetime_max);
            $("#udp-max-seen").html(mrtg_data['udp'].max);
            $("#udp-opened").html(mrtg_data['udp'].opened);
            $("#udp-closed").html(mrtg_data['udp'].opened - mrtg_data['udp'].cur);
            $("#icmp-current").html(mrtg_data['icmp'].cur);
            $("#icmp-max-seen-life-time").html(mrtg_data['icmp'].lifetime_max);
            $("#icmp-max-seen").html(mrtg_data['icmp'].max);
            $("#icmp-opened").html(mrtg_data['icmp'].opened);
            $("#icmp-closed").html(mrtg_data['icmp'].opened - mrtg_data['icmp'].cur);

            } 
            catch (ex) {
                    mrtg_data = {};
            }
            Refresh();
        }

        var value=0;
        function Refresh() {
            if (value) {
                window.location.replace("st_ct.asp");
            }
            value++;
            setTimeout("Refresh()",60000);
        }

        $(document).ready(function () {
            init();
        });

    </script>
    </head>

    <body>
    <div class="container">
        <%do_bootstrap_menu();%>
        <script type="text/javascript">create_waiting_window();</script>

        <form name="form" id="form" action="apply.cgi" method="post">
              <input type="hidden" name="submit_button" />
              <input type="hidden" name="action" />
              <input type="hidden" name="stats_proto" value="all"/>

                <h2><%lang("Status");%>-<%lang("Session");%> (<%lang("Max Allowed");%>: <%nvg_get("ct_max");%>)</h2>

        <div class="row">
            <div class="span12">

                <div class="row show-grid">
                    <div class="span4"><% lang("Graph Scale"); %></div>
                    <div class="span8">
                        <select name="stats_interval" id="stats_interval" onchange="SelInterval(this.form)">
                          <option value="60" <% nvg_match("stats_interval", "60", "selected"); %>><%lang("Two Hours");%></option>
                          <option value="600" <% nvg_match("stats_interval", "600", "selected"); %>><%lang("One Day");%></option>
                          <option value="3600" <% nvg_match("stats_interval", "3600", "selected"); %>><%lang("One Week");%></option>
                          <option value="21600" <% nvg_match("stats_interval", "21600", "selected"); %>><%lang("One Month");%></option>
                        </select>
                    </div>
                </div>
        
            </div>
        </div><!-- row -->
        <br>

        <div class="row">
            <div class="span12" style="">
                <div id="graph"></div>
                <br>
                <small>
                  <font color=#6495ed><%lang("Total Sessions");%></font>&nbsp;&nbsp;
                  <font color=#118811><%lang("TCP Sessions");%></font>&nbsp;&nbsp;
                  <font color=#cf0000><%lang("UDP Sessions");%></font>&nbsp;&nbsp;
                  <font color=#b8860b><%lang("ICMP Sessions");%></font>&nbsp;&nbsp;
                </small>
            </div>
        </div><!-- row -->
        <br>

        <div class="row">
            <div class="span6">
                <legend><%lang("Total Sessions");%></legend>
                <div class="row show-grid">
                    <div class="span3"><%lang("Current");%></div>
                    <div class="span3"><div id="total-current"></div></div>
                </div>

                <div class="row show-grid">
                    <div class="span3"><%lang("Max Seen");%> (<%lang("Since Boot");%>)</div>
                    <div class="span3"><div id="total-max-seen-life-time"></div></div>
                </div>
            
                <div class="row show-grid">
                    <div class="span3"><%lang("Max Seen");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="total-max-seen"></div></div>
                </div>
            
                <div class="row show-grid">
                    <div class="span3"><%lang("Opened");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="total-opened"></div></div>
                </div>
            
                <div class="row show-grid">
                    <div class="span3"><%lang("Closed");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="total-closed"></div></div>
                </div>
            
            </div>

            <div class="span6">
                <legend><%lang("TCP Sessions");%></legend>
                <div class="row show-grid">
                    <div class="span3"><%lang("Current");%></div>
                    <div class="span3"><div id="tcp-current"></div></div>
                </div>

                <div class="row show-grid">
                    <div class="span3"><%lang("Max Seen");%> (<%lang("Since Boot");%>)</div>
                    <div class="span3"><div id="tcp-max-seen-life-time"></div></div>
                </div>

                <div class="row show-grid">
                    <div class="span3"><%lang("Max Seen");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="tcp-max-seen"></div></div>
                </div>

                <div class="row show-grid">
                    <div class="span3"><%lang("Opened");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="tcp-opened"></div></div>
                </div>

                <div class="row show-grid">
                    <div class="span3"><%lang("Closed");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="tcp-closed"></div></div>
                </div>

            </div>

        </div><!-- row -->
        <br>


        <div class="row">
            <div class="span6">
                <legend><%lang("UDP Sessions");%></legend>
                <div class="row show-grid">
                    <div class="span3"><%lang("Current");%></div>
                    <div class="span3"><div id="udp-current"></div></div>
                </div>            

                <div class="row show-grid">
                    <div class="span3"><%lang("Max Seen");%> (<%lang("Since Boot");%>)</div>
                    <div class="span3"><div id="udp-max-seen-life-time"></div></div>
                </div>            

                <div class="row show-grid">
                    <div class="span3"><%lang("Max Seen");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="udp-max-seen"></div></div>
                </div>            

                <div class="row show-grid">
                    <div class="span3"><%lang("Opened");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="udp-opened"></div></div>
                </div>            

                <div class="row show-grid">
                    <div class="span3"><%lang("Closed");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="udp-closed"></div></div>
                </div>            

            </div>


            <div class="span6">
                <legend><%lang("ICMP Sessions");%></legend>
                <div class="row show-grid">
                    <div class="span3"><%lang("Current");%></div>
                    <div class="span3"><div id="icmp-current"></div></div>
                </div> 

                <div class="row show-grid">
                    <div class="span3"><%lang("Max Seen");%> (<%lang("Since Boot");%>)</div>
                    <div class="span3"><div id="icmp-max-seen-life-time"></div></div>
                </div>            

                <div class="row show-grid">
                    <div class="span3"><%lang("Max Seen");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="icmp-max-seen"></div></div>
                </div>            

                <div class="row show-grid">
                    <div class="span3"><%lang("Opened");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="icmp-opened"></div></div>
                </div>            

                <div class="row show-grid">
                    <div class="span3"><%lang("Closed");%> (<%st_show_period());%>)</div>
                    <div class="span3"><div id="icmp-closed"></div></div>
                </div>            
                
            </div>

        </div><!-- row -->

        </form>
        
        <div class="row">
            <div class="span12">
                   <script type="text/javascript">
                        <%show_copyright();%>
                    </script>
            </div>
        </div><!-- row -->

    </div> <!-- /container -->

</body></html>