<template>
  <div>
    <el-container>
      <el-header style="display: flex;justify-content: space-between;align-items: center;padding-left: 0px">
        <el-button @click="dialogVisible = true" icon="el-icon-plus" type="primary" size="mini">Add Employee Transfer</el-button>
        <el-button size="mini" type="success" @click="loadSalaryCfg" icon="el-icon-refresh"></el-button>
      </el-header>
      <el-main style="padding-left: 0px;padding-top: 0px">
        <div>
          <el-table
            :data="salaries"
            stripe
            v-loading="tableLoading"
            size="mini"
            @selection-change="handleSelectionChange"
            style="width: 100%">
            <el-table-column
              type="selection"
              width="30">
            </el-table-column>
            <el-table-column
              align="center"
              width="120"
              prop="eid"
              label="Employee Job Number">
            </el-table-column>
            <el-table-column
              align="center"
              width="70"
              prop="afterDepId"
              label="Department Transferred to">
            </el-table-column>
            <el-table-column
              align="center"
              width="70"
              prop="afterJobId"
              label="Position Transferred to">
            </el-table-column>
            <el-table-column
              align="center"
              width="100"
              label="Date of Transfer">
              <template slot-scope="scope">{{ scope.row.removeDate | formatDate}}</template>
            </el-table-column>
            <el-table-column
              align="center"
              width="350"
              prop="reason"
              label="Reason of Transfer">
            </el-table-column>
            <el-table-column
              align="center"
              prop="remark"
              width="350"
              label="Remark">
            </el-table-column>

            <el-table-column label="Operating" align="center">
              <el-table-column label="Edit" align="center">
                <template slot-scope="scope">
                  <el-button
                    size="mini"
                    @click="handleEdit(scope.$index, scope.row)">Edit
                  </el-button>
                </template>
              </el-table-column>
            </el-table-column>
          </el-table>
        </div>
      </el-main>
    </el-container>
    <div style="text-align: left">
      <el-dialog
        title="Add Transfer"
        :visible.sync="dialogVisible"
        width="50%"
        @close="emptySalary"
        :close-on-click-modal="false">
        <div style="display: flex;justify-content: flex-start;">
          <el-steps :active="index" direction="vertical">
            <el-step title="Employee Job Number" size="mini"></el-step>
            <el-step title="Department Transferred to"></el-step>
            <el-step title="Position Transferred to"></el-step>
            <el-step title="Date of Transfer"></el-step>
            <el-step title="Reason of Transfer"></el-step>
            <el-step title="Remark"></el-step>
          </el-steps>
          <div style="margin-left: 30px;display: flex;justify-content: center;align-items: center;width: 80%;">
            <div v-show="index==0">
              Employee Job Number
              <el-input
                placeholder="Please input job number..."
                size="mini"
                style="width: 200px"
                type="number"
                @keyup.enter.native="next"
                v-model="salary.eid">
              </el-input>
            </div>
            <div v-show="index==1">
              Department Transferred to:
              <el-input
                placeholder="Please input Department Transferred to..."
                @keyup.enter.native="next"
                size="mini"
                style="width: 200px"
                type="number"
                v-model="salary.afterDepId">
              </el-input>
            </div>
            <div v-show="index==2">
              Position Transferred to:
              <el-input
                placeholder="Please input Position Transferred to..."
                @keyup.enter.native="next"
                size="mini"
                style="width: 200px"
                type="number"
                v-model="salary.afterJobId">
              </el-input>
            </div>
            <div v-show="index==3">
              Date of Transfer
              <el-date-picker
                v-model="salary.removeDate"
                type="date"
                size="mini"
                value-format="yyyy-MM-dd"
                style="width: 200px;"
                placeholder="Select Date">
              </el-date-picker>
            </div>
            <div v-show="index==4">
              Reason of Transfer:
              <el-input
                placeholder="Please input the Reason of Transfer..."
                size="mini"
                @keyup.enter.native="next"
                style="width: 200px"
                type="textarea"
                v-model="salary.reason">
              </el-input>
            </div>
            <div v-show="index==5">
              Remark:
              <el-input
                placeholder="Please input the remark..."
                size="mini"
                @keyup.enter.native="next"
                style="width: 200px"
                type="textarea"
                v-model="salary.remark">
              </el-input>
            </div>
          </div>
        </div>
        <div style="display: flex;align-items: center;justify-content: center;padding: 0px;margin: 0px;">
          <el-button round size="mini" v-if="index!=0" @click="index--">Previous Step</el-button>
          <el-button type="primary" round size="mini" @click="next" v-text="index==5?'Finish':'Next Step'"></el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        dialogVisible: false,
        tableLoading: false,
        index: 0,
        salaries: [],
        multipleSelection: [],
        salary: {
          id: '',
          eid:'',
          afterDepId:'',
          afterJobId:'',
          removeDate:'',
          reason:'',
          remark:''
        }
      };
    },
    methods: {
      deleteAll(){
        this.$confirm('Delete[' + this.multipleSelection.length + ']rows, continue?', 'Reminder', {
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          var ids = '';
          this.multipleSelection.forEach(row=> {
            ids = ids + row.id + ",";
          })
          this.doDelete(ids);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: 'Delete canceled'
          });
        });
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      handleEdit(index, row) {
        this.dialogVisible = true;
        row.removeDate = new Date(row.removeDate);
        this.salary = row;
      },
      handleDelete(index, row) {
        this.$confirm('Delete[' + row.eid + '], continue?', 'Reminder', {
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          this.doDelete(row.id);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: 'Delete canceled'
          });
        });
      },
      doDelete(id){
        var _this = this;
        _this.tableLoading = true;
        this.deleteRequest("/personnel/remove/move" + id).then(resp=>{
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            var data = resp.data;

            _this.loadSalaryCfg();
          }
        });
      },
      next(){
        var _this = this;
        if (this.index == 5) {
          if(this.salary.eid&&this.salary.afterDepId&&this.salary.afterJobId&&this.salary.removeDate&&this.salary.reason&&this.salary.remark){
            if (this.salary.id) {//更新
              _this.tableLoading = true;
              this.putRequest("/personnel/remove/move", this.salary).then(resp=> {
                _this.tableLoading = false;
                if (resp && resp.status == 200) {
                  var data = resp.data;
                  _
                  _this.dialogVisible = false;
                  _this.index = 0;
                  _this.loadSalaryCfg();
                }
              });
            } else {//添加
              this.postRequest("/personnel/remove/move", this.salary).then(resp=> {
                if (resp && resp.status == 200) {
                  var data = resp.data;

                  _this.dialogVisible = false;
                  _this.index = 0;
                  _this.loadSalaryCfg();
                }
              });
            }
          }else{
            this.$message({type: 'error', message: 'Empty content not accepted!'});
          }
        } else {
          this.index++;
        }
      },
      loadSalaryCfg(){
        this.tableLoading = true;
        var _this = this;
        this.getRequest("/personnel/remove/move").then(resp=> {
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            _this.salaries = resp.data;
          }
        })
      },
      emptySalary(){
        this.salary = {
          id: '',
          eid:'',
          afterDepId:'',
          afterJobId:'',
          removeDate:'',
          reason:'',
          remark:''
        };
        this.index = 0;
      }
    },
    mounted: function () {
      this.loadSalaryCfg();
    }
  };
</script>
<style>
  .el-dialog__body {
    padding-bottom: 10px;
  }
</style>
