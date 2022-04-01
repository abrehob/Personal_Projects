using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Door : MonoBehaviour
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
			return;
		}

		GameObject[] keys = GameObject.FindGameObjectsWithTag("Key");
		bool destroySelf = true;

		foreach (GameObject key in keys)
		{
			if (this.gameObject.name == "YellowDoor" && key.name == "YellowKey" && 
				key.transform.position.y < 20)
			{
				destroySelf = false;
			}
			else if (this.gameObject.name == "PurpleDoor" && key.name == "PurpleKey" &&
				key.transform.position.y < 20)
			{
				destroySelf = false;
			}
		}

		if (destroySelf)
		{
			this.gameObject.transform.position += Vector3.up * 50;
		}
	}
}
