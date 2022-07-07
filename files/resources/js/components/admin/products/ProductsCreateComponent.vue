<template>
    <v-container>
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

        <v-row justify="center">
            <v-col cols="11">
                <div>
                    <div>
                        <br>
                        <v-toolbar-title>Добавление нового продукта</v-toolbar-title>
                        <br>
                        <v-form
                            v-model="valid"
                        >
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
                                v-model="product.category"
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

                            <br>

                            <template>
                                <v-row justify="center">
                                    <v-col cols="6">
                                        <div>
                                            <v-file-input
                                                v-model="product.image"
                                                label="Мини фото"
                                                placeholder="Выберите изображение"
                                                accept="image/jpg, image/png, image/bmp, image/jpeg"
                                                outlined
                                            ></v-file-input>
                                        </div>
                                    </v-col>
                                    <v-col cols="6">
                                        <div>
                                            <v-file-input
                                                v-model="editedItem.files"
                                                label="Добавить несколько изображений"
                                                placeholder="Выберите изображение"
                                                accept="image/jpg, image/png, image/bmp, image/jpeg"
                                                outlined
                                                multiple
                                            ></v-file-input>
                                        </div>
                                    </v-col>
                                </v-row>
                            </template>
                            <v-spacer></v-spacer>
                            <v-btn color="blue darken-1" :disabled="!valid" @click="addProduct">Добавить</v-btn>
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
                editedItem: {
                    files: [],
                },
                categories: [],
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
                product: {},
                valid: true,
                nameRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                priceRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                categoryRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                stockRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                unitsRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                text: '',
                snackbar: false,
                y: 'top',
            }
        },

        created () {
            this.initialize()
        },

        methods: {
            initialize () {
                axios.get(`/api/admin/products/create/`)
                    .then(res => {
                        this.categories = res.data.categories
                    })
                    .catch(err => console.dir(err.response))
            },

            validateForm(){
                if(!this.product.image){
                    this.snackbar = true;
                    this.text = 'Выберите изображение!';
                    return false;
                }
                return true;
            },

            addProduct() {
                if(!this.validateForm()){
                    return false;
                }

                const config = { 'content-type': 'multipart/form-data' };
                const formData = new FormData();
                for (let files of this.editedItem.files) {
                    formData.append('files[]', files);
                }
                formData.append('image', this.product.image);
                formData.append('name', this.product.name);
                formData.append('price', this.product.price);
                formData.append('stock', this.product.stock);
                formData.append('unit', this.product.unit);
                formData.append('category_id', this.product.category);
                axios.post(`/api/admin/products`, formData, config)
                    .then(res => {
                        console.log(this.$router.push({name: 'products.index'}))
                    })
                    .catch(err =>{
                        this.text = err.response.data.status;
                        this.snackbar = true;
                    })
            },
        }
    }
</script>

<style scoped></style>
