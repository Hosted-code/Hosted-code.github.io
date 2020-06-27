{%- set ccIcon = '<i class="fa fa-fw fa-creative-commons"></i>' %}
{%- set ccText = theme.creative_commons.license | upper %}
{%- set ccLink =  page.link or page.permalink %}
<script src="//cdn.bootcss.com/clipboard.js/1.5.10/clipboard.min.js"></script>
<div>
<ul class="my-post-copyright">
    <li class="post-copyright-title">
    <strong>{{ __('本文标题') + __('symbol.colon') }} </strong>
    {{- page.title or title }}
    </li>
  <li class="post-copyright-author">
    <strong>{{ __('post.copyright.author') + __('symbol.colon') }} </strong>
    {{- page.author or author }}
  </li>
  <li class="post-copyright-date">
    <strong>{{ __('发布时间') + __('symbol.colon') }} </strong>
     {{-page.date.format("YYYY年MM月DD日 - HH:mm:ss")}} 
  </li>
  <li class="post-copyright-update">
    <strong>{{ __('最后更新') + __('symbol.colon') }} </strong>
    {{- page.updated.format("YYYY年MM月DD日 - HH:mm:ss") or page.date.format("YYYY年MM月DD日 - HH:mm:ss") }}
  </li>
  <li class="post-copyright-link">
    <strong>{{ __('post.copyright.link') + __('symbol.colon') }}</strong>
    {{ next_url(ccLink, ccLink, {title: page.title}) }}
    <span class="copy-path"  title="点击复制文章链接"><i class="fa fa-clipboard" data-clipboard-text="{{ ccLink }}"  aria-label="复制成功！"></i></span>
  </li>
  <li class="post-copyright-license">
    <strong>{{ __('post.copyright.license_title') + __('symbol.colon') }} </strong>
    {{- __('post.copyright.license_content', next_url(ccURL, ccIcon + ccText)) }}
  </li>
</ul>
</div>
<style>
.my-post-copyright {
    width: 85%;
    max-width: 45em;
    margin: 2.8em auto 0;
    padding: .5em 1em;
    border: 1px solid #d3d3d3;
    font-size: .93rem;
    line-height: 1.6em;
    word-break: break-all;
    background: rgba(255,255,255,.4);
    box-shadow: 0 0 10px rgba(0,0,0,.12);
    color: #555;
}
</style>
<script> 
    var clipboard = new Clipboard('.fa-clipboard');
    clipboard.on('success', function(){
      $(".fa-clipboard").click(function(){
        swal({   
          title: "",   
          text: '复制成功',   
          html: false,
          timer: 500,   
          showConfirmButton: false
        });
      });
    });  
</script>
