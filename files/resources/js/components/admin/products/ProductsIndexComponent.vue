<template>
    <div class="container-fluid">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-sm-11">
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
                        :server-items-length="products.total"
                        :items="products.data"
                        show-select
                        @input="selectAll"
                        :footer-props="{
                            itemsPerPageOptions: [5, 10, 15, products.total],
                            itemsPerPageText: 'Страница',
                            'show-current-page': true,
                            'show-first-last-page': true
                        }"
                    >
                        <template v-slot:top>
                            <v-toolbar flat color="light">
                                <v-toolbar-title>Продукты</v-toolbar-title>
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
                                    <export-excel
                                        :data="products.data"
                                        :fields="json_fields"
                                        name="products.xls">
                                        <v-btn color="secondary" dark class="mb-2 mr-2">Экспортировать</v-btn>
                                    </export-excel>
                                    <router-link :to="{name: 'products.create'}">
                                        <v-btn color="primary" dark class="mb-2 mr-2">Добавить</v-btn>
                                    </router-link>
                                    <v-btn @click="deleteAll" color="error" dark class="mb-2 mr-2">Удалить</v-btn>
                                </template>
                            </v-toolbar>
                        </template>
                        <template v-slot:item.unit="{ item }">
                            <span v-if="item.unit === 1">шт</span>
                            <span v-if="item.unit === 2">кг</span>
                        </template>
                        <template v-slot:item.image="{ item }">
                            <v-edit-dialog>
                                <v-list-item-avatar>
                                    <v-img
                                        :src="`/files/storage/app/${item.image}`"
                                        aspect-ratio="1"
                                        class="grey lighten-2"
                                    ></v-img>
                                </v-list-item-avatar>
                                <template v-slot:input>
                                    <v-file-input
                                        v-model="editedItem.image"
                                        label="Изображение"
                                        placeholder="Выберите изображение"
                                        accept="image/jpg, image/png, image/bmp, image/jpeg"
                                        @change="uploadImage(item)"
                                    ></v-file-input>
                                </template>
                            </v-edit-dialog>
                        </template>
                        <template v-slot:item.actions="{ item }">
                            <router-link :to="{name: 'products.edit', params: { id: item.id }}">
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
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row justify-center text-center">
                <div class="col-sm-5">
                    <v-row justify="start">
                        <v-btn
                            color="primary"
                            dark
                            @click.stop="dialog = true"
                        >
                            Импорт
                        </v-btn>

                        <v-dialog
                            v-model="dialog"
                            max-width="390"
                        >
                            <v-card>
                                <v-card-title class="headline">Выберите файл</v-card-title>

                                <v-card-text>
                                    <v-form>
                                        <div>
                                            <v-file-input
                                                v-model="product.importFile"
                                                label="Обновить продукты"
                                                placeholder="Выберите файл"
                                                outlined
                                                @change="importProduct()"
                                            ></v-file-input>
                                        </div>
                                    </v-form>
                                </v-card-text>

                                <v-card-actions>
                                    <v-spacer></v-spacer>

                                    <v-btn
                                        color="green darken-1"
                                        text
                                        @click="dialog = false"
                                    >
                                        Закрыть
                                    </v-btn>
                                </v-card-actions>
                            </v-card>
                        </v-dialog>
                    </v-row>
                </div>
                <div class="col-sm-5">

                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data: () => ({
            json_fields: {
                'ID': 'id',
                'Имя продукта': 'name',
                'Категория': 'category_id',
                'Цена': 'price',
                'Кол-во': 'stock',
                'Ед.измерения': 'unit',
                'Фото': 'image',
            },
            product: {
                importFile: null,
            },
            valid: true,
            snackbar: false,
            text: '',
            dialog: false,
            loading: false,
            y: 'top',
            options:{
                sortBy:['name'],
                sortDesc:[true],
                itemsPerPage: 5
            },
            headers: [
                {
                    text: 'id',
                    align: 'start',
                    sortable: false,
                    value: 'id',
                },
                { text: 'Название', value: 'name' },
                { text: 'Цена', value: 'price'},
                { text: 'В наличие', value: 'stock', sortable: false},
                { text: 'Ед. измерение', value: 'unit', sortable: false},
                { text: 'Изображение', value: 'image', sortable: false},
                { text: 'Дата создания', value: 'created_at' },
                { text: 'Действия', value: 'actions', sortable: false},
            ],
            selected: [],
            products: [],
            editedIndex: -1,
            editedItem: {
                id: '',
                image: null,
            },
        }),

        watch: {
            dialog (val) {
                val || this.close()
            },
            options: {
                handler(e) {
                    const sortBy = this.options.sortBy.length === 0 ? 'name' : this.options.sortBy[0];
                    const orderBy = this.options.sortDesc.length > 0 && this.options.sortDesc[0] ? 'asc' : 'desc';
                    axios.get(`/api/admin/products`, {params: {'page': e.page, 'per_page': e.itemsPerPage, 'sort_by': sortBy, 'order_by': orderBy}})
                        .then(res => {
                            this.products = res.data.products;
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
            importProduct()
            {
                if(this.product.importFile != null)
                {
                    let formData = new FormData();
                    formData.append('import_file', this.product.importFile);
                    axios.post('/api/admin/products/import', formData)
                        .then(res => {
                            this.initialize();
                            this.product.importFile = null;
                        })
                        .catch(err => console.log(err.response))
                }
                this.close()
            },

            uploadImage(item){
                if(this.editedItem.image != null)
                {
                    const index = this.products.data.indexOf(item);
                    let formData = new FormData();
                    formData.append('image', this.editedItem.image, this.editedItem.image.name);
                    formData.append('product', item.id);
                    axios.post('/api/admin/products/image', formData)
                        .then(res => {
                            this.products.data[index].image = res.data.product.image
                            this.editedItem.image = null
                        })
                        .catch(err => console.log(err.response))
                }
            },
            selectAll(e){
                this.selected = [];
                if(e.length > 0){
                    this.selected = e.map(val => val.id)
                }
            },
            deleteAll(){
                let decide = confirm('Вы действительно хотите удалить эти записи?');
                if(decide){
                    axios.post('/api/admin/products/delete', {'products': this.selected})
                        .then(res => {
                            this.text = 'Записи удалены';
                            this.selected.map(val => {
                                const index = this.products.data.indexOf(val);
                                this.products.data.splice(index, 1);
                            });
                            this.snackbar = true;
                            this.paginate();
                        }).catch(err => console.log(err.response))
                }
                this.close();
            },
            searchIt(e){
                if(e.length >= 3){
                    axios.get(`/api/admin/products/${e}`)
                        .then(res => {this.products = res.data.products})
                        .catch(err => console.dir(err.response))
                }
                if(e.length <= 0){
                    const sortBy = this.options.sortBy.length === 0 ? 'name' : this.options.sortBy[0];
                    const orderBy = this.options.sortDesc.length > 0 && this.options.sortDesc[0] ? 'asc' : 'desc';
                    axios.get(`/api/admin/products`, {params: {'page': e.page, 'per_page': e.itemsPerPage, 'sort_by': sortBy, 'order_by': orderBy}})
                        .then(res => this.products = res.data.products)
                        .catch(err => console.dir(err.response))
                }
            },
            paginate(e){
                const sortBy = this.options.sortBy.length === 0 ? 'name' : this.options.sortBy[0];
                const orderBy = this.options.sortDesc.length > 0 && this.options.sortDesc[0] ? 'asc' : 'desc';
                axios.get(`/api/admin/products`,{params:{'page':e.page, 'per_page':e.itemsPerPage, 'sort_by': sortBy, 'order_by': orderBy}})
                    .then(res => {
                        this.products = res.data.products;
                    })
                    .catch(err => {
                        if(err.response.status === 401)
                            localStorage.removeItem('token');
                        this.$router.push('/admin/login');
                    })
            },
            initialize (e) {
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
                const index = this.products.data.indexOf(item);
                let decide = confirm('Вы действительно хотите удалить эту запись?');
                if(decide){
                    axios.delete('/api/admin/products/'+item.id)
                        .then(res => {
                            this.text = 'Успешно удален';
                            this.snackbar = true;
                            this.products.data.splice(index, 1)
                        }).catch(err => console.log(err.response))
                }
                this.close()
            },
            close () {
                this.dialog = false;
                this.$nextTick(() => {
                    this.products = Object.assign({}, this.products);
                    this.editedIndex = -1;
                    this.initialize();
                })
            },
        },
    }
</script>

<style scoped></style>
