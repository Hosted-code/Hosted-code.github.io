{% macro render(posts) %}
{%- set current_year = '1970' %}
{%- for post in posts.toArray() %}

  {%- set year = date(post.date, 'YYYY') %}

  {%- if year !== current_year %}
    {%- set current_year = year %}
    <div class="collection-year">
      <{%- if theme.seo %}h2{% else %}h1{%- endif %} class="collection-header">{{ current_year }}</{%- if theme.seo %}h2{% else %}h1{%- endif %}>
    </div>
  {%- endif %}

  <article class="my-post post-type-{{ post.type | default('normal') }}" itemscope itemtype="http://schema.org/Article">
    <header class="my-post-header">

      <div class="my-post-meta">
        <time class="my-post-time" itemprop="dateCreated"
              datetime="{{ moment(post.date).format() }}"
              content="{{ date(post.date, config.date_format) }}">
          {{ date(post.date, 'MM-DD') }}
        </time>
      </div>

      <{%- if theme.seo %}h3{% else %}h2{%- endif %} class="my-post-title">
        {%- if post.link %}{# Link posts #}
          {%- set postTitleIcon = '<i class="fa fa-external-link"></i>' %}
          {%- set postText = post.title or post.link %}
          {{ next_url(post.link, postText + postTitleIcon, {class: 'my-post-title-link post-title-link-external', itemprop: 'url'}) }}
        {% else %}
          <a class="my-post-title-link" href="{{ url_for(post.path) }}" itemprop="url">
            <span itemprop="name">{{ post.title or __('post.untitled') }}</span>
          </a>
        {%- endif %}
      </{%- if theme.seo %}h3{% else %}h2{%- endif %}>

    </header>
  </article>

{%- endfor %}
{% endmacro %}
