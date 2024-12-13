Return-Path: <linux-kernel+bounces-444097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14279F00B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD50A2858FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2AB23C9;
	Fri, 13 Dec 2024 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hnDe7CSj"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECBABA2D;
	Fri, 13 Dec 2024 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049029; cv=none; b=ONw23RtX/4z0+o2Fvwm3O7kZXbcMYpFjeAcHmXKfWlhi1o6gQ/viQigs3e42Yd1EZDn2mITC8fNWg43zF/yAaOdvEWNZy3zbBUnCya7Pj269hg/XuEgH7UzZZP/yV9/vvkhXX5MFRu5ajbYP1/eLc325MpqZ6ZOb7tZa3QClGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049029; c=relaxed/simple;
	bh=5VPDtNvK9i2w/wN9DFpxIWxQWboqbna1fZeRH35VbWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TadoWO7eNUJWsiCo/3qGiQa0Db8gUjm5wG5ur0AAgvawTE2v0R8oWwzWEPbqSL3ByVYxGqxQh11wonFo1Vxy5WeIBXOlKoCTLakQ9NBhLnsuwRoW+30KvnjDOxMZDfiwii+K1+zsPOopOwJHqTrJcFr24lhZte8k5gs9PXXklRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hnDe7CSj; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734049019; x=1734653819; i=w_armin@gmx.de;
	bh=D1lZgIEASCFhjHKcI+DVOag39YmhyUtR+F8m5MGxYEI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hnDe7CSjoLjlXCGI3BogQszEo+5mYi7Jz/D+wVbz3/S6PcZd13JG4+aFdmkNC5Ky
	 5alt/1JPGVOYhiM8SKFLUTwEjkRN1mrLd4egQSmGWNKvkY5PtrwuJQ80pLJ9FfI3S
	 mmQsRELUqJndRZLxPU5w0ZbxY+Ok1CFRRYaCuGiRxAt0CQN5iSsrpd4v9Wp2hDacj
	 s0GRZCa5Rethe8Lxu6uG0qJJx02Y/+7EzOJH4+eCgvMjU5PMOwcDJmLLlFYSwxEki
	 3CePpfM9QrSz+2Z1vZsQIGwh9Len+6hRK5LtRu8HEpqBQXHUo+I7DGWm8hsgNDKEa
	 W/5jStKBYudGhzWpkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1tJ8TI30Xa-00FY0S; Fri, 13
 Dec 2024 01:16:58 +0100
Message-ID: <84bd3fe1-bfba-4427-8f01-7d1ab245e617@gmx.de>
Date: Fri, 13 Dec 2024 01:16:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi-bmof: Make use of .bin_size() callback
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux@weissschuh.net, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20241206215650.2977-1-W_Armin@gmx.de>
 <ad05e251-37bd-0cc2-8b11-a859e453f476@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <ad05e251-37bd-0cc2-8b11-a859e453f476@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nJts4E3uXovXfsYWsEMRmx9zwn3qiqAg8t30Yui7hBHsKGEHhYR
 0j/LETu85qE2Z9+nlZJlQ0z8gVVxPHh/9LKAQ8gNVDAfcRR4kWz2C3CJVFneiAeCRu2PDnW
 DLhej+gv5pepLpNA50DXOGIqzYYUMhAXYhYvJMUuAJl5IvH+9tvnFoiEDpgmrOZ1qw+6Mrw
 1CvnuR5Ey4INMQWCe4GPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O33FMR1tMtw=;aryA9D+9jYtStbVAdXI7rKq959/
 QXGG3Nsnq5gfAz8qyCbsjzWD8Fi4thQJ2pBWNXWFQ7hLW6wpuk9/4TVpx6vAwxKpqay5e3e6N
 doiJpKLrYrZEeHHsRqWx+8gTdFoiKscCIl7uxh+lpxSelOeWcOpxZDVeH0j0FtP5p4EquKbmY
 DAoYwox12iGIzzDihqgEnrkZBgmqg+U0AO2ODnUWZsRT50RVWzfiGzQ0RzuvqN1WyiczRrJqf
 3IygrKm9Pv0F1kfmZpN9v47Cq5b2rRIngZ057+AEhuqbF6v7CKnDkr9Kpbtr8uIvKhg+ThjZg
 cEv+bE80uz+pAiZ8v/paRG2awoM0doPZujfF85BRELFhJOV/0D8zvh9RWlf5kKohK8rW+jmx9
 DJuORUBV5QksO0YZoCKsrIHjZIbSU1O5idOc8fK9tVFEdEub2a2XfW7peWF6Arszqlbg+p61+
 AWiazfLHpLDz7BGasZTZZ/niM/5M9nJh0TRZ+Oo/ocMPbGaCK/iyn9QNU+isKGMtXh+7QfmAq
 6qGmL0H4RSyg70EYqCTtWFcGaRPa1Uqu0HvAiQsO9LkRr9KdkAvPHuxgReeUY1BLHzNlSSVhn
 lnzyACzB5Rj2qk0qSUI5L+17S1DpCNNgwoRflOBmaUV9OYBJsJMKpCTKIfpcVs+6kUxb4WHL6
 HX0MSDu3WXZ56UjHtjSMVMYMVO7PGMkH4x8pUvkwJm30RWQYW/zjfNnQdJie7fFaOHAVzDvBv
 LaCSFreMB37lIDR0y6pJQShvPCBEi5QZ5+lf4ywDW3dvaecpCXqU3GtJ2ft7G2CUe4w1PPeuS
 PMtMuiqB6xnOM5IjJhgRM7hS5ziI2dgHRx2mT1hSPHzVEe3Dn4ko+SNfHEYVN0JniFp6nVnKk
 jBcs0MioaeihVmxcQyIgTIPwWreQrkt3kxQRgw+KEOwRNyZR0uaMmOUiUVHW6fvFp7Hd40/y8
 7wR1DtQZKpHIAtvjNj1i5UXA3Uz+thy+6g95AJjiuOKSXqJAeM6f7bFlgQwLOe0j6fya8WR+h
 2Pv7AwdfJLnIy0wjkhd6qSnOI+fdzaAAkgV9s9T1zW49deP0S0eZ5BOAmqSWklFew5RaaIz/P
 msPFGKzHEOHo8L2ObegCSBzcGiAeMV

Am 10.12.24 um 15:47 schrieb Ilpo J=C3=A4rvinen:

> On Fri, 6 Dec 2024, Armin Wolf wrote:
>
>> Until now the wmi-bmof driver had to allocate the binary sysfs
>> attribute dynamically since its size depends on the bmof buffer
>> returned by the firmware.
>>
>> Use the new .bin_size() callback to avoid having to do this memory
>> allocation.
>>
>> Tested on a Asus Prime B650-Plus.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/wmi-bmof.c | 75 +++++++++++++++++---------------=
-
>>   1 file changed, 38 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi=
-bmof.c
>> index df6f0ae6e6c7..3e33da36da8a 100644
>> --- a/drivers/platform/x86/wmi-bmof.c
>> +++ b/drivers/platform/x86/wmi-bmof.c
>> @@ -20,66 +20,66 @@
>>
>>   #define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>>
>> -struct bmof_priv {
>> -	union acpi_object *bmofdata;
>> -	struct bin_attribute bmof_bin_attr;
>> -};
>> -
>> -static ssize_t read_bmof(struct file *filp, struct kobject *kobj, stru=
ct bin_attribute *attr,
>> +static ssize_t bmof_read(struct file *filp, struct kobject *kobj, cons=
t struct bin_attribute *attr,
>>   			 char *buf, loff_t off, size_t count)
>>   {
>> -	struct bmof_priv *priv =3D container_of(attr, struct bmof_priv, bmof_=
bin_attr);
>> +	struct device *dev =3D kobj_to_dev(kobj);
>> +	union acpi_object *obj =3D dev_get_drvdata(dev);
>>
>> -	return memory_read_from_buffer(buf, count, &off, priv->bmofdata->buff=
er.pointer,
>> -				       priv->bmofdata->buffer.length);
>> +	return memory_read_from_buffer(buf, count, &off, obj->buffer.pointer,=
 obj->buffer.length);
>>   }
>>
>> -static int wmi_bmof_probe(struct wmi_device *wdev, const void *context=
)
>> +static const BIN_ATTR_ADMIN_RO(bmof, 0);
>> +
>> +static const struct bin_attribute * const bmof_attrs[] =3D {
>> +	&bin_attr_bmof,
>> +	NULL
>> +};
>> +
>> +static size_t bmof_bin_size(struct kobject *kobj, const struct bin_att=
ribute *attr, int n)
>>   {
>> -	struct bmof_priv *priv;
>> -	int ret;
>> +	struct device *dev =3D kobj_to_dev(kobj);
>> +	union acpi_object *obj =3D dev_get_drvdata(dev);
>> +
>> +	return obj->buffer.length;
>> +}
>>
>> -	priv =3D devm_kzalloc(&wdev->dev, sizeof(struct bmof_priv), GFP_KERNE=
L);
>> -	if (!priv)
>> -		return -ENOMEM;
>> +static const struct attribute_group bmof_group =3D {
>> +	.bin_size =3D bmof_bin_size,
>> +	.bin_attrs_new =3D bmof_attrs,
>> +};
>> +
>> +static const struct attribute_group *bmof_groups[] =3D {
>> +	&bmof_group,
>> +	NULL
>> +};
>>
>> -	dev_set_drvdata(&wdev->dev, priv);
>> +static int wmi_bmof_probe(struct wmi_device *wdev, const void *context=
)
>> +{
>> +	union acpi_object *obj;
>>
>> -	priv->bmofdata =3D wmidev_block_query(wdev, 0);
>> -	if (!priv->bmofdata) {
>> +	obj =3D wmidev_block_query(wdev, 0);
>> +	if (!obj) {
>>   		dev_err(&wdev->dev, "failed to read Binary MOF\n");
>>   		return -EIO;
>>   	}
>>
>> -	if (priv->bmofdata->type !=3D ACPI_TYPE_BUFFER) {
>> +	if (obj->type !=3D ACPI_TYPE_BUFFER) {
>>   		dev_err(&wdev->dev, "Binary MOF is not a buffer\n");
>> -		ret =3D -EIO;
>> -		goto err_free;
>> +		kfree(obj);
>> +		return -EIO;
>>   	}
>>
>> -	sysfs_bin_attr_init(&priv->bmof_bin_attr);
>> -	priv->bmof_bin_attr.attr.name =3D "bmof";
>> -	priv->bmof_bin_attr.attr.mode =3D 0400;
>> -	priv->bmof_bin_attr.read =3D read_bmof;
>> -	priv->bmof_bin_attr.size =3D priv->bmofdata->buffer.length;
>> -
>> -	ret =3D device_create_bin_file(&wdev->dev, &priv->bmof_bin_attr);
>> -	if (ret)
>> -		goto err_free;
>> +	dev_set_drvdata(&wdev->dev, obj);
>>
>>   	return 0;
>> -
>> - err_free:
>> -	kfree(priv->bmofdata);
>> -	return ret;
>>   }
>>
>>   static void wmi_bmof_remove(struct wmi_device *wdev)
>>   {
>> -	struct bmof_priv *priv =3D dev_get_drvdata(&wdev->dev);
>> +	union acpi_object *obj =3D dev_get_drvdata(&wdev->dev);
>>
>> -	device_remove_bin_file(&wdev->dev, &priv->bmof_bin_attr);
>> -	kfree(priv->bmofdata);
>> +	kfree(obj);
>>   }
>>
>>   static const struct wmi_device_id wmi_bmof_id_table[] =3D {
>> @@ -90,6 +90,7 @@ static const struct wmi_device_id wmi_bmof_id_table[]=
 =3D {
>>   static struct wmi_driver wmi_bmof_driver =3D {
>>   	.driver =3D {
>>   		.name =3D "wmi-bmof",
>> +		.dev_groups =3D bmof_groups,
>>   	},
>>   	.probe =3D wmi_bmof_probe,
>>   	.remove =3D wmi_bmof_remove,
> So do I understand right that this meant to supercede the patch from
> Thomas?
>
Yes, i totally overlooked this patch, sorry. I will ask him to drop his pa=
tch.

Thanks,
Armin Wolf


