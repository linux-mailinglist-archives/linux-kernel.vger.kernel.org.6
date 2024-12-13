Return-Path: <linux-kernel+bounces-444686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65079F0AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6E2162F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296C91DE899;
	Fri, 13 Dec 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="NoMr/Kf1"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A23187325;
	Fri, 13 Dec 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089324; cv=none; b=U53byejk0wnlHLR43WUfwdCuUW9GZgr0RIAUulFoDkN9bLm5KEQCTQqqnawW8vWPC0uTFYpdTA07SsPgmMrTKLb1tBK9wOMLIuRb64k9WhhFZNnS8bfws7f3QP9pv+q1xWgRdA4Jm+tTdKO5/MKNM5EOVox4YoN4KqTZHvbRHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089324; c=relaxed/simple;
	bh=K4iXwTVYirNiAZ4EQCA7vYZdUI6r7QeIFF54qzaK2ng=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NBBTwyPfgCxj+vQos/hdUCQUd1nnFIRuY0ejvP7tJlIrhIEtrYx3Z7kQ05ktLpb57zZrlbrpPD4ei1pUcU74Ej2EHk2VbRQqMkfCg/hYcXDss+Z8MJVbyXdkofu9XOwbUM1x5IY7E3AqJK+HCM4ohkqQ/svlAPpGE3WClHf9Z+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=NoMr/Kf1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734089314; x=1734694114; i=w_armin@gmx.de;
	bh=K4iXwTVYirNiAZ4EQCA7vYZdUI6r7QeIFF54qzaK2ng=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NoMr/Kf10rI/Y5+yHjn3B+/07GAtzHuHHU0NsEOL84LDp6Xhq+1uK/2g98SGEhXE
	 hJ5nZ2OSsF2vSNv1ikXwThIM1ysc1szLewSXzcqlVo205DoN1fAcwM/SB/lpJiaaL
	 v4lQebfO3ynk/ToLuWk2OU/4nS9VisrxapCuRAh4mcMPSs2ncvizsru9/tld8PABh
	 2r8+4saI2GLvHrVgTqW9tWWvDkGSvwApC+3VCczv+/8Gz6Teiw1Ezp5IbfYkTbK0G
	 wVKL24QnW5n0meNJ666gIgSvLonOQbwUFAEP9VARbKbKczi80WB4hukDi/uJK1Q/h
	 armxb8CEAbFWKZueVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1tYtyJ37O2-00wHBI; Fri, 13
 Dec 2024 12:28:33 +0100
Message-ID: <cc61f7f6-25ed-42f9-be47-5c9318cfb18a@gmx.de>
Date: Fri, 13 Dec 2024 12:28:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: wmi-bmof: Make use of .bin_size() callback
From: Armin Wolf <W_Armin@gmx.de>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux@weissschuh.net, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20241206215650.2977-1-W_Armin@gmx.de>
 <ad05e251-37bd-0cc2-8b11-a859e453f476@linux.intel.com>
 <84bd3fe1-bfba-4427-8f01-7d1ab245e617@gmx.de>
Content-Language: en-US
In-Reply-To: <84bd3fe1-bfba-4427-8f01-7d1ab245e617@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NvpkYHvE7ME/30vSFoKBhsKFXfXO/bBuGqPYkdwkZruc2MvKsqh
 nFo13178ymiBzkMYW8mmSirptvbQyc/SSX0mvGzqJTvWX/GUxHzG3W937SeoGmpOzMOazuT
 ZrBdX7dSVx1TpdTG5RTuhIC1/rhpkY6xbCMp5Tzzlq4ueq780EjrbgEm3156jgWGs3I7CLA
 Awb5v9iR5i0JuACOF+YeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:doBeWmqEKrs=;1KmsoHBw5hWbsy7Sdp8cfxfhBpR
 22bm7oyTEeCXFM8QJkEP5+C2SB9AHxRBcUBkqM/GN8cG+tSrM1t5FAGDeLbmFuFp2VyqyZu1D
 Qq75ZDBbHcmE4qEi3yBPdjYNRoqtL2Spxi3s/aKGM4xVafCUe4cI9Sf6zGkoqWO6iifWM+Dvz
 lJ/jd2Z3NtxMWltlIufpyfF+3Fl1MZ+Y4QyfeRnABJrnv2dHRUrfQfOIX+eQp7S0NRvqwAaRB
 Guh/82IGVud1Uj01jk+aYOdS6+Bxf9u3uoPblA/E7My5bJyT7h9Qx2i+DYR50TtJHYKwrnGWY
 d44SEXUKXsKZ1gHbh9ikwKExJ2+WvNShvHeACWEjCbWfZnUqrgbRGpqpTbFrvkXy3tzXsQsZR
 zLSvoD5g8q6CsZDoOSoZTnYTe102ZltY+v7/f88yq9/FcHJx+lHcOJkJTwHsaYcB7Voxt/ei8
 7OfrNJHImEGs0pzg/Cs2fZJjAo73Pz4DTEYiNym7MJzZCnny7Ymr8TE2AoP/KkqhG6fOqGP3b
 prZ2XXMNTSMvpDMSq7q9f14hTC5O8r0ye8SCCTXHJTIhc4mBGpV/tnzh33bi0JgG/poilyrpx
 1Q22xL5OYSznjDltCoKTLRk5zjnB7CmE88vR2bCTFpn0AxrElCkOqETu3itWnVg/orAhIYULo
 lSbDHrZxTLgHOlMq+kP2MTY0M6IuHXaJtwDg1UENMtN7ucWQx6NGfcCkMUg9zBiUz6MXMg1GU
 wioG56GoU0SI/nS06qsuuT5skOF3mXabP7/l9olw9indoihkOSF6qqjo/YLqhF0DfLfqmX9wy
 VOTKYr9fJrSi/Uwi1/x8B/m0JDmH6sX3D5btagggLwHqnSJAaKmB6nqgvUO5tRx1R/GDGGd/Q
 IPnsamfXNnNTaJ0qpX/BAF4w7qam5T5feAH7/7giRfIGLUz956W3BjBZkjowD0hDMuyB1hFXZ
 hj5PphfrmBEi1kGlyHh5wqLDZaIMs1RsEnQrOLH/8a/IoJWj8m/xiHVLPZ77kp9HHJ+i2qRvp
 gAhBO1vyD2uwMuXNta9ANssOrykIHvngGhXGe5WZfblxFg6wLn9Fqia2mOUb7xqqLE9jGQcNi
 mR/FfmT/jC4KLGZpoF3RLX8U0CHmx7

Am 13.12.24 um 01:16 schrieb Armin Wolf:

> Am 10.12.24 um 15:47 schrieb Ilpo J=C3=A4rvinen:
>
>> On Fri, 6 Dec 2024, Armin Wolf wrote:
>>
>>> Until now the wmi-bmof driver had to allocate the binary sysfs
>>> attribute dynamically since its size depends on the bmof buffer
>>> returned by the firmware.
>>>
>>> Use the new .bin_size() callback to avoid having to do this memory
>>> allocation.
>>>
>>> Tested on a Asus Prime B650-Plus.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>> =C2=A0 drivers/platform/x86/wmi-bmof.c | 75
>>> +++++++++++++++++----------------
>>> =C2=A0 1 file changed, 38 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/wmi-bmof.c
>>> b/drivers/platform/x86/wmi-bmof.c
>>> index df6f0ae6e6c7..3e33da36da8a 100644
>>> --- a/drivers/platform/x86/wmi-bmof.c
>>> +++ b/drivers/platform/x86/wmi-bmof.c
>>> @@ -20,66 +20,66 @@
>>>
>>> =C2=A0 #define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
>>>
>>> -struct bmof_priv {
>>> -=C2=A0=C2=A0=C2=A0 union acpi_object *bmofdata;
>>> -=C2=A0=C2=A0=C2=A0 struct bin_attribute bmof_bin_attr;
>>> -};
>>> -
>>> -static ssize_t read_bmof(struct file *filp, struct kobject *kobj,
>>> struct bin_attribute *attr,
>>> +static ssize_t bmof_read(struct file *filp, struct kobject *kobj,
>>> const struct bin_attribute *attr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 char *buf, loff_t off, size_t count)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 struct bmof_priv *priv =3D container_of(attr, stru=
ct bmof_priv,
>>> bmof_bin_attr);
>>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D kobj_to_dev(kobj);
>>> +=C2=A0=C2=A0=C2=A0 union acpi_object *obj =3D dev_get_drvdata(dev);
>>>
>>> -=C2=A0=C2=A0=C2=A0 return memory_read_from_buffer(buf, count, &off,
>>> priv->bmofdata->buffer.pointer,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->bmof=
data->buffer.length);
>>> +=C2=A0=C2=A0=C2=A0 return memory_read_from_buffer(buf, count, &off,
>>> obj->buffer.pointer, obj->buffer.length);
>>> =C2=A0 }
>>>
>>> -static int wmi_bmof_probe(struct wmi_device *wdev, const void
>>> *context)
>>> +static const BIN_ATTR_ADMIN_RO(bmof, 0);
>>> +
>>> +static const struct bin_attribute * const bmof_attrs[] =3D {
>>> +=C2=A0=C2=A0=C2=A0 &bin_attr_bmof,
>>> +=C2=A0=C2=A0=C2=A0 NULL
>>> +};
>>> +
>>> +static size_t bmof_bin_size(struct kobject *kobj, const struct
>>> bin_attribute *attr, int n)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 struct bmof_priv *priv;
>>> -=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D kobj_to_dev(kobj);
>>> +=C2=A0=C2=A0=C2=A0 union acpi_object *obj =3D dev_get_drvdata(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return obj->buffer.length;
>>> +}
>>>
>>> -=C2=A0=C2=A0=C2=A0 priv =3D devm_kzalloc(&wdev->dev, sizeof(struct bm=
of_priv),
>>> GFP_KERNEL);
>>> -=C2=A0=C2=A0=C2=A0 if (!priv)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>> +static const struct attribute_group bmof_group =3D {
>>> +=C2=A0=C2=A0=C2=A0 .bin_size =3D bmof_bin_size,
>>> +=C2=A0=C2=A0=C2=A0 .bin_attrs_new =3D bmof_attrs,
>>> +};
>>> +
>>> +static const struct attribute_group *bmof_groups[] =3D {
>>> +=C2=A0=C2=A0=C2=A0 &bmof_group,
>>> +=C2=A0=C2=A0=C2=A0 NULL
>>> +};
>>>
>>> -=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&wdev->dev, priv);
>>> +static int wmi_bmof_probe(struct wmi_device *wdev, const void
>>> *context)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 union acpi_object *obj;
>>>
>>> -=C2=A0=C2=A0=C2=A0 priv->bmofdata =3D wmidev_block_query(wdev, 0);
>>> -=C2=A0=C2=A0=C2=A0 if (!priv->bmofdata) {
>>> +=C2=A0=C2=A0=C2=A0 obj =3D wmidev_block_query(wdev, 0);
>>> +=C2=A0=C2=A0=C2=A0 if (!obj) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&wdev->=
dev, "failed to read Binary MOF\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 if (priv->bmofdata->type !=3D ACPI_TYPE_BUFFER) {
>>> +=C2=A0=C2=A0=C2=A0 if (obj->type !=3D ACPI_TYPE_BUFFER) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&wdev->=
dev, "Binary MOF is not a buffer\n");
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_free;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(obj);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> -=C2=A0=C2=A0=C2=A0 sysfs_bin_attr_init(&priv->bmof_bin_attr);
>>> -=C2=A0=C2=A0=C2=A0 priv->bmof_bin_attr.attr.name =3D "bmof";
>>> -=C2=A0=C2=A0=C2=A0 priv->bmof_bin_attr.attr.mode =3D 0400;
>>> -=C2=A0=C2=A0=C2=A0 priv->bmof_bin_attr.read =3D read_bmof;
>>> -=C2=A0=C2=A0=C2=A0 priv->bmof_bin_attr.size =3D priv->bmofdata->buffe=
r.length;
>>> -
>>> -=C2=A0=C2=A0=C2=A0 ret =3D device_create_bin_file(&wdev->dev, &priv->=
bmof_bin_attr);
>>> -=C2=A0=C2=A0=C2=A0 if (ret)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_free;
>>> +=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&wdev->dev, obj);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> -
>>> - err_free:
>>> -=C2=A0=C2=A0=C2=A0 kfree(priv->bmofdata);
>>> -=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>>
>>> =C2=A0 static void wmi_bmof_remove(struct wmi_device *wdev)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 struct bmof_priv *priv =3D dev_get_drvdata(&wdev->=
dev);
>>> +=C2=A0=C2=A0=C2=A0 union acpi_object *obj =3D dev_get_drvdata(&wdev->=
dev);
>>>
>>> -=C2=A0=C2=A0=C2=A0 device_remove_bin_file(&wdev->dev, &priv->bmof_bin=
_attr);
>>> -=C2=A0=C2=A0=C2=A0 kfree(priv->bmofdata);
>>> +=C2=A0=C2=A0=C2=A0 kfree(obj);
>>> =C2=A0 }
>>>
>>> =C2=A0 static const struct wmi_device_id wmi_bmof_id_table[] =3D {
>>> @@ -90,6 +90,7 @@ static const struct wmi_device_id
>>> wmi_bmof_id_table[] =3D {
>>> =C2=A0 static struct wmi_driver wmi_bmof_driver =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "wmi-=
bmof",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dev_groups =3D bmof_group=
s,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D wmi_bmof_probe,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .remove =3D wmi_bmof_remove,
>> So do I understand right that this meant to supercede the patch from
>> Thomas?
>>
> Yes, i totally overlooked this patch, sorry. I will ask him to drop
> his patch.
>
> Thanks,
> Armin Wolf
>
Thomas is fine with dropping his patch, so i think we can move forward.

Thanks,
Armin Wolf


