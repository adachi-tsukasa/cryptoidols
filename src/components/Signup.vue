<template>
  <section id='signup'>
    <h1>Debut</h1>
    <div class="form">
      <div class="entry">
        <div>
          <label>name</label>
          <input name="name" v-model="form.name">
        </div>
        <div>
          <label>age</label>
          <input name="age" v-model="form.age">
        </div>
        <button @click="signup" name="signup">debut</button>
      </div>
    </div>
  </section>
</template>

<script>
  import IdolFactory from '../js/idol_factory'

  export default {
    name: 'signup',
    data () {
      return {
        form: {
          name: undefined,
          age: undefined
        }
      }
    },
    beforeCreate: function () {
      IdolFactory.init()
    },
    methods: {
      signup: function () {
        let self = this
        IdolFactory.createIdol(this.form.name, this.form.age).then(tx => {
          console.log(tx)
          self.$router.push('/')
        }).catch(err => {
          console.log(err)
        })
      }
    }
  }
</script>

<style lang="scss" scoped>

  #signup {
    text-align: center;
    
    .form {
      display: flex;
      flex-direction: column;
      margin: auto;
      
      .entry {
        display: flex;
        // flex-direction: row-reverse;
        justify-content: center;
        
        label {
          margin-right: 20px
        }
        
        button {
          margin-left: 20px
        }  
        
      }
        
    }
    
  }

</style>
