{**
 * Стиль блока "Список"
 *}

{$component = 'ls-topic-similar'}
{component_define_params params=[ 'topics', 'options' ]}


{$options = $options|default:[]}
{$items = []}


{foreach $topics as $topic}
    {$user = $topic->getUser()}

    {capture 'item_content'}
        <ul class="{$component}-info">
            <li>
                <a href="{$user->getUserWebPath()}" class="{$component}-user">{$user->getDisplayName()}</a>
            </li>
            <li>
                <time datetime="{date_format date=$topic->getDatePublish() format='c'}" class="{$component}-date">
                    {date_format date=$topic->getDatePublish() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y"}
                </time>
            </li>
            <li>
                <a href="{$topic->getUrl()}#comments" class="{$component}-comments">
                    {component 'icon' icon='comments'}
                    {lang 'comments.comments_declension' count=$topic->getCountComment() plural=true}
                    {if $topic->getCountCommentNew()}
                        <span>+{$topic->getCountCommentNew()}</span>
                    {/if}
                </a>
            </li>
        </ul>
    {/capture}

    {if $options.avatar_use}
        {$itemImage = [
            'path' => $user->getProfileAvatarPath(48),
            'url'  => $user->getUserWebPath()
        ]}
    {/if}

    {$items[] = [
        'element' => 'li',
        'mods'    => 'image-rounded',
        'image'   => $itemImage,
        'title'   => $topic->getTitle(),
        'titleUrl'=> $topic->getUrl(),
        'content' => $smarty.capture.item_content
    ]}
{foreachelse}
    {component 'blankslate' text={lang 'common.empty'} mods='no-background'}
{/foreach}


{component 'item' template='group' items=$items}