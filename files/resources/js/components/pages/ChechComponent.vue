<template>
    <div>
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

        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-6 text-left">
                            <h2 class="h2">Оформление заказа</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-sm-6">
                        <table class="table">
                            <thead class="thead-light">
                            <tr>
                                <th scope="col">Данные заказчика</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">ФИО</th>
                                <td>{{order.name}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Email</th>
                                <td>{{order.email}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Комапния</th>
                                <td>{{order.name_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Тип компании</th>
                                <td>{{order.type_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Область (город)</th>
                                <td>{{order.city_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Адрес (улица, №)</th>
                                <td>{{order.address_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Телефон</th>
                                <td>{{order.phone_company}}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-sm-6">
                        <v-form v-model="valid">
                            <table class="table">
                                <thead class="thead-light">
                                <tr>
                                    <th scope="col">Другой адрес</th>
                                    <th scope="col"></th>
                                </tr>
                                </thead>
                            </table>
                            <v-col cols="12" sm="12">
                                <v-select
                                    :rules="nameRules"
                                    required color="error"
                                    :items="cities"
                                    v-model="other.city"
                                    label="Область (город)"
                                ></v-select>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="nameRules" required color="error" v-model="other.address" label="Адрес (улица, №)"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="nameRules" required color="error" v-model="other.phone" label="Телефон"></v-text-field>
                            </v-col>
                        </v-form>
                    </div>
                </div>
                <div v-if="$store.state.cart.length >= 1" class="row">
                    <div class="col-sm-12">
                        <table class="table table-hover pk-none">
                            <thead class="thead-p"></thead>
                            <tbody v-for="item in carts">
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
                                <td>
                                    <button class="btn btn-outline-dark btn-sm">
                                        {{item.productQuantity}}
                                        <span v-if="item.productUnit === 1">шт</span>
                                        <span v-if="item.productUnit === 2">кг</span>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Всего</th>
                                <td>{{item.productPrice * item.productQuantity}} сом</td>
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
                            <tr v-for="item in carts">
                                <th scope="row">
                                    {{item.productId}}
                                </th>
                                <td>{{item.productName}}</td>
                                <td>
                                    1
                                    <span v-if="item.productUnit === 1">шт.</span>
                                    <span v-if="item.productUnit === 2">кг.</span>
                                    - {{item.productPrice}} сом
                                </td>
                                <td>
                                    <button class="btn btn-outline-dark btn-sm">
                                        {{item.productQuantity}}
                                        <span v-if="item.productUnit === 1">шт</span>
                                        <span v-if="item.productUnit === 2">кг</span>
                                    </button>
                                </td>
                                <td>{{item.productPrice * item.productQuantity}} сом</td>
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
                    </div>
                </div>
                <div v-if="$store.state.cart.length >= 1" class="row justify-content-end text-right">
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
                                        Общая сумма: {{totalPrice}} сом
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="row justify-content-around">
                                        <router-link :to="{name: 'cart'}">
                                            <button type="button" class="btn btn-primary btn-sm">
                                                Вернутся в корзину
                                            </button>
                                        </router-link>
                                        <button type="button" class="btn btn-primary btn-sm" @click="save">
                                            Отправить заказ
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row justify-content-end text-right" v-else>
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
                                        Общая сумма: {{totalPrice}} сом
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
                                        <button type="button" class="btn btn-primary btn-sm" disabled>
                                            Отправить заказ
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
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
                other: {},
                order: {},
                carts: [],
                cities: ['Бишкек', 'Чуй', 'Нарын', 'Жалал-Абад', 'Ыссык-Кол', 'Талас', 'Баткен', 'Ош'],
                types: ['Ресторан', 'Кафе', 'Пансионат', 'Отель', 'Частный сектор', 'Хостел', 'Частное лицо'],
                nameRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                emailRules: [
                    v => !!v || 'Email обьязательно для заполнения',
                    v => /.+@.+\..+/.test(v) || 'Email должна быть действительной',
                ],
                valid: true,
                snackbar: false,
                text: '',
                y: 'top',
            }
        },

        mounted(){
            this.snackbar = localStorage.getItem('loggedIn') ? true : false;
            this.text = 'Успешно вошли';
            localStorage.removeItem('loggedIn')
        },


        computed: {
            totalPrice() {
                return this.$store.state.cart.reduce((total, cart) => {
                    return total + cart.productQuantity * cart.productPrice;
                }, 0);
            }
        },

        created () {
            this.initialize();
        },

        methods: {
            initialize () {
                axios.get(`/api/checkout`)
                    .then(res => {
                        this.order = res.data.order;
                        this.carts = this.$store.state.cart;
                    })
                    .catch(err => console.dir(err.response))
            },

            save() {
                const formData = new FormData();
                formData.append('total_price', this.totalPrice);
                formData.append('city', this.other.city);
                formData.append('address', this.other.address);
                formData.append('phone', this.other.phone);
                formData.append('products', JSON.stringify(this.$store.state.cart));
                axios.post(`/api/checkout/store`, formData)
                    .then(res => {
                        this.$router.push({name: 'page.thanks'});
                        localStorage.removeItem('cart');
                        this.carts.splice(0, this.$store.state.cart.length);
                    })
                    .catch(err =>{
                        this.text = err.response.data.status;
                        this.snackbar = true;
                    })
            }
        }
    }
</script>

<style scoped>
    .minus-plus div{
        margin: 0 5px
    }
</style>
