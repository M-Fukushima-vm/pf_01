// (ログイン後)navバーのeditボタンで展開する ユーザー情報更新フォームの.vue

<template>
  <v-list-item
    class="pa-7"
    :style="{ background: 'rgba(240, 240, 245, 0.82)' }"
  >
    <v-card outlined color="transparent" class="justify-center">
      <v-form ref="form" lazy-validation class="mb-3">
        <v-text-field class="py-2 mr-2"
          v-model="user.name"
          :rules="nameRules"
          label="name:"
          dense
          required
          prepend-icon="mdi-account-outline"
          hint="空の状態への変更はできません"
        ></v-text-field>

        <v-text-field class="py-2 mr-2"
          v-model="user.email"
          :rules="emailRules"
          label="e-mail:"
          dense
          required
          prepend-icon="mdi-email-outline"
          hint="空の状態への変更はできません"
        ></v-text-field>

        <v-text-field class="py-2 mr-2"
          v-model="password"
          :rules="passwordRules"
          :append-icon="toggle.icon"
          @click.append="showPassword = !showPassword"
          autocomplete="on"
          label="password:"
          dense
          required
          prepend-icon="mdi-lock-outline"
          hint="行内クリックで内容確認できます"
          counter
          :type="toggle.type"
        ></v-text-field>

        <v-text-field class="py-2 mr-2"
          v-model="user.introduction"
          label="introduction:"
          dense
          required
          prepend-icon="mdi-information-outline"
          hint="簡単な自己紹介文など必要あれば入力"
          persistent-hint
        ></v-text-field>

        <v-text-field class="py-2 mr-2"
          v-model="user.avatar_name"
          :rules="avatar_nameRules"
          label="avatar_name:"
          dense
          required
          prepend-icon="mdi-dots-horizontal-circle"
          hint="画像でなく文字アイコンを使う場合 : 3文字以内で入力  ( ex.イニシャル等 ) *"
          persistent-hint
          counter
        ></v-text-field>

        <v-card-text
          class="text-caption secondary--text text-center mt-n3 mb-n3"
          v-show="user.avatar_name"
        >
          ＊ アバター画像が優先されます ＊
        </v-card-text>

        <v-list-item class="justify-center">
          <v-spacer></v-spacer>

          <v-btn
            color="success darken-1"
            icon
            @click="$refs.editAddAvatarDialog.toggleShow()"
            v-if="!$store.getters['auth/currentUserAvatar']"
          >
            <div>
              <v-icon>mdi-camera-enhance</v-icon>
              <v-list-item-title class="text-caption">add image</v-list-item-title>
            </div>
          </v-btn>

          <v-btn
            icon
            @click="removeAvatarImage"
            v-if="$store.getters['auth/currentUserAvatar']"
          >
            <div>
              <v-icon>mdi-camera-off</v-icon>
              <v-list-item-title class="text-caption">remove image</v-list-item-title>
            </div>
          </v-btn>

          <v-spacer></v-spacer>
        </v-list-item>

        <add-avatar
          ref="editAddAvatarDialog"
        ></add-avatar>
      </v-form>

      <v-divider></v-divider>

      <v-list-item-subtitle>
        preview
      </v-list-item-subtitle>
      <v-list-item class="justify-center">
        <v-list-item-icon class="mt-n3 ml-6 pl-6">
          <v-list-item-avatar>

            <v-img
              :src="$store.getters['auth/currentUserAvatar']"
              v-if="$store.getters['auth/currentUserAvatar']"
              ></v-img>

            <v-avatar
              color="primary"
              size="40"
              v-if="!$store.getters['auth/currentUserAvatar'] && user.avatar_name"
            >
              <span class="white--text text-sm">{{ user.avatar_name }}</span>
            </v-avatar>

            <v-avatar
              color="primary lighten-1"
              size="40"
              v-if="!$store.getters['auth/currentUserAvatar'] && !user.avatar_name"
            >
              <v-icon
                class="white--text text-sm"
              >mdi-account</v-icon>
            </v-avatar>

          </v-list-item-avatar>
        </v-list-item-icon>
      </v-list-item>

      <v-list-item class="mt-n7">
        <v-list-item-content>
          <v-list-item-title class="text-h6 text-center">
            <!-- Sandra Adams -->
            {{ user.name }}
          </v-list-item-title>
          <v-list-item-subtitle class="text-center">
            <!-- sandra_a88@gmail.com -->
            {{ user.email }}
          </v-list-item-subtitle>
          <v-list-item-subtitle
            class="mt-3 mb-1 text-center font-weight-thin"
            v-show="this.user.introduction"
          >
            {{ user.introduction }}
          </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>

      <v-divider></v-divider>

      <v-card-actions class="mt-2 mb-n5">
        <v-spacer></v-spacer>
        <v-btn icon
          color="info"
          @click="updateProfile"
        >
          <div>
            <v-icon>mdi-check-circle</v-icon>
            <v-list-item-title class="text-caption">update</v-list-item-title>
          </div>
        </v-btn>

        <v-spacer></v-spacer>

        <v-btn icon
          @click="closeForm"
        >
          <div>
            <v-icon>mdi-close</v-icon>
            <v-list-item-title class="text-caption">cancel</v-list-item-title>
          </div>
        </v-btn>

        <v-spacer></v-spacer>
      </v-card-actions>

    </v-card>
  </v-list-item>
</template>

<script>
  import axios from 'axios'
  import addAvatar from '@/components/sideNav/pcNav/startArea/logIn/editUser/addAvatar/AddAvatar'
  export default {
    components: {
      addAvatar,
    },
    data: () => ({
      password: "",
      showPassword: false,
      user: "",
    }),
    created() {
      this.user = { ...this.$store.getters["auth/currentUser"] };
    },
    computed: {
      toggle () {
        const icon = this.showPassword ? 'mdi-eye' : 'mdi-eye-off'
        const type = this.showPassword ? 'text' : 'password'
        return { icon, type }
      },
      nameRules() {
        return [(v) => !!v || "空の状態への変更はできません"];
      },
      emailRules() {
        return [
          (v) => !!v || "空の状態への変更はできません",
          (v) => /.+@.+\..+/.test(v) || "有効なアドレスを入力してください",
        ];
      },
      passwordRules() {
        if (this.password) {
          return [(v) => v.length >= 4 || "4文字以上で設定してください"];
        }
      },
      avatar_nameRules() {
        if (this.user.avatar_name) {
          return [(v) => v.length <= 3 || "3文字以下で設定してください"];
        }
      }
    },
    methods: {
      async updateProfile() {
        if (!this.password && this.$refs.form.validate()) {
          try {
            const userParams1 = {
              user: {
                name: this.user.name,
                email: this.user.email.toLowerCase(),
                introduction: this.user.introduction,
                avatar_name: this.user.avatar_name,
              },
            };
            await this.$store.dispatch('auth/updateProfile', userParams1);
            this.closeForm();
          } catch (error) {
            alert(error.response.data.error.messages);
          }
        }
        if (this.password && this.$refs.form.validate()) {
          try {
            const userParams2 = {
              user: {
                name: this.user.name,
                email: this.user.email.toLowerCase(),
                password: this.password,
                introduction: this.user.introduction,
                avatar_name: this.user.avatar_name,
              },
            };
            await this.$store.dispatch('auth/updateProfile', userParams2);
            this.closeForm();
          } catch (error) {
            alert(error.response.data.error.messages);
          }
        }
      },
      async removeAvatarImage() {
        await this.$store.dispatch('auth/removeAvatar');
      },
      closeForm() {
        this.$emit('closeForm');
      }
    },
  }
</script>

<style lang="scss" scoped>
</style> 