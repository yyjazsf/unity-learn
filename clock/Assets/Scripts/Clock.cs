using System;
using UnityEngine;

public class Clock : MonoBehaviour {
  [SerializeField]
  Transform hoursPivot, minutesPivot, secondsPivot;

  void initUI() {
    // 初始化UI 动态创建表盘
  }
  void updateClock() {
    // 指针瞬间转动
    DateTime time = DateTime.Now;
    // 360/12 = 30度  
    hoursPivot.localRotation = Quaternion.Euler(0, 0, -30 * time.Hour);
    // 360/60 = 6度
    minutesPivot.localRotation = Quaternion.Euler(0, 0, -6 * time.Minute);
    // 360/60 = 6度
    secondsPivot.localRotation = Quaternion.Euler(0, 0, -6 * time.Second);
    // 指针连续转动
    // TimeSpan time = DateTime.Now.TimeOfDay;
    // hoursPivot.localRotation = Quaternion.Euler(0, 0, -30 * (float)time.TotalHours);
    // minutesPivot.localRotation = Quaternion.Euler(0, 0, -6 * (float)time.TotalMinutes);
    // secondsPivot.localRotation = Quaternion.Euler(0, 0, -6 * (float)time.TotalSeconds);
  }
  void Awake() {
    updateClock();
  }
  void Update() {
    updateClock();
  }
}
