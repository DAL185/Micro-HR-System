<template>
  <div>
    <el-container>
      <el-header style="display: flex;justify-content: space-between;align-items: center;padding-left: 0px">
        <el-button @click="dialogVisible = true" icon="el-icon-plus" type="primary" size="mini">Add Set</el-button>
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
              width="120"
              prop="name"
              label="Set Name">
            </el-table-column>
            <el-table-column
              width="70"
              prop="basicSalary"
              label="Basic Salary">
            </el-table-column>
            <el-table-column
              width="70"
              prop="trafficSalary"
              label="Transport Allowance">
            </el-table-column>
            <el-table-column
              width="70"
              prop="lunchSalary"
              label="Lunch Allowance">
            </el-table-column>
            <el-table-column
              prop="bonus"
              width="70"
              label="Reward">
            </el-table-column>
            <el-table-column
              width="100"
              label="Start Time">
              <template slot-scope="scope">{{ scope.row.createDate | formatDate}}</template>
            </el-table-column>
            <el-table-column label="Pension" align="center">
              <el-table-column
                prop="pensionPer"
                width="70"
                label="Rate">
              </el-table-column>
              <el-table-column
                width="70"
                prop="pensionBase"
                label="Cardinal Number">
              </el-table-column>
            </el-table-column>
            <el-table-column label="Healthy Insurance" align="center">
              <el-table-column
                width="70"
                prop="medicalPer"
                label="Rate">
              </el-table-column>
              <el-table-column
                prop="medicalBase"
                width="70"
                label="Cardinal Number">
              </el-table-column>
            </el-table-column>
            <el-table-column label="Provident Fund" align="center">
              <el-table-column
                width="70"
                prop="accumulationFundPer"
                label="Rate">
              </el-table-column>
              <el-table-column
                prop="accumulationFundBase"
                width="70"
                label="Cardinal Number">
              </el-table-column>
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
        title="Add Salary Set"
        :visible.sync="dialogVisible"
        width="50%"
        @close="emptySalary"
        :close-on-click-modal="false">
        <div style="display: flex;justify-content: flex-start;">
          <el-steps :active="index" direction="vertical">
            <el-step title="Basic Salary" size="mini"></el-step>
            <el-step title="Transport Allowance"></el-step>
            <el-step title="Lunch Allowance"></el-step>
            <el-step title="Reward"></el-step>
            <el-step title="Pension"></el-step>
            <el-step title="Healthy Insurance"></el-step>
            <el-step title="Provident Fund"></el-step>
            <el-step title="Start Time"></el-step>
          </el-steps>
          <div style="margin-left: 30px;display: flex;justify-content: center;align-items: center;width: 80%;">
            <div v-show="index==0">
              Basic Salary:
              <el-input
                placeholder="Please input Basic Salary..."
                size="mini"
                style="width: 200px"
                type="number"
                @keyup.enter.native="next"
                v-model="salary.basicSalary">
              </el-input>
            </div>
            <div v-show="index==1">
              Transport Allowance:
              <el-input
                placeholder="Please input Transport Allowance..."
                @keyup.enter.native="next"
                size="mini"
                style="width: 200px"
                type="number"
                v-model="salary.trafficSalary">
              </el-input>
            </div>
            <div v-show="index==2">
              Lunch Allowance:
              <el-input
                placeholder="Please input Lunch Allowance..."
                @keyup.enter.native="next"
                size="mini"
                style="width: 200px"
                type="number"
                v-model="salary.lunchSalary">
              </el-input>
            </div>
            <div v-show="index==3">
              Reward:
              <el-input
                placeholder="Please input reward..."
                size="mini"
                @keyup.enter.native="next"
                style="width: 200px"
                type="number"
                v-model="salary.bonus">
              </el-input>
            </div>
            <div v-show="index==4">
              <div>
                Pension Rate
                <el-input
                  placeholder="Please input pension rate..."
                  size="mini"
                  style="width: 200px"
                  type="number"
                  v-model="salary.pensionPer">
                </el-input>
              </div>
              <div style="margin-top: 10px">
                Pension Cardinal Number:
                <el-input
                  placeholder="Please input Pension Cardinal Number..."
                  size="mini"
                  @keyup.enter.native="next"
                  style="width: 200px"
                  type="number"
                  v-model="salary.pensionBase">
                </el-input>
              </div>
            </div>
            <div v-show="index==5">
              <div>
                Healthy Insurance Rate
                <el-input
                  placeholder="Please input Healthy Insurance Rate..."
                  size="mini"
                  style="width: 200px"
                  type="number"
                  v-model="salary.medicalPer">
                </el-input>
              </div>
              <div style="margin-top: 10px">
                Healthy Insurance Cardinal Number
                <el-input
                  placeholder="Please input Healthy Insurance Cardinal Number..."
                  size="mini"
                  @keyup.enter.native="next"
                  style="width: 200px"
                  type="number"
                  v-model="salary.medicalBase">
                </el-input>
              </div>
            </div>
            <div v-show="index==6">
              <div>
                Provident fund rate
                <el-input
                  placeholder="Please input Provident fund rate..."
                  size="mini"
                  style="width: 200px"
                  type="number"
                  v-model="salary.accumulationFundPer">
                </el-input>
              </div>
              <div style="margin-top: 10px">
                Provident fund Cardinal Number
                <el-input
                  placeholder="Please input Provident fund Cardinal Number..."
                  @keyup.enter.native="next"
                  size="mini"
                  style="width: 200px"
                  type="number"
                  v-model="salary.accumulationFundBase">
                </el-input>
              </div>
            </div>
            <div v-show="index==7">
              Start Time:
              <el-date-picker
                v-model="salary.createDate"
                type="date"
                size="mini"
                value-format="yyyy-MM-dd"
                style="width: 200px;"
                placeholder="Select date">
              </el-date-picker>
            </div>
          </div>
        </div>
        <div style="display: flex;align-items: center;justify-content: center;padding: 0px;margin: 0px;">
          <el-button round size="mini" v-if="index!=0" @click="index--">Previous Step</el-button>
          <el-button type="primary" round size="mini" @click="next" v-text="index==7?'Finish':'Next Step'"></el-button>
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
          createDate: '',
          basicSalary: '',
          trafficSalary: '',
          lunchSalary: '',
          bonus: '',
          pensionBase: '',
          pensionPer: '',
          medicalBase: '',
          medicalPer: '',
          accumulationFundBase: '',
          accumulationFundPer: ''
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
            message: 'Delete canceled'
          });
        });
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      handleEdit(index, row) {
        this.dialogVisible = true;
        row.createDate = new Date(row.createDate);
        delete row.allSalary;
        this.salary = row;
      },
      handleDelete(index, row) {
        this.$confirm('Delete[' + row.name + ']rows of set, continue?', 'reminder', {
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
        this.deleteRequest("/salary/sob/salary/" + id).then(resp=>{
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            var data = resp.data;

            _this.loadSalaryCfg();
          }
        });
      },
      next(){
        var _this = this;
        if (this.index == 7) {
          if(this.salary.createDate&&this.salary.basicSalary&&this.salary.trafficSalary&&this.salary.lunchSalary&&this.salary.bonus&&this.salary.pensionBase&&this.salary.pensionPer&&this.salary.medicalBase&&this.salary.medicalPer&&this.salary.accumulationFundBase&&this.salary.accumulationFundPer){
          if (this.salary.id) {//更新
            _this.tableLoading = true;
            this.putRequest("/salary/sob/salary", this.salary).then(resp=> {
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
            this.$prompt('Please input set name', 'reminder', {
              confirmButtonText: 'Confirm',
              cancelButtonText: 'Cancel'
            }).then(({value}) => {
              this.salary.name = value;
              this.postRequest("/salary/sob/salary", this.salary).then(resp=> {
                if (resp && resp.status == 200) {
                  var data = resp.data;

                  _this.dialogVisible = false;
                  _this.index = 0;
                  _this.loadSalaryCfg();
                }
              });
            }).catch(() => {
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
        this.getRequest("/salary/sob/salary").then(resp=> {
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            _this.salaries = resp.data;
          }
        })
      },
      emptySalary(){
        this.salary = {
          id: '',
          createDate: '',
          basicSalary: '',
          trafficSalary: '',
          lunchSalary: '',
          bonus: '',
          pensionBase: '',
          pensionPer: '',
          medicalBase: '',
          medicalPer: '',
          accumulationFundBase: '',
          accumulationFundPer: ''
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
