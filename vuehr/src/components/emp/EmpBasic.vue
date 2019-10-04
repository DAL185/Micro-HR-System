<template>
  <div>
    <el-container>
      <el-header style="padding: 0px;display:flex;justify-content:space-between;align-items: center">
        <div style="display: inline">
          <el-input
            placeholder="Search for employees by name, press return button when you finish..."
            clearable
            @change="keywordsChange"
            style="width: 300px;margin: 0px;padding: 0px;"
            size="mini"
            :disabled="advanceSearchViewVisible"
            @keyup.enter.native="searchEmp"
            prefix-icon="el-icon-search"
            v-model="keywords">
          </el-input>
          <el-button type="primary" size="mini" style="margin-left: 5px" icon="el-icon-search" @click="searchEmp">Search
          </el-button>
          <el-button slot="reference" type="primary" size="mini" style="margin-left: 5px"
                     @click="showAdvanceSearchView"><i
            class="fa fa-lg" v-bind:class="[advanceSearchViewVisible ? faangledoubleup:faangledoubledown]"
            style="margin-right: 5px"></i>Senior Search
          </el-button>
        </div>
        <div style="margin-left: 5px;margin-right: 20px;display: inline">
          <el-upload
            :show-file-list="false"
            accept="application/vnd.ms-excel"
            action="/employee/basic/importEmp"
            :on-success="fileUploadSuccess"
            :on-error="fileUploadError" :disabled="fileUploadBtnText=='Importing'"
            :before-upload="beforeFileUpload" style="display: inline">
            <el-button size="mini" type="success" :loading="fileUploadBtnText=='Importing'"><i class="fa fa-lg fa-level-up"
                                                                                          style="margin-right: 5px"></i>{{fileUploadBtnText}}
            </el-button>
          </el-upload>
          <el-button type="success" size="mini" @click="exportEmps"><i class="fa fa-lg fa-level-down"
                                                                       style="margin-right: 5px"></i>Export Data
          </el-button>
          <el-button type="primary" size="mini" icon="el-icon-plus"
                     @click="showAddEmpView">
            Add Employee
          </el-button>
        </div>
      </el-header>
      <el-main style="padding-left: 0px;padding-top: 0px">
        <div>
          <transition name="slide-fade">
            <div
              style="margin-bottom: 10px;border: 1px;border-radius: 5px;border-style: solid;padding: 5px 0px 5px 0px;box-sizing:border-box;border-color: #20a0ff"
              v-show="advanceSearchViewVisible">
              <el-row>
                <el-col :span="5">
                  Political Status:
                  <el-select v-model="emp.politicId" style="width: 130px" size="mini" placeholder="Political Status">
                    <el-option
                      v-for="item in politics"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-col>
                <el-col :span="4">
                  Nationality:
                  <el-select v-model="emp.nationId" style="width: 130px" size="mini" placeholder="Please select nationality">
                    <el-option
                      v-for="item in nations"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-col>
                <el-col :span="4">
                  Position:
                  <el-select v-model="emp.posId" style="width: 130px" size="mini" placeholder="Please select position">
                    <el-option
                      v-for="item in positions"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-col>
                <el-col :span="4">
                  Job Title:
                  <el-select v-model="emp.jobLevelId" style="width: 130px" size="mini" placeholder="Please select job title">
                    <el-option
                      v-for="item in joblevels"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-col>
                <el-col :span="7">
                  Hire Way:
                  <el-radio-group v-model="emp.engageForm">
                    <el-radio label="Staff Way">Staff Way</el-radio>
                    <el-radio style="margin-left: 15px" label="Contract Way">Contract Way</el-radio>
                  </el-radio-group>
                </el-col>
              </el-row>
              <el-row style="margin-top: 10px">
                <el-col :span="5">
                  Department:
                  <el-popover
                    v-model="showOrHidePop2"
                    placement="right"
                    title="Please select department"
                    trigger="manual">
                    <el-tree :data="deps" :default-expand-all="true" :props="defaultProps" :expand-on-click-node="false"
                             @node-click="handleNodeClick2"></el-tree>
                    <div slot="reference"
                         style="width: 130px;height: 26px;display: inline-flex;font-size:13px;border: 1px;border-radius: 5px;border-style: solid;padding-left: 13px;box-sizing:border-box;border-color: #dcdfe6;cursor: pointer;align-items: center"
                         @click="showDepTree2" v-bind:style="{color: depTextColor}">{{emp.departmentName}}
                    </div>
                  </el-popover>
                </el-col>
                <el-col :span="10">
                  Date of Onboard:
                  <el-date-picker
                    v-model="beginDateScope"
                    unlink-panels
                    size="mini"
                    type="daterange"
                    value-format="yyyy-MM-dd"
                    range-separator="To"
                    start-placeholder="Start Date"
                    end-placeholder="End Date">
                  </el-date-picker>
                </el-col>
                <el-col :span="5" :offset="4">
                  <el-button size="mini" @click="cancelSearch">Cancel</el-button>
                  <el-button icon="el-icon-search" type="primary" size="mini" @click="searchEmp">Search</el-button>
                </el-col>
              </el-row>
            </div>
          </transition>
          <el-table
            :data="emps"
            v-loading="tableLoading"
            border
            stripe
            @selection-change="handleSelectionChange"
            size="mini"
            style="width: 100%">
            <el-table-column
              type="selection"
              align="left"
              width="30">
            </el-table-column>
            <el-table-column
              prop="name"
              align="left"
              fixed
              label="Name"
              width="90">
            </el-table-column>
            <el-table-column
              prop="workID"
              width="85"
              align="left"
              label="Job Number">
            </el-table-column>
            <el-table-column
              prop="gender"
              label="Gender"
              width="50">
            </el-table-column>
            <el-table-column
              width="85"
              align="left"
              label="Date of Birth">
              <template slot-scope="scope">{{ scope.row.birthday | formatDate}}</template>
            </el-table-column>
            <el-table-column
              prop="idCard"
              width="150"
              align="left"
              label="ID Number">
            </el-table-column>
            <el-table-column
              prop="wedlock"
              width="70"
              label="Marital Status">
            </el-table-column>
            <el-table-column
              width="50"
              prop="nation.name"
              label="Nationality">
            </el-table-column>
            <el-table-column
              prop="nativePlace"
              width="80"
              label="Birthplace">
            </el-table-column>
            <el-table-column
              prop="politicsStatus.name"
              label="Political Status">
            </el-table-column>
            <el-table-column
              prop="email"
              width="180"
              align="left"
              label="Email Address">
            </el-table-column>
            <el-table-column
              prop="phone"
              width="100"
              label="Phone Number">
            </el-table-column>
            <el-table-column
              prop="address"
              width="220"
              align="left"
              label="Contact Address">
            </el-table-column>
            <el-table-column
              prop="department.name"
              align="left"
              width="100"
              label="Department">
            </el-table-column>
            <el-table-column
              width="100"
              align="left"
              prop="position.name"
              label="Posistion">
            </el-table-column>
            <el-table-column
              prop="jobLevel.name"
              width="100"
              align="left"
              label="Title">
            </el-table-column>
            <el-table-column
              prop="engageForm"
              label="Hire Way">
            </el-table-column>
            <el-table-column
              width="85"
              align="left"
              label="Date of Onboard">
              <template slot-scope="scope">{{ scope.row.beginDate | formatDate}}</template>
            </el-table-column>
            <el-table-column
              width="85"
              align="left"
              label="Positive Date">
              <template slot-scope="scope">{{ scope.row.conversionTime | formatDate}}</template>
            </el-table-column>
            <el-table-column
              width="95"
              align="left"
              label="Contract Start Date">
              <template slot-scope="scope">{{ scope.row.beginContract | formatDate}}</template>
            </el-table-column>
            <el-table-column
              width="95"
              align="left"
              label="Contract End Date">
              <template slot-scope="scope">{{ scope.row.endContract | formatDate}}</template>
            </el-table-column>
            <el-table-column
              align="left"
              width="70"
              label="Contract Period">
              <template slot-scope="scope">{{ scope.row.contractTerm}}Year</template>
            </el-table-column>
            <el-table-column
              align="left"
              prop="tiptopDegree"
              label="Highest Education">
            </el-table-column>
            <el-table-column
              fixed="right"
              label="Operating"
              width="195">
              <template slot-scope="scope">
                <el-button @click="showEditEmpView(scope.row)" style="padding: 3px 4px 3px 4px;margin: 2px"
                           size="mini">Edit
                </el-button>
                <el-button style="padding: 3px 4px 3px 4px;margin: 2px" type="primary"
                           size="mini">Check Senior Information
                </el-button>
                <el-button type="danger" style="padding: 3px 4px 3px 4px;margin: 2px" size="mini"
                           @click="deleteEmp(scope.row)">Delete
                </el-button>
              </template>
            </el-table-column>
          </el-table>
          <div style="display: flex;justify-content: space-between;margin: 2px">
            <el-button type="danger" size="mini" v-if="emps.length>0" :disabled="multipleSelection.length==0"
                       @click="deleteManyEmps">Batch Deletion
            </el-button>
            <el-pagination
              background
              :page-size="10"
              :current-page="currentPage"
              @current-change="currentChange"
              layout="prev, pager, next"
              :total="totalCount">
            </el-pagination>
          </div>
        </div>
      </el-main>
    </el-container>
    <el-form :model="emp" :rules="rules" ref="addEmpForm" style="margin: 0px;padding: 0px;">
      <div style="text-align: left">
        <el-dialog
          :title="dialogTitle"
          style="padding: 0px;"
          :close-on-click-modal="false"
          :visible.sync="dialogVisible"
          width="77%">
          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="Name:" prop="name">
                  <el-input prefix-icon="el-icon-edit" v-model="emp.name" size="mini" style="width: 150px"
                            placeholder="Please input employee's name"></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="5">
              <div>
                <el-form-item label="Gender:" prop="gender">
                  <el-radio-group v-model="emp.gender">
                    <el-radio label="Male">Male</el-radio>
                    <el-radio style="margin-left: 15px" label="Female">Female</el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-form-item label="Date of Birth:" prop="birthday">
                  <el-date-picker
                    v-model="emp.birthday"
                    size="mini"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    style="width: 150px"
                    type="date"
                    placeholder="Date of Birth">
                  </el-date-picker>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="7">
              <div>
                <el-form-item label="Political Status:" prop="politicId">
                  <el-select v-model="emp.politicId" style="width: 200px" size="mini" placeholder="Political Status">
                    <el-option
                      v-for="item in politics"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="Nationality:" prop="nationId">
                  <el-select v-model="emp.nationId" style="width: 150px" size="mini" placeholder="Please select nationality">
                    <el-option
                      v-for="item in nations"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="5">
              <div>
                <el-form-item label="Birthplace:" prop="nativePlace">
                  <el-input v-model="emp.nativePlace" size="mini" style="width: 120px" placeholder="Birthplace"></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-form-item label="Email Address:" prop="email">
                  <el-input prefix-icon="el-icon-message" v-model="emp.email" size="mini" style="width: 150px"
                            placeholder="Email Address..."></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="7">
              <div>
                <el-form-item label="Contact Address:" prop="address">
                  <el-input prefix-icon="el-icon-edit" v-model="emp.address" size="mini" style="width: 200px"
                            placeholder="Contact Address..."></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="Position:" prop="posId">
                  <el-select v-model="emp.posId" style="width: 150px" size="mini" placeholder="Please select position">
                    <el-option
                      v-for="item in positions"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="5">
              <div>
                <el-form-item label="Title:" prop="jobLevelId">
                  <el-select v-model="emp.jobLevelId" style="width: 120px" size="mini" placeholder="Please select title">
                    <el-option
                      v-for="item in joblevels"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-form-item label="Department:" prop="departmentId">
                  <el-popover
                    v-model="showOrHidePop"
                    placement="right"
                    title="Please select department"
                    trigger="manual">
                    <el-tree :data="deps" :default-expand-all="true" :props="defaultProps" :expand-on-click-node="false"
                             @node-click="handleNodeClick"></el-tree>
                    <div slot="reference"
                         style="width: 150px;height: 26px;display: inline-flex;font-size:13px;border: 1px;border-radius: 5px;border-style: solid;padding-left: 13px;box-sizing:border-box;border-color: #dcdfe6;cursor: pointer;align-items: center"
                         @click.left="showDepTree" v-bind:style="{color: depTextColor}">{{emp.departmentName}}
                    </div>
                  </el-popover>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="7">
              <div>
                <el-form-item label="Phone Number:" prop="phone">
                  <el-input prefix-icon="el-icon-phone" v-model="emp.phone" size="mini" style="width: 200px"
                            placeholder="Phone number..."></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="Job Number:" prop="workID">
                  <el-input v-model="emp.workID" disabled size="mini" style="width: 150px"
                            placeholder="Job number..."></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="5">
              <div>
                <el-form-item label="Education:" prop="tiptopDegree">
                  <el-select v-model="emp.tiptopDegree" style="width: 120px" size="mini" placeholder="Highest Education">
                    <el-option
                      v-for="item in degrees"
                      :key="item.id"
                      :label="item.name"
                      :value="item.name">
                    </el-option>
                  </el-select>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-form-item label="Graduated School:" prop="school">
                  <el-input prefix-icon="el-icon-edit" v-model="emp.school" size="mini" style="width: 150px"
                            placeholder="Name of graduated school"></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="7">
              <div>
                <el-form-item label="Major:" prop="specialty">
                  <el-input prefix-icon="el-icon-edit" v-model="emp.specialty" size="mini" style="width: 200px"
                            placeholder="Major"></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="6">
              <div>
                <el-form-item label="Date of Onboard:" prop="beginDate">
                  <el-date-picker
                    v-model="emp.beginDate"
                    size="mini"
                    style="width: 130px"
                    type="date"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    placeholder="Date of Onboard">
                  </el-date-picker>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-form-item label="Positive Date:" prop="conversionTime">
                  <el-date-picker
                    v-model="emp.conversionTime"
                    size="mini"
                    style="width: 130px"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    type="date"
                    placeholder="Positive date">
                  </el-date-picker>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-form-item label="Start Date of Contract:" prop="beginContract">
                  <el-date-picker
                    v-model="emp.beginContract"
                    size="mini"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    style="width: 135px"
                    type="date"
                    placeholder="Start Date of Contract">
                  </el-date-picker>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="6">
              <div>
                <el-form-item label="End Date of Contract:" prop="endContract">
                  <el-date-picker
                    v-model="emp.endContract"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    size="mini"
                    style="width: 135px"
                    type="date"
                    placeholder="End Date of Contract">
                  </el-date-picker>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="8">
              <div>
                <el-form-item label="ID Number:" prop="idCard">
                  <el-input prefix-icon="el-icon-edit" v-model="emp.idCard" size="mini" style="width: 180px"
                            placeholder="Please input ID number..."></el-input>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="8">
              <div>
                <el-form-item label="Hire Way:" prop="engageForm">
                  <el-radio-group v-model="emp.engageForm">
                    <el-radio label="Staff Way">Staff Way</el-radio>
                    <el-radio style="margin-left: 15px" label="Contract Way">Contract Way</el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-col>
            <el-col :span="8">
              <div>
                <el-form-item label="Marital Status:" prop="wedlock">
                  <el-radio-group v-model="emp.wedlock">
                    <el-radio label="Married">Married</el-radio>
                    <el-radio style="margin-left: 15px" label="Unmarried">Unmarried</el-radio>
                    <el-radio style="margin-left: 15px" label="Divorced">Divorced</el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <span slot="footer" class="dialog-footer">
    <el-button size="mini" @click="cancelEidt">Cancel</el-button>
    <el-button size="mini" type="primary" @click="addEmp('addEmpForm')">Confirm</el-button>
  </span>
        </el-dialog>
      </div>
    </el-form>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        emps: [],
        keywords: '',
        fileUploadBtnText: 'Import Data',
        beginDateScope: '',
        faangledoubleup: 'fa-angle-double-up',
        faangledoubledown: 'fa-angle-double-down',
        dialogTitle: '',
        multipleSelection: [],
        depTextColor: '#c0c4cc',
        nations: [],
        politics: [],
        positions: [],
        joblevels: [],
        totalCount: -1,
        currentPage: 1,
        degrees: [{id: 4, name: 'College'}, {id: 5, name: 'Bachelor'}, {id: 6, name: 'Master'}, {id: 7, name: 'Phd'}, {
          id: 3,
          name: 'High School'
        }, {id: 2, name: 'Junior High School'}, {id: 1, name: 'Primary School'}, {id: 8, name: 'Other'}],
        deps: [],
        defaultProps: {
          label: 'name',
          isLeaf: 'leaf',
          children: 'children'
        },
        dialogVisible: false,
        tableLoading: false,
        advanceSearchViewVisible: false,
        showOrHidePop: false,
        showOrHidePop2: false,
        emp: {
          name: '',
          gender: '',
          birthday: '',
          idCard: '',
          wedlock: '',
          nationId: '',
          nativePlace: '',
          politicId: '',
          email: '',
          phone: '',
          address: '',
          departmentId: '',
          departmentName: 'Department...',
          jobLevelId: '',
          posId: '',
          engageForm: '',
          tiptopDegree: '',
          specialty: '',
          school: '',
          beginDate: '',
          workState: '',
          workID: '',
          contractTerm: '',
          conversionTime: '',
          notWorkDate: '',
          beginContract: '',
          endContract: '',
          workAge: ''
        },
        rules: {
          name: [{required: true, message: 'Required:Name', trigger: 'blur'}],
          gender: [{required: true, message: 'Required:Gender', trigger: 'blur'}],
          birthday: [{required: true, message: 'Required:Date of Birth', trigger: 'blur'}],
          idCard: [{
            required: true,
            message: 'Required:ID Number',
            trigger: 'blur'
          }, {
            pattern: /(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)|(^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}$)/,
            message: 'ID Number format is wrong',
            trigger: 'blur'
          }],
          wedlock: [{required: true, message: 'Required:Marital Status', trigger: 'blur'}],
          nationId: [{required: true, message: 'Required:Nationality', trigger: 'change'}],
          nativePlace: [{required: true, message: 'Required:Birthplace', trigger: 'blur'}],
          politicId: [{required: true, message: 'Required:Political Status', trigger: 'blur'}],
          email: [{required: true, message: 'Required:Email Address', trigger: 'blur'}, {
            type: 'email',
            message: 'Email Format is Wrong',
            trigger: 'blur'
          }],
          phone: [{required: true, message: 'Required:Phone Number', trigger: 'blur'}],
          address: [{required: true, message: 'Required:Contact Address', trigger: 'blur'}],
          departmentId: [{required: true, message: 'Required:Department', trigger: 'change'}],
          jobLevelId: [{required: true, message: 'Required:Title', trigger: 'change'}],
          posId: [{required: true, message: 'Required:Position', trigger: 'change'}],
          engageForm: [{required: true, message: 'Required:Hire Way', trigger: 'blur'}],
          tiptopDegree: [{required: true, message: 'Required:Highest Education', trigger: 'change'}],
          specialty: [{required: true, message: 'Required:Major', trigger: 'blur'}],
          workID: [{required: true, message: 'Required:Job Number', trigger: 'blur'}],
          school: [{required: true, message: 'Required:Graduated School', trigger: 'blur'}],
          beginDate: [{required: true, message: 'Required:Date of Onboard', trigger: 'blur'}],
          conversionTime: [{required: true, message: 'Required:Positive Date', trigger: 'blur'}],
          beginContract: [{required: true, message: 'Required:Start Date of Contract', trigger: 'blur'}],
          endContract: [{required: true, message: 'Required:End Date of Contract', trigger: 'blur'}],
          workAge: [{required: true, message: 'Required:Working Years', trigger: 'blur'}]
        }
      };
    },
    mounted: function () {
      this.initData();
      this.loadEmps();
    },
    methods: {
      fileUploadSuccess(response, file, fileList){
        if (response) {
          this.$message({type: response.status, message: response.msg});
        }
        this.loadEmps();
        this.fileUploadBtnText = 'Import Data';
      },
      fileUploadError(err, file, fileList){
        this.$message({type: 'error', message: "Import failed!"});
        this.fileUploadBtnText = 'Import Data';
      },
      beforeFileUpload(file){
        this.fileUploadBtnText = 'Importing';
      },
      exportEmps(){
        window.open("/employee/basic/exportEmp", "_parent");
      },
      cancelSearch(){
        this.advanceSearchViewVisible = false;
        this.emptyEmpData();
        this.beginDateScope = '';
        this.loadEmps();
      },
      showAdvanceSearchView(){
        this.advanceSearchViewVisible = !this.advanceSearchViewVisible;
        this.keywords = '';
        if (!this.advanceSearchViewVisible) {
          this.emptyEmpData();
          this.beginDateScope = '';
          this.loadEmps();
        }
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      deleteManyEmps(){
        this.$confirm('This operation will delete[' + this.multipleSelection.length + ']rows of data, continue?', 'Reminder', {
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          var ids = '';
          for (var i = 0; i < this.multipleSelection.length; i++) {
            ids += this.multipleSelection[i].id + ",";
          }
          this.doDelete(ids);
        }).catch(() => {
        });
      },
      deleteEmp(row){
        this.$confirm('THis operation will permanently delte[' + row.name + '], continue', 'Reminder', {
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          this.doDelete(row.id);
        }).catch(() => {
        });
      },
      doDelete(ids){
        this.tableLoading = true;
        var _this = this;
        this.deleteRequest("/employee/basic/emp/" + ids).then(resp=> {
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            var data = resp.data;

            _this.loadEmps();
          }
        })
      },
      keywordsChange(val){
        if (val == '') {
          this.loadEmps();
        }
      },
      searchEmp(){
        this.loadEmps();
      },
      currentChange(currentChange){
        this.currentPage = currentChange;
        this.loadEmps();
      },
      loadEmps(){
        var _this = this;
        this.tableLoading = true;
        this.getRequest("/employee/basic/emp?page=" + this.currentPage + "&size=10&keywords=" + this.keywords + "&politicId=" + this.emp.politicId + "&nationId=" + this.emp.nationId + "&posId=" + this.emp.posId + "&jobLevelId=" + this.emp.jobLevelId + "&engageForm=" + this.emp.engageForm + "&departmentId=" + this.emp.departmentId + "&beginDateScope=" + this.beginDateScope).then(resp=> {
          this.tableLoading = false;
          if (resp && resp.status == 200) {
            var data = resp.data;
            _this.emps = data.emps;
            _this.totalCount = data.count;
//            _this.emptyEmpData();
          }
        })
      },
      addEmp(formName){
        var _this = this;
        this.$refs[formName].validate((valid) => {
          if (valid) {
            if (this.emp.id) {
              //更新
              this.tableLoading = true;
              this.putRequest("/employee/basic/emp", this.emp).then(resp=> {
                _this.tableLoading = false;
                if (resp && resp.status == 200) {
                  var data = resp.data;
                  _this.dialogVisible = false;
                  _this.emptyEmpData();
                  _this.loadEmps();
                }
              })
            } else {
              //添加
              this.tableLoading = true;
              this.postRequest("/employee/basic/emp", this.emp).then(resp=> {
                _this.tableLoading = false;
                if (resp && resp.status == 200) {
                  var data = resp.data;

                  _this.dialogVisible = false;
                  _this.emptyEmpData();
                  _this.loadEmps();
                }
              })
            }
          } else {
            return false;
          }
        });
      },
      cancelEidt(){
        this.dialogVisible = false;
        this.emptyEmpData();
      },
      showDepTree(){
        this.showOrHidePop = !this.showOrHidePop;
      },
      showDepTree2(){
        this.showOrHidePop2 = !this.showOrHidePop2;
      },
      handleNodeClick(data) {
        this.emp.departmentName = data.name;
        this.emp.departmentId = data.id;
        this.showOrHidePop = false;
        this.depTextColor = '#606266';
      },
      handleNodeClick2(data) {
        this.emp.departmentName = data.name;
        this.emp.departmentId = data.id;
        this.showOrHidePop2 = false;
        this.depTextColor = '#606266';
      },
      initData(){
        var _this = this;
        this.getRequest("/employee/basic/basicdata").then(resp=> {
          if (resp && resp.status == 200) {
            var data = resp.data;
            _this.nations = data.nations;
            _this.politics = data.politics;
            _this.deps = data.deps;
            _this.positions = data.positions;
            _this.joblevels = data.joblevels;
            _this.emp.workID = data.workID;
          }
        })
      },
      showEditEmpView(row){
        console.log(row)
        this.dialogTitle = "Edit Employee";
        this.emp = row;
        this.emp.birthday = this.formatDate(row.birthday);
        this.emp.conversionTime = this.formatDate(row.conversionTime);
        this.emp.beginContract = this.formatDate(row.beginContract);
        this.emp.endContract = this.formatDate(row.endContract);
        this.emp.beginDate = this.formatDate(row.beginDate);
        this.emp.nationId = row.nation.id;
        this.emp.politicId = row.politicsStatus.id;
        this.emp.departmentId = row.department.id;
        this.emp.departmentName = row.department.name;
        this.emp.jobLevelId = row.jobLevel.id;
        this.emp.posId = row.position.id;
//        delete this.emp.department;
//        delete this.emp.jobLevel;
//        delete this.emp.position;
//        delete this.emp.nation;
//        delete this.emp.politicsStatus;
        delete this.emp.workAge;
        delete this.emp.notWorkDate;
        delete this.emp.salary;
        this.dialogVisible = true;
      },
      showAddEmpView(){
        this.dialogTitle = "Add Employee";
        this.dialogVisible = true;
        var _this = this;
        this.getRequest("/employee/basic/maxWorkID").then(resp=> {
          if (resp && resp.status == 200) {
            _this.emp.workID = resp.data;
          }
        })
      },
      emptyEmpData(){
        this.emp = {
          name: '',
          gender: '',
          birthday: '',
          idCard: '',
          wedlock: '',
          nationId: '',
          nativePlace: '',
          politicId: '',
          email: '',
          phone: '',
          address: '',
          departmentId: '',
          departmentName: 'Department...',
          jobLevelId: '',
          posId: '',
          engageForm: '',
          tiptopDegree: '',
          specialty: '',
          school: '',
          beginDate: '',
          workState: '',
          workID: '',
          contractTerm: '',
          conversionTime: '',
          notWorkDate: '',
          beginContract: '',
          endContract: '',
          workAge: ''
        }
      }
    }
  };
</script>
<style>
  .el-dialog__body {
    padding-top: 0px;
    padding-bottom: 0px;
  }

  .slide-fade-enter-active {
    transition: all .8s ease;
  }

  .slide-fade-leave-active {
    transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
  }

  .slide-fade-enter, .slide-fade-leave-to {
    transform: translateX(10px);
    opacity: 0;
  }
</style>
