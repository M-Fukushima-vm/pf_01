module Redcarpet::MdToHtml
	extend self

	require 'rouge/plugins/redcarpet'

  class HTML < Redcarpet::Render::HTML
		include Rouge::Plugins::Redcarpet
	end

  def change_html(text)
    render_options = {
      filter_html:         true, # ユーザーが入力したhtmlを出力しない
      hard_wrap:           true, # 改行をhtmlの<br>に置き換え
      space_after_headers: true  # ヘッダー記号(#)と文字の間にスペース必要
    }
    renderer = HTML.new(render_options)
  
    extensions = {
      autolink:           true, # 自動でリンク化
      fenced_code_blocks: true, # コードを表す「```」を認識
      no_intra_emphasis:  true, # 文字の強調を無視
      strikethrough:      true, # 取り消し線を表す「~~」を認識
      superscript:        true, # 上つき文字を表す「^」を認識
      tables:             true, # テーブルを認識
      escape_html:        true, # xss対策 全てのHTMLタグをエスケープ(filter_htmlより優先) 
      quote:              true  # xss対策 引用符を表す「""」を認識
    }
		
		# マークダウンをHTMLに変換
    html_output = Redcarpet::Markdown.new(renderer, extensions).render(text)

		# Tiptap向けに、コードブロックを変換
		formatted_output = html_output.gsub(/<div class="highlight"><pre class="highlight (.*?)"><code>(.*?)<\/code><\/pre><\/div>|<code.*?>(.*?)<\/code>/m) do
			language = Regexp.last_match(1)
			code_block = Regexp.last_match(2) || Regexp.last_match(3)
			
			if language
				code_block.rstrip! # 末尾の空白を削除
				code_block.gsub!(/<span.*?>(.*?)<\/span>/m, '\1') # <span>タグを削除
				"<pre><code class=\"language-#{language}\">#{code_block}</code></pre>"
			else
				code_block.gsub(/<span.*?>(.*?)<\/span>/m, '\1') # <span>タグを削除
			end
		end

    formatted_output.html_safe

		# debugger
  end
end