using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tile : MonoBehaviour
{
	public GameObject tilePlacer;
	public AudioClip pickUp;
	public AudioClip placeDown;

	void Update()
	{
		// If this tile is currently picked up, have it follow the mouse
		if (Game.tilePickedUp == this)
		{
			this.transform.position = new Vector3(Game.MousePos().x, Game.MousePos().y,
				this.transform.position.z);
			if (!ObjectUnderneath())
			{
				GameObject go = GameObject.Instantiate(tilePlacer);
				go.transform.position = GridSnap();
			}
		}

		if (Game.MousePos().x < this.transform.position.x + this.transform.localScale.x / 2 &&
			Game.MousePos().x > this.transform.position.x - this.transform.localScale.x / 2 &&
			Game.MousePos().y < this.transform.position.y + this.transform.localScale.y / 2 &&
			Game.MousePos().y > this.transform.position.y - this.transform.localScale.y / 2 &&
			!Game.active && Input.GetMouseButtonDown(0) && !Game.goalReached && !Game.messageActive)
		{
			// If this tile is currently picked up, put it down if there's nothing underneath
			if (Game.tilePickedUp == this && !ObjectUnderneath())
			{
				Game.tilePickedUp = null;
				this.transform.position = GridSnap();
				AudioSource.PlayClipAtPoint(placeDown, 10 * Vector3.back);
			}
			// If a tile is not currently picked up, pick this one up
			else if (!Game.tilePickedUp)
			{
				Game.tilePickedUp = this;
				this.transform.position += new Vector3(0, 0, -1.5f);
				AudioSource.PlayClipAtPoint(pickUp, 10 * Vector3.back);
			}
		}
	}

	Vector3 GridCheck()
	{
		return new Vector3(Mathf.Round(this.transform.position.x - 0.5f) + 0.5f,
			Mathf.Round(this.transform.position.y - 0.5f) + 0.5f, this.transform.position.z - 0.04f);
	}

	Vector3 GridSnap()
	{
		return new Vector3(Mathf.Round(this.transform.position.x - 0.5f) + 0.5f,
			Mathf.Round(this.transform.position.y - 0.5f) + 0.5f, this.transform.position.z + 1.5f);
	}

	bool ObjectUnderneath()
	{
		return Physics.Raycast(GridCheck(), Vector3.forward, 1.5f);
	}
}
