{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ page.title }} | {{ title }}{% endblock %}

{% block content %}
<div class="posts-expand">
    {{ partial('_macro/post.swig', {post: page}) }}
    <div class="post-spread">
    <!-- 引入share.js -->
        {% if theme.share_js%}
               <center><div data-weibo-title="分享到微博" data-qq-title="分享到QQ" data-douban-title="分享到豆瓣" class="social-share" class="share-component" data-disabled="twitter,facebook" data-description="Share.js - 一键分享到微博，QQ空间，腾讯微博，人人，豆瓣">分享到：</div></center>
        {% endif %}
    </div>
</div>

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(true) }}
{% endblock %}
