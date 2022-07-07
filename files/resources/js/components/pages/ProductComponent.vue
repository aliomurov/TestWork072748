<template>
    <div>
        <div class="container-fluid">
            <v-snackbar
                v-model="snackbar"
                :top="y === 'top'"
            >
                {{ text }}
                <v-btn
                    color="pink"
                    text
                    @click="snackbar = false"
                >
                    Закрыть
                </v-btn>
            </v-snackbar>
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-4 text-left">
                            <h2 class="h2">{{category.name}}</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row align-content-center">
                    <div class="col-sm-9">
                        <div class="row justify-content-between">
                            <div class="col-sm-4" v-for="(product, i) in category.product" :key="i">
                                <div class="block-product-s">
                                    <img :src="`/files/storage/app/${product.image}`" class="img-fluid" height="200">
                                    <p>{{product.name | truncate(55, '...') }}</p>
                                    <div class="body-p row justify-content-between mob-none">
                                        <div class="col-sm-8 p-price">
                                            <span>{{product.price}} сом/кг</span>
                                        </div>
                                    </div>
                                    <div class="body-p pk-none">
                                        <div class="col p-price">
                                            <span>{{product.price}} сом/кг</span>
                                        </div>
                                    </div>
                                    <div class="add-to-cart-product row mob-none">
                                        <div class="col-sm-4">
                                            <h5 class="card-title c-t-wish">
                                                <add-to-cart
                                                    :p-id="product.id"
                                                    :price="product.price"
                                                    :name="product.name"
                                                    :unit="product.unit"
                                                    :stock="product.stock"
                                                ></add-to-cart>
                                                <span v-for="item in carts" v-if="item.productId === product.id" class="icon-d">
                                                <button @click="$store.commit('removeFromCart', item)" type="button" class="btn btn-danger btn-sm">
                                                    <v-icon small class="mr-2">
                                                        mdi-delete-empty
                                                    </v-icon>
                                                </button>
                                            </span>
                                            </h5>
                                        </div>
                                        <div class="col-sm-8 minus-product row" v-for="item in carts" v-if="item.productId === product.id">
                                            <div v-if="item.productQuantity <= 1">
                                                <button disabled type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('minusCart', item)">
                                                    <span class="text-danger">-</span>
                                                </button>
                                            </div>
                                            <div v-else>
                                                <button type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('minusCart', item)">
                                                    <span class="text-danger">-</span>
                                                </button>
                                            </div>
                                            <div>
                                                <div>
                                                    <button class="btn btn-outline-dark btn-sm">
                                                        <input style="width: 35px;" type="text" inputmode="numeric" pattern="[0-9]*" v-model="item.productQuantity" min="1" @change="$store.commit('change', item)">
                                                        <span v-if="item.productUnit === 1">шт</span>
                                                        <span v-if="item.productUnit === 2">кг</span>
                                                    </button>
                                                </div>
                                            </div>
                                            <div>
                                                <div v-if="item.productQuantity >= item.productStock">
                                                    <button disabled type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('plusCart', item)">
                                                        <span class="text-primary">+</span>
                                                    </button>
                                                </div>
                                                <div v-else>
                                                    <button type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('plusCart', item)">
                                                        <span class="text-primary">+</span>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="add-to-cart-product pk-none">
                                        <div class="col">
                                            <h5 class="card-title c-t-wish">
                                                <add-to-cart
                                                    :p-id="product.id"
                                                    :price="product.price"
                                                    :name="product.name"
                                                    :unit="product.unit"
                                                    :stock="product.stock"
                                                ></add-to-cart>
                                                <span v-for="item in carts" v-if="item.productId === product.id" class="icon-d">
                                                <button @click="$store.commit('removeFromCart', item)" type="button" class="btn btn-danger btn-sm">
                                                    <v-icon small class="mr-2">
                                                        mdi-delete-empty
                                                    </v-icon>
                                                </button>
                                            </span>
                                            </h5>
                                        </div>
                                        <div class="col minus-product row" v-for="item in carts" v-if="item.productId === product.id">
                                            <div v-if="item.productQuantity <= 1">
                                                <button disabled type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('minusCart', item)">
                                                    <span class="text-danger">-</span>
                                                </button>
                                            </div>
                                            <div v-else>
                                                <button type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('minusCart', item)">
                                                    <span class="text-danger">-</span>
                                                </button>
                                            </div>
                                            <div>
                                                <div>
                                                    <button class="btn btn-outline-dark btn-sm">
                                                        <input style="width: 35px;" type="text" inputmode="numeric" pattern="[0-9]*" v-model="item.productQuantity" min="1" @change="$store.commit('change', item)">
                                                        <span v-if="item.productUnit === 1">шт</span>
                                                        <span v-if="item.productUnit === 2">кг</span>
                                                    </button>
                                                </div>
                                            </div>
                                            <div>
                                                <div v-if="item.productQuantity >= item.productStock">
                                                    <button disabled type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('plusCart', item)">
                                                        <span class="text-primary">+</span>
                                                    </button>
                                                </div>
                                                <div v-else>
                                                    <button type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('plusCart', item)">
                                                        <span class="text-primary">+</span>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="cart-product-show" v-if="$store.state.cart.length >= 1">
                            <div class="title-c-p-s">
                                <h4>Корзина</h4>
                            </div>
                            <div class="cart-body-product" v-for="item in this.$store.state.cart">
                                <h5>
                                    {{item.productName}}
                                </h5>
                                <div class="body-p row justify-content-between mob-none">
                                    <div class="col-sm-8 p-price">
                                        <span>{{item.productPrice * item.productQuantity}} сом</span>
                                    </div>
                                </div>
                                <div class="body-p pk-none">
                                    <div class="col p-price">
                                        <span>{{item.productPrice * item.productQuantity}} сом</span>
                                    </div>
                                </div>
                                <div class="add-to-cart-product row mob-none">
                                    <div class="col-sm-4">
                                        <button @click="$store.commit('removeFromCart', item)" type="button" class="btn btn-danger btn-sm">
                                            <v-icon small class="mr-2">
                                                mdi-delete-empty
                                            </v-icon>
                                        </button>
                                    </div>
                                    <div class="col-sm-8 minus-product row">
                                        <div v-if="item.productQuantity <= 1">
                                            <button disabled type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('minusCart', item)">
                                                <span class="text-danger">-</span>
                                            </button>
                                        </div>
                                        <div v-else>
                                            <button type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('minusCart', item)">
                                                <span class="text-danger">-</span>
                                            </button>
                                        </div>
                                        <div>
                                            <div>
                                                <button class="btn btn-outline-dark btn-sm">
                                                    <input style="width: 35px;" type="text" inputmode="numeric" pattern="[0-9]*" v-model="item.productQuantity" min="1" @change="$store.commit('change', item)">
                                                    <span v-if="item.productUnit === 1">шт</span>
                                                    <span v-if="item.productUnit === 2">кг</span>
                                                </button>
                                            </div>
                                        </div>
                                        <div>
                                            <div v-if="item.productQuantity >= item.productStock">
                                                <button disabled type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('plusCart', item)">
                                                    <span class="text-primary">+</span>
                                                </button>
                                            </div>
                                            <div v-else>
                                                <button type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('plusCart', item)">
                                                    <span class="text-primary">+</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="add-to-cart-product pk-none">
                                    <div class="col">
                                        <button @click="$store.commit('removeFromCart', item)" type="button" class="btn btn-danger btn-sm">
                                            <v-icon small class="mr-2">
                                                mdi-delete-empty
                                            </v-icon>
                                        </button>
                                    </div>
                                    <div class="col minus-product row">
                                        <div v-if="item.productQuantity <= 1">
                                            <button disabled type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('minusCart', item)">
                                                <span class="text-danger">-</span>
                                            </button>
                                        </div>
                                        <div v-else>
                                            <button type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('minusCart', item)">
                                                <span class="text-danger">-</span>
                                            </button>
                                        </div>
                                        <div>
                                            <div>
                                                <button class="btn btn-outline-dark btn-sm">
                                                    <input style="width: 35px;" type="text" inputmode="numeric" pattern="[0-9]*" v-model="item.productQuantity" min="1" @change="$store.commit('change', item)">
                                                    <span v-if="item.productUnit === 1">шт</span>
                                                    <span v-if="item.productUnit === 2">кг</span>
                                                </button>
                                            </div>
                                        </div>
                                        <div>
                                            <div v-if="item.productQuantity >= item.productStock">
                                                <button disabled type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('plusCart', item)">
                                                    <span class="text-primary">+</span>
                                                </button>
                                            </div>
                                            <div v-else>
                                                <button type="button" class="btn btn-outline-primary btn-sm" @click="$store.commit('plusCart', item)">
                                                    <span class="text-primary">+</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="cart-price-all">
                                <div class="title-price-all">
                                    <h4>Итого на сумма:</h4>
                                </div>
                                <div class="number-price-all">
                                    <p>{{totalPrice}} сом</p>
                                </div>
                                <div class="btn-check-product">
                                    <router-link to="/cart">
                                        <div>
                                            <button type="button" class="btn btn-primary btn-sm">
                                                Оформить заказ
                                            </button>
                                        </div>
                                    </router-link>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import MenuComponent from "../include/MenuComponent";
    import AddToCartComponent from "../include/AddToCartComponent";
    export default {
        components:{
            'MenuComponent': MenuComponent,
            'add-to-cart': AddToCartComponent,
        },
        data() {
            return {
                categories: [],
                carts: [],
                category: [],
                snackbar: false,
                text: '',
                y: 'top',
            }
        },

        computed: {
            totalPrice() {
                return this.$store.state.cart.reduce((total, cart) => {
                    return total + cart.productQuantity * cart.productPrice;
                }, 0);
            },
        },

        created () {
            this.initialize();
        },

        methods: {
            initialize () {
                axios.get(`/api/catalog/${this.$route.params.id}/`)
                    .then(res => {
                        this.category = res.data.category;
                        this.categories = res.data.categories;
                        this.carts = this.$store.state.cart;
                    })
                    .catch(err => console.dir(err.response))
            },
        }
    }
</script>

<style scoped>
    .icon-w i{
        color: #fff;
    }
    .icon-g i{
        color: green;
    }
</style>
