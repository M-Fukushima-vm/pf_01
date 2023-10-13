<template>
	<div>
		<v-speed-dial
			v-model="fab"
			:top="top"
			:bottom="bottom"
			:right="right"
			:left="left"
			:direction="direction"
			:open-on-hover="hover"
			:transition="transition"
		>
			<template v-slot:activator>
				<v-btn v-model="fab" color="info lighten-1 ml-7" dark fab>
					<v-icon v-if="fab"> mdi-close </v-icon>
					<v-icon v-else> mdi-message-alert </v-icon>
				</v-btn>
			</template>

			<v-row class="ml-n12">
				<v-col class="ml-n10 mr-10">
					<div class="mt-n3 pt-n3 mb-9 pb-4 ml-n12">
						<v-divider />
						<v-list-item-subtitle
							class="text-caption grey--text my-2 px-4"
							justify="center"
						>
							<span class="grey--text font-weight-bold">無料枠</span>の
							HackMDユーザー は
							<span class="error--text font-weight-bold">2,000 回/月</span>
							までの<br />
							<span class="error--text">APIコール数の制限</span>
							が設定されており、<br />
							・ (
							<span class="grey--text font-weight-bold">本文を含まない</span>
							)
							<span class="grey--text font-weight-bold"
								>概要リスト取得 … 1 回</span
							><br />
							・ ( <span class="grey--text font-weight-bold">本文を含む</span>
							)
							<span class="grey--text font-weight-bold"
								>個別データの取得 … 各 1 回</span
							><br />
							のコール数を消費します。<br />
							本アプリでは、安全性と上記制限の観点より<br />
							<span class="grey--text font-weight-bold">閲覧権限：全員</span>
							に設定されたデータのみ取り扱います。<br />
							まずは左の
							<span class="grey--text font-weight-bold">ARCHIVEボタン</span>
							より<br />
							<span class="grey--text font-weight-bold"
								>概要リストのアーカイブ</span
							>
							を作成して下さい。<br />
						</v-list-item-subtitle>
						<v-divider />
					</div>
				</v-col>
			</v-row>
			<!-- <v-spacer /> -->
		</v-speed-dial>
	</div>
</template>

<script>
export default {
	data: () => ({
		fab: false,
		top: false,
		bottom: true,
		right: true,
		left: false,
		direction: "right",
		hover: true,
		fling: false,
		tabs: null,
		transition: "slide-y-reverse-transition",
	}),

	watch: {
		top(val) {
			this.bottom = !val;
		},
		right(val) {
			this.left = !val;
		},
		bottom(val) {
			this.top = !val;
		},
		left(val) {
			this.right = !val;
		},
	},
};
</script>

<style lang="scss" scoped>
#create .v-speed-dial {
	position: absolute;
}

#create .v-btn--floating {
	position: relative;
}
</style>
