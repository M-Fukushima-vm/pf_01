<template>
	<div>
		<v-list-item-group>
			<v-list-item link class="px-1 mx-1">
				<v-list-item-icon>
					<v-icon>mdi-folder</v-icon>
				</v-list-item-icon>
				<v-list-item-title>My Files</v-list-item-title>
			</v-list-item>
			<v-list-item link class="px-1 mx-1">
				<v-list-item-icon>
					<v-icon>mdi-account-multiple</v-icon>
				</v-list-item-icon>
				<v-list-item-title>Shared with me</v-list-item-title>
			</v-list-item>
			<v-list-item
				v-if="$store.getters['auth/currentUser']"
				to="/memos"
				link
				class="px-1 mx-1"
			>
				<v-list-item-icon>
					<v-icon>mdi-file-document-outline</v-icon>
				</v-list-item-icon>
				<v-list-item-title>Memos</v-list-item-title>
			</v-list-item>
		</v-list-item-group>

		<v-list-item-group class="pt-7">
			<v-list-item
				v-if="$store.getters['auth/currentUser']"
				to="/users"
				link
				class="px-1 mx-1"
			>
				<v-list-item-icon>
					<v-icon>mdi-account-search-outline</v-icon>
				</v-list-item-icon>
				<v-list-item-title>Search Users</v-list-item-title>
			</v-list-item>
			<v-list-item
				v-if="$store.getters['auth/currentUser']"
				to="/mates"
				link
				class="px-1 mx-1"
			>
				<v-list-item-icon>
					<v-icon>mdi-account-switch-outline</v-icon>
				</v-list-item-icon>
				<v-list-item-title>Mates</v-list-item-title>
			</v-list-item>
		</v-list-item-group>
	</div>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
.v-list-item {
	text-decoration: none;
}
</style>
