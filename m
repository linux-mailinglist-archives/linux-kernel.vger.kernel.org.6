Return-Path: <linux-kernel+bounces-556830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCDBA5CF32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FFE3B3D60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB108263F3B;
	Tue, 11 Mar 2025 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="od2kLM23"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B4149C55;
	Tue, 11 Mar 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741720927; cv=none; b=HwKCRjx3JZUwnyBG9n1pYglIVIKohWxL6Q9VATGjXq37qYZqEjwDusCYTlDb8ixSlSqTIpngZPjU57ciTXsycBkAofF/zuzMGgstDgrOUUECMWOmXirm1OZrMOXdrlRx2z07TxdeH6MdDHSg69aydTq7UHtcZ/z6+FE2qhJDGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741720927; c=relaxed/simple;
	bh=+aajBLwo+9Ipl1oDNXM4YLQi5b40hCdt202MuuiG80g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9+eYJEeqxlwXmGUmOMbJMxXUG8UuKdm99pUJ9H9ghBHVDE70lt0vycoahUu4kRLMo/CUIQSIbaZPDDJzCXq4FKWmo7lBkcWO3CbWiRKcKe4quc/ftIUto294SSeDR2JTn+L97/9g+cCZcS0EznisaMer2uoOmZWv7SOMMzwis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=od2kLM23; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741720919; x=1742325719; i=w_armin@gmx.de;
	bh=Wlvpw/LpumOboiY53p7LYGtKWw9smKDO/kRHBZhGW0Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=od2kLM23YE4L5lz8oW5BzWqd8sPZJsjKHc1rZnxbe6CUQHTWbd9Msniju9uEtrtx
	 5agDknsxf0nxCx4FsWmLSOOX5oHFQ8gGjYggQ2wMzEu8SlcZZEF+JRkNR66P2lzXV
	 oWl9whkattJT1rmcZBrrapTEXSCFQPAXFQLmnuWq/PyNkrnfQ4fB/54EPCT+U1MZy
	 THEkgwa4yhEkpgFqcoUUOm9YZOSREh8y+hN77qLTdQt48jzZPGPP8M/fgHdRhS/z/
	 pUbZuy2NVP+oLeEqWt5SGvEDIgM2WxIuQ8leA+ra929ZqeoObG60UgpP9lSGVNTBf
	 Hhse95N8ARIx+z/ZDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY6Cl-1tiZ2o1T4P-00S4gn; Tue, 11
 Mar 2025 20:21:59 +0100
Message-ID: <9c172560-65ee-4468-93f7-ea5c11fe033f@gmx.de>
Date: Tue, 11 Mar 2025 20:21:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] platform/x86: wmi: Add
 wmidev_get_acpi_device_uid()
To: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20250309-awcc-uid-v2-0-5338c6380b2f@gmail.com>
 <20250309-awcc-uid-v2-1-5338c6380b2f@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250309-awcc-uid-v2-1-5338c6380b2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vyEyETMwRJsLnou5PUBCowckoes/zhRbd7dXNlNAfUG45uskRGw
 7lVDGj9TttZWkDmpivqo4PafC/RbJzedeBt+bAsS3NWo/3VHIpVb257HaILHTCvS9xka9oh
 lFAcNjTEe4nlw8DHrF5w4hhp5SLkjs4hVyWfWroDxwEmx/UIorJX71AzDpWSTFrReGp8inM
 nJdGTCI1YG6/xzIF0/Wxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tL1aw/I+w10=;kUTwEIRJc490191b2OZl/eRocp1
 oP+oh66kSvVv6Bbwa0ve82AWQA7LQU9abfoO1WVWQko8JpY6NkuPWk534e/A485kj+n7TemM1
 pbOHYGB8p/XZzpry7i9JvsDqX+9wHtx2BRmjRTOoXCV8ltpsz5r/9sa/nAQKttpHWz3EVyHnW
 x9wFWhZ4sn+XTIb64F800AawkyCDBK1CPIy0inwm54S1aDEWVXd/ha8euCw+EkCCIldufC5fT
 69remTOuGR/Xq0SzZyn4MspzKZf49wt88MkfRqMyVOG+i3pajPokgB8WXzJTyTTFhbXm6cwlK
 KWSuZ/YpDVEzpiVr2wXraKLM6jjXBRqga4Phs+9AqtG+c9Q4XHaWbG9krfHT8eMVw0tv++J1H
 9K0Pz2Yale5Rbdu29/z+jRCfGlO+MuBZDHHK/BkTQkYPaW3BuhyMYG2hGdE+lEezrevGhW3zo
 7MpzTWF8evYWAIHea1J8Q2DdjUdXUDN3B0tLCtQ/ngyhpT8HMHnkb7eUI3yOWHi7VXuicy+VQ
 zbS6YntA7GHlW0Gk7MVJ+kX9s0uK2sVQLVPmCY+KsE/bDFHak7S9J+BrcL4N/K41aq3iD2lHr
 +L8U94XRnNG62c7O+KE1K7Mc5cM2AJ8FAWR8dX30j5gRgC3TY5miyzOkC2L6F8oZXtd774iWS
 i5oqWO8HNbAf4lwieu+0pNqCdg3QbOSU/iQ9SGUKGy1riBNs9LWzo+g4DazxId2vj0nuJo0Yu
 dBfuNm1Ehp0HiZpuSLbGt8DfE4e8EExPlX6867Up5Znkt/C9Ru8oHQ4TIfAQA0GrJXhhaTUvu
 VMM+fcn7mCCmIvcyZM7E3jUNPZ2ifqWIqsf7XiRHcCUh2L58w4xwL63zaWagOnUBtfsAsT2mA
 rtjAXfD3uhI1rc8dGWHdyG3eDhNimQK3bp8yTZ5BuQUqDOQJgPXvvQNEiz+fMsmJAwBwChDr9
 ei3SYO0ebt77TdRMgYdgTmttiGMJw7Bak5u6ms5SXK8Y4BAUQDpT+BWxmCWNgrffqFGaWihuz
 hw/NOPJYil/X1II16ibdhnErgioLK8extziAXN5kdi56Hypwbsc6AN21lKfvZhDCEegAm879K
 91gNjoBBX8QEfsZT3JwIsPGvp6XxQABBxjdy+9UBjbO7H2oQyrfothkFcjzjKqSKKONbX7w9r
 2QXSjSDaElkxPk3+vcmSKdRL29kgz7waryEy3covYSAIHNSDbtOKzG6OFn8QOC0gkgeNoMpaV
 NcHkfYxSophT1KbBXgo5MZU62ftQfAiIUpi9sZrZmjbnAblO5ROri0q0nrSC1MJu3T3N1pzle
 km5AVTApMHgAQG8DWQBH7EKZSnXghYq/Yv5CLhRObKJWJXj03wUtfKn2GoNjE6SUEG2Kjia3S
 zg2SZjVtHMPuLOQXWN1uZI4IPuAcnFVnpo/L/RlhvvBAGJcCFjxwODFsiyMd4Golv2NLLjx1k
 +2Jz1qYPCTldojksrwTX/L53nEJo=

Am 09.03.25 um 06:13 schrieb Kurt Borja:

> Add a non-deprecated version of wmi_get_acpi_device_uid().

Hi,

i can understand you motivation behind this patch, but this is IMHO the wr=
ong approach.
Nothing guarantees us that a given ACPI _UID value will reliably signal th=
e presence of
WMI methods now or in the future. Because of this i am against this patch.

The correct way would be to use the BMOF data to check for missing WMI met=
hods. I did
some work on that which i will announce soon.

Thanks,
Armin Wolf

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/wmi.c | 20 +++++++++++++++++---
>   include/linux/wmi.h        |  2 ++
>   2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index e46453750d5f1475eb87342b1c5fd04fe20df335..39f379777ad08efd3cda7313=
f293522c68773dbe 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -636,7 +636,6 @@ EXPORT_SYMBOL_GPL(wmi_has_guid);
>    */
>   char *wmi_get_acpi_device_uid(const char *guid_string)
>   {
> -	struct wmi_block *wblock;
>   	struct wmi_device *wdev;
>   	char *uid;
>
> @@ -644,8 +643,7 @@ char *wmi_get_acpi_device_uid(const char *guid_strin=
g)
>   	if (IS_ERR(wdev))
>   		return NULL;
>
> -	wblock =3D container_of(wdev, struct wmi_block, dev);
> -	uid =3D acpi_device_uid(wblock->acpi_device);
> +	uid =3D wmidev_get_acpi_device_uid(wdev);
>
>   	wmi_device_put(wdev);
>
> @@ -653,6 +651,22 @@ char *wmi_get_acpi_device_uid(const char *guid_stri=
ng)
>   }
>   EXPORT_SYMBOL_GPL(wmi_get_acpi_device_uid);
>
> +/**
> + * wmidev_get_acpi_device_uid() - Get _UID name of a WMI device
> + * @wdev: A wmi bus device from a driver
> + *
> + * Find the _UID of the ACPI device associated with this WMI device.
> + *
> + * Return: The ACPI _UID field or NULL if there is no _UID
> + */
> +char *wmidev_get_acpi_device_uid(struct wmi_device *wdev)
> +{
> +	struct wmi_block *wblock =3D container_of(wdev, struct wmi_block, dev)=
;
> +
> +	return acpi_device_uid(wblock->acpi_device);
> +}
> +EXPORT_SYMBOL_GPL(wmidev_get_acpi_device_uid);
> +
>   /*
>    * sysfs interface
>    */
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index 10751c8e5e6a0ad3ac9ae317b6f8ecfb14c9a983..625c52ee125219aaa23cf946=
333af33ad118aafa 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -46,6 +46,8 @@ extern union acpi_object *wmidev_block_query(struct wm=
i_device *wdev,
>
>   acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, con=
st struct acpi_buffer *in);
>
> +char *wmidev_get_acpi_device_uid(struct wmi_device *wdev);
> +
>   u8 wmidev_instance_count(struct wmi_device *wdev);
>
>   /**
>

