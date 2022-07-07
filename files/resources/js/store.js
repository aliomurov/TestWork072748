import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);

let cart = window.localStorage.getItem('cart');

export default new Vuex.Store({
    state: {
        cart: cart ? JSON.parse(cart) : [],
    },

    mutations:{
        addToCart(state, item){
            let found = state.cart.find(product => product.productId === item.productId);
            if(found){
                return alert('Этот товар уже был добавлен в корзину');
            } else {
                state.cart.push(item);
            }

            this.commit('saveData');
        },

        saveData(state){
            window.localStorage.setItem('cart', JSON.stringify(state.cart));
        },
    
        change(state, item){
            let found = state.cart.find(product => product.productId === item.productId);
            found.productQuantity = item.productQuantity;
            this.commit('saveData');
        },

        plusCart(state, item){
            let found = state.cart.find(product => product.productId === item.productId);
            found.productQuantity++;
            this.commit('saveData');
        },

        minusCart(state, item){
            let found = state.cart.find(product => product.productId === item.productId);
            found.productQuantity--;
            this.commit('saveData');
        },

        removeFromCart(state, item){
            let index = state.cart.indexOf(item);
            state.cart.splice(index, 1);
            this.commit('saveData');
        },
    },
})
