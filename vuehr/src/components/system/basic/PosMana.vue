<template>
  <div>
    <div style="text-align: left">
      <el-input
        :placeholder="state=='position'?'Add Position...':'Add Title...'"
        size="mini"
        @keyup.enter.native="addPosition"
        style="width: 300px;"
        prefix-icon="el-icon-plus"
        v-model="positionName">
      </el-input>
      <el-select v-model="titleLevel" v-if="state=='jobtitle'" size="mini" placeholder="Title Level">
        <el-option
          v-for="tl in titleLevels"
          :key="tl"
          :label="tl"
          :value="tl">
        </el-option>
      </el-select>
      <el-button type="primary" icon="el-icon-plus" size="mini" @click="addPosition">Add</el-button>
    </div>
    <div style="margin-top: 10px">
      <el-table
        v-loading="loading"
        :data="posData"
        size="mini"
        stripe
        border
        @selection-change="handleSelectionChange"
        style="width: 80%">
        <el-table-column
          type="selection"
          width="55"
          align="left">
        </el-table-column>
        <el-table-column
          prop="id"
          label="Number"
          width="80"
          align="left">
        </el-table-column>
        <el-table-column
          prop="name"
          :label="state=='position'?'Position Name':'Title Name'"
          width="180"
          align="left">
        </el-table-column>
        <el-table-column
          prop="titleLevel"
          label="Title Level"
          width="180"
          align="left" v-if="state=='jobtitle'">
        </el-table-column>
        <el-table-column
          width="180"
          label="Created Time"
          align="left">
          <template slot-scope="scope">{{ scope.row.createDate | formatDate}}</template>
        </el-table-column>
        <el-table-column label="Operating" align="left">
          <template slot-scope="scope">
            <el-button
              size="mini"
              @click="handleEdit(scope.$index, scope.row)">Edit
            </el-button>
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.$index, scope.row)">Delete
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div style="text-align: left;margin-top: 10px">
      <el-button type="danger" size="mini" v-if="posData.length>0" :disabled="multipleSelection.length==0"
                 @click="deleteMany">Batch Delete
      </el-button>
    </div>
    <div style="text-align: left">
      <el-dialog
        :title="state=='position'?'Edit Position':'Edit Title'"
        :visible.sync="dialogVisible"
        width="25%">
        <el-input v-model="updatePosName" size="mini" placeholder="Please input new position..."></el-input>
        <el-select v-model="updateTitleLevel" v-if="state=='jobtitle'" style="margin-top: 10px" size="mini"
                   placeholder="Title Level">
          <el-option
            v-for="tl in titleLevels"
            :key="tl"
            :label="tl"
            :value="tl">
          </el-option>
        </el-select>
        <span slot="footer" class="dialog-footer">
    <el-button size="mini" @click="dialogVisible = false">Cancel</el-button>
    <el-button type="primary" size="mini" @click="updatePosNameExec">Confirm</el-button>
  </span>
      </el-dialog>
    </div>
  </div>
</template>
<script>
  export default{
    mounted: function () {
      this.loadTableData();
    },
    methods: {
      updatePosNameExec(){
        if (!this.isNotNullORBlank(this.updatePosName)) {
          this.$message.warning(this.state == 'position' ? 'Position cannot be empty!' : 'Title cannot be empty!');
          return;
        }
        this.loading = true;
        var _this = this;
        this.putRequest(this.state=='position'?"/system/basic/position":"/system/basic/joblevel", {name: this.updatePosName, id: this.updatePosId,titleLevel:this.updateTitleLevel}).then(resp=> {
          _this.loading = false;
          if (resp && resp.status == 200) {
            this.dialogVisible = false;
            var data = resp.data;

            _this.loadTableData();
          }
        })
      },
      deleteMany(){
        var _this = this;
        this.$confirm('Delete' + this.multipleSelection.length + 'rows, continue?', 'reminder', {
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          var multipleSelection = _this.multipleSelection;
          var ids = '';
          multipleSelection.forEach(row=> {
            ids = ids + row.id + ',';
          })
          _this.doDelete(ids);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: 'Delete Canceled'
          });
        });
      },
      addPosition(){
        if (!this.isNotNullORBlank(this.positionName)) {
          this.$message.warning(this.state == 'position' ? 'Position cannot be empty!' : 'Title cannot be empty!');
          return;
        }
        if (this.state == 'jobtitle') {
          if (!this.isNotNullORBlank(this.titleLevel)) {
            this.$message.warning('Please select title level!');
            return;
          }
        }
        var _this = this;
        this.loading = true;
        this.postRequest(this.state == 'position' ? "/system/basic/position" : "/system/basic/joblevel", {
          name: this.positionName,
          titleLevel: this.titleLevel
        }).then(resp=> {
          _this.loading = false;
          if (resp && resp.status == 200) {
            var data = resp.data;

            _this.loadTableData();
            _this.positionName = '';
            _this.titleLevel = '';
          }
        });
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      handleEdit(index, row){
        this.updatePosName = row.name;
        this.updatePosId = row.id;
        this.updateTitleLevel=row.titleLevel;
        this.dialogVisible = true;
      },
      handleDelete(index, row){
        var _this = this;
        this.$confirm('Delete[' + row.name + '], continue?', 'reminder', {
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          _this.doDelete(row.id);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: 'Delete Canceled'
          });
        });
      },
      doDelete(ids){
        var _this = this;
        _this.loading = true;
        var url = this.state == 'position' ? '/system/basic/position/' : '/system/basic/joblevel/';
        this.deleteRequest(url + ids).then(resp=> {
          _this.loading = false;
          if (resp && resp.status == 200) {
            _this.loadTableData();
          }
        })
      },
      loadTableData(){
        var _this = this;
        this.loading = true;
        this.getRequest(this.state == 'position' ? "/system/basic/positions" : "/system/basic/joblevels").then(resp=> {
          _this.loading = false;
          if (resp && resp.status == 200) {
            _this.posData = resp.data;
          }
        })
      }
    },
    data(){
      return {
        positionName: '',
        updatePosName: '',
        updateTitleLevel: '',
        titleLevel: '',
        updatePosId: -1,
        loading: false,
        dialogVisible: false,
        multipleSelection: [],
        type: [],
        titleLevels: ['Senior', 'Intermediate', 'Primary', 'Internship'],
        nameLabelName: this.state == 'position' ? 'Position Name' : 'Title Name',
        posData: []
      }
    },
    props: ['state']
  }
</script>
