using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Key : MonoBehaviour
{
	Vector3 startPos;
	bool gameWasActive = false;

	void Start()
	{
		startPos = this.transform.position;
	}

	void Update()
	{
		if (Game.active && !gameWasActive)
		{
			gameWasActive = true;
		}
		else if (!Game.active && gameWasActive)
		{
			this.transform.position = startPos;
		}
	}
}
