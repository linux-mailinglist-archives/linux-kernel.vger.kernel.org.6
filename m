Return-Path: <linux-kernel+bounces-516466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DEAA37221
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED89188EBC1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 05:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEB8149E13;
	Sun, 16 Feb 2025 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EWRQaUwF"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9B290F;
	Sun, 16 Feb 2025 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739684673; cv=none; b=KwxmFJycgQAsGDbreSo6WVIrhiuimWeNYo3gvQRlhgiQHhMniXEuwZJX6Fps/ctCMqoJuRP0wg1oy7KvTWr17YwVTWR7cGJb92dw752uHmb6T3A5y/uW7DkwpHo0b7vPAQAvwoN9VOSIWjQuJEZdMWjNx1PvVp2+aMVH7COEnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739684673; c=relaxed/simple;
	bh=ugq3SxARc94wvNCHC6VQnvRZ6pQbNdQMjgbyFcBHVeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEKNfChAkAhrATE+vz5YVEQpYIHBoR64EL6zLzW7TyX77EkO9jmGjziKdj+T5OOyK/fWBzLV//OlBbExnr0X0tJwti8KLy6tJXtZs/wZmKv7XM4PqI/3FFQqe05gf0C/Cjpi7Kf81B6L8M1yted5gscCpI2xjuDgExz5UFZ8NYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=EWRQaUwF; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739684669; x=1740289469; i=w_armin@gmx.de;
	bh=uQQu2JjO7AFB3dae4M5u+a5yNVbl6gbx2wcggPboxd8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EWRQaUwFfhQr3bhXoxLahcpYePXeKvhgZyQRausa9+CqQfGAeWFxAjfjoCFxJWqY
	 BknS1dnRTWm+upZ5wArvqREGghmQzd0yAgNBfoar7KnRmmkPpMffL8NrBxsiA8kr+
	 RxU70zbXOar0ELuyNECJ2ApA8hI2Mn/v5+EHVTEw8mJytaR4gPE+vUV0JHe4rQQlJ
	 B0QMLP2Y56zQUS/awQl3ViNM8YgarDIestco6cFcQC+t6KGAmYeH5Zu2Zd2P0ZHEQ
	 nxXkMNKvQJ155zi3VxnzE58QgE1nUuayw4wRZwZ8RzYsVvup6O0uzn60ox03SYO/C
	 WG0JkWjhtjQXc07Yxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY6Cl-1tqpyy25Qj-00ScGk; Sun, 16
 Feb 2025 06:44:29 +0100
Message-ID: <c49def7d-dde0-4956-991a-3e1b9518eb13@gmx.de>
Date: Sun, 16 Feb 2025 06:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] platform/x86: alienware-wmi-wmax: Refactor
 is_awcc_thermal_mode()
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-3-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250208051614.10644-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Vg3Gub078D775g02CVdWhG11LzxA4lUBRBgiRRuqMkMyJGh3gD
 t5rezNXwz8FtG0dS+w+MWYbHU65d3sOHHA5GdN+jv/Vi6uqKI3KEwrM7dG11Eiiqo0h/xsW
 F036ppmbGa2hlaGA2hAGDtDzQDa1G4CgksCUcchLWKZqSIbXXMNLgAPqjPpZJFVOVEtzoj4
 Oc1Q05/Io8082zaP+hxAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xvu8a0qjgtU=;SLsAoq6KDws/7JXeE4baHOguhEt
 FrjvCGVPj5NfbJBH4TgCfYeM9lRq3FtO1FDr2K0ywtfuCWz668A6l3sVNC8upx8BncV4XU7HF
 Bs1Tx8VzxQ4BvwqPsahbGYfHKrHV/5WsWv+aaaoPBoDKvsO9ioaPc3eFg08B003b6gRCY9W4B
 sHj1aF/I+m1I0RY4It8VpDU1MCD/NWrHyeYbLh6sM0Sj8QYW/LbVvvQajM/lVK4b+mDrAYZGf
 8AdhC7DgvEc0aWcHs9/jqZ65oOMX5Li6kCmaiz7jt/LQuKPBs7OIath2CEDq5P4bkXKdYdEhc
 HxgKnTV96G+nWAKx6iKz34pqoWewF3Q4m9I/2aWrVMuZ3g4RGm2Ms3MZXtkrGiItd0FVnrmVL
 enGSeqh2S78PH1AnNpp1o37q59crgPq0rQdMfwfNcrdPgKq0Pw89NDWtFvx62aytgrFXJEhQ7
 6ZSk+HK7q+dO9OpkH89qQLRmfkE0GvIjTqJ3nes/Ngb6VR8MII24pelWHUMj/QjbIr1vuQlyk
 fFrQGNjTk4zirwJumCOHobY3ugIJxwnfi5dHEGZW2X7Aa/f0Hu/MyGpemNCji2PbaeVxCsecB
 RT/6EflHhFE9r0II7prW3kH/2himvy6Jw8PtlC8mUsUxMdyTxbT2mlocx1hFHWNMRu9ej4LB0
 Fksqm/0NAt/HJjh+x3H6FfdLYb+PCyHwMXUkg7ZTp+RugUiA6g2RjSj/pCMBLtS2/8ZssRrt0
 KMmcKsBblg2EqahYM20BUamIMg91/Ti4nx4Z4JoTId7yRLHGrQEuoGNpCQqTapclAp3cW5FIv
 CXzhrHAAa+eS1k+8lAU/LLWyP3PP8/nnHafJVgQIkvk2YiDvMdfjmj25u5ZW2ruKOcLy62Gb/
 K15Qha2yKOfmZDjRtGTGpyrWq0XwjsWonK++/AIhIN/tYPXnUJoF1Utzoq3j3kASKbCy45XZr
 CDnKqaQKYEkf+Ffwz/WOQtwvVOHUfgrfCqr8Z9gR2WauK6/NMFiFzMfM/f0ZF8aqH/B/BbMti
 PCYhEiltH/LLO0TwCBAs02fHWeoH3EPpgCokuvMn15T8UkzMImaMMKgaAOl59a4rt+l5hCb+B
 FdYflS7xnGnYLMMfjUFFDlmy5RZi7pp5Ufu2JFhUpSQxoZugTOI9PlMBdDBqkskSJZb+O3B/Q
 qnL+fdhtcfe2k760Yg8yLDA5EWybpwLVa618Q7mMEzn0m8fSuNsC9jvIk/+tV9nVcz5S+Jqyu
 +4UV/7D3QfXNiVK50u3RMy9aU6pEFJVpb8S71cFyyariRR5vuz/Ug6K0KKW67eGCGaiYIKZX6
 XXOijXPMUoG1K4XHI+4QF6afbEUbR/zCZNNllb0mIUWO4ZApJo1OH8sl2l+ss2LPLWvPFcleJ
 aR2VzAphRCbxoM2a1I4QKrTwOBmcacydrboboP1xJw1sf8lBoYvWTUksGB

Am 08.02.25 um 06:16 schrieb Kurt Borja:

> Refactor is_awcc_thermal_mode() to use FIELD_GET() instead of bitwise
> operations. Drop the check for BIT(8) sensor flag and rename it to
> is_awcc_thermal_profile_id().

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   .../platform/x86/dell/alienware-wmi-wmax.c    | 31 ++++++++++---------
>   1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index ed70e12d73d7..7f0aa88221d6 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -34,7 +34,7 @@
>   #define AWCC_FAILURE_CODE			0xFFFFFFFF
>   #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
>   #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
> -#define AWCC_SENSOR_ID_MASK			BIT(8)
> +#define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
>
>   static bool force_platform_profile;
>   module_param_unsafe(force_platform_profile, bool, 0);
> @@ -168,8 +168,8 @@ enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
>   };
>
>   enum AWCC_THERMAL_TABLES {
> -	AWCC_THERMAL_TABLE_LEGACY		=3D 0x90,
> -	AWCC_THERMAL_TABLE_USTT			=3D 0xA0,
> +	AWCC_THERMAL_TABLE_LEGACY		=3D 0x9,
> +	AWCC_THERMAL_TABLE_USTT			=3D 0xA,
>   };
>
>   enum awcc_thermal_profile {
> @@ -445,20 +445,18 @@ const struct attribute_group wmax_deepsleep_attrib=
ute_group =3D {
>    * Thermal Profile control
>    *  - Provides thermal profile control through the Platform Profile AP=
I
>    */
> -static bool is_awcc_thermal_mode(u32 code)
> +static bool is_awcc_thermal_profile_id(u8 code)
>   {
> -	if (code & AWCC_SENSOR_ID_MASK)
> -		return false;
> +	u8 table =3D FIELD_GET(AWCC_THERMAL_TABLE_MASK, code);
> +	u8 mode =3D FIELD_GET(AWCC_THERMAL_MODE_MASK, code);
>
> -	if ((code & AWCC_THERMAL_MODE_MASK) >=3D AWCC_PROFILE_LAST)
> +	if (mode >=3D AWCC_PROFILE_LAST)
>   		return false;
>
> -	if ((code & AWCC_THERMAL_TABLE_MASK) =3D=3D AWCC_THERMAL_TABLE_LEGACY =
&&
> -	    (code & AWCC_THERMAL_MODE_MASK) >=3D AWCC_PROFILE_LEGACY_QUIET)
> +	if (table =3D=3D AWCC_THERMAL_TABLE_LEGACY && mode >=3D AWCC_PROFILE_L=
EGACY_QUIET)
>   		return true;
>
> -	if ((code & AWCC_THERMAL_TABLE_MASK) =3D=3D AWCC_THERMAL_TABLE_USTT &&
> -	    (code & AWCC_THERMAL_MODE_MASK) <=3D AWCC_PROFILE_USTT_LOW_POWER)
> +	if (table =3D=3D AWCC_THERMAL_TABLE_USTT && mode <=3D AWCC_PROFILE_UST=
T_LOW_POWER)
>   		return true;
>
>   	return false;
> @@ -548,7 +546,7 @@ static int awcc_platform_profile_get(struct device *=
dev,
>   		return 0;
>   	}
>
> -	if (!is_awcc_thermal_mode(out_data))
> +	if (!is_awcc_thermal_profile_id(out_data))
>   		return -ENODATA;
>
>   	out_data &=3D AWCC_THERMAL_MODE_MASK;
> @@ -597,6 +595,7 @@ static int awcc_platform_profile_probe(void *drvdata=
, unsigned long *choices)
>   	u32 first_mode;
>   	u32 out_data;
>   	int ret;
> +	u8 id;
>
>   	ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCR=
IPTION,
>   				       0, (u32 *) &sys_desc);
> @@ -615,12 +614,14 @@ static int awcc_platform_profile_probe(void *drvda=
ta, unsigned long *choices)
>   		if (ret =3D=3D -EBADRQC)
>   			break;
>
> -		if (!is_awcc_thermal_mode(out_data))
> +		/* Some IDs have a BIT(8) flag that should be ignored */
> +		id =3D FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
> +		if (!is_awcc_thermal_profile_id(id))
>   			continue;
>
> -		mode =3D out_data & AWCC_THERMAL_MODE_MASK;
> +		mode =3D FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
>   		profile =3D awcc_mode_to_platform_profile[mode];
> -		priv->supported_thermal_profiles[profile] =3D out_data;
> +		priv->supported_thermal_profiles[profile] =3D id;
>
>   		set_bit(profile, choices);
>   	}

