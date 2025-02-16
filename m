Return-Path: <linux-kernel+bounces-516467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27973A3722A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FEC1887648
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 05:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB51487F8;
	Sun, 16 Feb 2025 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="D5vMtzC1"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B3440C;
	Sun, 16 Feb 2025 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739684935; cv=none; b=ZVyUMJ66yBC0LIcxubapldq26XSJ8080M29XGva4mUyA/DsaoUL9GOS83nchQ+xSooL0yypChMw+dpLNgNGVy/BSD4vqr4ior7MaVfnmwa6wLHiXXZ/IvSFLVoS4bztfd7bBUJQZsWJcvNqTaEFEfSvpOudYEEYwjQxJUucW9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739684935; c=relaxed/simple;
	bh=be69TTupFIlqkcUrH6mUVFP1w0kPEeXybUIJZ/gFPVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jy4UNBaj59OQbsAe9F+4zNHDdHJS80Lc+JbxWKK9nOBpHAIM4kyT82XD/1zkRSZ+pc3mx/WnCFWEUbcDtfVnKcEgMgV2DXCzkSlJxDsbCDzXnvyGWs4QpwvSN4C4PLLdn7lJRx+ju/YiY4uTG4VbGPU46aPEKaKg1/gmp001iWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=D5vMtzC1; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739684924; x=1740289724; i=w_armin@gmx.de;
	bh=RSQjlJew/FphahJiQttmsBsIcWPS8OkpZW4NpxUlkf8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D5vMtzC16TM9w4/VySoziqCiWpL3hjUbCaf2RqL077gGYkgP8+TZSRr8/ThI9ME0
	 mT5ZT++eaUVcXYnfmtFOLH1efMJCowcWY4IrjUavPvtopfZNSus/x4EcIgwHNrNqT
	 ZdJAC66hxJg/V5pXtBiISAoY6xN8j0rNc/wyMI00QXlRb2B7vRQYAIo8W/0BNo//Q
	 dbYnX+UWcuxNIo3I1Bb3tq8z96dp5G6ev+EyJLDZsuDRewPZaOk0NL7Nz8cYJw4m2
	 HqrBG2JkWCBq52axBGNOzJnSVfzCWlGLJhqaciTsPfG64Vn9quUBbc/RYKk+8M9Kt
	 KNHpQly9CqJAwdes8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1tHVEU1VhS-013smU; Sun, 16
 Feb 2025 06:48:44 +0100
Message-ID: <aea0dede-e3fc-4140-9a68-8502ff5328ab@gmx.de>
Date: Sun, 16 Feb 2025 06:48:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] platform/x86: alienware-wmi-wmax: Improve internal
 AWCC API
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-4-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250208051614.10644-4-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3BBrD2EmoQJNdEtDUkEzARqDX1v9Uy5h8C4UgHNwtEnkSuxvTAk
 iqmJYLnRaJm7/YNCUO+DGkHj6h2QmohP/S/i6/E/YoigPxGVhR+F8y/Fy6s+T+AI433hZk+
 bh6r3/siE331UxK/9XGaShs7U01OGNk8Dp2zMV801fRfoVO46dY+RWPlOFLibZLUxso8N5S
 hLQWpC+J7C1RajoFpeT5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iii5LoyFYwU=;T+xzIKXtofZuAwdv0lAxN1EUWh8
 Vw+fQrL02W7xMF3rgbG5QwS5+tZv0oPKMEhC9dK6hckfKff3ffWyWxmDreaJzyo+bdH8uP0xo
 R10BxZRLkUtTSQKscOEsNXYrzDGs1HJ5PvxR+XxPVG32GeYCBhdiEHDDwWq8c5ZT+a37mhM78
 CmdUxcy+tCTeshWw7WSNaIazIXt89Z+VXC3LAfJN9u239ZL4dl2q2eoEiO/kYLoTKmo07Fctj
 /2+v4nAxjBz8+7t4g/qAMV3vrHX7iLx8tae+lFH/9tyDysJSvo19J6apZWkbq/eMJ/S0JwK1B
 tjWnAdE9b/Flo/SuuULBGEvapEEjn1l/3WwOD7b3/MXDj15VEIUu6nE7A7E0Ryih0s4fX6/CB
 Ndm9WXA3mgSxRg0Zr49dza1of6z8MlkzhDUTJpV4S09Tff8Z3D8bpvmrPwp/QJlJNXLifZX6j
 nY1NqaZAfNQBqdUPViti4Qv8sB4noRUIDl7uQtWHPs8RE5hcBzHSv9BodVXBGV4w4SLb0pMYZ
 XcmUFI9bMdE8QhJSmbeLqV6lEhR8uUTf+WzvoTpaCgsdBIl16wfIHnNez97ivPEuPDTABXKcd
 YaptJ5Em7PHuyf1g4cQcKsE1BKhmh056cXZEafJPeUf+6uMchKAkorjMWhoyFI9LHWgzm4rFY
 SXn+yah/yDkoOM+quYFapD17kGjrfrXcu3Hgi9ZTz1ecqXnf0CNomjcb37QgCghZpO9I81h8Q
 f5Ne80y9p+01w5yeyvB5jP9b0uwGf8nqzDc5yHgiJYx/EuKD1MD5LkD9n4YUDQhkmKNX0Tqq4
 IZ0c5Ps1Ts2CYSYwSq6lnpVBcgZxzraCbULDZlBXvE2HS5IuVPGBBIBSiayfPdfRQtUapLQbM
 bFmowc4/RAYaBERFhjHPbSqUZmDFE3nm0iuNaesKXkmhBsOpqwSx7lkHspxLN/+IYMP/QOhMm
 V85C99UEaapKZcYQ7Z6qeOM3JYCvLyZUepS5W0C+U4Bx2S0raypg1WFLWWttBweEcMV+CWJEb
 7qc5intHLelpSx3mYyYwmlQkg4LRONWuog60dkEiidTsjQuzBebTZUZLrfa1by2Ax3z4jlGhK
 XNBJzwcIdITfsDGhHET9IMDu/6KMfZY+wvkkLjiUhi2X9+1iGkxBeFz50T8DN9UNQDP7RRLYw
 s/ERcywjmMGVB6z0sQ1Yga7T0CWGRwEcCVjqXFciYRH1iOl9RAHF/l2dFjo/IuRxgC2rAJZ9g
 X1UqiRyP5bjriMeXshcfmArUY5g2Xg64OM7EdOXfhUEVS525q4V3bm2tPmVsdTwqdELysOJBN
 4dGvTGyXepqbr775y30Thw+CpWVlps54hUMt5UOSTbXDVXUA0WEu7kNAGq7u/2A/I5pmD+1jZ
 xXqu2LxafyX23by8QNJ7JvJNSybYEiDlhHcqKNdWPHLKCco2o9u44LfOHk

Am 08.02.25 um 06:16 schrieb Kurt Borja:

> Inline all AWCC WMI helper methods and directly return the newly
> introduced __awcc_wmi_command() to simplify implementation. Additionally
> make wmax_u32_args __packed, additional failure code and add a helper
> with documentation for AWCC_OP_GET_RESOURCE_ID.

"add a additional failure code"

With this being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   .../platform/x86/dell/alienware-wmi-wmax.c    | 104 +++++++++++-------
>   1 file changed, 63 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index 7f0aa88221d6..57897a0f4296 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -32,6 +32,7 @@
>   #define AWCC_THERMAL_MODE_GMODE			0xAB
>
>   #define AWCC_FAILURE_CODE			0xFFFFFFFF
> +#define AWCC_FAILURE_CODE_2			0xFFFFFFFE
>   #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
>   #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
>   #define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
> @@ -206,7 +207,7 @@ struct wmax_u32_args {
>   	u8 arg1;
>   	u8 arg2;
>   	u8 arg3;
> -};
> +} __packed;
>
>   struct awcc_priv {
>   	struct wmi_device *wdev;
> @@ -442,8 +443,7 @@ const struct attribute_group wmax_deepsleep_attribut=
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
> @@ -462,72 +462,95 @@ static bool is_awcc_thermal_profile_id(u8 code)
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
> -		.operation =3D operation,
> -		.arg1 =3D arg,
> -		.arg2 =3D 0,
> -		.arg3 =3D 0,
> -	};
>   	int ret;
>
> -	ret =3D alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION,
> -				    &in_args, sizeof(in_args), out_data);
> -	if (ret < 0)
> +	ret =3D alienware_wmi_command(wdev, method_id, args, sizeof(*args), ou=
t);
> +	if (ret)
>   		return ret;
>
> -	if (*out_data =3D=3D AWCC_FAILURE_CODE)
> +	if (*out =3D=3D AWCC_FAILURE_CODE || *out =3D=3D AWCC_FAILURE_CODE_2)
>   		return -EBADRQC;
>
>   	return 0;
>   }
>
> -static int awcc_thermal_control(struct wmi_device *wdev, u8 profile)
> +static inline int awcc_thermal_information(struct wmi_device *wdev, u8 =
operation,
> +					   u8 arg, u32 *out)
>   {
> -	struct wmax_u32_args in_args =3D {
> -		.operation =3D AWCC_OP_ACTIVATE_PROFILE,
> -		.arg1 =3D profile,
> +	struct wmax_u32_args args =3D {
> +		.operation =3D operation,
> +		.arg1 =3D arg,
>   		.arg2 =3D 0,
>   		.arg3 =3D 0,
>   	};
> -	u32 out_data;
> -	int ret;
>
> -	ret =3D alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL,
> -				    &in_args, sizeof(in_args), &out_data);
> -	if (ret)
> -		return ret;
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
> +}
>
> -	if (out_data =3D=3D AWCC_FAILURE_CODE)
> -		return -EBADRQC;
> +static inline int awcc_thermal_control(struct wmi_device *wdev, u8 prof=
ile)
> +{
> +	struct wmax_u32_args args =3D {
> +		.operation =3D AWCC_OP_ACTIVATE_PROFILE,
> +		.arg1 =3D profile,
> +		.arg2 =3D 0,
> +		.arg3 =3D 0,
> +	};
> +	u32 out;
>
> -	return 0;
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &o=
ut);
>   }
>
> -static int awcc_game_shift_status(struct wmi_device *wdev, u8 operation=
,
> -				  u32 *out_data)
> +static inline int awcc_game_shift_status(struct wmi_device *wdev, u8 op=
eration,
> +					 u32 *out)
>   {
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
>
> -	return 0;
> +	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args=
, out);
>   }
>
> +/*
> + * Thermal Profile control
> + *  - Provides thermal profile control through the Platform Profile API
> + */
>   static int awcc_platform_profile_get(struct device *dev,
>   				     enum platform_profile_option *profile)
>   {
> @@ -605,8 +628,7 @@ static int awcc_platform_profile_probe(void *drvdata=
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

