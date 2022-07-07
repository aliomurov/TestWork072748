<template>
    <v-container>
        <v-row justify="center">
            <div class="col-sm-11" v-if="!loading">
                <br>
                <v-toolbar-title>Компания - {{order.user.name_company}}, (Всего к оплате: {{order.total_price}} сом)</v-toolbar-title>
                <br>
                <div class="row">
                    <div class="col-sm-6">
                        <table class="table">
                            <thead class="thead-dark">
                            <tr>
                                <th scope="col">Данные заказчика</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">ФИО</th>
                                <td>{{order.user.name}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Email</th>
                                <td>{{order.user.email}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Комапния</th>
                                <td>{{order.user.name_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Тип компании</th>
                                <td>{{order.user.type_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Область (город)</th>
                                <td>{{order.user.city_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Адрес компании (улица, №)</th>
                                <td>{{order.user.address_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Телефон компании</th>
                                <td>{{order.user.phone_company}}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-sm-6" v-if="order.city != 'undefined'">
                        <table class="table">
                            <thead class="thead-dark">
                            <tr>
                                <th scope="col">Другой адрес</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">Область (город)</th>
                                <td>{{order.city}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Адрес компании (улица, №)</th>
                                <td>{{order.address}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Телефон компании</th>
                                <td>{{order.phone}}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <v-form v-model="valid">
                            <v-col cols="12" sm="12">
                                <v-select
                                    :rules="checkRules"
                                    required color="error"
                                    :items="items"
                                    v-model="order.check"
                                    item-text="name"
                                    item-value="id"
                                    label="Выберите статус заказа"
                                ></v-select>
                            </v-col>
                            <v-spacer></v-spacer>
                            <br>
                            <v-btn color="blue darken-1" :disabled="!valid" text @click="update">Сохранить</v-btn>
                        </v-form>
                    </div>
                </div>
            </div>

            <v-col cols="11" v-if="!loading">
                <br>
                <v-progress-linear
                    color="indigo"
                    rounded
                    value="100"
                ></v-progress-linear>
                <br>
                <h4>История заказов</h4>
                <br>
                <v-data-table
                    :headers="headers"
                    :items="products"
                    :footer-props="{
                        itemsPerPageOptions: [5, 10, 15],
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
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    export default {
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
                loading: false,
                order: {},
                products: {},
                items: [
                    {
                        name: 'Доставлено',
                        id: 2,
                    },
                    {
                        name: 'Не доставлено',
                        id: 1,
                    }
                ],
                valid: true,
                checkRules: [v => !!v || 'Это поле обьязательно для заполнения'],
            }
        },

        created () {
            this.initialize()
        },

        methods: {
            initialize () {
                this.loading = true;
                axios.get(`/api/admin/orders/edit/${this.$route.params.id}`)
                    .then(res => {
                        this.order = res.data.order;
                        this.products = res.data.products;
                        this.loading = false;
                    })
                    .catch(err => console.dir(err.response))
            },

            update() {
                axios.post(`/api/admin/orders/update/${this.$route.params.id}`, this.order)
                    .then(res => {
                        this.$router.push({name: 'orders.index'});
                    })
                    .catch(err => console.dir(err.response))
            }
        }
    }
</script>

<style scoped></style>
