using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Go : MonoBehaviour
{
	public AudioClip soundGo;

	void Update()
	{
		if (Game.MousePos().x < this.transform.position.x + this.transform.localScale.x / 2 &&
			Game.MousePos().x > this.transform.position.x - this.transform.localScale.x / 2 &&
			Game.MousePos().y < this.transform.position.y + this.transform.localScale.y / 2 &&
			Game.MousePos().y > this.transform.position.y - this.transform.localScale.y / 2 &&
			!Game.active && Input.GetMouseButtonDown(0) && !Game.tilePickedUp && !Game.goalReached &&
			!Game.messageActive)
		{
			AudioSource.PlayClipAtPoint(soundGo, 10 * Vector3.back);
			Game.active = true;
		}
	}
}
