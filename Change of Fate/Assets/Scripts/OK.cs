using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OK : MonoBehaviour
{
	Material mat;
	Color normalColor;

	void Start()
	{
		mat = this.GetComponent<Renderer>().material;
		normalColor = mat.color;
	}

	void Update()
	{
		if (Game.MousePos().x < this.transform.position.x + this.transform.lossyScale.x / 2 &&
			Game.MousePos().x > this.transform.position.x - this.transform.lossyScale.x / 2 &&
			Game.MousePos().y < this.transform.position.y + this.transform.lossyScale.y / 2 &&
			Game.MousePos().y > this.transform.position.y - this.transform.lossyScale.y / 2 &&
			!Game.tilePickedUp && !Game.goalReached)
		{
			float r = normalColor[0] * 0.4f;
			float g = normalColor[1] * 0.4f;
			float b = normalColor[2] * 0.4f;

			mat.color = new Color(r, g, b, normalColor[3]);
		}
		else
		{
			mat.color = normalColor;
		}

		if (Game.MousePos().x < this.transform.position.x + this.transform.lossyScale.x / 2 &&
			Game.MousePos().x > this.transform.position.x - this.transform.lossyScale.x / 2 &&
			Game.MousePos().y < this.transform.position.y + this.transform.lossyScale.y / 2 &&
			Game.MousePos().y > this.transform.position.y - this.transform.lossyScale.y / 2 &&
			Input.GetMouseButtonDown(0))
		{
			Game.messageActive = false;
			Time.timeScale = 1f;
			Destroy(this.transform.parent.gameObject);
		}
	}
}
