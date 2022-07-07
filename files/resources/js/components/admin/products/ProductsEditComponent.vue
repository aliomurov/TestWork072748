<template>
    <v-container>
        <v-row justify="center">
            <v-col cols="11">
                <div>
                    <div>
                        <br>
                        <v-toolbar-title>{{product.name}}</v-toolbar-title>
                        <br>
                        <v-form v-model="valid">
                            <v-text-field
                                v-model="product.name"
                                label="Название прдукта"
                                :rules="nameRules"
                                required
                            ></v-text-field>

                            <v-text-field
                                v-model="product.price"
                                label="Цена продукта"
                                :rules="priceRules"
                                required
                            ></v-text-field>

                            <v-select
                                v-model="product.category_id"
                                :items="categories"
                                name="category"
                                :rules="categoryRules"
                                label="Категория"
                                item-text="name"
                                item-value="id"
                                required
                            ></v-select>

                            <v-text-field
                                v-model="product.stock"
                                label="В наличие (количество сколько 100, 150, 500 ...)"
                                :rules="stockRules"
                                required
                            ></v-text-field>

                            <v-select
                                v-model="product.unit"
                                :items="units"
                                name="category"
                                :rules="unitsRules"
                                label="Ед. измерения"
                                item-text="name"
                                item-value="id"
                                required
                            ></v-select>

                            <template>
                                <v-row justify="start">
                                    <v-col cols="6">
                                        <div>
                                            <span>Мини фото</span>
                                            <v-img
                                                :src="`/files/storage/app/${product.image}`"
                                                class="grey lighten-2"
                                                aspect-ratio="1"
                                                width="100%"
                                            ></v-img>
                                        </div>
                                        <br>
                                        <div>
                                            <v-file-input
                                                v-model="editedItem.image"
                                                label="Мини фото"
                                                placeholder="Выберите изображение"
                                                accept="image/jpg, image/png, image/bmp, image/jpeg"
                                                @change="uploadImage()"
                                            ></v-file-input>
                                        </div>
                                    </v-col>
                                </v-row>
                            </template>
                            <br>
                            <v-progress-linear
                                color="indigo"
                                rounded
                                value="100"
                            ></v-progress-linear>
                            <br>
                            <template>
                                <div>
                                    <span>Галерея изображений</span>
                                </div>
                                <v-row justify="start">
                                    <div class="col-sm-2" v-for="(file, i) in files" :key="i" v-if="file.product_id === product.id">
                                        <div>
                                            <v-img
                                                :src="`/files/storage/app/${file.images}`"
                                                class="grey lighten-2"
                                                aspect-ratio="1"
                                                width="100%"
                                            ></v-img>
                                        </div>
                                        <div class="lead text-center">
                                            <span class="text-danger" @click="deleteItem(file)">Удалить</span>
                                        </div>
                                    </div>
                                </v-row>
                                <br>
                                <v-row justify="start">
                                    <v-col cols="6">
                                        <div>
                                            <v-file-input
                                                v-model="editedItem.images"
                                                label="Добавить несколько изображений"
                                                placeholder="Выберите изображение"
                                                accept="image/jpg, image/png, image/bmp, image/jpeg"
                                                outlined
                                                multiple
                                                @change="uploadFiles()"
                                            ></v-file-input>
                                        </div>
                                    </v-col>
                                </v-row>
                            </template>
                            <v-progress-linear
                                color="indigo"
                                rounded
                                value="100"
                            ></v-progress-linear>
                            <br>
                            <br>
                            <v-spacer></v-spacer>
                            <v-btn color="blue darken-1" :disabled="!valid" @click="updatePost">Сохранить</v-btn>
                        </v-form>
                    </div>
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    export default {
        data () {
            return {
                files: [],
                categories: [],
                product: {},
                units: [
                    {
                        name: 'шт',
                        id: 1,
                    },
                    {
                        name: 'кг',
                        id: 2
                    }
                ],
                valid: true,
                nameRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                priceRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                categoryRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                stockRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                unitsRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                editedItem: {
                    image: null,
                    images: null,
                },
            }
        },

        created () {
            this.initialize()
        },

        methods: {
            uploadImage(){
                if(this.editedItem.image != null)
                {
                    let formData = new FormData();
                    formData.append('image', this.editedItem.image, this.editedItem.image.name);
                    formData.append('product', this.product.id);
                    axios.post('/api/admin/products/image', formData)
                        .then(res => {
                            this.product.image = res.data.product.image;
                            this.editedItem.image = null
                        })
                        .catch(err => console.log(err.response))
                }
            },

            uploadFiles(){
                if(this.editedItem.images != null){
                    const config = { 'content-type': 'multipart/form-data' };
                    let formData = new FormData();
                    for (let images of this.editedItem.images) {
                        formData.append('images[]', images);
                    }
                    formData.append('id', this.$route.params.id);
                    axios.post('/api/admin/products/images', formData, config)
                        .then(res => {
                            this.initialize();
                            this.editedItem.images = null;
                        })
                        .catch(err => console.log(err.response))
                }
            },

            initialize () {
                axios.get(`/api/admin/products/edit/${this.$route.params.id}`)
                    .then(res => {
                        this.product = res.data.product;
                        this.categories = res.data.categories;
                        this.files = res.data.files;
                    })
                    .catch(err => console.dir(err.response))
            },

            updatePost() {
                axios.post(`/api/admin/products/update/${this.$route.params.id}`, this.product)
                    .then(res => {
                        this.$router.push({name: 'products.index'})
                    })
                    .catch(err => console.dir(err.response))
            },

            deleteItem(file){
                const index = this.files.indexOf(file);
                let decide = confirm('Вы действительно хотите удалить эту запись?');
                if(decide){
                    axios.delete('/api/admin/uploads/'+file.id)
                        .then(res => {
                            this.text = 'Успешно удален';
                            this.snackbar = true;
                            this.files.splice(index, 1);
                        }).catch(err => console.log(err.response))
                }
            }
        }
    }
</script>

<style scoped></style>
