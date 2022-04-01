using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Play : MonoBehaviour
{
	public GameObject levelSelect;

	void Update()
	{
		if (Game.MousePos().x < this.transform.position.x + this.transform.localScale.x / 2 &&
			Game.MousePos().x > this.transform.position.x - this.transform.localScale.x / 2 &&
			Game.MousePos().y < this.transform.position.y + this.transform.localScale.y / 2 &&
			Game.MousePos().y > this.transform.position.y - this.transform.localScale.y / 2 &&
			Input.GetMouseButtonDown(0))
		{
			Destroy(GameObject.Find("ChangeOfFate").gameObject);
			GameObject go = Instantiate(levelSelect);
			go.transform.position = Vector3.zero;
			Destroy(this.gameObject);
		}
	}
}
