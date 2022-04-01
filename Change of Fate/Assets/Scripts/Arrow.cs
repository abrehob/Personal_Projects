using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Arrow : MonoBehaviour
{
	Vector3 startPos;
	Quaternion rotation;
	Vector3 destination;
	float timeForBounce = 0.8f;
	float timeSinceStartOfBounce;
	float distance = 0.8f;
	bool gameWasActive = false;

	void Start()
	{
		startPos = this.transform.position;
		rotation = this.transform.rotation;

		if (rotation.eulerAngles.z == 0)
		{
			destination = this.transform.position + new Vector3(0, distance, 0);
		}
		else if (rotation.eulerAngles.z == 90)
		{
			destination = this.transform.position + new Vector3(-distance, 0, 0);
		}
		else if (rotation.eulerAngles.z == 180)
		{
			destination = this.transform.position + new Vector3(0, -distance, 0);
		}
		else
		{
			destination = this.transform.position + new Vector3(distance, 0, 0);
		}

		timeSinceStartOfBounce = Time.time;
	}

	void FixedUpdate() 
	{
		if (!Game.active)
		{
			if (gameWasActive)
			{
				gameWasActive = false;
				this.transform.position = startPos;
				timeSinceStartOfBounce = Time.time;
			}

			// Trust me, this math works out
			if ((Time.time - timeSinceStartOfBounce) / timeForBounce <= 0.5f)
			{
				this.transform.position = startPos + (destination - startPos) *
					Mathf.Sqrt(2 * (Time.time - timeSinceStartOfBounce) / timeForBounce);
			}
			else if ((Time.time - timeSinceStartOfBounce) / timeForBounce <= 1f)
			{
				this.transform.position = destination + (startPos - destination) *
					Mathf.Pow((2 * (Time.time - timeSinceStartOfBounce - timeForBounce / 2) / timeForBounce), 2);
			}
			else
			{
				timeSinceStartOfBounce = Time.time;
			}
		}
		else if (!gameWasActive)
		{
			gameWasActive = true;
			this.transform.position = new Vector3(20, 20, 0);
		}
	}
}
