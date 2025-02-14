using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using UnityEngine;
using Vector3 = UnityEngine.Vector3;

public class Butterfly : MonoBehaviour
{
    private Vector3 goal = Vector3.zero;
    
    [SerializeField] public float speed;
    [SerializeField] public float lifeTime;
    public void Initlize(Vector3 goal)
    {
        this.goal = goal;
       
    }
    private void Update()
    {

    
        if(goal != Vector3.zero)
        {
            Vector3 dir = (goal - this.transform.position).normalized;
            this.transform.position += dir * speed * Time.deltaTime;
            lifeTime -= Time.deltaTime;

        }
    }
   
}
