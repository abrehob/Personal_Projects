using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChooseLevel : MonoBehaviour
{
	void Update()
	{
		if (Game.MousePos().x < this.transform.position.x + this.transform.localScale.x / 2 &&
			Game.MousePos().x > this.transform.position.x - this.transform.localScale.x / 2 &&
			Game.MousePos().y < this.transform.position.y + this.transform.localScale.y / 2 &&
			Game.MousePos().y > this.transform.position.y - this.transform.localScale.y / 2 &&
			Input.GetMouseButtonDown(0))
		{
			if (this.transform.parent.name == "LevelSelect1")
			{
				Game.GoToLevel(1);
			}
			else if (this.transform.parent.name == "LevelSelect2")
			{
				Game.GoToLevel(2);
			}
			else if (this.transform.parent.name == "LevelSelect3")
			{
				Game.GoToLevel(3);
			}
			else if (this.transform.parent.name == "LevelSelect4")
			{
				Game.GoToLevel(4);
			}
			else if (this.transform.parent.name == "LevelSelect5")
			{
				Game.GoToLevel(5);
			}
			else if (this.transform.parent.name == "LevelSelect6")
			{
				Game.GoToLevel(6);
			}
			else if (this.transform.parent.name == "LevelSelect7")
			{
				Game.GoToLevel(7);
			}
			else if (this.transform.parent.name == "LevelSelect8")
			{
				Game.GoToLevel(8);
			}
			else if (this.transform.parent.name == "LevelSelect9")
			{
				Game.GoToLevel(9);
			}
			else if (this.transform.parent.name == "LevelSelect10")
			{
				Game.GoToLevel(10);
			}
			else if (this.transform.parent.name == "LevelSelect11")
			{
				Game.GoToLevel(11);
			}
			else if (this.transform.parent.name == "LevelSelect12")
			{
				Game.GoToLevel(12);
			}
			else if (this.transform.parent.name == "LevelSelect13")
			{
				Game.GoToLevel(13);
			}
			else if (this.transform.parent.name == "LevelSelect14")
			{
				Game.GoToLevel(14);
			}
			else if (this.transform.parent.name == "LevelSelect15")
			{
				Game.GoToLevel(15);
			}
			else if (this.transform.parent.name == "LevelSelect16")
			{
				Game.GoToLevel(16);
			}

			Destroy(GameObject.FindGameObjectWithTag("LevelSelect").gameObject);
		}
	}
}
