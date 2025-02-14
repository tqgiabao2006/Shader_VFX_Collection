using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GemRoation : MonoBehaviour
{
    [SerializeField] float _rotateSpeed;

    private void Update()
    {
       this.transform.Rotate(new Vector3(0,0, _rotateSpeed)); 
    }
}
