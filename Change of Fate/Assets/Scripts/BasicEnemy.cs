using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BasicEnemy : MonoBehaviour
{
	public int startDirection = 0;
	Rigidbody rigid;
	bool gameWasActive = false;
	Vector3 startPos;
	int direction;
	float speed = 2f;
	float rotateIncrement = 3f;

	void Start()
	{
		startPos = this.transform.position;
		direction = startDirection;
		rigid = this.GetComponent<Rigidbody>();
		SetVelocity();
	}

	void Update()
	{
		if (Game.active && !gameWasActive)
		{
			gameWasActive = true;
		}
		else if (!Game.active && gameWasActive)
		{
			gameWasActive = false;
			this.transform.position = startPos;
			direction = startDirection;
			SetVelocity();
		}

		Transform rotateThing = this.transform.Find("RotateThing");
		Vector3 rotation = rotateThing.rotation.eulerAngles;
		rotateThing.rotation = Quaternion.Euler(rotation.x, rotation.y, rotation.z - rotateIncrement);
	}

	void SetVelocity()
	{
		if (direction == 0)
		{
			rigid.velocity = new Vector3(speed, 0, 0);
		}
		else if (direction == 1)
		{
			rigid.velocity = new Vector3(0, speed, 0);
		}
		else if (direction == 2)
		{
			rigid.velocity = new Vector3(-speed, 0, 0);
		}
		else if (direction == 3)
		{
			rigid.velocity = new Vector3(0, -speed, 0);
		}
	}

	void OnTriggerEnter(Collider other)
	{
		if (other.CompareTag("Enemy") || other.CompareTag("Untagged"))
		{
			rigid.velocity = -rigid.velocity;
			direction = (direction + 2) % 4;
		}
	}
}
