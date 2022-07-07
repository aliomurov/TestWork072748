<template>
    <div>
        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-4 text-left">
                            <h2 class="h2">Корзина покупок</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div v-if="$store.state.cart.length >= 1" class="container">
                <div class="row align-content-center">
                    <div class="col-sm-12">
                        <table class="table table-hover pk-none">
                            <thead class="thead-p"></thead>
                            <tbody v-for="item in this.$store.state.cart">
                            <tr class="t-head-product">
                                <th scope="col">
                                    Продукт №{{item.productId}}
                                </th>
                                <th scope="col">
                                    {{item.productName}}
                                </th>
                            </tr>
                            <tr>
                                <th scope="row">Цена</th>
                                <td>
                                    1
                                    <span v-if="item.productUnit === 1">шт.</span>
                                    <span v-if="item.productUnit === 2">кг.</span>
                                    - {{item.productPrice}} сом
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Кол-во</th>
                                <td class="row minus-plus">
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
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Всего</th>
                                <td>{{item.productPrice * item.productQuantity}} сом</td>
                            </tr>
                            <tr>
                                <th scope="row">Лимит</th>
                                <td>
                                    <div>
                                        <div v-if="item.productQuantity">
                                            <span class="text-danger">
                                                {{item.productStock - item.productQuantity}}
                                                <span v-if="item.productUnit === 1">шт.</span>
                                                <span v-if="item.productUnit === 2">кг.</span>
                                            </span>
                                        </div>
                                    </div>
                                    <div v-if="item.productQuantity > item.productStock">
                                        <div class="text-danger">
                                            - 0
                                            (<span>
                                                {{item.productStock}}
                                                <span v-if="item.productUnit === 1">шт.</span>
                                                <span v-if="item.productUnit === 2">кг.</span>
                                            </span>)
                                        </div>
                                    </div>
                                    <div v-if="item.productQuantity === item.productStock">
                                        <div class="text-danger">
                                            0
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Удалить</th>
                                <td>
                                    <button @click="$store.commit('removeFromCart', item)" type="button" class="btn btn-danger btn-sm">
                                        <v-icon small class="mr-2">
                                            mdi-delete-empty
                                        </v-icon>
                                        Удалить
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <table class="table table-hover mob-none">
                            <thead class="thead-dark">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Продукт</th>
                                <th scope="col">Цена</th>
                                <th scope="col">Кол-во</th>
                                <th scope="col">Всего</th>
                                <th scope="col" class="icon-w">
                                    Действия
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr v-for="item in this.$store.state.cart">
                                <th scope="row">{{item.productId}}</th>
                                <td>{{item.productName}}</td>
                                <td>
                                   {{item.productPrice}} сом
                                </td>
                                <td class="row minus-plus">
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
                                                <input style="width: 40px;" type="text" inputmode="numeric" pattern="[0-9]*" v-model="item.productQuantity" min="1" @change="$store.commit('change', item)">
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
                                </td>
                                <td>{{item.productPrice * item.productQuantity}} сом</td>
                                <td>
                                    <button @click="$store.commit('removeFromCart', item)" type="button" class="btn btn-danger btn-sm">
                                        <v-icon small class="mr-2">
                                            mdi-delete-empty
                                        </v-icon>
                                    </button>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row justify-content-end text-right">
                    <div class="col-sm-4">
                        <table class="table table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th scope="col">Всего к оплате</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <div>
                                            Общая цена: {{totalPrice}} сом
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="row justify-content-around">
                                            <router-link :to="{name: 'page.catalog'}">
                                                <button type="button" class="btn btn-primary btn-sm">
                                                    Вернутся в магазин
                                                </button>
                                            </router-link>
                                            <router-link to="/checkout">
                                                <div>
                                                    <button type="button" class="btn btn-primary btn-sm">
                                                        Оформить заказ
                                                    </button>
                                                </div>
                                            </router-link>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div v-else class="container">
                <div class="row">
                    <div class="col">
                        <h3>В корзине пусто</h3>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="col">
                        <router-link :to="{name: 'page.catalog'}">
                            <button type="button" class="btn btn-primary btn-sm">
                                Вернутся в магазин
                            </button>
                        </router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import MenuComponent from "../include/MenuComponent";
    export default {
        components:{
            'MenuComponent': MenuComponent,
        },
        data() {
            return {

            }
        },

        computed: {
            totalPrice() {
                return this.$store.state.cart.reduce((total, cart) => {
                    return total + cart.productQuantity * cart.productPrice;
                }, 0);
            },
        },
    }
</script>

<style scoped></style>
