<template>
    <div>
        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-6 text-left">
                            <h2 class="h2">История заказов</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container pk-none">
                <div class="row">
                    <div class="col">
                        <router-link :to="{name: 'page.profile'}">
                            <v-icon>mdi-step-backward-2</v-icon>
                            Назад в личный кабинет
                        </router-link>
                    </div>
                </div>
                <v-progress-linear
                    color="indigo"
                    rounded
                    value="100"
                ></v-progress-linear>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <v-expansion-panels focusable>
                            <v-expansion-panel
                                v-for="(order ,i) in orders"
                                :key="i"
                            >
                                <v-expansion-panel-header>
                                    Заказ №{{order.id}} (На сумму: {{order.total_price}} сом),
                                    <span class="text-danger text-c-a">Дата заказ: {{order.created_at}}</span>
                                </v-expansion-panel-header>
                                <v-expansion-panel-content>
                                    <v-data-table
                                        :headers="headers"
                                        :items="order.products"
                                        :footer-props="{
                                            itemsPerPageOptions: [10, 15, 20],
                                            itemsPerPageText: 'Страница',
                                            'show-current-page': true,
                                            'show-first-last-page': true
                                        }"
                                        class="elevation-1"
                                    >
                                        <template v-slot:item.price="{ item }">
                                            1
                                            <span v-if="item.unit === 1">шт</span>
                                            <span v-if="item.unit === 2">кг</span>
                                            - {{item.price}} сом

                                        </template>
                                        <template v-slot:item.pivot.quantity="{ item }">
                                            {{item.pivot.quantity}}
                                            <span v-if="item.unit === 1">шт</span>
                                            <span v-if="item.unit === 2">кг</span>
                                        </template>
                                        <template v-slot:item.total="{ item }">
                                            {{item.price * item.pivot.quantity}} сом
                                        </template>
                                        <template v-slot:item.image="{ item }">
                                            <v-list-item-avatar>
                                                <v-img
                                                    :src="`/files/storage/app/${item.image}`"
                                                    aspect-ratio="1"
                                                    class="grey lighten-2"
                                                ></v-img>
                                            </v-list-item-avatar>
                                        </template>
                                    </v-data-table>
                                </v-expansion-panel-content>
                            </v-expansion-panel>
                        </v-expansion-panels>
                    </div>
                </div>
                <br>
                <div class="row mob-none">
                    <router-link :to="{name: 'page.profile'}">
                        <a class="btn btn-primary">
                            Назад в личный кабинет
                        </a>
                    </router-link>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import MenuComponent from "../include/MenuComponent";
    export default {
        components:{
            'MenuComponent': MenuComponent
        },
        data () {
            return {
                headers: [
                    {
                        text: 'id',
                        align: 'start',
                        sortable: false,
                        value: 'id',
                    },
                    { text: 'Наименование продукта', value: 'name', sortable: false},
                    { text: 'Цена', value: 'price', sortable: false},
                    { text: 'Количество', value: 'pivot.quantity', sortable: false},
                    { text: 'Всего', value: 'total', sortable: false},
                    { text: 'Изображение', value: 'image', sortable: false},
                ],
                user: {},
                orders: {},
            }
        },

        created () {
            this.initialize()
        },

        methods: {
            initialize () {
                axios.get(`/api/profile/order/${this.$route.params.id}`)
                    .then(res => {
                        this.user = res.data.user;
                        this.orders = res.data.orders;
                    })
                    .catch(err => console.dir(err.response))
            },
        }
    }
</script>

<style scoped>
    .text-c-a{
        margin-left: 15px;
    }
</style>
