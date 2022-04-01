using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Trail : MonoBehaviour
{
	void Update()
	{
		if (!Game.active)
		{
			Destroy(this.gameObject);
		}

		this.transform.localScale -= new Vector3(0.05f, 0.05f, 0f);
		this.transform.position += new Vector3(0f, 0f, 0.005f);
		if (this.transform.localScale.x < 0.02f)
		{
			Destroy(this.gameObject);
		}
	}
}
