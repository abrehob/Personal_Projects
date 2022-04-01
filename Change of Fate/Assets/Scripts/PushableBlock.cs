using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PushableBlock : MonoBehaviour
{
	public AudioClip pushBlock;
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

	void OnTriggerEnter(Collider other)
	{
		if (other.CompareTag("Ball"))
		{
			Vector3 pos = this.gameObject.transform.position;
			Vector3 otherPos = other.gameObject.transform.position;
			if (otherPos.x < pos.x - 0.5f && !Physics.Raycast(pos, Vector3.right, 1f))
			{
				pos = pos + Vector3.right;
			}
			else if (otherPos.x > pos.x + 0.5f && !Physics.Raycast(pos, Vector3.left, 1f))
			{
				pos = pos + Vector3.left;
			}
			else if (otherPos.y < pos.y - 0.5f && !Physics.Raycast(pos, Vector3.up, 1f))
			{
				pos = pos + Vector3.up;
			}
			else if (otherPos.y > pos.y + 0.5f && !Physics.Raycast(pos, Vector3.down, 1f))
			{
				pos = pos + Vector3.down;
			}

			this.gameObject.transform.position = pos;
			AudioSource.PlayClipAtPoint(pushBlock, 10 * Vector3.back);
		}
	}
}
