{% block content %}
  {######################}
  {### LINKS BLOCK ###}
  {######################}

<div id="links">
    <style>
        .links-content{
            margin-top:1rem;
        }

        .link-navigation::after {
            content: " ";
            display: block;
            clear: both;
        }

        .card {
            width: 45%;
            font-size: 1rem;
            padding: 10px 20px;
            border-radius: 4px;
            transition-duration: 0.15s;
            margin-bottom: 1rem;
            display:flex;
        }
        .card:nth-child(odd) {
            float: left;
        }
        .card:nth-child(even) {
            float: right;
        }
        .card:hover {
            transform: scale(1.1);
            box-shadow: 0 2px 6px 0 rgba(0, 0, 0, 0.12), 0 0 6px 0 rgba(0, 0, 0, 0.04);
            background-image: radial-gradient(circle at 65% 10%, rgb(230, 196, 141), rgb(71, 254, 185));
        }
        .card a {
            border:none;
        }
        .card .ava {
            width: 3rem!important;
            height: 3rem!important;
            margin:0!important;
            margin-right: 1em!important;
            border-radius:4px;

        }
        .card .card-header {
            font-style: italic;
            overflow: hidden;
            /*width: 236px;*/
        }
        .card .card-header a {
            font-style: normal;
            color: #2bbc8a;
            font-weight: bold;
            text-decoration: none;
        }
        .card .card-header a:hover {
            color: #d480aa;
            text-decoration: none;
        }
        .card .card-header .info {
            font-style:normal;
            color:#a3a3a3;
            font-size:14px;
            min-width: 0;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        span.focus-links {
            font-style: normal;
            margin-left: 10px;
            position: unset;
            left: 0;
            padding: 0 7px 0 5px;
            font-size: 11px;
            border-color: #42c02e;
            border-radius: 40px;
            line-height: 24px;
            height: 22px;
            color: #fff !important;
            background-color: #42c02e;
            display: inline-block;
        }

        .friends-btn{
            text-align: center;
            color: #555!important;
            background-color: #fff;
            border-radius: 3px;
            font-size: 15px;
            box-shadow: inset 0 0 10px 0 rgba(0,0,0,.35);
            border: none!important;
            transition-property: unset;
            padding: 0 15px;
            margin: inherit;
        }

        .friends-btn:hover{
            color: rgb(255, 255, 255) !important;
            border-radius: 3px;
            font-size: 15px;
            box-shadow: inset 0px 0px 10px 0px rgba(0, 0, 0, 0.35);
            background-image: linear-gradient(90deg, #a166ab 0%, #ef4e7b 25%, #f37055 50%, #ef4e7b 75%, #a166ab 100%);
            margin: inherit;
            }
        }
    </style>
    <div class="links-content">
        <div class="no-icon note warning" style="background-color: #fdf8ea">
            <div class="link-info">👨‍🎓 大佬 —— 没有不劳而获的工作，更没有坐享其成的收获</div>
        </div>
        <div class="link-navigation">
            {% for link in theme.mylinks_expert %}
                <div class="card">
                    <img class="ava" src="{{ link.avatar }}"/>
                    <div class="card-header">
                    <div><a href="{{ link.site }}" target="_blank"> {{ link.nickname }}</a> <a href="{{ link.site }}"><span class="focus-links">关注</span></a></div>
                    <div class="info">{{ link.info }}</div>
                    </div>
                </div>
            {% endfor %}
        </div>
        <div class="no-icon note primary" style="background-color: #f5f0fa">
            <div class="link-info">🌤️ 工具 —— 你的春日好运正在派件，请保持心情舒畅</div>
        </div>
        <div class="link-navigation">
            {% for link in theme.mylinks_tool %}
                <div class="card">
                    <img class="ava" src="{{ link.avatar }}"/>
                    <div class="card-header">
                    <div><a href="{{ link.site }}" target="_blank"> {{ link.nickname }}</a> <a href="{{ link.site }}"><span class="focus-links">关注</span></a></div>
                    <div class="info">{{ link.info }}</div>
                    </div>
                </div>
            {% endfor %}
        </div>
        <div class="no-icon note info" style="background-color: #eef7fa">
            <div class="link-info">🍀 论坛 —— 我欲穿花寻路，直入白云深处，浩气展虹霓</div>
        </div>
        <div class="link-navigation">
            {% for link in theme.mylinks_forum %}
                <div class="card">
                    <img class="ava" src="{{ link.avatar }}"/>
                    <div class="card-header">
                    <div><a href="{{ link.site }}" target="_blank"> {{ link.nickname }}</a> <a href="{{ link.site }}"><span class="focus-links">关注</span></a></div>
                    <div class="info">{{ link.info }}</div>
                    </div>
                </div>
            {% endfor %}
        </div>
        {{ page.content }}
    </div>
</div>

  {##########################}
  {### END LINKS BLOCK ###}
  {##########################}
{% endblock %}