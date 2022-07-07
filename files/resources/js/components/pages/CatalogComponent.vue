<template>
    <div>
        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-4 text-left">
                            <h2 class="h2">Каталог</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="row page-product-card">
                            <div v-for="(category, i) in categories" :key="i">
                                <div class="card" style="width: 17rem;">
                                    <div class="card-body">
                                        <h5 class="card-title">
                                            <router-link :to="{name: 'page.product', params: { id: category.id }}">
                                                {{category.name}}
                                            </router-link>
                                        </h5>
                                    </div>
                                </div>
                            </div>
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
        data() {
            return {
                categories: [],
                snackbar: false,
                text: '',
                y: 'top',
            }
        },

        created () {
            this.initialize()
        },

        methods: {
            initialize (){
                axios.get("/api/catalog")
                    .then(res => {
                        this.categories = res.data.categories;
                    })
                    .catch(err => console.dir(err.response));
            },
        }
    }
</script>

<style scoped>
    .icon-w i{
        color: #fff;
    }
    .icon-g i{
        color: green;
    }
    .icon-d i{
        color: red;
    }
    .but-page-cart div{
        margin: 0 5px;
    }
    .card{
        margin: 10px;
    }
</style>
