using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CircularEnemy : MonoBehaviour
{
	public int startPosPath;
	public bool clockwise;
	Rigidbody rigid;
	bool gameWasActive = false;
	Vector3 startPos;
	Vector3 center;
	int direction;
	float speed = 2f;
	float currRadians = 0;
	float radianIncrement = 0.3f;

	void Start()
	{
		startPos = this.transform.position;

		// Upper left, going clockwise
		if (startPosPath == 0)
		{
			center = new Vector3(startPos.x + 1f, startPos.y - 1f, startPos.z);
		}
		else if (startPosPath == 1)
		{
			center = new Vector3(startPos.x, startPos.y - 1f, startPos.z);
		}
		else if (startPosPath == 2)
		{
			center = new Vector3(startPos.x - 1f, startPos.y - 1f, startPos.z);
		}
		else if (startPosPath == 3)
		{
			center = new Vector3(startPos.x - 1f, startPos.y, startPos.z);
		}
		else if (startPosPath == 4)
		{
			center = new Vector3(startPos.x - 1f, startPos.y + 1f, startPos.z);
		}
		else if (startPosPath == 5)
		{
			center = new Vector3(startPos.x, startPos.y + 1f, startPos.z);
		}
		else if (startPosPath == 6)
		{
			center = new Vector3(startPos.x + 1f, startPos.y + 1f, startPos.z);
		}
		else
		{
			center = new Vector3(startPos.x + 1f, startPos.y, startPos.z);
		}
		
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
			SetVelocity();
		}

		if (this.transform.position.x > center.x + 1f)
		{
			this.transform.position = new Vector3(center.x + 1f,
				this.transform.position.y, this.transform.position.z);
			if (clockwise)
			{
				rigid.velocity = Vector3.down * speed;
			}
			else
			{
				rigid.velocity = Vector3.up * speed;
			}
		}
		else if (this.transform.position.x < center.x - 1f)
		{
			this.transform.position = new Vector3(center.x - 1f,
				this.transform.position.y, this.transform.position.z);
			if (clockwise)
			{
				rigid.velocity = Vector3.up * speed;
			}
			else
			{
				rigid.velocity = Vector3.down * speed;
			}
		}
		else if (this.transform.position.y > center.y + 1f)
		{
			this.transform.position = new Vector3(this.transform.position.x,
				center.y + 1f, this.transform.position.z);
			if (clockwise)
			{
				rigid.velocity = Vector3.right * speed;
			}
			else
			{
				rigid.velocity = Vector3.left * speed;
			}
		}
		else if (this.transform.position.y < center.y - 1f)
		{
			this.transform.position = new Vector3(this.transform.position.x,
				center.y - 1f, this.transform.position.z);
			if (clockwise)
			{
				rigid.velocity = Vector3.left * speed;
			}
			else
			{
				rigid.velocity = Vector3.right * speed;
			}
		}

		// Rotates the little circle around the big one
		if (clockwise)
		{
			currRadians += radianIncrement;
		}
		else
		{
			currRadians -= radianIncrement;
		}
		if (currRadians >= 2 * Mathf.PI)
		{
			currRadians -= 2 * Mathf.PI;
		}
		else if (currRadians < 0)
		{
			currRadians += 2 * Mathf.PI;
		}
		Transform circle = this.transform.Find("Circle");
		circle.position = new Vector3(this.transform.position.x + 0.3f * Mathf.Cos(currRadians),
			this.transform.position.y + 0.3f * Mathf.Sin(currRadians), this.transform.position.z);
	}

	void SetVelocity()
	{
		if (startPosPath == 0 || startPosPath == 1)
		{
			if (clockwise)
			{
				rigid.velocity = Vector3.right * speed;
			}
			else
			{
				rigid.velocity = Vector3.left * speed;
			}
		}
		else if (startPosPath == 2 || startPosPath == 3)
		{
			if (clockwise)
			{
				rigid.velocity = Vector3.down * speed;
			}
			else
			{
				rigid.velocity = Vector3.up * speed;
			}
		}
		else if (startPosPath == 4 || startPosPath == 5)
		{
			if (clockwise)
			{
				rigid.velocity = Vector3.left * speed;
			}
			else
			{
				rigid.velocity = Vector3.right * speed;
			}
		}
		else if (startPosPath == 6 || startPosPath == 7)
		{
			if (clockwise)
			{
				rigid.velocity = Vector3.up * speed;
			}
			else
			{
				rigid.velocity = Vector3.down * speed;
			}
		}
	}

	void OnTriggerEnter(Collider other)
	{
		if (other.CompareTag("Enemy") || other.CompareTag("Untagged"))
		{
			rigid.velocity = -rigid.velocity;
			clockwise = !clockwise;
		}
	}
}
