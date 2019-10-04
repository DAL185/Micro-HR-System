<template>
  <div style="margin-top: 10px">
    <el-table
      :data="emps"
      size="mini"
      border
      stripe
      v-loading="tableLoading"
      style="width: 100%">
      <el-table-column
        type="selection"
        align="left"
        width="55">
      </el-table-column>
      <el-table-column
        prop="name"
        align="left"
        fixed
        label="Name"
        width="120">
      </el-table-column>
      <el-table-column
        prop="workID"
        width="120"
        align="left"
        label="Job Number">
      </el-table-column>
      <el-table-column
        prop="email"
        width="200"
        align="left"
        label="Email Address">
      </el-table-column>
      <el-table-column
        prop="phone"
        width="120"
        label="Phone Number">
      </el-table-column>
      <el-table-column
        prop="department.name"
        align="left"
        width="120"
        label="Department">
      </el-table-column>
      <el-table-column label="Salary Set" align="center">
        <template slot-scope="scope">
          <el-tooltip placement="right">
            <div slot="content">
              <template v-if="scope.row.salary">
                <div>
                  <el-tag size="mini">Basic Salary</el-tag>
                  ￥{{scope.row.salary.basicSalary}}
                </div>
                <div>
                  <el-tag size="mini">Reward</el-tag>
                  ￥{{scope.row.salary.bonus}}
                </div>
                <div>
                  <el-tag size="mini">Lunch Allowance</el-tag>
                  ￥{{scope.row.salary.lunchSalary}}
                </div>
                <div>
                  <el-tag size="mini">Transport Allowance</el-tag>
                  ￥{{scope.row.salary.trafficSalary}}
                </div>
                <div>
                  <el-tag size="mini">Pension Cardinal Number</el-tag>
                  ￥{{scope.row.salary.pensionBase}}
                </div>
                <div>
                  <el-tag size="mini">Pension Rate</el-tag>
                  {{scope.row.salary.pensionPer}}
                </div>
                <div>
                  <el-tag size="mini">Provident fund base</el-tag>
                  ￥{{scope.row.salary.accumulationFundBase}}
                </div>
                <div>
                  <el-tag size="mini">Provident fund rate</el-tag>
                  {{scope.row.salary.accumulationFundPer}}
                </div>
                <div>
                  <el-tag size="mini">Medical insurance base</el-tag>
                  ￥{{scope.row.salary.medicalBase}}
                </div>
                <div>
                  <el-tag size="mini">Medical insurance ratio</el-tag>
                  {{scope.row.salary.medicalPer}}
                </div>
              </template>
            </div>
            <el-tag size="mini">{{scope.row.salary?scope.row.salary.name:'Not yet set'}}</el-tag>
          </el-tooltip>
        </template>
      </el-table-column>
      <el-table-column label="Operating" align="center">
        <template slot-scope="scope">
          <el-popover
            placement="right"
            width="200"
            @hide="updateSalaryCfg(scope.row.id)"
            :key="scope.row.id"
            trigger="click">
            <el-select size="mini" v-model="sid" placeholder="Please select">
              <el-option
                v-for="item in salaries"
                :key="item.id"
                :label="item.name"
                :value="item.id">
              </el-option>
            </el-select>
            <el-button
              size="mini"
              slot="reference"
              type="danger" @click="showUpdateView(scope.row)">Modify Set
            </el-button>
          </el-popover>
        </template>
      </el-table-column>
    </el-table>
    <div style="text-align: right;margin-top: 10px">
      <el-pagination
        background
        @current-change="currentChange"
        layout="prev, pager, next"
        :total="totalCount">
      </el-pagination>
    </div>
  </div>
</template>
<script>
  export default{
    data(){
      return {
        emps: [],
        salaries: [],
        tableLoading: false,
        totalCount: -1,
        sid: '',
        osid: '',
        currentPage: 1
      }
    },
    mounted: function () {
      this.loadEmps();
    },
    methods: {
      showUpdateView(data){
        this.loadSalaries();
        if (data.salary) {
          this.sid = data.salary.id;
          this.osid = data.salary.id;
        } else {
          this.sid = '';
          this.osid = '';
        }
      },
      loadSalaries(){
        var _this = this;
        this.getRequest("/salary/sobcfg/salaries").then(resp=> {
          if (resp && resp.status == 200) {
            _this.salaries = resp.data;
          }
        })
      },
      updateSalaryCfg(eid){
        var _this = this;
        if(this.osid==this.sid) {
          return;
        }
        this.putRequest("/salary/sobcfg/", {eid: eid, sid: this.sid}).then(resp=> {
          if(resp&&resp.status==200) {
            var data = resp.data;

            _this.loadEmps();
          }
        })
      },
      currentChange(currentPage){
        this.currentPage = currentPage;
        this.loadEmps();
      },
      loadEmps(){
        this.tableLoading = true;
        var _this = this;
        this.getRequest("/salary/sobcfg/emp?page=" + this.currentPage + "&size=10").then(resp=> {
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            var data = resp.data;
            _this.emps = data.emps;
            _this.totalCount = data.count;
          }
        })
      }
    }
  }
</script>
