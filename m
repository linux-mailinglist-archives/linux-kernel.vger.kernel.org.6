Return-Path: <linux-kernel+bounces-514295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD7A35536
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EBC18915C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789391519A4;
	Fri, 14 Feb 2025 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="dEN3We9e"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41982753FD;
	Fri, 14 Feb 2025 03:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502444; cv=none; b=Vkp7QpBAnFtSzxy59l74yYYmvUU3jxOrnLsQeJ8RZ4ndYUSXVYzKgIC1I9ccM2CVevYBTnxMu/12CFNCVWi5kYscIbIj7iRbFzIZ9rve/+Eb583zyJHm8bKglOiuP0fCYvPxZdySeN0a2y3gPt9HKDIE1ElpnQYTmrBXYD+YV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502444; c=relaxed/simple;
	bh=U3iLt2jTVvFU0CrH4KAjwFp/wrFL6Fai2J1A7HCeWvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VshFjDbzRlLs+lYIGMRIMM3MKVIHkT87g2LtLUPuy8DdfvTbxa++MLMVg0sZIqW71OxHcigD3UlBrcIOKdLCcD5QJOQx4BVKt7O9ixAe3F6C38DDEP0yd6i76whHvxJvBc/c2kYxwR5aYbugySVafkVjKsuMsD33ujfM+0CnQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=dEN3We9e; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739502434; x=1740107234; i=w_armin@gmx.de;
	bh=UkVu9TB9y3bg528X+5UCDMdueq5YjpPbMSyJYp2IyZA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dEN3We9ef2XfOawN+NEw7U4xlzDzWpAowENjqY+KmkA7OVQ8rElf+O+aeiNnfVbq
	 liyq+23GMTMbRik+MoGg1xo4ByCkQcO3zxfKxj0IqwqJF7BGsJYyvwwjj8cqxyn4A
	 a18Lg2khXyzFp+WLOTmYjSxKf/Lx5LGzpcCi7Szrb5Hq1e6SDISj8HrRducNxIreC
	 Vgo/lwNyt5u2gPZHTeW1jW8OTqzWuWuUrWJhqgj1gE7WPc+ug1tuqzMBEdNyAzoQN
	 Scr41vutcN1f9oOIHOWCM0oco4VmqaiFLtHJE0osauuLaosn6NWIIgC9OhzhrvVQw
	 xYFwHzLi2BsfeXRvoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyuc-1tTqER3isg-014D2j; Fri, 14
 Feb 2025 04:07:14 +0100
Message-ID: <62e5b2f6-23e8-44e2-80f8-2509dd8e5a17@gmx.de>
Date: Fri, 14 Feb 2025 04:07:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] platform/x86: think-lmi: Use WMI bus API when
 accessing BIOS settings
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: james@equiv.tech, markpearson@lenovo.com, jorge.lopez2@hp.com,
 jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org
References: <20250203182322.384883-1-W_Armin@gmx.de>
 <20250203182322.384883-4-W_Armin@gmx.de>
 <0dd7bda3-bf76-228b-27f3-f057e80e3a03@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <0dd7bda3-bf76-228b-27f3-f057e80e3a03@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7OWgTiuneYVq8FpBOEoyTSddAPhgwOL3QU9g3CpiK8oF7t5sbYv
 vm4Gfz3ze46FCkApkUgdWCnjY5dtJM7FvvudeAN9MTB/l3Lc5krFEmHzpTNi+IqQv3fsUbP
 FBCHKSO+z/yH2tyJ+PnIuT2RoD4tcbXpJIBZViuf0XPPOn5QptwISobBk5KhaOtWG6JFdjh
 InoP4BwP99ZyGaU5h0uGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9oFAX8DxaHU=;AZ76pu+mJr308YybNs+pLiNTG/2
 am67VWgfC/ASgx1PrP/gSHIZLHGKXGZGaZK+SHgpqcJFb2dt4AwV9pT/y0BhwUVeh8tljMgV5
 OYpDF6nnuZcfqJO6HNedInVLUkL59Ypzc2jeyZnFkkOpB4vW5ft3uHmZmEmvYy+dzXw/cGdBB
 f8bhxz7WJRypBqN5V7eO+LWy2slOJSVIRaD14JEopBaHmeFsv3wHFdJK+vx/aMwoNd9PGfJ2s
 Mg8bOn69bfTqIQJOKbvEOobpYgdr4sTy4o6DddzH9FfHEBUJ5POSGoG8xj4IkJkizJOmU45i2
 tlQcwcTWzd8feFIeAbF207OrCKDtyXK12/1Kivnkcx+Zgyi5KM0Qbnfm1xu7HVS9l0Qzoke93
 cgCSX+CAddJCIhenZFJ5Tp6gLfLSRcgjPoN1JHGOHqB75L1oeJq6DQMcBGBtz8uKe+gwCz1OD
 9iZNjyxAEbI8d8rS+hwWChuVDD0SIR16GwoMAuy45vO6lzuZ22rirXn1IkQx8UDkrjuyZeFPJ
 eGdBun7MGm5VxhrGWwir+6ZygCWElfStiNT70IXWLGaeAqWVy/pOvsvHXQIKtEP4OQPX5s7O3
 /ZfOnAzSTELbhNEXxLxJDD9RzgO9gKXB+LMbuC9WZLMjhNnSlIb/lkPGvouubBtVuwfsWPDeU
 qLkht91RfQmNbw0JXk89urcD6PQMqQTiOv825Yi4/7ZY2ROT72Gu3mK+qn1qu9VlR8LSPN6Xi
 WhObR3cvXbzrHj53wifNIYR5sjIkkPZ8GfSeruxNfFir4/20s5Y4vLCSsvfnDx7DFp12OI1hJ
 Y/nh+UeldcN1t3oAWje/4LrP3sCrOi1tYIMYDH3Ueqc2lYYxMCX8bO2IhIelCHUA1sEL1GFDp
 0ps8Q1Ij0uMXX/swpnOaU7/iHXXFi7gqCUH//3KVf2i5kCwjwleZAXyOiH31aXs36tWKjKLv7
 LlzIJJGrKsi301p/Z2j2akNtRDagXnfZ2oJ10kjrOB1ZSrObYsqmc4d3X84lbaeuMeLtrwBEU
 K5uj4V5V7nYRlUhp5Vb8ys9agZKXYkZVZyOVdrFC935aNsBQU1QHYVq316izc/0WbOGluSgaX
 gKWWoP+wqgi8gcdxKFZtF4DscV4X6UiYvk9tiJV6MXYUHZ04fB+n6zB5fyG1U7oZblfSOWEsr
 3Y2AXWDzht+viRN/AoPWDKCid3FvKUgXR9me4PSL7o07f2fUloCLVfzngLok7v+iGF8NqOyCk
 BAicXNF7u155wSK4a0BnGlOTIO9TNsvUp+Tm6gbClIHA5Js+M527dR0y6ICkOrVBs/K5aeI2E
 W8saGvBT3FpA8GnTODTLQK013sDhd3A3duMqTkJhu+WK6X5hXnk2kV9G3aKuP2sJaAHULNoA7
 fD5vpeMt2npe/8azwhkez7yLvSYjzUuG6sfwxHpNxSFqxh+TcFFlXhLvoE

Am 13.02.25 um 14:17 schrieb Ilpo J=C3=A4rvinen:

> On Mon, 3 Feb 2025, Armin Wolf wrote:
>
>> Since the driver already binds to LENOVO_BIOS_SETTING_GUID, using
>> wmidev_block_query() inside tlmi_setting() allows for faster
>> access to BIOS settings.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/think-lmi.c | 23 +++++++++--------------
>>   drivers/platform/x86/think-lmi.h |  2 ++
>>   2 files changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/th=
ink-lmi.c
>> index 2c94a4af9a1d..0fc275e461be 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -344,20 +344,14 @@ static int tlmi_opcode_setting(char *setting, con=
st char *value)
>>   	return ret;
>>   }
>>
>> -static int tlmi_setting(int item, char **value, const char *guid_strin=
g)
>> +static int tlmi_setting(struct wmi_device *wdev, int item, char **valu=
e)
>>   {
>> -	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>   	union acpi_object *obj;
>> -	acpi_status status;
>>   	int ret;
>>
>> -	status =3D wmi_query_block(guid_string, item, &output);
>> -	if (ACPI_FAILURE(status))
>> -		return -EIO;
>> -
>> -	obj =3D output.pointer;
>> +	obj =3D wmidev_block_query(wdev, item);
>>   	if (!obj)
>> -		return -ENODATA;
>> +		return -EIO;
> Hi Armin,
>
> I'm trying to understand why there are these back and forth changes in t=
he
> error code.
>
> It almost looks to me like wmidev_block_query() would want to return the
> error code itself because after you abstracted this code using
> wmidev_block_query(), you had to change the error code because you no
> longer have access to the key detail to decide which error code should b=
e
> returned. That is, use ERR_PTR() inside wmidev_block_query() and the
> callers should just pass that error code on with IS_ERR & friends?
>
Hi,

the reason why wmidev_block_query() only returns NULL in case of an error =
is that
according to the WMI-ACPI specification, querying a WMI data block should =
return data.

So we have two error scenarios:

- ACPI error =3D> firmware error =3D> EIO
- no data returned =3D> violation of firmware spec =3D> EIO

Because of this always returning EIO is the correct approach in my opinion=
.

Thanks,
Armin Wolf


