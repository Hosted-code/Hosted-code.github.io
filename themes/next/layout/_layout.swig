<!DOCTYPE html>
<html lang="{{ config.language }}">
<head>
  {{ partial('_partials/head/head.swig', {}, {cache: theme.cache.enable}) }}
  {% include '_partials/head/head-unique.swig' %}
  {{- next_inject('head') }}
  <title>{% block title %}{% endblock %}</title>
  {{ partial('_third-party/analytics/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_scripts/noscript.swig', {}, {cache: theme.cache.enable}) }}
  <link rel="stylesheet" href="/dist/css/share.min.css">
</head>

<body itemscope itemtype="http://schema.org/WebPage">
  <div class="container{%- if theme.motion.enable %} use-motion{%- endif %}">
    <div class="headband"></div>

    <header class="header" itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner">{% include '_partials/header/index.swig' %}</div>
    </header>

    {{ partial('_partials/widgets.swig', {}, {cache: theme.cache.enable}) }}

    <main class="main">
      <div class="main-inner">
        <div class="content-wrap">
          {% include '_partials/header/sub-menu.swig' %}
          <div class="content">
            {% block content %}{% endblock %}
          </div>
          {% include '_partials/comments.swig' %}
        </div>
        {%- if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {%- endif %}
      </div>
    </main>

    <footer class="footer">
      <div class="footer-inner">
        {{ partial('_partials/footer.swig', {}, {cache: theme.cache.enable}) }}
        {{ partial('_third-party/statistics/index.swig', {}, {cache: theme.cache.enable}) }}
      </div>
    </footer>
  </div>

  {{ partial('_scripts/index.swig', {}, {cache: theme.cache.enable}) }}
  {{ partial('_third-party/index.swig', {}, {cache: theme.cache.enable}) }}

  {%- if theme.pjax %}
    <div id="pjax">
  {%- endif %}
  {% include '_third-party/math/index.swig' %}
  {% include '_third-party/quicklink.swig' %}

  {{- next_inject('bodyEnd') }}
  {%- if theme.pjax %}
    </div>
  {%- endif %}
   <!--崩溃欺骗-->
  {% if theme.crashcheat %}
    <script type="text/javascript" src="/js/src/crash_cheat.js"></script>
  {% endif %}
  <!-- 点击特效 -->
  {% if theme.click_effect.enabled %}
    {% if theme.click_effect.type == "fireworks" %}
      <script src="/js/src/fireworks.js"></script>
    {% elseif theme.click_effect.type == "explosion" %}
      <canvas class="fireworks" style="position: fixed;left: 0;top: 0;z-index: 1; pointer-events: none;" ></canvas>
      <script src="//cdn.bootcss.com/animejs/2.2.0/anime.min.js"></script>
      <script src="/js/src/explosion.min.js"></script>
    {% elseif theme.click_effect.type == "love" %}
      <script src="/js/src/love.min.js"></script>
    {% elseif theme.click_effect.type == "text" %}
      <script src="/js/src/text.js"></script>
    {% endif %}
  {% endif %}
  <!-- 背景特效 -->
  {% if theme.particle %}
  <script type="text/javascript" src="/js/src/particle.js"></script>
  {% endif %}
  <!-- 分享功能 -->
  <script src="/dist/js/social-share.min.js"></script>
  <!-- 卡片链接 -->
  <script type="text/javascript" src="/js/src/linkcard.js"></script>
</body>
</html>
