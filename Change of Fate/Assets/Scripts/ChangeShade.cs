using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeShade : MonoBehaviour
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
		if (Game.MousePos().x < this.transform.position.x + this.transform.localScale.x / 2 &&
			Game.MousePos().x > this.transform.position.x - this.transform.localScale.x / 2 &&
			Game.MousePos().y < this.transform.position.y + this.transform.localScale.y / 2 &&
			Game.MousePos().y > this.transform.position.y - this.transform.localScale.y / 2 &&
			!Game.tilePickedUp && !Game.goalReached && !Game.messageActive)
		{
			float r = normalColor[0] * 0.6f;
			float g = normalColor[1] * 0.6f;
			float b = normalColor[2] * 0.6f;

			mat.color = new Color(r, g, b, normalColor[3]);
		}
		else
		{
			mat.color = normalColor;
		}
	}
}
