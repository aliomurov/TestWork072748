<template>
    <v-col
        cols="11"
    >
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

        <v-data-table
            item-key="name"
            class="elevation-1"
            color="primary"
            :loading = "loading"
            loading-text="Загрузка... Пожалуйста подождите"
            :headers="headers"
            :options.sync="options"
            :server-items-length="orders.total"
            :items="orders.data"
            show-select
            @input="selectAll"
            :footer-props="{
                itemsPerPageOptions: [5, 10, 15],
                itemsPerPageText: 'Страница',
                'show-current-page': true,
                'show-first-last-page': true
            }"
        >
            <template v-slot:top>
                <v-toolbar flat color="light">
                    <v-toolbar-title>Список Заявок</v-toolbar-title>
                    <v-divider
                        class="mx-4"
                        inset
                        vertical
                    ></v-divider>
                    <v-spacer></v-spacer>
                    <template>
                        <v-btn @click="deleteAll" color="error" dark class="mb-2 mr-2">Удалить</v-btn>
                    </template>
                </v-toolbar>
            </template>
            <template v-slot:item.total_price="{ item }">
                {{item.total_price}} сом
            </template>
            <template v-slot:item.check="{ item }">
                <span v-if="item.check === 1" class="i-close">
                    <v-icon medium>
                        mdi-close-circle
                    </v-icon>
                </span>
                <span v-if="item.check === 2" class="i-check">
                    <v-icon medium>
                        mdi-check-circle
                    </v-icon>
                </span>
            </template>
            <template v-slot:item.actions="{ item }">
                <router-link :to="{name: 'orders.edit', params: { id: item.id }}">
                    <v-icon small class="mr-2">
                        mdi-pencil
                    </v-icon>
                </router-link>
                <v-icon
                    small
                    @click="deleteItem(item)"
                >
                    mdi-delete
                </v-icon>
            </template>
            <template v-slot:no-data>
                <v-btn color="primary" @click="initialize">Reset</v-btn>
            </template>
        </v-data-table>
    </v-col>
</template>

<script>
    export default {
        data: () => ({
            snackbar: false,
            text: '',
            loading: false,
            y: 'top',
            options:{
                itemsPerPage: 5
            },
            headers: [
                {
                    text: 'id',
                    align: 'start',
                    sortable: false,
                    value: 'id',
                },
                { text: 'Компания', value: 'user.name_company', sortable: false},
                { text: 'Телефон', value: 'user.phone_company', sortable: false},
                { text: 'Тип', value: 'user.type_company', sortable: false},
                { text: 'Общая цена', value: 'total_price', sortable: false},
                { text: 'Статус', value: 'check', sortable: false},
                { text: 'Дата заказа', value: 'created_at', sortable: false},
                { text: 'Действия', value: 'actions', sortable: false,},
            ],
            selected: [],
            orders: [],
        }),

        watch: {
            options: {
                handler(e) {
                    axios.get(`/api/admin/orders`, {params: {'page': e.page, 'per_page': e.itemsPerPage}})
                        .then(res => {
                            this.orders = res.data.orders
                        })
                        .catch(err => {
                            if(err.response.status === 401)
                                localStorage.removeItem('token');
                            this.$router.push('/admin/login');
                        })
                },
                deep: true
            }
        },

        created () {
            this.initialize()
        },

        methods: {
            selectAll(e){
                this.selected = [];
                if(e.length > 0){
                    this.selected = e.map(val => val.id)
                }
            },
            deleteAll(){
                let decide = confirm('Вы действительно хотите удалить эти записи?');
                if(decide){
                    axios.post('/api/admin/orders/delete', {'orders': this.selected})
                        .then(res => {
                            this.text = 'Записи удалены';
                            this.selected.map(val => {
                                const index = this.orders.data.indexOf(val);
                                this.orders.data.splice(index, 1)
                            });
                            this.snackbar = true
                        }).catch(err => console.log(err.response))
                }
            },
            paginate(e){
                axios.get(`/api/admin/orders`,{params:{'page':e.page, 'per_page':e.itemsPerPage}})
                    .then(res => {
                        this.orders = res.data.orders
                    })
                    .catch(err => {
                        if(err.response.status === 401)
                            localStorage.removeItem('token');
                        this.$router.push('/admin/login');
                    })
            },
            initialize () {
                axios.interceptors.request.use((config) => {
                    this.loading = true;
                    return config;
                }, (error) => {
                    this.loading = false;
                    return Promise.reject(error);
                });

                axios.interceptors.response.use((response) => {
                    this.loading = false;
                    return response;
                }, (error) => {
                    this.loading = false;
                    return Promise.reject(error);
                });
            },
            deleteItem (item) {
                const index = this.orders.data.indexOf(item);
                let decide = confirm('Вы действительно хотите удалить эту запись?');
                if(decide){
                    axios.delete('/api/admin/orders/'+item.id)
                        .then(res => {
                            this.text = 'Успешно удален';
                            this.snackbar = true;
                            this.orders.data.splice(index, 1)
                        }).catch(err => console.log(err.response))
                }
            },
        },
    }
</script>

<style scoped>
    .i-close i{
        color: red;
    }

    .i-check i{
        color: green;
    }
</style>
