<template>
    <v-data-table
        :headers="headers"
        :items="got_users"
        disable-sort
        locale="ru-Ru"
        mobile-breakpoint="300"
        class="elevation-1"
        :search="search"
    >

      <template v-slot:top>
        <v-toolbar            flat        >
          <v-text-field
              v-model="search"
              append-icon="mdi-magnify"
              label="Search"
              single-line
              hide-details
              dense
              outlined
          ></v-text-field>
          <v-spacer></v-spacer>
          <v-dialog
              v-model="dialog"
              max-width="500px"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                  color="primary"
                  dark
                  class="mb-2"
                  v-bind="attrs"
                  v-on="on"
                  x-small
                  plain
              >
                <v-icon>mdi-account-plus</v-icon>
              </v-btn>
            </template>
            <v-card>
              <v-card-title>
                <span class="overline">{{ formTitle }}</span>
              </v-card-title>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col
                        cols="12"
                        sm="6"
                        md="4"
                    >
                      <v-text-field
                          dense
                          v-model="editedItem.surname"
                          label="Фамилия"
                      ></v-text-field>
                    </v-col>
                    <v-col
                        cols="12"
                        sm="6"
                        md="4"
                    >
                      <v-text-field
                          dense
                          v-model="editedItem.name"
                          label="Имя"
                      ></v-text-field>
                    </v-col>
                    <v-col
                        cols="12"
                        sm="6"
                        md="4"
                    >
                      <v-text-field
                          dense
                          v-model="editedItem.patronymic"
                          label="Отчество"
                      ></v-text-field>
                    </v-col>
                    <v-col
                        cols="12"
                        sm="6"
                        md="4"
                    >
                      <v-text-field
                          dense
                          v-model="editedItem.birthday"
                          label="День рождения"
                      ></v-text-field>
                    </v-col>
                    <v-col
                        cols="12"
                        sm="6"
                        md="4"
                    >
                      <v-text-field
                          dense
                          v-model="editedItem.start_date"
                          label="Начало работы"
                      ></v-text-field>
                    </v-col>
                    <v-col
                        cols="12"
                        sm="6"
                        md="4"
                    >
                      <v-text-field
                          dense
                          v-model="editedItem.internal_code"
                          label="Внутренний код"
                      ></v-text-field>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>

              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                    color="blue darken-1"
                    text
                    @click="close"
                >
                  Закрыть
                </v-btn>
                <v-btn
                    color="blue darken-1"
                    text
                    @click="save"
                >
                  Сохранить
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <v-dialog v-model="dialogDelete" max-width="500px">
            <v-card>
              <v-card-title class="text-center overline">Вы уверены что хотите удалить сотрудника?</v-card-title>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" text @click="closeDelete">Нет</v-btn>
                <v-btn color="blue darken-1" text @click="deleteItemConfirm">Да</v-btn>
                <v-spacer></v-spacer>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-toolbar>
      </template>
      <template v-slot:item.actions="{ item }">
        <v-icon
            small
            class="mr-2"
            @click="editItem(item)"
        >
          mdi-pencil
        </v-icon>
        <!--<v-icon
            small
            @click="deleteItem(item)"
        >
          mdi-delete
        </v-icon>-->
      </template>
      <template v-slot:no-data>
        <v-btn
            color="primary"
            @click="initialize"
        >
          Обновить
        </v-btn>
      </template>
    </v-data-table>
</template>

<script>
export default {
  data: () => ({
    search: '',
    updateComplete: null,
    dialog: false,
    dialogDelete: false,
    got_users: [],
    headers: [
      { text: 'Фамилия', align: 'start', sortable: true, value: 'surname' },
      { text: 'Имя', align: 'start', sortable: false, value: 'name' },
      { text: 'Отчество', align: 'start', sortable: false, value: 'patronymic' },
      { text: 'День рождения', align: 'end', sortable: false, value: 'birthday' },
      { text: 'Начало работы', align: 'end', sortable: true, value: 'start_date' },
      { text: '', align: 'end', value: 'actions', sortable: false },
    ],
    editedIndex: -1,
    editedItem: {
      name: '',
      surname: '',
      patronymic: '',
      birthday: '',
      start_date: '',
      internal_code: ''
    },
    defaultItem: {
      name: '',
      surname: '',
      patronymic: '',
      birthday: '',
      start_date: '',
      internal_code: ''
    },
  }),

  computed: {
    formTitle () {
      return this.editedIndex === -1 ? 'Новый сотрудник' : 'Изменение данных'
    },
  },

  watch: {
    dialog (val) {
      val || this.close()
    },
    dialogDelete (val) {
      val || this.closeDelete()
    },
  },

  created () {
    this.initialize()
  },

  methods: {
    async get_users() {
      this.got_users = await this.$api.post('getusers',{"month" : 4})
      console.log(this.got_users)
    },
    async updateUser(){
      const updateComplete = await this.$api.post('updateuser', this.editedItem)
      console.log(updateComplete)
    },
    initialize () {
      this.get_users()
    },

    editItem (item) {
      this.editedIndex = this.got_users.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialog = true
    },

    deleteItem (item) {
      this.editedIndex = this.got_users.indexOf(item)
      this.editedItem = Object.assign({}, item)
      this.dialogDelete = true
    },

    deleteItemConfirm () {
      this.got_users.splice(this.editedIndex, 1)
      this.closeDelete()
    },

    close () {
      this.dialog = false
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      })
    },

    closeDelete () {
      this.dialogDelete = false
      this.$nextTick(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      })
    },

    save () {
      if (this.editedIndex > -1) {
        Object.assign(this.got_users[this.editedIndex], this.editedItem)
        //this.editedItem['sender'] = this.$storage.state.user.id
        this.updateUser()
        console.log(JSON.stringify(this.editedItem))
      } else {
        this.got_users.push(this.editedItem)

        console.log(this.editedItem)
      }
      this.close()
    },
  },
name: "Users.vue"
}
</script>

<style scoped>

</style>