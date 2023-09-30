<template>
	<div>
		<div v-if="editor">
			<!-- <button
				@click="editor.chain().focus().toggleCodeBlock().run()"
				:class="{ 'is-active': editor.isActive('codeBlock') }"
			>
				code block
			</button> -->
			<!-- <button
				@click="editor.chain().focus().toggleCodeBlock().run()"
				:class="{ 'is-active': editor.isActive('codeBlock') }"
			>
				toggleCodeBlock
			</button>
			<button
				@click="editor.chain().focus().setCodeBlock().run()"
				:disabled="editor.isActive('codeBlock')"
			>
				setCodeBlock
			</button> -->

			<bubble-menu
				class="bubble-menu"
				:tippy-options="{ duration: 100 }"
				:editor="editor"
			>
				<button
					@click="editor.chain().focus().toggleBold().run()"
					:class="{ 'is-active': editor.isActive('bold') }"
				>
					Bold
				</button>
				<button
					@click="editor.chain().focus().toggleItalic().run()"
					:class="{ 'is-active': editor.isActive('italic') }"
				>
					Italic
				</button>
				<button
					@click="editor.chain().focus().toggleStrike().run()"
					:class="{ 'is-active': editor.isActive('strike') }"
				>
					Strike
				</button>
			</bubble-menu>

			<floating-menu
				class="floating-menu"
				:tippy-options="{ duration: 100 }"
				:editor="editor"
			>
				<button
					@click="editor.chain().focus().toggleHeading({ level: 1 }).run()"
					:class="{ 'is-active': editor.isActive('heading', { level: 1 }) }"
				>
					H1
				</button>
				<button
					@click="editor.chain().focus().toggleHeading({ level: 2 }).run()"
					:class="{ 'is-active': editor.isActive('heading', { level: 2 }) }"
				>
					H2
				</button>
				<button
					@click="editor.chain().focus().toggleBulletList().run()"
					:class="{ 'is-active': editor.isActive('bulletList') }"
				>
					Bullet List
				</button>
			</floating-menu>
		</div>

		<editor-content :editor="editor" />

		<div class="character-count" v-if="editor">
			{{ editor.storage.characterCount.characters() }}/{{ limit }}
		</div>
	</div>
</template>

<script>
import StarterKit from "@tiptap/starter-kit";
import { Editor, EditorContent, BubbleMenu, FloatingMenu } from "@tiptap/vue-2";
import CharacterCount from "@tiptap/extension-character-count";
import CodeBlockLowlight from "@tiptap/extension-code-block-lowlight";

// node_modules/lowlight/lib/common.js からimportする言語
import bash from "highlight.js/lib/languages/bash";
import css from "highlight.js/lib/languages/css";
import go from "highlight.js/lib/languages/go";
import javascript from "highlight.js/lib/languages/javascript";
import json from "highlight.js/lib/languages/json";
import markdown from "highlight.js/lib/languages/markdown";
import php from "highlight.js/lib/languages/php";
import python from "highlight.js/lib/languages/python";
import ruby from "highlight.js/lib/languages/ruby";
import scss from "highlight.js/lib/languages/scss";
import shell from "highlight.js/lib/languages/shell";
import sql from "highlight.js/lib/languages/sql";
import swift from "highlight.js/lib/languages/swift";
import typescript from "highlight.js/lib/languages/typescript";
import xml from "highlight.js/lib/languages/xml";
import yaml from "highlight.js/lib/languages/yaml";

import { lowlight } from "lowlight/lib/common.js";

// コードブロック末尾 ```の後の文字列に↑のimport言語の何を設定するか (同じく common.js から)
lowlight.registerLanguage("bash", bash);
lowlight.registerLanguage("css", css);
lowlight.registerLanguage("go", go);
lowlight.registerLanguage("js", javascript);
lowlight.registerLanguage("json", json);
lowlight.registerLanguage("md", markdown);
lowlight.registerLanguage("php", php);
lowlight.registerLanguage("python", python);
lowlight.registerLanguage("ruby", ruby);
lowlight.registerLanguage("scss", scss);
lowlight.registerLanguage("shell", shell);
lowlight.registerLanguage("sql", sql);
lowlight.registerLanguage("swift", swift);
lowlight.registerLanguage("ts", typescript);
lowlight.registerLanguage("html", xml);
lowlight.registerLanguage("yaml", yaml);

export default {
	components: {
		EditorContent,
		BubbleMenu,
		FloatingMenu,
	},
	props: {
		value: {
			type: String,
			default: "",
		},
	},
	data() {
		return {
			editor: null,
			limit: 5000,
		};
	},
	// created() {
	// 	console.log(lowlight);
	// },
	watch: {
		value(value) {
			// HTML
			// const isSame = this.editor.getHTML() === value

			// JSON
			const isSame =
				JSON.stringify(this.editor.getJSON()) === JSON.stringify(value);

			if (isSame) {
				return;
			}
			this.editor.commands.setContent(value, false);
		},
	},

	mounted() {
		this.editor = new Editor({
			content: this.value,
			extensions: [
				// StarterKit,
				StarterKit.configure({
					codeBlock: false,
				}),
				CharacterCount.configure({
					limit: this.limit,
				}),
				CodeBlockLowlight.configure({
					lowlight,
				}),
			],
			onUpdate: () => {
				// HTML
				// this.$emit('input', this.editor.getHTML())

				// JSON
				this.$emit("input", this.editor.getJSON());
			},
		});
	},

	beforeDestroy() {
		this.editor.destroy();
	},
};
</script>

<style lang="scss">
/* Basic editor styles */
.tiptap {
	> * + * {
		margin-top: 0.75em;
	}

	pre {
		background: #0d0d0d;
		color: #fff;
		font-family: "JetBrainsMono", monospace;
		padding: 0.75rem 1rem;
		border-radius: 0.5rem;

		code {
			color: inherit;
			padding: 0;
			background: none;
			font-size: 0.8rem;
		}

		.hljs-comment,
		.hljs-quote {
			color: #616161;
		}

		.hljs-variable,
		.hljs-template-variable,
		.hljs-attribute,
		.hljs-tag,
		.hljs-name,
		.hljs-regexp,
		.hljs-link,
		.hljs-name,
		.hljs-selector-id,
		.hljs-selector-class {
			color: #f98181;
		}

		.hljs-number,
		.hljs-meta,
		.hljs-built_in,
		.hljs-builtin-name,
		.hljs-literal,
		.hljs-type,
		.hljs-params {
			color: #fbbc88;
		}

		.hljs-string,
		.hljs-symbol,
		.hljs-bullet {
			color: #b9f18d;
		}

		.hljs-title,
		.hljs-section {
			color: #faf594;
		}

		.hljs-keyword,
		.hljs-selector-tag {
			color: #70cff8;
		}

		.hljs-emphasis {
			font-style: italic;
		}

		.hljs-strong {
			font-weight: 700;
		}
	}

	ul,
	ol {
		padding: 0 1rem;
	}

	blockquote {
		padding-left: 1rem;
		border-left: 2px solid rgba(#0d0d0d, 0.1);
	}
}

.bubble-menu {
	display: flex;
	background-color: #0d0d0d;
	padding: 0.2rem;
	border-radius: 0.5rem;

	button {
		border: none;
		background: none;
		color: #fff;
		font-size: 0.85rem;
		font-weight: 500;
		padding: 0 0.2rem;
		opacity: 0.6;

		&:hover,
		&.is-active {
			opacity: 1;
		}
	}
}

.floating-menu {
	display: flex;
	background-color: #0d0d0d10;
	padding: 0.2rem;
	border-radius: 0.5rem;

	button {
		border: none;
		background: none;
		font-size: 0.85rem;
		font-weight: 500;
		padding: 0 0.2rem;
		opacity: 0.6;

		&:hover,
		&.is-active {
			opacity: 1;
		}
	}
}

.character-count {
	margin-top: 1rem;
	color: #868e96;
}
</style>
