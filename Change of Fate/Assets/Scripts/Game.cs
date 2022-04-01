using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Game : MonoBehaviour {
	public static bool active;
	public static bool goalReached = false;
	public static Tile tilePickedUp = null;
	public static bool messageActive = false;
	public static int level = 0;

	public GameObject level1;
	public GameObject level2;
	public GameObject level3;
	public GameObject level4;
	public GameObject level5;
	public GameObject level6;
	public GameObject level7;
	public GameObject level8;
	public GameObject level9;
	public GameObject level10;
	public GameObject level11;
	public GameObject level12;
	public GameObject level13;
	public GameObject level14;
	public GameObject level15;
	public GameObject level16;
	public GameObject endScreen;
	public GameObject generalGameStuff;
	public GameObject levelSelect;
	public GameObject message1;
	public GameObject message2;
	public GameObject message3;
	public GameObject message4;
	public GameObject message5;
	public GameObject message6;
	public GameObject message7;
	public GameObject message8;

	static GameObject slevel1;
	static GameObject slevel2;
	static GameObject slevel3;
	static GameObject slevel4;
	static GameObject slevel5;
	static GameObject slevel6;
	static GameObject slevel7;
	static GameObject slevel8;
	static GameObject slevel9;
	static GameObject slevel10;
	static GameObject slevel11;
	static GameObject slevel12;
	static GameObject slevel13;
	static GameObject slevel14;
	static GameObject slevel15;
	static GameObject slevel16;
	static GameObject sendScreen;
	static GameObject sgeneralGameStuff;
	static GameObject smessage1;
	static GameObject smessage2;
	static GameObject smessage3;
	static GameObject smessage4;
	static GameObject smessage5;
	static GameObject smessage6;
	static GameObject smessage7;
	static GameObject smessage8;

	static Camera c;
	static GameObject currentLevel;
	static GameObject currentMessage;
	float timeTouchedGoal;
	float delay = 2f;


	void Start()
	{
		c = this.GetComponent<Camera>();
		timeTouchedGoal = Time.time;
		active = false;
		slevel1 = level1;
		slevel2 = level2;
		slevel3 = level3;
		slevel4 = level4;
		slevel5 = level5;
		slevel6 = level6;
		slevel7 = level7;
		slevel8 = level8;
		slevel9 = level9;
		slevel10 = level10;
		slevel11 = level11;
		slevel12 = level12;
		slevel13 = level13;
		slevel14 = level14;
		slevel15 = level15;
		slevel16 = level16;
		sendScreen = endScreen;
		smessage1 = message1;
		smessage2 = message2;
		smessage3 = message3;
		smessage4 = message4;
		smessage5 = message5;
		smessage6 = message6;
		smessage7 = message7;
		smessage8 = message8;

		sgeneralGameStuff = generalGameStuff;
	}

	void Update()
	{
		// When timeTouchedGoal stops changing, the ball must have reached the goal
		if (goalReached && Time.time - timeTouchedGoal >= delay)
		{
			GoToLevel(level + 1);
		}
		else if (!goalReached)
		{
			timeTouchedGoal = Time.time;
		}

		if (Input.GetKeyDown(KeyCode.M))
		{
			active = false;
			goalReached = false;
			tilePickedUp = null;
			messageActive = false;
			level = 0;
			GameObject.Destroy(currentLevel.gameObject);
			if (GameObject.FindGameObjectWithTag("GameStuff"))
			{
				GameObject.Destroy(GameObject.FindGameObjectWithTag("GameStuff").gameObject);
			}

			if (!GameObject.FindGameObjectWithTag("LevelSelect"))
			{
				GameObject go = GameObject.Instantiate(levelSelect);
				go.transform.position = Vector3.zero;
			}
		}
	}

	public static Vector3 MousePos()
	{
		return c.ScreenToWorldPoint(Input.mousePosition);
	}
		
	public static void GoToLevel(int levelParam)
	{
		level = levelParam;

		goalReached = false;
		if (currentLevel != null)
		{
			GameObject.Destroy(currentLevel.gameObject);
		}
		if (!GameObject.FindGameObjectWithTag("GameStuff"))
		{
			GameObject go = GameObject.Instantiate(sgeneralGameStuff);
			go.transform.position = Vector3.zero;
		}

		if (level == 1)
		{
			currentLevel = GameObject.Instantiate(slevel1);
			currentLevel.transform.position = Vector3.zero;
			DisplayMessage(smessage1);
		}
		if (level == 2)
		{
			currentLevel = GameObject.Instantiate(slevel2);
			currentLevel.transform.position = Vector3.zero;
		}
		else if (level == 3)
		{
			currentLevel = GameObject.Instantiate(slevel3);
			currentLevel.transform.position = Vector3.zero;
			DisplayMessage(smessage2);
		}
		else if (level == 4)
		{
			currentLevel = GameObject.Instantiate(slevel4);
			currentLevel.transform.position = Vector3.zero;
		}
		else if (level == 5)
		{
			currentLevel = GameObject.Instantiate(slevel5);
			currentLevel.transform.position = Vector3.zero;
			DisplayMessage(smessage3);
		}
		else if (level == 6)
		{
			currentLevel = GameObject.Instantiate(slevel6);
			currentLevel.transform.position = Vector3.zero;
		}
		else if (level == 7)
		{
			currentLevel = GameObject.Instantiate(slevel7);
			currentLevel.transform.position = Vector3.zero;
			DisplayMessage(smessage4);
		}
		else if (level == 8)
		{
			currentLevel = GameObject.Instantiate(slevel8);
			currentLevel.transform.position = Vector3.zero;
		}
		else if (level == 9)
		{
			currentLevel = GameObject.Instantiate(slevel9);
			currentLevel.transform.position = Vector3.zero;
			DisplayMessage(smessage5);
		}
		else if (level == 10)
		{
			currentLevel = GameObject.Instantiate(slevel10);
			currentLevel.transform.position = Vector3.zero;
		}
		else if (level == 11)
		{
			currentLevel = GameObject.Instantiate(slevel11);
			currentLevel.transform.position = Vector3.zero;
			DisplayMessage(smessage6);
		}
		else if (level == 12)
		{
			currentLevel = GameObject.Instantiate(slevel12);
			currentLevel.transform.position = Vector3.zero;
		}
		else if (level == 13)
		{
			currentLevel = GameObject.Instantiate(slevel13);
			currentLevel.transform.position = Vector3.zero;
			DisplayMessage(smessage7);
		}
		else if (level == 14)
		{
			currentLevel = GameObject.Instantiate(slevel14);
			currentLevel.transform.position = Vector3.zero;
		}
		else if (level == 15)
		{
			currentLevel = GameObject.Instantiate(slevel15);
			currentLevel.transform.position = Vector3.zero;
			DisplayMessage(smessage8);
		}
		else if (level == 16)
		{
			currentLevel = GameObject.Instantiate(slevel16);
			currentLevel.transform.position = Vector3.zero;
		}
		else if (level == 17)
		{
			currentLevel = GameObject.Instantiate(sendScreen);
			currentLevel.transform.position = Vector3.zero;

			if (GameObject.FindGameObjectWithTag("GameStuff"))
			{
				Destroy(GameObject.FindGameObjectWithTag("GameStuff").gameObject);
			}
		}
	}

	static void DisplayMessage(GameObject message)
	{
		Time.timeScale = 0;
		messageActive = true;
		currentMessage = GameObject.Instantiate(message);
		currentMessage.transform.position = Vector3.back * 2;
	}
}
