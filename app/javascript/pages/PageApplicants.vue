<template>
  <div>
    <applicants-tool-bar></applicants-tool-bar>
    <v-row>
      <v-col>
        <applicants-list></applicants-list>
      </v-col>
    </v-row>
  </div>
</template>

<script>
  import applicantsToolBar from '@/components/toolBar/ApplicantsToolBar'
  import applicantsList from '@/components/lists/ApplicantsList'
  export default {
    components: {
      applicantsToolBar,
      applicantsList,
    },
    created() {
      // 読み込みの確認用
        // console.log(this.$children)
    }
  }
</script>

<style lang="scss" scoped>

</style>