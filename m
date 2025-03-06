Return-Path: <linux-kernel+bounces-549930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2781A558C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195C5174A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53227701B;
	Thu,  6 Mar 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QN1LH5ig"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B227701E;
	Thu,  6 Mar 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296432; cv=none; b=se5eMjZFQG5MAjSjuuKaohaQk0A1F3z7DIh24S+ZiSvQyrRZDmb25zMfUVktv2SigLeZrftHYNHTIIdF5e6eMMgdr0WwdVaNsHe+wUjPfH2ncMsasAQzsd0Zo486hvYGKfFRaVzW1cJVhm9vZZVEJjb4PymdTVZlLdWSOjD3GE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296432; c=relaxed/simple;
	bh=+teJ2bIy+jRuCWoObGYUP/8ODUMDyG81dtPF3thWKtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ump+i1KDbsmiKT8AKwvBGBwXAyFbbNFZLd9vPubXt+amLxfFpQWg6NAb2Ef8hIcPeQN6eseVpopVsem/pngUouAoVAKfRKywDUoHHDhBt3CcPGhch0Ad3MCJWcW16MDnV6Vf6l/vE3MR0zbCe8v/aO+Wti5SrD2tUobfahddueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QN1LH5ig; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741296428; x=1741901228; i=w_armin@gmx.de;
	bh=051DgrsrM1mRUaTBGkVQbh7iCUdWww5XbKpVKTf7eAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QN1LH5igilIB4Oftm2MOX1So74Ru8M5MD4/DBY2PeOTvmde5z0klQgUQ3nhEboFu
	 exPJpYfr9S7SBfnpld1XwNPM3VcJaS9JoeZMpVLBhskXyoOAxNJL1bmMjzgb0YuhQ
	 JBKJLyq1h0Qy3H7RwkG0ht6rYSkMs8ptzXiFjwkaJT3Zxqz2iIh0Q/y51KMoc7r8L
	 icG5+sF4bSZJBI529lZne9QtiNBihCSSKgKNo4ZMGlyr9kCfjdH+oBu6v3LDhNwFg
	 3qxbulR0Sn/UlnLbPXlNLE+MJP2fD+QaOyQpqROhbTDB5v4BodGVGE6+LtuyoBl70
	 IVpU+4MzI0JXmzHbLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1tWr103BoP-00IVz2; Thu, 06
 Mar 2025 22:27:07 +0100
Message-ID: <fc3875fa-8ec9-4279-b8b6-d2ee35eb7602@gmx.de>
Date: Thu, 6 Mar 2025 22:27:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] platform/x86: alienware-wmi-wmax: Improve
 internal AWCC API
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-3-395e7a1407e2@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250305-hwm-v3-3-395e7a1407e2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V2qYOwSFOW5a0q2+7/G9ZrWtTnCr5hkO8xJk0szn9WsVjqZzxJK
 sbbjqH7m1N1GUNgpTp4gmAgwcqcSxF7ic1fbncKTBsAFGcQz0T+zjx6d30/wr8hfCwNladh
 R9Fh8CfPjIdwXT6vQ5zr0T1cy7VCUr7zmrSjXzXeQSJk0aa0hFqKyR/Txw0jshRdqVyE68C
 kVh0GYj9rtxqUxnrq+g4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GHPVV1RyvxY=;amZYKBw2Q0457dRHcKp3dGoGWLv
 +JDTfRFIDTSj78QIywCca+s9Cga/WAmBEqjfkuTvoo31jN9NQIiDY3l+yKsGtXXXDEl+9AzEP
 FK+oe+jkkir7lKeCcg0WVrhVqxG/NaQ8R9WRmrgxlRTKKUN2x7zu5pVt3LfT7e73oHFPqbSO/
 x7zWpOMfcn7LOjlCZrSYEjjCr0jwW52dNiZPgzLy25R+nqbGLw82HYhJMZQpNx5/ZMsBFPznk
 hpIvV4xu09RaPspWAK+Bm9TKE1XPjmPfwL8QGJz1ZudCm5x+OO1hd0Y5DBkkQTn1QquQOUQno
 VrzCie4BUrEwVn/9SH5sqenJCGtl4iHJaU+9CvU5U7uLhfp8W9feF+HHFInCf0F8/QxQAXIDw
 5OXt2vwzX+rHhcaJnndCserl5QWTkemt+Opf4lZhFAZhdj6aTkl/jVeVpaK9ZaqWkbzTojm0j
 I5bAjGaoHwE9C5b2INNr0h8yVseNRUM3WVzgtjd2RPqnuI/OdP357qJZrbo05abtkkkRMwRFe
 /viflKfXZ4Kjppin4TIIVRVLR+TTt+e+IHVklHHmTtg8C28LydEAZPwbPOkbtjieMJ55/miF6
 eMmoAekuE64V4+PlKKt+KvXbUu26CB8/QmC7oHyLIQ7nslcnA0WtC2+nsp9NeDkBnkqteteDj
 +BLcokjyGeMgPyXv8k6jeQrEj1dwvOwvJAkTdy/00tJDC//zEEYMsG2REaRVmmYUD1YszM+JX
 aSlIH9BRH2/jCBhLLHNPOlTImTagx6tZxDCS3F1wAyXLuLwfZ+KkJK1bKCHYlfBhBzVty3/IJ
 Ojkwx0Fopd8muqtM1g47D82ZphUDo7x5RezDc3RAXIxv76XMe/blQtTx7oQClqR3DnwPgBz2a
 ISV17XuZB66rbGeocnRc+qoilEpo2HAMSHnnkS9bBmxyePwT7++ePkY3Tsrg/FvSyKNhf6Qct
 pJ7Pk0o+5OR7SJfPc+M+FrBpOi92LhV5U4tBsu3QuDg3uVKQ4vkai4eG8o19viDmVXkkEFvTl
 hQPMRINyJsU1jNoUW7+VyVATOHpJ2M+x5E8jbPXb8LgmDGhO2/R/ycVsBqkSj8PY8bsoQC6MH
 s/uo5ahm6ZlOcsjO6jldCqh/aES1uTIBHlL6MT74GnnykKGm8WxQmeo+yeD3QBES8tfSIFYHV
 36sKWh1DCn/glZS0sHhOfbsczkzjqKpZC9KjvmG0WncBv/OpmSeWu4Fw3GAG2KOgsyh+oCN+2
 Kg90ikPIZijZVajCEbMjWNksmbLNd1+SYrcchr67sruY4GIaKW1F2C9dRtvmm6aYAs5NJ0W1z
 /JL8X3cGoJ1BjqJZeoVJxxEDnOhOcVrZYW6Mn0/hQBmXueYnlG3PRd+9seiMPINWTtOwiSvmG
 ZbPWx0oR8IjwBhmUM+Y43IZM4x3jJ3MlfmKRnR5i66uheVNryXWk9+yRu6

Am 06.03.25 um 01:56 schrieb Kurt Borja:

> Inline all AWCC WMI helper methods and directly return the newly
> introduced __awcc_wmi_command() helper to simplify implementation.
>
> Drop awcc_thermal_control() in favor of awcc_op_activate_profile().
>
> Add awcc_op_get_resource_id() and awcc_profile_id_to_pprof() helpers to
> support upcoming changes, as well as a new failure code.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 176 +++++++++++++++--=
--------
>   1 file changed, 110 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index 80aefba5b22d6b4ac18aeb2ca356f8c911150abd..a43373717bd4580e8f62a726=
3e67664630165e28 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -32,6 +32,7 @@
>   #define AWCC_THERMAL_MODE_GMODE			0xAB
>
>   #define AWCC_FAILURE_CODE			0xFFFFFFFF
> +#define AWCC_FAILURE_CODE_2			0xFFFFFFFE
>   #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
>   #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
>   /* Some IDs have a BIT(8) flag that we ignore */
> @@ -443,8 +444,7 @@ const struct attribute_group wmax_deepsleep_attribut=
e_group =3D {
>   };
>
>   /*
> - * Thermal Profile control
> - *  - Provides thermal profile control through the Platform Profile API
> + * AWCC Helpers
>    */
>   static bool is_awcc_thermal_profile_id(u8 code)
>   {
> @@ -463,95 +463,140 @@ static bool is_awcc_thermal_profile_id(u8 code)
>   	return false;
>   }
>
> -static int awcc_thermal_information(struct wmi_device *wdev, u8 operati=
on,
> -				    u8 arg, u32 *out_data)
> +static int __awcc_wmi_command(struct wmi_device *wdev, u32 method_id,
> +			      struct wmax_u32_args *args, u32 *out)
>   {
> -	struct wmax_u32_args in_args =3D {
> +	int ret;
> +
> +	ret =3D alienware_wmi_command(wdev, method_id, args, sizeof(*args), ou=
t);
> +	if (ret)
> +		return ret;
> +
> +	if (*out =3D=3D AWCC_FAILURE_CODE || *out =3D=3D AWCC_FAILURE_CODE_2)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static inline int awcc_thermal_information(struct wmi_device *wdev, u8 =
operation,
> +					   u8 arg, u32 *out)
> +{
> +	struct wmax_u32_args args =3D {
>   		.operation =3D operation,
>   		.arg1 =3D arg,
>   		.arg2 =3D 0,
>   		.arg3 =3D 0,
>   	};
> -	int ret;
>
> -	ret =3D alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION,
> -				    &in_args, sizeof(in_args), out_data);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (*out_data =3D=3D AWCC_FAILURE_CODE)
> -		return -EBADRQC;
> -
> -	return 0;
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
>   }
>
> -static int awcc_thermal_control(struct wmi_device *wdev, u8 profile)
> +static inline int awcc_game_shift_status(struct wmi_device *wdev, u8 op=
eration,
> +					 u32 *out)
>   {
> -	struct wmax_u32_args in_args =3D {
> -		.operation =3D AWCC_OP_ACTIVATE_PROFILE,
> -		.arg1 =3D profile,
> -		.arg2 =3D 0,
> -		.arg3 =3D 0,
> -	};
> -	u32 out_data;
> -	int ret;
> -
> -	ret =3D alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL,
> -				    &in_args, sizeof(in_args), &out_data);
> -	if (ret)
> -		return ret;
> -
> -	if (out_data =3D=3D AWCC_FAILURE_CODE)
> -		return -EBADRQC;
> -
> -	return 0;
> -}
> -
> -static int awcc_game_shift_status(struct wmi_device *wdev, u8 operation=
,
> -				  u32 *out_data)
> -{
> -	struct wmax_u32_args in_args =3D {
> +	struct wmax_u32_args args =3D {
>   		.operation =3D operation,
>   		.arg1 =3D 0,
>   		.arg2 =3D 0,
>   		.arg3 =3D 0,
>   	};
> -	int ret;
>
> -	ret =3D alienware_wmi_command(wdev, AWCC_METHOD_GAME_SHIFT_STATUS,
> -				    &in_args, sizeof(in_args), out_data);
> -	if (ret < 0)
> -		return ret;
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_GAME_SHIFT_STATUS, &args, =
out);
> +}
>
> -	if (*out_data =3D=3D AWCC_FAILURE_CODE)
> -		return -EOPNOTSUPP;
> +/**
> + * awcc_op_get_resource_id - Get the resource ID at a given index
> + * @wdev: AWCC WMI device
> + * @index: Index
> + * @out: Value returned by the WMI call
> + *
> + * Get the resource ID at a given index. Resource IDs are listed in the
> + * following order:
> + *
> + *	- Fan IDs
> + *	- Sensor IDs
> + *	- Unknown IDs
> + *	- Thermal Profile IDs
> + *
> + * The total number of IDs of a given type can be obtained with
> + * AWCC_OP_GET_SYSTEM_DESCRIPTION.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +static inline int awcc_op_get_resource_id(struct wmi_device *wdev, u8 i=
ndex, u32 *out)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_GET_RESOURCE_ID,
> +		.arg1 =3D index,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
> +
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
> +}
> +
> +static inline int awcc_op_get_current_profile(struct wmi_device *wdev, =
u32 *out)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_GET_CURRENT_PROFILE,
> +		.arg1 =3D 0,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
> +
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
> +}
> +
> +static inline int awcc_op_activate_profile(struct wmi_device *wdev, u8 =
profile)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_ACTIVATE_PROFILE,
> +		.arg1 =3D profile,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
> +	u32 out;
> +
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &o=
ut);
> +}
> +
> +static int awcc_profile_id_to_pprof(u32 id, enum platform_profile_optio=
n *profile)
> +{
> +	switch (id) {
> +	case AWCC_THERMAL_MODE_GMODE:
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	if (!is_awcc_thermal_profile_id(id))
> +		return -ENODATA;
> +
> +	id =3D FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
> +	*profile =3D awcc_mode_to_platform_profile[id];
>
>   	return 0;
>   }
>
> +/*
> + * Thermal Profile control
> + *  - Provides thermal profile control through the Platform Profile API
> + */
>   static int awcc_platform_profile_get(struct device *dev,
>   				     enum platform_profile_option *profile)
>   {
>   	struct awcc_priv *priv =3D dev_get_drvdata(dev);
> -	u32 out_data;
> +	u32 profile_id;
>   	int ret;
>
> -	ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_CURRENT_PROFI=
LE,
> -				       0, &out_data);
> -
> -	if (ret < 0)
> +	ret =3D awcc_op_get_current_profile(priv->wdev, &profile_id);
> +	if (ret)
>   		return ret;
>
> -	if (out_data =3D=3D AWCC_THERMAL_MODE_GMODE) {
> -		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> -		return 0;
> -	}
> -
> -	if (!is_awcc_thermal_profile_id(out_data))
> -		return -ENODATA;
> -
> -	out_data &=3D AWCC_THERMAL_MODE_MASK;
> -	*profile =3D awcc_mode_to_platform_profile[out_data];
> +	ret =3D awcc_profile_id_to_pprof(profile_id, profile);
> +	if (ret)
> +		return ret;
>
>   	return 0;
>   }
> @@ -583,8 +628,8 @@ static int awcc_platform_profile_set(struct device *=
dev,
>   		}
>   	}
>
> -	return awcc_thermal_control(priv->wdev,
> -				    priv->supported_thermal_profiles[profile]);
> +	return awcc_op_activate_profile(priv->wdev,
> +					priv->supported_thermal_profiles[profile]);
>   }
>
>   static int awcc_platform_profile_probe(void *drvdata, unsigned long *c=
hoices)
> @@ -606,8 +651,7 @@ static int awcc_platform_profile_probe(void *drvdata=
, unsigned long *choices)
>   	first_mode =3D sys_desc[0] + sys_desc[1];
>
>   	for (u32 i =3D 0; i < sys_desc[3]; i++) {
> -		ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_RESOURCE_ID,
> -					       i + first_mode, &out_data);
> +		ret =3D awcc_op_get_resource_id(priv->wdev, i + first_mode, &out_data=
);
>
>   		if (ret =3D=3D -EIO)
>   			return ret;
>

