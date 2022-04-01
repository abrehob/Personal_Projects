using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VelocityMeter : MonoBehaviour
{
	void Update()
	{
		if (Ball.speed > 0)
		{
			this.transform.Find("VM_1").gameObject.SetActive(true);
		}
		else
		{
			this.transform.Find("VM_1").gameObject.SetActive(false);
		}

		if (Ball.speed > Ball.normalSpeed / 6f)
		{
			this.transform.Find("VM_2").gameObject.SetActive(true);
		}
		else
		{
			this.transform.Find("VM_2").gameObject.SetActive(false);
		}

		if (Ball.speed > Ball.normalSpeed / 3f)
		{
			this.transform.Find("VM_3").gameObject.SetActive(true);
		}
		else
		{
			this.transform.Find("VM_3").gameObject.SetActive(false);
		}

		if (Ball.speed > Ball.normalSpeed / 2f)
		{
			this.transform.Find("VM_4").gameObject.SetActive(true);
		}
		else
		{
			this.transform.Find("VM_4").gameObject.SetActive(false);
		}

		if (Ball.speed > 2 * Ball.normalSpeed / 3f)
		{
			this.transform.Find("VM_5").gameObject.SetActive(true);
		}
		else
		{
			this.transform.Find("VM_5").gameObject.SetActive(false);
		}

		if (Ball.speed > 5 * Ball.normalSpeed / 6f)
		{
			this.transform.Find("VM_6").gameObject.SetActive(true);
		}
		else
		{
			this.transform.Find("VM_6").gameObject.SetActive(false);
		}

		if (Ball.speed > Ball.normalSpeed)
		{
			this.transform.Find("VM_7").gameObject.SetActive(true);
		}
		else
		{
			this.transform.Find("VM_7").gameObject.SetActive(false);
		}

		if (Ball.speed > 7 * Ball.normalSpeed / 6f)
		{
			this.transform.Find("VM_8").gameObject.SetActive(true);
		}
		else
		{
			this.transform.Find("VM_8").gameObject.SetActive(false);
		}

		if (Ball.speed > 4 * Ball.normalSpeed / 3f)
		{
			this.transform.Find("VM_9").gameObject.SetActive(true);
		}
		else
		{
			this.transform.Find("VM_9").gameObject.SetActive(false);
		}
	}
}
