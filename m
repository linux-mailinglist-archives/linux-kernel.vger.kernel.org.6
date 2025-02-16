Return-Path: <linux-kernel+bounces-516468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AFA3722C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C47A1DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 05:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E51494B5;
	Sun, 16 Feb 2025 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UFzMAtAg"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531F1487F8;
	Sun, 16 Feb 2025 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739685003; cv=none; b=X/apTRlt8kZZqFXIEr+RjHdJeGCd3+2GlLQfLrpp2F5oKBOjorxclnOdlG11iNm1bv+B39sjoKtPT4Ubt6QlkkLlxEACThOHgaxK1iS1GgJGZTFk0+b0stzscUxfeGLlNifIKusbkRNBreus0UMXerP6dNbLyEjp8zCLz7mt++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739685003; c=relaxed/simple;
	bh=3TCtuOFGB4neSMrOFjfTpFHzSRr4QRmSUvEv8XpCdlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sG55oOBT/Yq3X2wCur1Dvm0Pgh6pEbt5ijrSsaODXK9LHqKV5okwaGQh6YZ8ldfW4VSR3LtXYMzwIXfKvPLegk5Rs40OYV2dAmWxMOSo05cz4+MujAdDxVHs9SAGWQz7IHv+insNFzu96RWloGG0AaAKtqat5DGSTojR6SUnWuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UFzMAtAg; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739684999; x=1740289799; i=w_armin@gmx.de;
	bh=WFywgh/m8e882+FQCyUN+lOlI8Cz7wOxv5dYMyXR0tY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UFzMAtAg7iOxFSLY5WK9HhTa9d7sSn5Ln61GaBaV+zww4gsScHjDiU/5Pto4a44f
	 Je74l3ZXJlBapdRzEW2ETJLIY58TE9CmVa6MLmloelO2xlNyBHVUWIgJh5mPwD9Pg
	 bIvv2dIMDt5ciccONcyO6PG4MAfJVfE5Pfk1ZfT7HQYxJsSG916gfJBifNzDML6SE
	 Q1Gs8NyZ/HfJiSGlECQ/PgSZxkn89rkGJhEjNCJz9afF7tf7XZkPNZKmbEXVDjUqw
	 ek2ihjoxkLVmArgmMvvZuTDZmQbEqVao/9h6H0KKAAs26bRx3hppmAUUMX/1yGE9z
	 ceSZ2jTY4mwJKAeTew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1tIK9x2xXb-011E0g; Sun, 16
 Feb 2025 06:49:58 +0100
Message-ID: <076a5b8c-e401-4bf0-80f6-130daae61c48@gmx.de>
Date: Sun, 16 Feb 2025 06:49:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] platform/x86: alienware-wmi-wmax: Modify
 supported_thermal_profiles[]
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-5-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250208051614.10644-5-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9SI+5q3Kqg2mCaHnufBosyKbYHWvQy2nGeqTJNukXBLEQYxinYt
 cb0rquubufe9w1IygpKZ1Jy1TH/UgzaAdFRQ3SuhLQ8mJSnTAAEWWgrpyFc9BJayII61T4F
 avqL93KFTTh7+vVuisEEuMxBU66cHYk8MFrTmTdxj6wKa5cFEFI2JGlPidxeFGpAXOd1hkg
 Fg44PQmkQ+bbaDIoSJC8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4ZdUFXpsyf8=;wMFTm5dTB0mH4A386lOSEMV5ymB
 WogF2ie1ijim9oEK+cDUcyj/HAXa/nh+a4arOmn0tDiYqPzEEAnBk8NbAP7A4Eu0qy1lRd8Gr
 ZAqO1zWlc7eLhrzyiWQ3f9hgPfQaAEWVJ0u8iPkjJKiI4z12RZblgHuS/wL9ovK69FZxi6UQL
 ZVoRrhhtar/O1K6zryqyvXKsJyUnUcuCg6W/FKFznclaKn6peBgU/xmuMYiRSC5Fx2ntiZDQU
 bqdJ58a7mh4PjQUYa/LnNtYu93Y0T8RItKl/I5nPy+J+5Z8s5zleU0paroYCg1aIQhzH4bbAk
 AsqyuXMzcw5yaZ8gZ3qfDPR4jNnIHRrLb3PIyyqSODVVtpUfkpBfJWSdnuNX4qWBIc23ezUTa
 9Izs2qHxwwxztpucGBBEthNF00dfpxwlRaTASo73BFzGHyWPLcmayrkUQTKKiWX3XEI3nVsEX
 Y7DqHPaEttzF2OKpZvrFooZNiLZSnpHYtFkYXc3Jw0450/u+v15Y6yeIcx5Prprq8joI+IbN9
 XOuaumEylyONKXgaqKS+jwUEfid7zc2znvVDDabbsDMKAf7wio7rm2tbriME3XOJWKJ5hsEfH
 djivszy3fsPMw+vkn1HCIhvn452cXYqYSVX3GDuLTa9uzLQfl3aTk/ya50velxKrM/eY5aQT8
 b8YY7+RmQ5xb63D55dV3QD3mnHfl8qcBasAOkz2KSC7w4G4gyaX7bqWzNomei0PYK+rM+a9zh
 k4dgovdHaBTcoy+AAxj0auYxrw353ZDVQ+j7zpMxRKvIQbvOxNROaAHzhOIRWciGHVBvnG6s9
 mi+dhOfFhbL6eUwjWHVRNk1c04fc4w9bEW4927VR9f3EuiKQxC/jH97gU4ZJI5A9dJ5S/twbM
 ah6FgQAwEm4ToZlMe7nLhmpHtrXXgGw6WoBGk2PawtcQsLnpH9xqxG4COdmJhIs8NVqe0sOe4
 9YrjBURVGsCqT/0mVeJErzgrVXLNejmWER6a238+ZjV55S8m9rveu98JDgKNfEl1JoDk4R1L0
 k4T1fpv5W00OjUNT+T82uBp5yTblk7BMYg1a2J5QEWwonPf3YrdHDSlok2eaf4RXMwMfOHP7k
 GfqraFWpUeypEmqRhMcgSK5MssU320qTugbOe6pjBFW+7kmfTAG/2oDMeSxOfwgWv6wlkFyHF
 WnAPSo/I3Zj89t+9hRnLFENmpNb9T3jsP6Iywfeh64u8PuhRkCNQa4sUgL02mU7Vv79VEEXkY
 i0c7Khl/1UinNEFpAtD/WhndACBvu2qoLZdh/RLJ86ehtzw3/GNMgSwtzl3YwkOstJslOuNDg
 1iOj701N500zVvwL85Jq86BbL/6p5ZFrc8tUBuwVEa6APqlvX71zCUNQw2DQmergeBCYzfRB1
 JQ2JAknsO3b0nygSHTq73vLVvDEMgFczJdGLC2dOHrGzvOFSyfTbcNex/s

Am 08.02.25 um 06:16 schrieb Kurt Borja:

> Rename supported_thermal_profiles[] -> supported_profiles[] and change
> it's type to u8 because it stores AWCC thermal IDs.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/alienware-wmi-wmax.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index 57897a0f4296..4a8335d90b5d 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -212,7 +212,7 @@ struct wmax_u32_args {
>   struct awcc_priv {
>   	struct wmi_device *wdev;
>   	struct device *ppdev;
> -	enum awcc_thermal_profile supported_thermal_profiles[PLATFORM_PROFILE_=
LAST];
> +	u8 supported_profiles[PLATFORM_PROFILE_LAST];
>   };
>
>   static const enum platform_profile_option awcc_mode_to_platform_profil=
e[AWCC_PROFILE_LAST] =3D {
> @@ -606,7 +606,7 @@ static int awcc_platform_profile_set(struct device *=
dev,
>   	}
>
>   	return awcc_thermal_control(priv->wdev,
> -				    priv->supported_thermal_profiles[profile]);
> +				    priv->supported_profiles[profile]);
>   }
>
>   static int awcc_platform_profile_probe(void *drvdata, unsigned long *c=
hoices)
> @@ -643,7 +643,7 @@ static int awcc_platform_profile_probe(void *drvdata=
, unsigned long *choices)
>
>   		mode =3D FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
>   		profile =3D awcc_mode_to_platform_profile[mode];
> -		priv->supported_thermal_profiles[profile] =3D id;
> +		priv->supported_profiles[profile] =3D id;
>
>   		set_bit(profile, choices);
>   	}
> @@ -652,7 +652,7 @@ static int awcc_platform_profile_probe(void *drvdata=
, unsigned long *choices)
>   		return -ENODEV;
>
>   	if (awcc->gmode) {
> -		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =3D
> +		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =3D
>   			AWCC_THERMAL_MODE_GMODE;
>
>   		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);

