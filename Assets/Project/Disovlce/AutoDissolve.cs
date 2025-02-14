using System.Collections;
using System.Collections.Generic;
using Unity.Mathematics;
using UnityEngine;
using Random = UnityEngine.Random;

public class AutoDissolve : MonoBehaviour
{
    private Renderer _renderer;
    private Material _material;
    private float dissolveSpeed = 0.3f;
    private bool hasSpawned = false;  

    [SerializeField] public bool DrawDebug = true; 
    [SerializeField] public Vector3 Center;
    [SerializeField] public float Radius;
    [SerializeField] public int Amount;
    [SerializeField] GameObject butterfly;


    private float _current;
   
   private void Start()
   {
     _renderer = this.GetComponent<Renderer>();
     _material = _renderer.material;
   }

   private void Update()
   {
    _current = _material.GetFloat("_AlphaClipThreshold");
    if(_current >= 0.4 && !hasSpawned)
    {
        SpawnButterfly();
        return;
    }
     Auto();
   }

    Vector3 GetRandomPointOnSphere(Vector3 sphereCenter, float sphereRadius)
    {
        // Generate random spherical coordinates
        float phi = Random.Range(0f, Mathf.PI * 2); // Azimuthal angle
        float theta = Random.Range(0f, Mathf.PI); // Polar angle

        // Convert spherical coordinates to Cartesian coordinates
        float x = sphereRadius * Mathf.Sin(theta) * Mathf.Cos(phi);
        float y = sphereRadius * Mathf.Sin(theta) * Mathf.Sin(phi);
        float z = sphereRadius * Mathf.Cos(theta);

        // Return the point relative to the sphere center
        return new Vector3(x, y, z) + sphereCenter;
    }
   private void SpawnButterfly()
   {
    for(int i = 0; i < Amount; i++)
    {
      Vector3 randomPos = GetRandomPointOnSphere(Center, Radius);
       GameObject g = Instantiate(butterfly, Center, Quaternion.identity);
        Debug.Log(g.transform.position);
       g.GetComponent<Butterfly>().Initlize(randomPos);
    }

    hasSpawned = true;
   }
   private void Auto()
   {
     if(_material.HasProperty("_AlphaClipThreshold"))
     {
    
        _material.SetFloat("_AlphaClipThreshold", _current += dissolveSpeed * Time.deltaTime);
     }
   }
   
   private void OnDrawGizmos()
   {
       if(!DrawDebug) return;

       Gizmos.color = Color.yellow;
       Gizmos.DrawWireSphere(Center, Radius);
   }
}
