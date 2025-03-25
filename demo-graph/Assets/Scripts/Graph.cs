using UnityEngine;

public class Graph: MonoBehaviour
{
    [SerializeField]
    Transform pointPrefab;

    [SerializeField, Range(10, 1000)]
    int resolution = 10;
    Transform[] points;

    void Awake() {
      points = new Transform[resolution];
      Transform point;
      float step = 2f / resolution;
      Vector3 position = Vector3.zero;
      // scale the prefab to 1/5 of its original size.
      var scale = Vector3.one * step;
      for (int i = 0; i < points.Length; i++) {
        point = Instantiate(pointPrefab);
        point.SetParent(transform, false);
        position.x = ((i + 0.5f) * step - 1f);
        point.localPosition = position;
        point.localScale = scale;
        points[i] = point;
      }
    }

    void Update() {
      float time = Time.time;
      for (int i = 0; i < points.Length; i++) {
        Transform point = points[i];
        Vector3 position = point.localPosition;
        position.y = Mathf.Sin(Mathf.PI * (position.x + time));
        point.localPosition = position;
      }
    }

}
