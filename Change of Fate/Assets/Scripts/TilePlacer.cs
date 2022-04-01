using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TilePlacer : MonoBehaviour
{
	bool destroy = false;

	// Destroys itself the frame after it is created
	void Update()
	{
		if (destroy)
		{
			GameObject.Destroy(this.gameObject);
		}
		else
		{
			destroy = true;
		}
	}
}
