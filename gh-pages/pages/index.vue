<template>
  <div class="container">
    <div>
      <Logo/>
      <h1 class="title">微漫App</h1>
      <h2 class="title">最新版本 {{version}}</h2>
      <div class="links">
        <a href="https://github.com/nrop19/weiman_app/releases/latest" target="_blank" rel="noopener noreferrer"
           class="button--green">
          最新版下载页面
        </a>
        <a href="https://github.com/nrop19/weiman_app" target="_blank" rel="noopener noreferrer" class="button--grey">
          GitHub开源
        </a>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
  import Vue from 'vue'

  export default Vue.extend({
    data () {
      return { version: process.env.VERSION }
    },
  })
</script>

<style>
  .container {
    margin: 0 auto;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
  }

  .title {
    font-family: 'Quicksand',
    'Source Sans Pro',
    -apple-system,
    BlinkMacSystemFont,
    'Segoe UI',
    Roboto,
    'Helvetica Neue',
    Arial,
    sans-serif;
    display: block;
    font-weight: 100;
    /*font-size: 100px;*/
    color: #35495e;
    letter-spacing: 1px;
  }

  h1 {
    font-size: 70px;
    margin: 0;
  }

  h2 {
    font-size: 30px;
  }

  .subtitle {
    font-weight: 300;
    font-size: 42px;
    color: #526488;
    word-spacing: 5px;
    padding-bottom: 15px;
  }

  .links {
    padding-top: 15px;
  }
</style>
