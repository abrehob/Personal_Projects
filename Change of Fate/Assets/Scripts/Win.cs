using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Win : MonoBehaviour
{
	public AudioClip win;
	TextMesh text;
	int colorVal;

	void Start()
	{
		colorVal = 0;
		text = this.GetComponent<TextMesh>();
		AudioSource.PlayClipAtPoint(win, 10 * Vector3.back);
	}

	void FixedUpdate()
	{
		float red = 0f;
		float green = 0f;
		float blue = 0f;

		if (colorVal < 2)
		{
			red = 1f;
			green = 0f;
			blue = 0f;
		}
		else if (colorVal < 4)
		{
			red = 1f;
			green = 0.5f;
			blue = 0f;
		}
		else if (colorVal < 6)
		{
			red = 1f;
			green = 1f;
			blue = 0f;
		}
		else if (colorVal < 8)
		{
			red = 0.5f;
			green = 1f;
			blue = 0f;
		}
		else if (colorVal < 10)
		{
			red = 0f;
			green = 1f;
			blue = 0f;
		}
		else if (colorVal < 12)
		{
			red = 0f;
			green = 1f;
			blue = 0.5f;
		}
		else if (colorVal < 14)
		{
			red = 0f;
			green = 1f;
			blue = 1f;
		}
		else if (colorVal < 16)
		{
			red = 0f;
			green = 0.5f;
			blue = 1f;
		}
		else if (colorVal < 18)
		{
			red = 0f;
			green = 0f;
			blue = 1f;
		}
		else if (colorVal < 20)
		{
			red = 0.5f;
			green = 0f;
			blue = 1f;
		}
		else if (colorVal < 22)
		{
			red = 1f;
			green = 0f;
			blue = 1f;
		}
		else if (colorVal < 24)
		{
			red = 1f;
			green = 0f;
			blue = 0.5f;
		}

		text.color = new Color(red, green, blue);
		colorVal++;
		if (colorVal >= 24)
		{
			colorVal = 0;
		}
	}
}
