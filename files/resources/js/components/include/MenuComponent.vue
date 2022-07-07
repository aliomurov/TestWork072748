<template>
    <div>
        <div class="container-fluid head mob-none">
            <div class="container">
                <div class="row justify-content-between head-1">
                    <div class="col-sm-4">
                        <v-icon small>mdi-ship-wheel</v-icon>
                        <a class="lead">
                            Тестовое задание
                        </a>
                    </div>
                    <div class="col-sm-3 row justify-content-end" v-if="authCheck === true">
                        <div>
                            <v-icon small>mdi-account-circle-outline</v-icon>
                            <router-link :to="{name: 'page.profile'}">
                                <a class="lead">
                                    {{order.name}}
                                </a>
                            </router-link>
                        </div>
                        <div>
                            <v-icon small>mdi-account-plus-outline</v-icon>
                            <a class="lead"  @click="logout">
                                Выйти
                            </a>
                        </div>
                    </div>
                    <div class="col-sm-3 row justify-content-end" v-if="authCheck === false">
                        <div>
                            <v-icon small>mdi-account-circle-outline</v-icon>
                            <a class="lead">
                                <router-link :to="{name: 'page.login'}">
                                    Вход
                                </router-link>
                            </a>
                        </div>
                        <div>
                            <v-icon small>mdi-account-plus-outline</v-icon>
                            <a class="lead">
                                <router-link :to="{name: 'page.register'}">
                                    Регистрация
                                </router-link>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container head-center mob-none">
            <div class="row align-item-center justify-content-between">
                <div class="col-sm-3">
                    <img src="/images/referral-logo-small.svg" class="img-fluid">
                    <p class="text-logo">Тестовое задание</p>
                </div>
                <div class="col-sm-3 row align-center justify-content-end b-l-1">
                    <div>
                        <v-icon large>
                            mdi-clipboard-list-outline
                        </v-icon>
                    </div>
                    <div>
                        <p class="lead">
                            Пон - Суб. 8:00 - 18:00 <br>
                            <span class="text-danger">Вос. выходной</span>
                        </p>
                    </div>
                </div>
                <div class="col-sm-3 row align-center justify-content-end b-l-1">
                    <div>
                        <v-icon large>
                            mdi-truck-delivery
                        </v-icon>
                    </div>
                    <div>
                        <p class="lead">
                            Доставка по городу <br>
                            <span class="text-danger">Бесплатно</span>
                        </p>
                    </div>
                </div>
                <div class="col-sm-3 row align-center justify-content-end b-l-1">
                    <div>
                        <v-icon large>
                            mdi-phone-check-outline
                        </v-icon>
                    </div>
                    <div>
                        <p class="lead">
                            <span>
                                <a class="text-success" href="https://api.whatsapp.com/send?phone=996995686897" target="_blanck">
                                    +996 995 686897
                                </a>
                            </span><br>
                            <span>
                                <a class="text-danger" href="tel:+996995686897">+996 995 686897</a>
                            </span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid head-nav">
            <div class="container">
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <router-link to="/">
                        <a class="navbar-brand">Главная</a>
                    </router-link>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item">
                                <a class="nav-link">
                                    <router-link :to="{name: 'page.catalog'}">
                                        Каталог
                                    </router-link>
                                </a>
                            </li>
                        </ul>
                        <div class="cart-head mob-none">
                            <a class="nav-link">
                                <router-link :to="{name: 'cart'}">
                                    <span v-if="this.$store.state.cart.length <= 0">
                                        <v-badge color="green" content="0">
                                             <v-icon>mdi-cart</v-icon>
                                        </v-badge>
                                    </span>
                                    <span v-else>
                                        <v-badge color="green" :content="this.$store.state.cart.length">
                                             <v-icon>mdi-cart</v-icon>
                                        </v-badge>
                                        <span class="text-ligth">{{totalPrice}} сом</span>
                                    </span>
                                </router-link>
                            </a>
                        </div>
                    </div>
                </nav>
            </div>
        </div>

        <div class="container-fluid menu-cart-mobile-fixed">
            <div class="menu-cart-mobile-row">
                <div class="wa-m-block">
                    <a class="text-success" href="https://api.whatsapp.com/send?phone=996995686897" target="_blanck">
                        <v-icon>mdi-whatsapp</v-icon>
                    </a>
                </div>
                <div class="phone-m-block">
                    <a class="text-danger" href="tel:+996995686897">
                        <v-icon>mdi-phone</v-icon>
                    </a>
                </div>
                <div class="wa-m-block">
                    <router-link to="/">
                        <v-icon>mdi-home</v-icon>
                    </router-link>
                </div>
                <div class="cart-m-block">
                    <router-link :to="{name: 'cart'}">
                        <span v-if="this.$store.state.cart.length <= 0">
                            <v-badge color="green" content="0">
                                <v-icon>mdi-cart</v-icon>
                            </v-badge>
                        </span>
                        <span v-else>
                            <v-badge color="green" :content="this.$store.state.cart.length">
                                <v-icon>mdi-cart</v-icon>
                            </v-badge>
                        </span>
                    </router-link>
                </div>
                <div class="phone-m-block">
                    <div v-if="authCheck === false">
                        <div class="text-center">
                            <v-menu open-on-hover top offset-y>
                                <template v-slot:activator="{ on }">
                                    <div v-on="on">
                                        <v-icon>mdi-account-circle-outline</v-icon>
                                    </div>
                                </template>

                                <v-list>
                                    <v-list-item>
                                        <v-list-item-title>
                                            <div>
                                                <router-link :to="{name: 'page.login'}">
                                                    <v-icon small>mdi-account-circle-outline</v-icon>
                                                    Войти
                                                </router-link>
                                            </div>
                                            <div>
                                                <router-link :to="{name: 'page.register'}">
                                                    <v-icon small>mdi-account-plus-outline</v-icon>
                                                    Регистрация
                                                </router-link>
                                            </div>
                                        </v-list-item-title>
                                    </v-list-item>
                                </v-list>
                            </v-menu>
                        </div>
                    </div>
                    <div v-if="authCheck === true">
                        <div class="text-center">
                            <v-menu open-on-hover top offset-y>
                                <template v-slot:activator="{ on }">
                                    <div v-on="on">
                                        <v-icon>mdi-account-circle-outline</v-icon>
                                    </div>
                                </template>

                                <v-list>
                                    <v-list-item>
                                        <v-list-item-title>
                                            <div>
                                                <router-link :to="{name: 'page.profile'}">
                                                    <v-icon small>mdi-account-circle-outline</v-icon>
                                                    {{order.name}}
                                                </router-link>
                                            </div>
                                            <div>
                                                <a @click="logout">
                                                    <v-icon small>mdi-account-plus-outline</v-icon>
                                                    Выйти
                                                </a>
                                            </div>
                                        </v-list-item-title>
                                    </v-list-item>
                                </v-list>
                            </v-menu>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                order: {},
                authCheck: false,
            }
        },
        computed: {
            totalPrice() {
                return this.$store.state.cart.reduce((total, cart) => {
                    return total + cart.productQuantity * cart.productPrice;
                }, 0);
            }
        },

        created() {
            axios.get(`/api/checkout`)
                .then(res => {
                    this.order = res.data.order;
                    this.authCheck = true;
                })
                .catch(err => {})
        },

        methods:{
            logout: function(){
                localStorage.removeItem('token');
                localStorage.removeItem('loggedIn');
                this.$router.push('/login')
                    .then(res => {
                        this.text = 'Успешно вышли';
                        this.snackbar = true;
                    })
                    .catch(err => {})
            }
        },
    }
</script>

<style scoped></style>
