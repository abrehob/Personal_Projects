using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClickWall : MonoBehaviour
{
	public AudioClip click;
	Material mat;
	Color normalColor;
	bool gameWasActive = false;
	bool clicked = false;
	Vector3 startPos;
	Vector3 child0StartPos;
	Vector3 child1StartPos;
	Vector3 child2StartPos;

	void Start()
	{
		mat = this.GetComponent<Renderer>().material;
		normalColor = mat.color;
		startPos = this.transform.position;
		child0StartPos = this.transform.GetChild(0).position;
		child1StartPos = this.transform.GetChild(1).position;
		child2StartPos = this.transform.GetChild(2).position;
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
			clicked = false;
			this.transform.position = startPos;
			this.transform.GetChild(0).position = child0StartPos;
			this.transform.GetChild(1).position = child1StartPos;
			this.transform.GetChild(2).position = child2StartPos;
		}

		if (Game.MousePos().x < this.transform.position.x + this.transform.localScale.x / 2 &&
			Game.MousePos().x > this.transform.position.x - this.transform.localScale.x / 2 &&
			Game.MousePos().y < this.transform.position.y + this.transform.localScale.y / 2 &&
			Game.MousePos().y > this.transform.position.y - this.transform.localScale.y / 2 &&
			Game.active && Input.GetMouseButtonDown(0) && !Game.goalReached && !clicked)
		{
			clicked = true;
			AudioSource.PlayClipAtPoint(click, 10 * Vector3.back);
			this.transform.position += new Vector3(0, 0, 0.998f);
			this.transform.GetChild(0).position += new Vector3(0, 0, 5f);
			this.transform.GetChild(1).position += new Vector3(0, 0, 5f);
			this.transform.GetChild(2).position += new Vector3(0, 0, 5f);
		}
			
		if (Game.MousePos().x < this.transform.position.x + this.transform.localScale.x / 2 &&
			Game.MousePos().x > this.transform.position.x - this.transform.localScale.x / 2 &&
			Game.MousePos().y < this.transform.position.y + this.transform.localScale.y / 2 &&
			Game.MousePos().y > this.transform.position.y - this.transform.localScale.y / 2 &&
			Game.active && !Game.goalReached && !clicked)
		{
			float r = normalColor[0] * 0.6f;
			float g = normalColor[1] * 0.6f;
			float b = normalColor[2] * 0.6f;

			mat.color = new Color(r, g, b);
		}
		else
		{
			mat.color = normalColor;
		}
	}
}
