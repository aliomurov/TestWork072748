<template>
    <span>
        <button type="button" class="btn btn-primary btn-sm" @click="addToCart" :disabled="this.stock === 0">
            <v-icon small class="mr-2">
                mdi-cart
            </v-icon>
        </button>
    </span>
</template>

<script>
    export default {
        name: "add-to-cart",
        props: {
            name: String,
            price: String,
            pId: Number,
            unit: Number,
            stock: Number,
        },
        data() {
            return {
                item: {
                    productName: this.name,
                    productPrice: this.price,
                    productId: this.pId,
                    productUnit: this.unit,
                    productStock: this.stock,
                    productQuantity: 1,
                }
            }
        },

        methods: {
            addToCart(){
                this.$store.commit('addToCart', this.item)
            },
        }
    }
</script>

<style scoped></style>
