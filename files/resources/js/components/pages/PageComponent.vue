<template>
    <div>
        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <swiper :options="swiperOption" ref="mySwiper">
                            <!-- slides -->
                            <swiper-slide v-for="(item, i) in items" :key="i">
                                <div class="block-news">
                                    <div class="img-block-news">
                                        <a href="#">
                                            <img :src="`${item.src}`" alt="404" class="img-fluid">
                                        </a>
                                    </div>
                                </div>
                            </swiper-slide>

                            <div class="swiper-pagination" slot="pagination"></div>
                            <div class="swiper-button-prev" slot="button-prev"></div>
                            <div class="swiper-button-next" slot="button-next"></div>
                        </swiper>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-4 text-left">
                            <h4 class="h4">Все продукты</h4>
                        </div>
                        <div class="col-sm-4 text-right mob-none">
                            <a class="lead">Каталог</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <v-card
                            class="mx-auto"
                            max-width="300"
                            tile
                        >
                            <v-list flat>
                                <v-subheader>Категории</v-subheader>
                                <v-list-item-group color="primary">
                                    <v-list-item
                                        v-for="(category, i) in categories"
                                        :key="i"
                                    >
                                        <v-list-item-icon>
                                            <v-icon medium>
                                                mdi-arrow-right-bold-circle
                                            </v-icon>
                                        </v-list-item-icon>
                                        <v-list-item-content>
                                            <v-list-item-title>
                                                <router-link :to="{name: 'page.product', params: { id: category.id }}">
                                                    {{category.name}}
                                                </router-link>
                                            </v-list-item-title>
                                        </v-list-item-content>
                                    </v-list-item>
                                </v-list-item-group>
                            </v-list>
                        </v-card>
                    </div>
                    <div class="col-sm-9">
                        <div class="row page-product-card">
                            <div v-for="(product, i) in products.data" :key="i">
                                <div class="card" style="width: 17rem;">
                                    <img :src="`files/storage/app/${product.image}`" class="card-img-top" height="210">
                                    <div class="card-body">
                                        <div class="row but-page-cart">
                                            <div>
                                                <h5 class="card-title">
                                                    {{product.name | truncate(12, '...') }}
                                                    <span v-for="item in carts" v-if="item.productId === product.id" class="icon-g">
                                                        <v-icon small>
                                                            mdi-check-bold
                                                        </v-icon>
                                                    </span>
                                                </h5>
                                            </div>
                                        </div>
                                        <p class="card-text">
                                            1
                                            <span v-if="product.unit === 1">шт.</span>
                                            <span v-if="product.unit === 2">кг.</span>
                                            - {{product.price}} сом:
                                            <span>
                                                (
                                                {{product.stock}}
                                                <span v-if="product.unit === 1">шт.</span>
                                                <span v-if="product.unit === 2">кг.</span>
                                                )
                                            </span>
                                        </p>
                                        <div class="row but-page-cart">
                                            <div>
                                                <span>
                                                    <button type="button" class="btn btn-primary btn-sm" @click="addToCart(product)">
                                                        <v-icon small class="mr-2">
                                                            mdi-cart
                                                        </v-icon>
                                                        В корзину
                                                    </button>
                                                </span>
                                            </div>
                                            <div>
                                                <button v-for="item in carts" v-if="item.productId === product.id" @click="$store.commit('removeFromCart', item)" type="button" class="btn btn-danger btn-sm">
                                                    <v-icon small class="mr-2">
                                                        mdi-delete-empty
                                                    </v-icon>
                                                    Удалить
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-center">
                            <v-container>
                                <v-row justify="center">
                                    <div class="col-md-8">
                                        <v-pagination
                                            v-model="pagination.current_page"
                                            :length="pagination.last_page"
                                            @input="onPageChange"
                                            :total-visible="pagination.last_page"
                                        ></v-pagination>
                                    </div>
                                    <div class="col-md-4">
                                        Продуктов: {{pagination.from_page}} - {{pagination.to_page}}
                                        из: {{pagination.total_page}}
                                    </div>
                                </v-row>
                            </v-container>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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

    </div>
</template>

<script>
    import MenuComponent from "../include/MenuComponent";

    export default {
        components:{
            'MenuComponent': MenuComponent,
        },
        name: 'carrousel',
        data() {
            return {
                items: [
                    {
                        src: '/images/slider-1.jpg',
                    },
                    {
                        src: '/images/slider-2.jpg',
                    },
                    {
                        src: '/images/slider-3.jpg',
                    },
                    {
                        src: '/images/slider-4.jpg',
                    },
                ],
                products: [],
                carts: {},
                categories: {},
                snackbar: false,
                text: '',
                y: 'top',
                swiperOption: {
                    autoplay: {
                        delay: 3500,
                        disableOnInteraction: false
                    },
                    grabCursor: true,
                    slidesPerView: 1,
                    centeredSlides: true,
                    coverflowEffect: {
                        rotate: 50,
                        stretch: 0,
                        depth: 100,
                        modifier: 1,
                        slideShadows : true
                    },
                    loop: true,
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true
                    },
                    navigation: {
                        nextEl: ".swiper-button-next",
                        prevEl: ".swiper-button-prev"
                    }
                },
                pagination: {},
            }
        },

        mounted(){
            this.snackbar = localStorage.getItem('loggedIn') ? true : false;
            this.text = 'Успешно зарегестрировались';
            localStorage.removeItem('loggedIn');
        },

        computed: {
            swiper() {
                return this.$refs.mySwiper.swiper;
            },
        },

        created () {
            this.initialize()
        },

        methods: {
            initialize(){
                axios.get(`/api/`, {params:{'page':this.pagination.current_page, 'per_page':this.pagination.per_page}})
                    .then(res => {
                        this.categories = res.data.categories;
                        this.products = res.data.products;
                        this.carts = this.$store.state.cart;
                        this.makePagination(res.data.products)
                    })
                    .catch(err => console.dir(err.response));
            },
            onPageChange() {
                this.initialize();
            },

            makePagination(response){
                let pagination = {
                    current_page: response.current_page,
                    last_page: response.last_page,
                    from_page: response.from,
                    to_page: response.to,
                    total_page: response.total,
                    per_page: response.per_page,
                    path_page: response.path+"?page="+this.pagination.current_page,
                    first_link: response.first_page_url,
                    last_link: response.last_page_url,
                    prev_link: response.prev_page_url,
                    next_link: response.next_page_url,
                };

                this.pagination = pagination;
            },

            addToCart(product){
                this.$store.commit('addToCart', {
                    productName: product.name,
                    productPrice: product.price,
                    productId: product.id,
                    productUnit: product.unit,
                    productStock: product.stock,
                    productQuantity: 1,
                })
            },
        }
    }
</script>

<style scoped></style>
