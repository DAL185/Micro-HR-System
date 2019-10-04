<template>
  <div>
    <el-container>
      <el-header style="display: flex;justify-content: space-between;align-items: center;padding-left: 0px">
        <el-button @click="dialogVisible = true" icon="el-icon-plus" type="primary" size="mini">Add Salary Adjustment</el-button>
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
              label="Employee's Job Number">
            </el-table-column>
            <el-table-column
              align="center"
              width="100"
              label="Date of Salary Adjustment">
              <template slot-scope="scope">{{ scope.row.asDate | formatDate}}</template>
            </el-table-column>
            <el-table-column
              align="center"
              width="70"
              prop="beforeSalary"
              label="Previous Salary">
            </el-table-column>
            <el-table-column
              align="center"
              width="70"
              prop="afterSalary"
              label="Salary after Adjustment">
            </el-table-column>
            <el-table-column
              align="center"
              width="350"
              prop="reason"
              label="Reason of Adjustment">
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
              <el-table-column label="Delete" align="center">
                <template slot-scope="scope">
                  <el-button
                    size="mini"
                    type="danger"
                    @click="handleDelete(scope.$index, scope.row)">Delete
                  </el-button>
                </template>
              </el-table-column>
            </el-table-column>
          </el-table>
        </div>
        <div style="text-align: left;margin-top: 10px" v-if="salaries!=0">
          <el-button type="danger" round size="mini" :disabled="multipleSelection.length==0" @click="deleteAll">Batch Delete
          </el-button>
        </div>
      </el-main>
    </el-container>
    <div style="text-align: left">
      <el-dialog
        title="Add Adjustment"
        :visible.sync="dialogVisible"
        width="50%"
        @close="emptySalary"
        :close-on-click-modal="false">
        <div style="display: flex;justify-content: flex-start;">
          <el-steps :active="index" direction="vertical">
            <el-step title="Employee's Job Number" size="mini"></el-step>
            <el-step title="Date of Adjustment"></el-step>
            <el-step title="Previous Salary"></el-step>
            <el-step title="Salary after Adjustment"></el-step>
            <el-step title="Reason of Adjustment"></el-step>
            <el-step title="Remark"></el-step>
          </el-steps>
          <div style="margin-left: 30px;display: flex;justify-content: center;align-items: center;width: 80%;">
            <div v-show="index==0">
              Employee's Job Number
              <el-input
                placeholder="Please input Employee's Job Number..."
                size="mini"
                style="width: 200px"
                type="number"
                @keyup.enter.native="next"
                v-model="salary.eid">
              </el-input>
            </div>
            <div v-show="index==1">
              Date of Adjustment
              <el-date-picker
                v-model="salary.asDate"
                type="date"
                size="mini"
                value-format="yyyy-MM-dd"
                style="width: 200px;"
                placeholder="Select Date">
              </el-date-picker>
            </div>
            <div v-show="index==2">
              Previous Salary:
              <el-input
                placeholder="Please input previous salary..."
                @keyup.enter.native="next"
                size="mini"
                style="width: 200px"
                type="number"
                v-model="salary.beforeSalary">
              </el-input>
            </div>
            <div v-show="index==3">
              Salary after Adjustment:
              <el-input
                placeholder="Please input salary after Adjustment..."
                @keyup.enter.native="next"
                size="mini"
                style="width: 200px"
                type="number"
                v-model="salary.afterSalary">
              </el-input>
            </div>
            <div v-show="index==4">
              Reason of Adjustment:
              <el-input
                placeholder="Please input the reason of Adjustment..."
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
          asDate:'',
          beforeSalary:'',
          afterSalary:'',
          reason:'',
          remark:''
        }
      };
    },
    methods: {
      deleteAll(){
        this.$confirm('Delete[' + this.multipleSelection.length + ']rows, continue?', 'reminder', {
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
            message: 'Delete Canceled'
          });
        });
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      handleEdit(index, row) {
        this.dialogVisible = true;
        row.asDate = new Date(row.asDate);
        this.salary = row;
      },
      handleDelete(index, row) {
        this.$confirm('Delete[' + row.eid + '], continue?', 'reminder', {
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          this.doDelete(row.id);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: 'Delete Canceled'
          });
        });
      },
      doDelete(id){
        var _this = this;
        _this.tableLoading = true;
        this.deleteRequest("/personnel/adjust/salary/" + id).then(resp=>{
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
          if(this.salary.eid&&this.salary.asDate&&this.salary.beforeSalary&&this.salary.afterSalary&&this.salary.reason&&this.salary.remark){
            if (this.salary.id) {//更新
              _this.tableLoading = true;
              this.putRequest("/personnel/adjust/salary", this.salary).then(resp=> {
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
                this.postRequest("/personnel/adjust/salary", this.salary).then(resp=> {
                  if (resp && resp.status == 200) {
                    var data = resp.data;

                    _this.dialogVisible = false;
                    _this.index = 0;
                    _this.loadSalaryCfg();
                  }
                });
            }
          }else{
            this.$message({type: 'error', message: 'Please input something!'});
          }
        } else {
          this.index++;
        }
      },
      loadSalaryCfg(){
        this.tableLoading = true;
        var _this = this;
        this.getRequest("/personnel/adjust/salary").then(resp=> {
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
          asDate:'',
          beforeSalary:'',
          afterSalary:'',
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
