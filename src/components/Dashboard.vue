<template>
  <div class="dashboard">
    <h1>{{ msg }}</h1>
    <div v-if="!exists">
      Debut <router-link to="/signup">here</router-link>.
    </div>
    <div v-else>
      <a href="#" @click="retire">To retire</a>.
    </div>
  </div>
</template>

<script>
import IdolFactory from '../js/idol_factory'

export default {
  name: 'dashboard',
  data () {
    return {
      msg: 'Welcome to CryptoIdol.',
      exists: false,
    }
  },
  beforeCreate: function () {
    IdolFactory.init().then(() => {
      IdolFactory.idolExists(window.web3.eth.accounts[0]).then((exists) => {
        console.log(exists);
        this.exists = exists;
        if (exists) {
          this.msg = "Welcome back to CryptoIdol."
        }
      })
    }).catch(err => {
      console.log(err)
    })
  },
  methods: {
    retire: function (e) {
      e.preventDefault()
      IdolFactory.destroyIdol().then(() => {
        this.msg = 'Welcome to CryptoIdol.'
        this.exists = false;
      }).catch(err => {
        console.log(err)
      })
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
  display: block;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
