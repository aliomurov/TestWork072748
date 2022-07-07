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
            :server-items-length="categories.total"
            :items="categories.data"
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
                    <v-toolbar-title>Список категорий</v-toolbar-title>
                    <v-divider
                        class="mx-4"
                        inset
                        vertical
                    ></v-divider>
                    <v-text-field
                        @input="searchIt"
                        append-icon="mdi-magnify"
                        label="Поиск ..."
                        single-line
                        hide-details
                    ></v-text-field>
                    <v-spacer></v-spacer>
                    <template>
                        <router-link :to="{name: 'categories.create'}">
                            <v-btn color="primary" dark class="mb-2 mr-2">Добавить</v-btn>
                        </router-link>
                        <v-btn @click="deleteAll" color="error" dark class="mb-2 mr-2">Удалить</v-btn>
                    </template>
                </v-toolbar>
            </template>
            <template v-slot:item.actions="{ item }">
                <router-link :to="{name: 'categories.edit', params: { id: item.id }}">
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
                { text: 'Название категории', value: 'name' },
                { text: 'Дата создания', value: 'created_at' },
                { text: 'Действия', value: 'actions', sortable: false,},
            ],
            selected: [],
            categories: [],
        }),

        watch: {
            options: {
                handler(e) {
                    axios.get(`/api/admin/categories`, {params: {'page': e.page, 'per_page': e.itemsPerPage}})
                        .then(res => {
                            this.categories = res.data.categories
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
                    axios.post('/api/admin/categories/delete', {'categories': this.selected})
                        .then(res => {
                            this.text = 'Записи удалены';
                            this.selected.map(val => {
                                const index = this.categories.data.indexOf(val);
                                this.categories.data.splice(index, 1)
                            });
                            this.snackbar = true
                        }).catch(err => console.log(err.response))
                }
            },
            searchIt(e){
                if (e.length >= 3) {
                    axios
                        .get(`/api/admin/categories/${e}`)
                        .then(res => (this.categories = res.data.categories))
                        .catch(err => console.dir(err.response));
                }
                if (e.length <= 0) {
                    axios
                        .get(`/api/admin/categories/`)
                        .then(res => (this.categories = res.data.categories))
                        .catch(err => console.dir(err.response));
                }
            },
            paginate(e){
                axios.get(`/api/admin/categories`,{params:{'page':e.page, 'per_page':e.itemsPerPage}})
                    .then(res => {
                        this.categories = res.data.categories
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
                const index = this.categories.data.indexOf(item);
                let decide = confirm('Вы действительно хотите удалить эту запись?');
                if(decide){
                    axios.delete('/api/admin/categories/'+item.id)
                        .then(res => {
                            this.text = 'Успешно удален';
                            this.snackbar = true;
                            this.categories.data.splice(index, 1)
                        }).catch(err => console.log(err.response))
                }
            },
        },
    }
</script>

<style scoped></style>
