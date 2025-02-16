Return-Path: <linux-kernel+bounces-516469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1DA3722F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACE2189218E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 05:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924B11494B5;
	Sun, 16 Feb 2025 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MHRpRGfl"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8A42A92;
	Sun, 16 Feb 2025 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739685453; cv=none; b=Ethh79LDftWFybYy8QHVDxarVBZ6+q3K/XcVuQ1O9oagqJWfpbklOfWfc2rMflrGPGYUKLZuM8yOEOPBzqfrlmJbHjWJ/kY24oUpWnU+l0A+uwv6X6XRly34GOKLBCkYGhF2tjEuTK92nwIY3jGfDYzJ1eJP+Cgcd+JKvlIg6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739685453; c=relaxed/simple;
	bh=9/rfINTeprflTCmKh44EUXAHOtTll/amK4Gkz/FxSqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jex/QV1RHL7a22lQrKYCmWd06WT+B1/Q0gogRnj4F526xsHWyyx7K7X0Uo+GxSuW/jMr27O60SYyChBBzHbgziImuJtVIoWkA4nacUkjEHncQw0ODztYBz0BEgTc1SjkaEP+pQx64jbkgA6kdLjDgVGW9J6zc15T6PlwR99PPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MHRpRGfl; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739685440; x=1740290240; i=w_armin@gmx.de;
	bh=wpSkRIvNX3aSgJW4dBwwAmgQsGIaQXNDdbwVA8mTXeU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MHRpRGflo9g6xk5cjQV57+tlPx/+gMryKrFnA8Nq/oYjWIEe7hprvrRzAP/Cw81S
	 NdtXT0HBCcNSiaDFtbcpbBi0CpeuupdFBMLnR9ju1drFWOBI33hKvHCSqUR8zDY09
	 PYda+xPANBpKHqBnUF0eze2QlnOqJNXcbtPbTTatHRWXmYlbI3VhYihx+Z7ok0iOV
	 es2fNPIj4VQSoxZbvgBrIPTPeLFymAXXUO4nLGAm/+iIxy/1aJUevfGdlH351DGt1
	 Srr6vQrdmvvXbw0BXayDTeZm+03Pj5478mT94bWNQn9fTP+Sx8hFaI31YlhANApQl
	 qFNEJlG7m7cC5TTh1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KPg-1tJj5014WQ-0164Yj; Sun, 16
 Feb 2025 06:57:20 +0100
Message-ID: <f8a5b533-15a6-46ac-8593-debc5e1cd151@gmx.de>
Date: Sun, 16 Feb 2025 06:57:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] platform/x86: alienware-wmi-wmax: Improve platform
 profile probe
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-6-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250208051614.10644-6-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uAijnFD/UxrILB32m59nkatWQmXsp+7+QC1VAECowwRxy8jF5tY
 hlaG233NfPNgM7T2Oq2H+/mc6Dm/ITduSyXNx2BdOnO8iZJfiESO/ajZWjc49RMUY+DowW4
 50sELfCNZsabtiHV5HhIFFcoLTldX/8QWI+pAGrwSulJ4R5P8t1iJATKc3O0g0n/FxszT3t
 XazHYHb35Z5nNOq0+X/4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fr4LHRbK10U=;ccz5RhZ077G6d5YJRF4Kzd3471z
 c9razKbCN0DicD0l2pXPfcjsvpgdKZpLvwypUHGunsKEhRf0Rqp6pBGeAJEASCUkZ9/Z2dsww
 1CUC5UqPHfFjb7dzXom8asbigOT6H8FcqQvfON3ztDdbx2EcjkXb9YqicP5ry8+5G+LfBBt4E
 UouZfFmLFxHrmawB5n6Z/wwKqttbr5+/fIKVpRgHfZ381bYYJgasZkThCE8vGDS1KEjy4wy9L
 Ke4gZRSM9FRlfaikxPoOU3ZFjR2GWQMcWwrB3jn8LDz4b8FvcFmv6XxOZcRihXUopMX1N+FGX
 kHtQdGQJIfySNvN3E6r99bLi8UoyDm+HjzoLYYSB45WgFvpOOX3EYXeRJbQf5dpafApwDHLaR
 KATcVLPAl8Kb40jyyczedymmN0iUAoV9wqv3vKw4HPmqs2uzsSwYaz8SSTPHjDD2PqJeOhb2+
 ue0QkouMowLT5RHABhW3EHYWxqfhDTKAdDJgpY47OkG/Z6kwVwYcS58xZ76q6PhCO9z3SjHUC
 dVc1Fv3ww79WxZUQoC7ar4YcLCtgtZNVMM9m23UnfFPl2RqY67g/DuHS83HynP0dmO518W5vj
 BcuyqcGasHL4xUBOpbgi1M4O/OAsVpCU7UYZUX1VyhU6YyxvcEKAtEMBRjtcFODofk92vdUn5
 f/fQRzUX0igTk2W/ejKG2MFG5Ygcz9ynHu5jdWbXPDhTit+W22PpqltcMxIgs9bLiNnuPf4oN
 PZsLyGLF8670UCpVshMKf/lGO6g1VptVNUY+ABFbNxcGoLgL87nys+95OmdwgeJ7nbDa0B+P/
 JgxG27W90xNWej1Gg40eMh+AD89g2B+NAWHvyxlrKR2fn3oKaIJpgs0dWBJxeD5v2I0Lg2Uep
 ckApUqPWB0Pz8WhnUVarqAAxGfsSVhKcUXt/EAabtt1sbPal3xTdyh7iORX0qMlC0aZFUJ8cy
 +8UnPykOoUvZywJK84DlRF4Cr+bTYWS4IBa6P0gHRupPp5AmZKoc9bGZXw7aIUgEaLzSfGQjR
 vde1G5tN3YIy5ebUhv9o3RZt9kLTqsYS7aF7R49/mKjZrne7i+0l54QEY5gdWPpCC+42By5U+
 87t+TG1zPcNJj+QORe8Ut1t2+cWbc3d7lbdM7JgqtPyYYCI3vMFP3zO8NAdBMfcAwvTuNc2ao
 r6TF4uWvY9nnmEuWDAANG2BsjWNiLM1UMjCII8o/hfpeQV5oWJROt0Ko0AmJDC3AdojXW+xov
 SlkxD4K004WBrKDHTGmigzAJRgrIAijjeNkNpRz9On7PIGUN/pftDgEXKjTsRZ8puMqIsOu5V
 9K1AN/xag5bwFW+s01M1YNRKhNDrFK8auRYfTLjcCCMkUMOvUwDpbqVjeTYKJZ8lEZjlBI6LW
 gikF58Ai6bP6hinp28kiPDsmzn8UUP3pZbRhmQP0NXNWAqkC+r4/g0YCWn

Am 08.02.25 um 06:16 schrieb Kurt Borja:

> Get and store the AWCC system description in alienware_awcc_setup()
> instead of awcc_platform_profile_probe() and add a check for integer
> overflows to avoid misbehaviors.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   .../platform/x86/dell/alienware-wmi-wmax.c    | 56 ++++++++++++++-----
>   1 file changed, 43 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index 4a8335d90b5d..e8fe16da036a 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -12,6 +12,7 @@
>   #include <linux/bits.h>
>   #include <linux/dmi.h>
>   #include <linux/moduleparam.h>
> +#include <linux/overflow.h>
>   #include <linux/platform_profile.h>
>   #include <linux/wmi.h>
>   #include "alienware-wmi.h"
> @@ -211,6 +212,17 @@ struct wmax_u32_args {
>
>   struct awcc_priv {
>   	struct wmi_device *wdev;
> +	union {
> +		u32 system_description;
> +		struct {
> +			u8 fan_count;
> +			u8 temp_count;
> +			u8 unknown_count;
> +			u8 profile_count;
> +		} __packed;
> +		u8 res_count[4];
> +	} __packed;
> +
>   	struct device *ppdev;
>   	u8 supported_profiles[PLATFORM_PROFILE_LAST];
>   };
> @@ -614,32 +626,35 @@ static int awcc_platform_profile_probe(void *drvda=
ta, unsigned long *choices)
>   	enum platform_profile_option profile;
>   	struct awcc_priv *priv =3D drvdata;
>   	enum awcc_thermal_profile mode;
> -	u8 sys_desc[4];
> -	u32 first_mode;
> +	u8 id, offset =3D 0;
>   	u32 out_data;
>   	int ret;
> -	u8 id;
> -
> -	ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRI=
PTION,
> -				       0, (u32 *) &sys_desc);
> -	if (ret < 0)
> -		return ret;
> -
> -	first_mode =3D sys_desc[0] + sys_desc[1];
>
> -	for (u32 i =3D 0; i < sys_desc[3]; i++) {
> -		ret =3D awcc_op_get_resource_id(priv->wdev, i + first_mode, &out_data=
);
> +	/*
> +	 * Thermal profile IDs are listed last at offset
> +	 *	fan_count + temp_count + unknown_count
> +	 */
> +	for (u32 i =3D 0; i < ARRAY_SIZE(priv->res_count) - 1; i++)
> +		offset +=3D priv->res_count[i];
>
> +	for (u32 i =3D 0; i < priv->profile_count; i++) {
> +		ret =3D awcc_op_get_resource_id(priv->wdev, i + offset, &out_data);
>   		if (ret =3D=3D -EIO)
>   			return ret;
>
> +		/*
> +		 * Some devices report an incorrect number of thermal profiles
> +		 * so the resource ID list may end prematurely
> +		 */
>   		if (ret =3D=3D -EBADRQC)
>   			break;
>
>   		/* Some IDs have a BIT(8) flag that should be ignored */
>   		id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
> -		if (!is_awcc_thermal_profile_id(id))
> +		if (!is_awcc_thermal_profile_id(id)) {
> +			dev_dbg(&priv->wdev->dev, "Unmapped thermal profile ID 0x%02x\n", id=
);
>   			continue;
> +		}
>
>   		mode =3D FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
>   		profile =3D awcc_mode_to_platform_profile[mode];
> @@ -680,12 +695,27 @@ static int awcc_platform_profile_init(struct wmi_d=
evice *wdev)
>   static int alienware_awcc_setup(struct wmi_device *wdev)
>   {
>   	struct awcc_priv *priv;
> +	u8 tot =3D 0;
>   	int ret;
>
>   	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
>   		return -ENOMEM;
>
> +	ret =3D awcc_thermal_information(wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
> +				       0, &priv->system_description);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Sanity check */
> +	for (u32 i =3D 0; i < ARRAY_SIZE(priv->res_count); i++) {
> +		if (check_add_overflow(tot, priv->res_count[i], &tot)) {

I wonder if it would be easier to just use a int to accumulate all offsets=
 and then check if the resulting value is greater than U8_MAX.

Other than that:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +			dev_err(&wdev->dev, "Malformed system description: %u\n",
> +				priv->system_description);
> +			return -ENXIO;
> +		}
> +	}
> +
>   	priv->wdev =3D wdev;
>   	dev_set_drvdata(&wdev->dev, priv);
>

