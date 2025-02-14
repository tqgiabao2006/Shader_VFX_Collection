using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PortalController : MonoBehaviour
{

   #region StartValue
     [SerializeField] float _circleClipStart;
     [SerializeField] float _featherStart;
     [SerializeField] float _circleWidthStart;
     [SerializeField] float _portalSpeed;

   #endregion

   #region Targetvalue
   [SerializeField] float _circleClipTarget;
     [SerializeField] float _featherTarget;
     [SerializeField] float _circleWidthTarget;
   #endregion
   
   #region CurrentValue
    [SerializeField] float _circleClipCurrent;
     [SerializeField] float _featherCurrent;
     [SerializeField] float _circleWidthCurrent;
   #endregion
   
   private Material material;
    void Start()
    {
        material = GetComponent<MeshRenderer>().material;
        
    }

    // Update is called once per frame
    void Update()
    {
        _circleClipCurrent = Mathf.Lerp(_circleClipCurrent, _circleClipTarget, Time.deltaTime * _portalSpeed);
        _featherCurrent = Mathf.Lerp(_featherCurrent, _featherTarget, Time.deltaTime * _portalSpeed);  
        _circleWidthCurrent = Mathf.Lerp(_circleWidthCurrent, _circleWidthTarget, Time.deltaTime * _portalSpeed);

        if(Input.GetKeyDown(KeyCode.A))
        {
            _circleClipTarget = _circleClipStart;
            _circleWidthTarget = _circleWidthStart;
            _featherTarget = _featherStart;
        }

        if(Input.GetKeyDown(KeyCode.S))
        {
            _circleClipTarget =0;
            _circleWidthTarget = 0;
            _featherTarget =0;
        }

        material.SetFloat("_CircleClip", _circleClipCurrent);
        material.SetFloat("_Feather", _featherCurrent);
        material.SetFloat("_RingWidth",_circleWidthCurrent);


        
    }
}
