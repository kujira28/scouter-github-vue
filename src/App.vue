<template>
  <div class="bg-gray-100 pb-60">
      <div class="max-w-l mx-auto p-1 pt-10 pr-0 text-center">
        <h2 class="text-lg font-bold text-gray-800">{{ displayMonth }}</h2>
        <form
          class="flex justify-center items-center my-10"
          v-on:submit.prevent="jumpCalendar"
        >
          <input
            class="bg-purple-white shadow rounded border-0 p-2 mr-4"
            type="text"
            v-model="jumpYear"
          />
          <p class="mr-4 text-lg font-bold text-gray-800">年</p>
          <input
            class="bg-purple-white shadow rounded border-0 p-2 mr-4"
            type="text"
            v-model="jumpMonth"
          />
          <p class="mr-4 text-lg font-bold text-gray-800">月</p>

          <button
            class="focus:outline-none text-white text-sm py-2 px-5 rounded-md bg-blue-500 hover:bg-blue-600 hover:shadow-lg"
            type="submit"
          >
            移動
          </button>
        </form>
        <div class="button-area">
          <button
            class="bg-indigo-500 hover:bg-indigo-600 text-white py-2 px-4 text-xs ml-4 mb-4 mr-8 ml-auto"
            @click="prevMonth"
          >
            前の月
          </button>
          <button
            class="bg-indigo-500 hover:bg-indigo-600 text-white py-2 px-4 text-xs ml-4 mb-4 mr-0 ml-auto"
            @click="nextMonth"
          >
            次の月
          </button>
        </div>
        <button
          @click="addTask"
          class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 text-xs ml-4 mb-4 mr-0 ml-auto"
        >
          <span class="font-bold text-xs">予定を追加する</span>
        </button>
        <div>
          <div
            class="fixed top-0 left-0 right-0 flex justify-center mt-24 z-50"
            v-show="show"
          >
            <div class="overlay" v-show="show" @click="show=false"></div>
            <div class="contentmodal" v-show="show">
              <h2 class="font-bold" v-if="update_mode">タスクの更新</h2>
              <h2 class="font-bold" v-else>予定の追加</h2>
              <div class="my-4">
                <label class="text-xs">予定名</label>
                <input
                  class="ml-2 text-xs border rounded-lg px-4 py-2"
                  v-model="form.name"
                />
              </div>
              <div class="my-4">
                <label class="text-xs">開始日</label>
                <input
                  class="ml-2 text-xs border rounded-lg px-4 py-2"
                  v-model="form.start"
                />
              </div>
              <div class="my-4">
                <label class="text-xs">完了日</label>
                <input
                  class="ml-2 text-xs border rounded-lg px-4 py-2"
                  v-model="form.end"
                />
              </div>
              <div class="my-4">
                <label class="text-xs">開始時刻</label>
                <select
                  class="ml-2 text-xs border w-40 rounded-lg px-4 py-2"
                  v-model="form.startTime"
                >
                  <option value="00:00">00:00</option>
                  <option value="01:00">01:00</option>
                  <option value="02:00">02:00</option>
                  <option value="03:00">03:00</option>
                  <option value="04:00">04:00</option>
                  <option value="05:00">05:00</option>
                  <option value="06:00">06:00</option>
                  <option value="07:00">07:00</option>
                  <option value="08:00">08:00</option>
                  <option value="09:00">09:00</option>
                  <option value="10:00">10:00</option>
                  <option value="11:00">11:00</option>
                  <option value="12:00">12:00</option>
                  <option value="13:00">13:00</option>
                  <option value="14:00">14:00</option>
                  <option value="15:00">15:00</option>
                  <option value="16:00">16:00</option>
                  <option value="17:00">17:00</option>
                  <option value="18:00">18:00</option>
                  <option value="19:00">19:00</option>
                  <option value="20:00">20:00</option>
                  <option value="21:00">21:00</option>
                  <option value="22:00">22:00</option>
                  <option value="23:00">23:00</option>
                </select>
              </div>
              <div class="my-4">
                <label class="text-xs">終了時刻</label>
                <select
                  class="ml-2 text-xs border w-40 rounded-lg px-4 py-2"
                  v-model="form.endTime"
                >
                  <option value="00:00">00:00</option>
                  <option value="01:00">01:00</option>
                  <option value="02:00">02:00</option>
                  <option value="03:00">03:00</option>
                  <option value="04:00">04:00</option>
                  <option value="05:00">05:00</option>
                  <option value="06:00">06:00</option>
                  <option value="07:00">07:00</option>
                  <option value="08:00">08:00</option>
                  <option value="09:00">09:00</option>
                  <option value="10:00">10:00</option>
                  <option value="11:00">11:00</option>
                  <option value="12:00">12:00</option>
                  <option value="13:00">13:00</option>
                  <option value="14:00">14:00</option>
                  <option value="15:00">15:00</option>
                  <option value="16:00">16:00</option>
                  <option value="17:00">17:00</option>
                  <option value="18:00">18:00</option>
                  <option value="19:00">19:00</option>
                  <option value="20:00">20:00</option>
                  <option value="21:00">21:00</option>
                  <option value="22:00">22:00</option>
                  <option value="23:00">23:00</option>
                </select>
              </div>
              <div class="my-4">
                <label class="text-xs">カラー(英語表記)</label>
                <input
                  class="ml-2 text-xs border rounded-lg px-4 py-2"
                  v-model="form.color"
                  type="text"
                />
              </div>
              <div class="my-4">
              </div>

              <div v-if="update_mode" class="flex items-center justify-between">
                <button
                  @click="updateTask(form.id)"
                  class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded-lg flex items-center"
                >
                  <span class="font-bold text-xs">予定を更新</span>
                </button>
                <button
                  @click="deleteTask(form.id)"
                  class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded-lg flex items-center ml-2"
                >
                  <span class="text-xs font-bold text-white">予定を削除</span>
                </button>
              </div>
              <div v-else>
                <button
                  @click="saveTask"
                  class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded-lg flex items-center"
                >
                  <span class="font-bold text-xs">タスクを追加</span>
                </button>
              </div>
            </div>
          </div>
        </div>
        <div class="calendar mx-auto bg-white shadow overflow-hidde">
          <div class="calendar-youbi-wrap">
            <div
              class="calendar-youbi border py-2 text-lg font-bold text-gray-600"
              v-for="n in 7"
              :key="n"
            >
              {{ youbi(n-1) }}
            </div>
          </div>
          <div
            class="calendar-weekly"
            v-for="(week, index) in calendars"
            :key="index"
          >
            <div
              class="calendar-daily"
              :class="{outside: currentMonth !== day.month}"
              v-for="(day, index) in week"
              :key="index"
              @drop="dragEnd(day.date)"
              @dragover.prevent
            >
              <div class="calendar-day pt-2 text-base font-bold text-gray-500">
                {{ day.day }}
              </div>

              <div
                class="relative"
                v-for="dayEvent in day.dayEvents"
                :key="dayEvent.id"
              >
                <div
                  v-if="dayEvent.width"
                  class="calendar-event relative"
                  :style="`width:${dayEvent.width}%;background-color:${dayEvent.color}`"
                  @click="editTask(dayEvent)"
                  draggable="true"
                  @dragstart="dragStart(dayEvent.id)"
                >
                  <div class="flex justify-center items-center">
                    <p>{{ dayEvent.name }}</p>
                  </div>
                  <p>開始{{ dayEvent.startTime }}</p>
                  <p>終了予定{{ dayEvent.endTime }}</p>
                </div>

                <div v-else style="height: 66px"></div>

                <div
                  v-if="dayEvent.width"
                  class="absolute w-2 h-full z-10"
                  style="top: 0px; left: -10px; cursor: col-resize"
                  draggable="true"
                  @dragstart="dragleft(dayEvent.id)"
                ></div>
                <div
                  v-if="colRight"
                  class="absolute w-2 h-full z-10"
                  style="top: 0; right: -10px; cursor: col-resize"
                  :style="`left:${dayEvent.width}%;`"
                  draggable="true"
                  @dragstart="dragright(dayEvent.id)"
                ></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

</template>

<script>
import moment from "moment";

export default {
  name: 'App',
   data() {
  return{
     currentDate: moment(),
          show: false,
          update_mode: false,
          changeKey: 0,
          colRight: true,
          jumpYear: '',
          jumpMonth: '',
          form: {
            id: '',
            name: '',
            start: '',
            end: '',
            color: '',
            startTime: '',
            endTime: '',
          },
          events: [],
  }
  },
         methods: {
          jumpCalendar() {
            this.currentDate = moment(this.currentDate)
              .year(parseInt(this.jumpYear))
              .month(parseInt(this.jumpMonth))
              .subtract(1, 'month');
          },
          addTask() {
            this.update_mode = false;
            this.form = {};
            this.show = true;
          },

          saveTask() {
            this.form.id = parseFloat(Math.random());
            this.events.push(this.form);
            this.form = {};
            this.show = false;
          },

          editTask(task) {
            this.update_mode = true;
            this.show = true;
            this.form.id = task.id;
            this.form.name = task.name;
            this.form.start = task.start;
            this.form.end = task.end;
            this.form.color = task.color;
            this.form.startTime = task.startTime;
            this.form.endTime = task.endTime;
          },

          updateTask(id) {
            let edit_index;
            this.events.map((task, index) => {
              if (task.id === id) edit_index = index;
            });
            this.events.splice(edit_index, 1);
            this.events.push(this.form);
            this.form = {};
            this.show = false;
          },

          deleteTask(id) {
            let delete_index;
            this.events.map((task, index) => {
              if (task.id === id) delete_index = index;
            });
            this.events.splice(delete_index, 1);
            this.form = {};
            this.show = false;
          },
          getStartDate() {
            let date = moment(this.currentDate);
            date.startOf('month');
            const youbiNum = date.day();
            return date.subtract(youbiNum, 'days');
          },
          getEndDate() {
            let date = moment(this.currentDate);
            date.endOf('month');
            const youbiNum = date.day();
            return date.add(6 - youbiNum, 'days');
          },
          getCalendar() {
            let startDate = this.getStartDate();
            const endDate = this.getEndDate();

            const weekNumber = Math.ceil(endDate.diff(startDate, 'days') / 7);

            let calendars = [];
            let calendarDate = this.getStartDate();
            for (let week = 0; week < weekNumber; week++) {
              let weekRow = [];
              for (let day = 0; day < 7; day++) {
                let dayEvents = this.getDayEvents(calendarDate, day);
                weekRow.push({
                  day: calendarDate.get('date'),
                  month: calendarDate.format('YYYY-MM'),
                  date: calendarDate.format('YYYY-MM-DD'),
                  dayEvents: dayEvents,
                });
                calendarDate.add(1, 'days');
              }
              calendars.push(weekRow);
            }

            return calendars;
          },
          getDayEvents(date, day) {
            let stackIndex = 0;
            let dayEvents = [];
            let startedEvents = [];
            this.sortedEvents.forEach((event) => {
              let startDate = moment(event.start).format('YYYY-MM-DD');
              let endDate = moment(event.end).format('YYYY-MM-DD');
              let Date = date.format('YYYY-MM-DD');
              if (startDate <= Date && endDate >= Date) {
                if (startDate === Date) {
                  [stackIndex, dayEvents, startedEvents] = this.getStackEvents(
                    event,
                    day,
                    date,
                    stackIndex,
                    dayEvents,
                    startedEvents,
                    event.start
                  );
                } else if (day === 0) {
                  [stackIndex, dayEvents, startedEvents] = this.getStackEvents(
                    event,
                    day,
                    date,
                    stackIndex,
                    dayEvents,
                    startedEvents,
                    date
                  );
                } else {
                  startedEvents.push(event);
                }
              }
            });
            return dayEvents;
          },

          getStackEvents(
            event,
            day,
            calendarDate,
            stackIndex,
            dayEvents,
            startedEvents,
            start
          ) {
            [stackIndex, startedEvents, dayEvents] = this.getStartedEvents(
              event,
              stackIndex,
              startedEvents,
              dayEvents
            );
            let width = this.getEventWidth(start, event.end, day);
            Object.assign(event, {
              stackIndex,
            });
            dayEvents.push({ ...event, width });
            stackIndex++;
            return [stackIndex, dayEvents, startedEvents];
          },
          getStartedEvents(event, stackIndex, startedEvents, dayEvents) {
            let startedEvent;
            do {
              startedEvent = startedEvents.find(
                (event) => event.stackIndex === stackIndex
              );
              if (startedEvent) {
                dayEvents.push(startedEvent);
                stackIndex++;
              }
            } while (typeof startedEvent !== 'undefined');
            return [stackIndex, startedEvents, dayEvents];
          },

          getEventWidth(end, start, day) {
            let betweenDays = -moment(end).diff(moment(start), 'days');
            if (betweenDays > 6 - day) {
              return (6 - day) * 100 + 95;
            } else {
              return betweenDays * 100 + 95;
            }
          },

          nextMonth() {
            this.currentDate = moment(this.currentDate).add(1, 'month');
          },
          prevMonth() {
            this.currentDate = moment(this.currentDate).subtract(1, 'month');
          },

          youbi(dayIndex) {
            let week = ['日', '月', '火', '水', '木', '金', '土'];
            const slice = week.splice(0, this.weekSlice);
            week = week.concat(slice);
            return week[dayIndex];
          },

          dragStart(dayEvent) {
            event.dataTransfer.effectAllowed = 'move';
            event.dataTransfer.dropEffect = 'move';
            event.dataTransfer.setData('eventId', dayEvent);
          },

          dragleft(dayEvent) {
            event.dataTransfer.effectAllowed = 'move';
            event.dataTransfer.dropEffect = 'move';
            event.dataTransfer.setData('dragIdLeft', dayEvent);
          },
          dragright(dayEvent) {
            event.dataTransfer.effectAllowed = 'move';
            event.dataTransfer.dropEffect = 'move';
            event.dataTransfer.setData('dragIdRight', dayEvent);
          },
          dragEnd(date) {
            let eventId = event.dataTransfer.getData('eventId');
            let dragIdLeft = event.dataTransfer.getData('dragIdLeft');
            let dragIdRight = event.dataTransfer.getData('dragIdRight');
            // this.colRight = false;

            if (eventId !== '') {
              let dragEvent = this((event) => event == eventId);
              let betweenDays = moment(
                moment(dragEvent),
                'days'
              );
              dragEvent.start = date;
              dragEvent.end = moment(dragEvent.start)
                .add(betweenDays, '')
                .format('YYYY-MM-DD');

              let drag_index;
              this((task, index) => {
                if (task === parseFloat(eventId)) {
                  drag_index = index;
                }
              });
              this(drag_index, 1);
              this();

            }

            if (dragIdLeft !== '') {
              let dragEvent = this(
                (event) => event == dragIdLeft
              );
              dragEvent.start = date;

              let drag_index;
              this((task, index) => {
                if (task === parseFloat(dragIdLeft)) {
                  drag_index = index;
                }
              });
              this.events.splice(drag_index, 1);
              this.events.push(dragEvent);
            }

            if (dragIdRight !== '') {
              let dragEvent = this(
                (event) => event == dragIdRight
              );
              dragEvent = date;

              let drag_index;
              this((task, index) => {
                if (task === parseFloat()) {
                  drag_index = index;
                }
              });
              this.events(drag_index, 1);
              this.events(dragEvent);
              this.colRight = true;
            }
          },
        },
        computed: {
          calendars() {
            return this.getCalendar();
          },
          displayMonth() {
            return this.currentDate.format('YYYY[年]M[月]');
          },
          currentMonth() {
            return this.currentDate.format('YYYY-MM');
          },
          sortedEvents() {
            return this.events.slice().sort(function (a, b) {
              let startTime = parseInt(a.startTime.replace(':', ''));
              let endTime = parseInt(b.startTime.replace(':', ''));

              if (startTime < endTime) return -1;
              if (startTime > endTime) return 1;
              return 0;
            });
          },

          sortedEventsByHour() {
            return this.events.slice().sort(function (a, b) {
              if (
                moment(a.end).diff(moment(a.start), 'days') === 1 &&
                moment(b.end).diff(moment(b.start), 'days') === 1
              ) {
                let startTime = moment(a.startTime).format('h:mm');
                let endTime = moment(b.startTime).format('h:mm');
                if (startTime < endTime) return -1;
                if (startTime > endTime) return 1;
                return 0;
              } else {
                return this.events.slice().sort(function (a, b) {
                  let startDate = moment(a.start).format('YYYY-MM-DD');
                  let endDate = moment(b.start).format('YYYY-MM-DD');
                  if (startDate < endDate) return -1;
                  if (startDate > endDate) return 1;
                  return 0;
                });
              }
            });
          },
        },
}
</script>

<style>
    .bgGray {
      background-color: #efefef;
    }
    .overlay {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-color: gray;
      opacity: 0.5;
    }
    .content {
      margin: 2em auto;
      width: 900px;
    }

    .contentmodal {
      background-color: white;
      position: relative;
      border-radius: 10px;
      padding: 40px;
    }
    .button-area {
      margin: 0.5em 0;
    }
    .button {
      padding: 4px 8px;
      margin-right: 8px;
    }
    .calendar {
      max-width: 900px;
      border-top: 1px solid #e0e0e0;
      font-size: 0.8em;
    }
    .calendar-weekly {
      display: flex;
      border-left: 1px solid #e0e0e0;
      /* background-color: black; */
    }
    .calendar-daily {
      flex: 1;
      min-height: 125px;
      border-right: 1px solid #e0e0e0;
      border-bottom: 1px solid #e0e0e0;
      margin-right: -1px;
    }
    .calendar-day {
      text-align: center;
    }

    .calendar-youbi-wrap {
      display: flex;
    }

    .calendar-youbi {
      flex: 1;
      border-right: 1px solid #e0e0e0;
      margin-right: -1px;
      text-align: center;
    }
    .calendar-event {
      color: white;
      margin-bottom: 1px;
      height: 65px;
      line-height: 20px;
      position: relative;
      z-index: 40;
      border-radius: 4px;
      padding-left: 4px;
      padding-top: 3px;
    }
</style>

<style src="./assets/tailwind.css" />