<template>
  <v-list-item class="pa-3" :style="{ background: 'rgba(240, 240, 245, 0.82)' }">
    <v-card outlined color="transparent">
      <v-form ref="form1" lazy-validation>
        <v-text-field class="py-1"
          v-model="email"
          :rules="emailRules"
          label="e-mail:"
          dense
          required
          prepend-icon="mdi-email-outline"
          hint="アカウントの認証/登録に必要"
          persistent-hint
        ></v-text-field>

        <v-text-field class="py-1"
          v-model="password"
          :rules="passwordRules"
          label="password:"
          dense
          required
          prepend-icon="mdi-lock-outline"
          counter
          type="password"
        ></v-text-field>

        <v-card-text class="text-caption secondary--text mt-n3">
          <span class="text-caption info--text text--darken-3">
            初回は Signin
          </span>から登録して下さい
        </v-card-text>
      </v-form>

      <v-card-actions class="mt-n4 mb-n1">
        <v-spacer></v-spacer>

        <v-btn icon
          color="success darken-1"
          @click="login"
        >
          <div>
            <v-icon>mdi-arrow-right-circle</v-icon>
            <v-list-item-title class="text-caption">login</v-list-item-title>
          </div>
        </v-btn>

        <v-spacer></v-spacer>
      </v-card-actions>

      <v-form ref="form2" lazy-validation>
        <v-text-field class="py-1"
          v-model="name"
          :rules="nameRules"
          label="name:"
          dense
          required
          prepend-icon="mdi-account-outline"
          hint="Signinには追加で入力必須"
          persistent-hint
        ></v-text-field>
      </v-form>
      
      <v-card-actions class="mt-2">
        <v-spacer></v-spacer>
        <v-btn icon
          color="info"
          @click="signin"
        >
          <div>
            <v-icon>mdi-check-circle</v-icon>
            <v-list-item-title class="text-caption">signin</v-list-item-title>
          </div>
        </v-btn>

        <v-spacer></v-spacer>

        <v-btn icon
          @click="closeForm"
        >
          <div>
            <v-icon>mdi-close</v-icon>
            <v-list-item-title class="text-caption">cansel</v-list-item-title>
          </div>
        </v-btn>

        <v-spacer></v-spacer>
      </v-card-actions>

    </v-card>
  </v-list-item>
</template>

<script>
  import axios from 'axios'
  export default {
    data: () => ({
      email: "",
      password: "",
      name: "",
    }),
    computed: {
      emailRules() {
        return [
          (v) => !!v || "Loginには入力必須です",
          (v) => /.+@.+\..+/.test(v) || "有効なアドレスを入力してください",
        ];
      },
      passwordRules() {
        return [(v) => !!v || "Loginには入力必須です"];
      },
      nameRules() {
        return [(v) => !!v || "Signinには入力必須です"];
      },
    },
    methods: {
      async login() {
        if (this.$refs.form1.validate()) {
          try {
            const sessionParams = {
              session: {
                email: this.email.toLowerCase(),
                password: this.password,
              },
            };
            await this.$store.dispatch("auth/login", sessionParams);
            this.$emit("closeForm");
          } catch (error) {
            alert(error.response.data.error);
          }
        }
      },
      async signin() {
        if (this.$refs.form2.validate()) {
          try {
            const userParams = {
              user: {
                email: this.email.toLowerCase(),
                password: this.password,
                name: this.name,
              },
            };
            await axios.post(`/api/users`, userParams);
            this.login();
          } catch(err) {
            alert(err.response.data.error);
          }
        }
      },
      closeForm(){
        this.$emit("closeForm");
      }
    },
  }
</script>

<style lang="scss" scoped>

</style>