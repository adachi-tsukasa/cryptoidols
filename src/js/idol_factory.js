import contract from 'truffle-contract'
import IdolFactoryContract from '../../build/contracts/IdolFactory.json'

const IdolFactory = {

  contract: null,

  instance: null,

  init: function () {
    let self = this
    return new Promise(function (resolve, reject) {
      self.contract = contract(IdolFactoryContract)
      self.contract.setProvider(window.web3.currentProvider)

      self.contract.deployed().then(instance => {
        self.instance = instance
        resolve()
      }).catch(err => {
        reject(err)
      })
    })
  },

  idolExists: function (address) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.idolExists.call(
        address || window.web3.eth.defaultAccount,
        {from: window.web3.eth.accounts[0]}
      ).then(exists => {
        resolve(exists)
      }).catch(err => {
        reject(err)
      })
    })
  },

  createIdol: function(name, age) {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.createIdol(
        name,
        age,
        {from: window.web3.eth.accounts[0]}
      ).then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  },

  destroyIdol: function () {
    let self = this

    return new Promise((resolve, reject) => {
      self.instance.destroyIdol(
        {from: window.web3.eth.accounts[0]}
      ).then(tx => {
        resolve(tx)
      }).catch(err => {
        reject(err)
      })
    })
  }
}

export default IdolFactory
