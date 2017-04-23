{**
 * Блок "похожие топики по тегам"
 *
 * @param array  $topics
 *}

{$plugin = 'topicsimilar'}
{component_define_params params=[ 'topics', 'style' ]}


{cfg "plugin.$plugin.block.style" assign='style'}
{cfg "plugin.$plugin.style.$style" assign='options'}


{capture 'similar_content'}
    {$template = $LS->Component_GetTemplatePath("$plugin:goweb-topic", "style-{$style}")}

    {if $template}
        {component "$plugin:goweb-topic.style-$style" options=$options topics=$topics}
    {else}
        {component "$plugin:goweb-topic.style-list" options=$options topics=$topics}
    {/if}
{/capture}


{component 'block'
    mods     = 'similar-topics'
    classes  = 'js-block-default'
    title    = {lang 'plugin.topicsimilar.block.title'}
    content  = $smarty.capture.similar_content}
