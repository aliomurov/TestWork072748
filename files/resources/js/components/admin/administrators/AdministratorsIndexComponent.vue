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
            :server-items-length="administrators.total"
            :items="administrators.data"
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
                    <v-toolbar-title>Список администраторов</v-toolbar-title>
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
                        <router-link :to="{name: 'administrators.create'}">
                            <v-btn color="primary" dark class="mb-2 mr-2">Добавить</v-btn>
                        </router-link>
                        <v-btn @click="deleteAll" color="error" dark class="mb-2 mr-2">Удалить</v-btn>
                    </template>
                </v-toolbar>
            </template>
            <template v-slot:item.role="{ item }">
                <div v-if="item.role === 1">
                    Администратор
                </div>
                <div v-if="item.role === 2">
                    Менеджер
                </div>
            </template>
            <template v-slot:item.actions="{ item }">
                <router-link :to="{name: 'administrators.edit', params: { id: item.id }}">
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
                { text: 'ФИО', value: 'name' },
                { text: 'Email', value: 'email' },
                { text: 'Роль', value: 'role' },
                { text: 'Дата создания', value: 'created_at' },
                { text: 'Действия', value: 'actions', sortable: false },
            ],
            selected: [],
            administrators: [],
        }),

        watch: {
            options: {
                handler(e) {
                    console.dir(e);
                    axios.get(`/api/admin/administrators`, {params: {'page': e.page, 'per_page': e.itemsPerPage}})
                        .then(res => {
                            this.administrators = res.data.administrators
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
                    axios.post('/api/admin/administrators/delete', {'administrators': this.selected})
                        .then(res => {
                            this.text = 'Записи удалены';
                            this.selected.map(val => {
                                const index = this.administrators.data.indexOf(val);
                                this.administrators.data.splice(index, 1)
                            });
                            this.snackbar = true
                        })
                        .catch(err =>{
                            this.text = err.response.data.status;
                            this.snackbar = true;
                        })
                }
            },
            searchIt(e){
                if(e.length >= 3){
                    axios.get(`/api/admin/administrators/${e}`)
                        .then(res => {this.administrators = res.data.administrators})
                        .catch(err => console.dir(err.response))
                }
                if(e.length <= 0){
                    axios.get(`/api/admin/administrators`, {params: {'page': e.page, 'per_page': e.itemsPerPage}})
                        .then(res => this.administrators = res.data.administrators)
                        .catch(err => console.dir(err.response))
                }
            },
            paginate(e){
                axios.get(`/api/admin/administrators`,{params:{'page':e.page, 'per_page':e.itemsPerPage}})
                    .then(res => {
                        this.administrators = res.data.administrators
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
                const index = this.administrators.data.indexOf(item)
                let decide = confirm('Вы действительно хотите удалить эту запись?')
                if(decide){
                    axios.delete('/api/admin/administrators/'+item.id)
                        .then(res => {
                            this.text = 'Успешно удален';
                            this.snackbar = true;
                            this.administrators.data.splice(index, 1)
                        })
                        .catch(err =>{
                            this.text = err.response.data.status;
                            this.snackbar = true;
                        })
                }
            },
        },
    }
</script>

<style scoped></style>
