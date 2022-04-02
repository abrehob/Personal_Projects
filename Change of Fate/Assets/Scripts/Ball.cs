using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Ball : MonoBehaviour
{
	public AudioClip woohoo;
	public AudioClip bounce;
	public AudioClip changeDir;
	public AudioClip ow;
	public AudioClip teleportSound;
	public AudioClip openDoor;
	public GameObject trail;
	public GameObject arrow;
	private GameObject arrowCopy;

	public int startDirection = 0;
	public static float normalSpeed = 4f;
	public static float speed;
	Rigidbody rigid;
	bool gameWasActive = false;
	Vector3 startPos;
	Vector3 tilePos;
	Vector3 otherTilePos;
	bool changeDirection = false;
	int direction;
	int nextDirection = 0;
	float speedIncrement = 0.1f;
	Vector3 normalScale;
	bool willFallInHole = false;
	bool fallingInHole = false;
	bool willTeleport = false;
	bool bounced = false;
	bool bounced2 = false;
	bool teleport = false;
	bool teleport2 = false;

	void Start()
	{
		Game.active = false;
		startPos = this.transform.position;
		direction = startDirection;

		arrowCopy = GameObject.Instantiate(arrow);
		int multiplier = 0;
		if (this.direction == 0 || this.direction == 1)
		{
			multiplier = 1;
		}
		else
		{
			multiplier = -1;
		}
		arrowCopy.transform.position = new Vector3(this.transform.position.x +
			(((int) (this.direction + 1) % 2) * (multiplier * 1.3f)),
			this.transform.position.y + (((int) this.direction % 2) *
			(multiplier * 1.3f)), this.transform.position.z);
		arrowCopy.transform.rotation = 
			Quaternion.Euler(0, 0, this.direction * 90 - 90);
		
		rigid = this.GetComponent<Rigidbody>();
		rigid.velocity = Vector3.zero;
		normalScale = this.transform.localScale;
		speed = 0;
		Game.goalReached = false;
	}

	void FixedUpdate()
	{
		if (Game.active && !gameWasActive)
		{
			gameWasActive = true;
			speed = normalSpeed;
			SetVelocity();
		}
		else if (!Game.active && gameWasActive)
		{
			gameWasActive = false;
			this.transform.position = startPos;
			this.transform.localScale = normalScale;
			direction = startDirection;

			// I think this causes a race condition with code in Arrow.cs
			/*Instantiate(arrow);
			int multiplier = 0;
			if (this.direction == 0 || this.direction == 90)
			{
				multiplier = 1;
			}
			else
			{
				multiplier = -1;
			}
			arrow.transform.position = new Vector3(this.transform.position.x +
				((((int) (this.direction + 90) % 180) / 90) * ((multiplier - 0.5f) * 2) * 1.3f),
				this.transform.position.x + ((((int) this.direction % 180) / 90) *
				((multiplier - 0.5f) * 2) * 1.3f), this.transform.position.z);*/
				
			rigid.velocity = Vector3.zero;
			Game.goalReached = false;
			changeDirection = false;
			willFallInHole = false;
			fallingInHole = false;
			willTeleport = false;
			bounced = false;
			bounced2 = false;
			teleport = false;
			teleport2 = false;
		}
		else if (fallingInHole)
		{
			Vector3 scale = this.transform.localScale;
			if (scale.x > 0f)
			{
				this.transform.localScale = new Vector3(scale.x - 0.03f, scale.y - 0.03f, scale.z - 0.03f);
			}
			else
			{
				fallingInHole = false;
				Game.active = false;
			}
		}
		else
		{
			if (Game.active &&
				this.transform.position.x < tilePos.x + 0.1f &&
				this.transform.position.x > tilePos.x - 0.1f &&
				this.transform.position.y < tilePos.y + 0.1f &&
				this.transform.position.y > tilePos.y - 0.1f)
			{
				if (changeDirection)
				{
					AudioSource.PlayClipAtPoint(changeDir, 10 * Vector3.back);
					this.transform.position = new Vector3(tilePos.x, tilePos.y, this.transform.position.z);
					changeDirection = false;
					direction = nextDirection;
					SetVelocity();
				}
				else if (Game.goalReached)
				{
					AudioSource.PlayClipAtPoint(woohoo, 10 * Vector3.back);
					Destroy(this.gameObject);
				}
				else if (willTeleport)
				{
					AudioSource.PlayClipAtPoint(teleportSound, 10 * Vector3.back);
					willTeleport = false;
					teleport = true;
					this.transform.position = new Vector3(otherTilePos.x, otherTilePos.y,
						this.transform.position.z);
				}
				else if (willFallInHole)
				{
					this.transform.position = new Vector3(tilePos.x, tilePos.y, this.transform.position.z);
					willFallInHole = false;
					fallingInHole = true;
					rigid.velocity = Vector3.zero;
				}
			}

			if (Game.active)
			{
				if (Input.GetKey(KeyCode.F) && !Input.GetKey(KeyCode.S) && speed < normalSpeed * 1.5f)
				{
					UpdateVelocity(true);
				}
				else if (Input.GetKey(KeyCode.S) && !Input.GetKey(KeyCode.F) && speed > normalSpeed / 6f)
				{
					UpdateVelocity(false);
				}

				if (trail != null)
				{
					GameObject go = GameObject.Instantiate(trail);
					go.transform.position = this.transform.position + new Vector3(0f, 0f, 0.4f);
				}
			}

			// Allows 2 frames for checking if bounced
			// against a wall and still on a tile
			if (bounced)
			{
				bounced = false;
				bounced2 = true;
			}
			else if (bounced2)
			{
				bounced2 = false;
			}

			if (teleport)
			{
				teleport = false;
				teleport2 = true;
			}
			else if (teleport2)
			{
				teleport2 = false;
			}
		}

		speed = rigid.velocity.magnitude;
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

	void UpdateVelocity(bool positive)
	{
		Vector3 velocityChange = Vector3.zero;

		if (direction == 0)
		{
			velocityChange = new Vector3(speedIncrement, 0, 0);
		}
		else if (direction == 1)
		{
			velocityChange = new Vector3(0, speedIncrement, 0);
		}
		else if (direction == 2)
		{
			velocityChange = new Vector3(-speedIncrement, 0, 0);
		}
		else if (direction == 3)
		{
			velocityChange = new Vector3(0, -speedIncrement, 0);
		}

		if (!positive)
		{
			velocityChange = -velocityChange;
		}
		rigid.velocity += velocityChange;
	}

	void OnTriggerEnter(Collider other)
	{
		if (other.CompareTag("Goal"))
		{
			Game.goalReached = true;
			tilePos = other.gameObject.transform.position;
		}
		else if (other.CompareTag("Tile"))
		{
			changeDirection = true;
			tilePos = other.gameObject.transform.position;

			int otherRotation = (int) other.gameObject.transform.rotation.eulerAngles.z;
			if (otherRotation == 0)
			{
				nextDirection = 1;
			}
			else if (otherRotation == 90)
			{
				nextDirection = 2;
			}
			else if (otherRotation == 180)
			{
				nextDirection = 3;
			}
			else
			{
				nextDirection = 0;
			}
		}
		else if (other.CompareTag("ClockwiseTile"))
		{
			changeDirection = true;
			tilePos = other.gameObject.transform.position;

			nextDirection = (direction + 3) % 4;
		}
		else if (other.CompareTag("CounterclockwiseTile"))
		{
			changeDirection = true;
			tilePos = other.gameObject.transform.position;

			nextDirection = (direction + 1) % 4;
		}
		else if (other.CompareTag("TeleportTile"))
		{
			// Don't teleport if you just teleported
			if (teleport || teleport2)
			{
				return;
			}
			willTeleport = true;
			tilePos = other.gameObject.transform.position;

			if (other.name == "YellowTeleportTile")
			{
				otherTilePos = GameObject.Find("FixedYellowTeleportTile").transform.position;
			}
			else if (other.name == "FixedYellowTeleportTile")
			{
				otherTilePos = GameObject.Find("YellowTeleportTile").transform.position;
			}
			if (other.name == "PurpleTeleportTile")
			{
				otherTilePos = GameObject.Find("FixedPurpleTeleportTile").transform.position;
			}
			if (other.name == "FixedPurpleTeleportTile")
			{
				otherTilePos = GameObject.Find("PurpleTeleportTile").transform.position;
			}
		}
		else if (other.CompareTag("Enemy"))
		{
			AudioSource.PlayClipAtPoint(ow, 10 * Vector3.back);
			Game.active = false;
		}
		else if (other.CompareTag("Hole"))
		{
			willFallInHole = true;
			tilePos = other.gameObject.transform.position;
		}
		else if (other.CompareTag("Key"))
		{
			AudioSource.PlayClipAtPoint(openDoor, 10 * Vector3.back);
			other.gameObject.transform.position += Vector3.up * 50;
		}
		else
		{
			bounced = true;
			rigid.velocity = -rigid.velocity;
			direction = (direction + 2) % 4;
			AudioSource.PlayClipAtPoint(bounce, 10 * Vector3.back);
		}
	}

	// If you don't leave a tile and you bounce against a wall,
	// the tile should change the ball's direction again
	void OnTriggerStay(Collider other)
	{
		if ((bounced || bounced2) && (other.CompareTag("Tile") || other.CompareTag("ClockwiseTile") ||
			other.CompareTag("CounterclockwiseTile")))
		{
			changeDirection = true;
			bounced = false;
			bounced2 = false;

			if (other.CompareTag("ClockwiseTile"))
			{
				nextDirection = (direction + 3) % 4;
			}
			else if (other.CompareTag("CounterclockwiseTile"))
			{
				nextDirection = (direction + 1) % 4;
			}
		}
	}

	void OnDestroy()
	{
		Destroy(arrowCopy);
	}
}
