using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMove : MonoBehaviour
{
    [SerializeField] List<Vector3> CameraPosition; 
    [SerializeField] float CameraSpeed = 2; 
    [SerializeField] float SlowDownFactor = 2; 
    [SerializeField] public bool ZoomInTake;
    [SerializeField] public bool RotateTake;

    Vector3 direction;

    void Start()
    {
    }

    void Update()
    {
       if(ZoomInTake)
       {
         ZoomIn();
       }else if(RotateTake)
       {
          Rotate();
       }
    }

    private void Rotate()
    {
        this.transform.Rotate(0, CameraSpeed * Time.deltaTime, 0, Space.Self);
    }

    private void ZoomIn()
    {
        if (CameraPosition.Count < 2) return;

        direction = CameraPosition[1] - this.transform.position;

        float dis = Vector3.Distance(this.transform.position, CameraPosition[1]);

        if (dis <= 0.1f)
        {
            return; 
        }
        else if (dis <= 1f && dis > 0.1f)
        {
            CameraSpeed = Mathf.Max(0.2f, CameraSpeed - Time.deltaTime * SlowDownFactor); // Slow down smoothly
        }

        this.transform.Translate(direction.normalized * CameraSpeed * Time.deltaTime);

    }
}
