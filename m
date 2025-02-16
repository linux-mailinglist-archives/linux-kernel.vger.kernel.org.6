Return-Path: <linux-kernel+bounces-516470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11EA37230
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88C9166232
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 05:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F89149DF0;
	Sun, 16 Feb 2025 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="T83VfHDD"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1158142A92;
	Sun, 16 Feb 2025 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739685568; cv=none; b=AWJKnXkVlceSzF9Fg8qjeH3w5HQcWocjN0oMP5xbu0qT5bF3m9OyrbpXPYZQg1FdyYiRsuFMyX0yE9WgoIuN9rJ4JYtY2pRxRnCXnfYTrhz7GzJv+xpwe/EOoVbQnxiYl7zPK5HsK1b+TiQxROJZnQQOa2ait73aCJXYn8ybRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739685568; c=relaxed/simple;
	bh=ilK6x5CR4ALk9Wb7gc2MyjPT20DmSXHNLNFd2HA99mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mo0rvNsv3nDbiVbqPaQBtLdZIdkK2wCl1cL2EA4biJ+ZphmYlUSIwSVUCbopAQG9PBtc4yyPz/eoB4KiELQfY6NigKRj/TBcjILQIVie+UJ6owHCEsejqdSil9wCF4xBx8eaohnjc+caP5UxZ9t+tmwQj5l/PH6tuFuSO1yggBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=T83VfHDD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739685561; x=1740290361; i=w_armin@gmx.de;
	bh=ZYc1hvWWMY51W7G9kml0y0VyUak8pl9wRHFXAMBpnWI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T83VfHDDrJCdrC4FUp+hjjnxBowuMrp77zWET3zC64WWU4qPKPpc+qiRndaZZvq9
	 ZmSUrdyeFHfluIazS1UEEkwUIpF5/nt7HAzQThj86yCFUUPSFx82TlHLl6nYWERj0
	 +jga1qmdxeSINGeanHZvStcyRpmpDH5pOTGoqxEs/A2ArbdqDvZfTNUPYTqbWF2mu
	 YB8q5P1GIJ9Dy/5e89Homj7vdG8EisDcf05NcEMGq8hipWnOBXpAy/Mp0tJ4CQIp2
	 8FD3siY3+AmuKe3TO/wpMl0hQpDfIH8JYi3XaofwzC2FKiMQLlUmIDvruPqa4CYJu
	 Z77GiIFM/FoOLX6Rvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1tDDjm2rFa-00dlOr; Sun, 16
 Feb 2025 06:59:20 +0100
Message-ID: <2b717fa9-dbb1-4db6-8c4b-1b81b9be9e9e@gmx.de>
Date: Sun, 16 Feb 2025 06:59:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] platform/x86: alienware-wmi-wmax: Add support for
 the "custom" thermal profile
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-7-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250208051614.10644-7-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lqsuONQhZNRd7KECcfFRygwtAXlIu981V4A/13dyoZK60NJ1gXz
 Teqp4umQVTtiphITQuYz4919nO2RHVDTMAdU6ZSZEeCFVXL7QDSO+7HIH9pTFRy2urKDBJ/
 YOa8AMumfHdwLHD6uCRjnmf3odInyd6EQyxKKGGOGcVnpwWrAAvP/4UhQivhxHFE7Z6Gxn3
 HclsHYKF3AJYLSJOhn1ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DdMuG9s1UNo=;v3Z0AGm5SsDGHeVwbamVo73k3Mo
 9+0ENRJOwkd7xOg+/meXeU12MkSxG2N7l6/EV0Gnd5PrhbR6RqRsLlvqD5o84Xg2BSZhCsoiI
 96+nfBjmspuruNIAS1Mg6PtNE4qfGBonsegrD4xENC1AIe50kCxZ9gR0AdwdA9roB6i/H4IQ3
 Q2vRKsfeN7N2wA1a+9uflIHGBF4eELEdHfkWa5oFiLGmuQEuIkTSgJMsD58hBUzqtOVgP7B+s
 +LiNUX2HKJxvrBjjc5Xeg8k+l8xduHsRrQ5SzG5qGqPZfWmwWzpPNtSaiLebZfla7EtkQGTDw
 bpvqBXV4HIOMvM6loAXodLzHwGCDBuW9sUiptrBT8f/uCf8bZMXmeLw7o0SNlOWWIWTYvhlNS
 2h3DMRDVAJpbUtt+G5S6gXZFXMWA3D7E8f+AlgIK5+Zot+IeW6rmlAt4qlYwcskVOBxY4re9g
 luDwGVlJF51B6a6ssRGXxrd34wcwIrdegykAm52OooOPE5n4IdOXGdaR77AB3Z2HbndMDQ0qr
 xATzSsm1a9E2tTCyQHQB/NDPpdiHrlQnMpYT9aEgZJT4CXasBBXgeGOmyjxbnoxmOOvvlt4XQ
 sV09ISN5iYLTQdRecZ5JoBxihV1Xi2RebXy0bmHgPLRDkyQhohPdYnREqF8ZnTQT8sAxMt9Nl
 g1vtNduI08meHgRikOdoBZJHj7LtAFXEsvYsOPEFdWbHrJ7cibNueVjOtpRJD9kXqFD166wyz
 SqZXRgYsK65rOCWH7+umlqKTBhapjigm9yYdErMQ0UsBwjMWgn5Dir62OvsWVu8HI8k2Hh5gN
 AE/jVK/PtKkbbkLskuO06D4yumQZyTUiFpNXK95oYirUqVV9WfKTqIz80ftDL4T6q/8Lu+dFi
 JtHptd+m5h9CCU8VuF1KnPSakjyUp1RsoGGwjT6bkaHoX0tJdbYMUhcAeIE4SIR4SmQbufegB
 hUWjIGVDnrUOBv0sWAa17qEwjWlgamSbP31TtvNV2enw3zJGGGjr+J1NRKl1adHRHR1MmjDlU
 0/I+ROCC4Ph2Vk3ebum9DXM7Y/zX98nAO8q4tG/NQgCqx0OvFfDAvBZcqH55vm4DlxaIbCBEj
 3F0Vg2ZJhbK1ltLM5eVVwGzGOzOfTY7nY9TyBlivAGJTwxucD5CJgppVm5y6Ys9JGCzoIKF2E
 CTSTC1H0gaPIoh1JzWCSiCNNE9YKcqLcq0S4OGMiJ1NLTwgS2DU3EgfFR2ENrUKX/r2Pfp2eZ
 KCy3fi4a8AbvuJZhWw4m2qXEknDSJqi0oQVItewMghMfAGyyeoqUopqhseK9Vmk3YbKRH2dvZ
 /1Ps+S5k91EUbXHD5dXdWo1Hu0JYhlBTD9hB280zsiTu7o6ZDMQIGQJRXjBxm/AxGx2Y40aEb
 cRePgxUGNhhXsdIDCK0j4HJpkSGvllXXXARS30cBGqxZljUH7CrcooYuLP

Am 08.02.25 um 06:16 schrieb Kurt Borja:

> All models with the "AWCC" WMAX device support a "custom" thermal
> profile. In some models this profile signals user-space that the user
> wants to manually control the fans, which are always unlocked. In other
> models it actually unlocks manual fan control.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   .../platform/x86/dell/alienware-wmi-wmax.c    | 23 +++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index e8fe16da036a..0d31156f43bb 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -30,8 +30,6 @@
>   #define AWCC_METHOD_THERMAL_CONTROL		0x15
>   #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
>
> -#define AWCC_THERMAL_MODE_GMODE			0xAB
> -
>   #define AWCC_FAILURE_CODE			0xFFFFFFFF
>   #define AWCC_FAILURE_CODE_2			0xFFFFFFFE
>   #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
> @@ -174,6 +172,11 @@ enum AWCC_THERMAL_TABLES {
>   	AWCC_THERMAL_TABLE_USTT			=3D 0xA,
>   };
>
> +enum AWCC_SPECIAL_THERMAL_CODES {
> +	AWCC_SPECIAL_PROFILE_CUSTOM		=3D 0x00,
> +	AWCC_SPECIAL_PROFILE_GMODE		=3D 0xAB,
> +};
> +
>   enum awcc_thermal_profile {
>   	AWCC_PROFILE_USTT_BALANCED,
>   	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
> @@ -576,9 +579,15 @@ static int awcc_platform_profile_get(struct device =
*dev,
>   	if (ret < 0)
>   		return ret;
>
> -	if (out_data =3D=3D AWCC_THERMAL_MODE_GMODE) {
> +	switch (out_data) {
> +	case AWCC_SPECIAL_PROFILE_CUSTOM:
> +		*profile =3D PLATFORM_PROFILE_CUSTOM;
> +		return 0;
> +	case AWCC_SPECIAL_PROFILE_GMODE:
>   		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>   		return 0;
> +	default:
> +		break;
>   	}
>
>   	if (!is_awcc_thermal_profile_id(out_data))
> @@ -666,9 +675,15 @@ static int awcc_platform_profile_probe(void *drvdat=
a, unsigned long *choices)
>   	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
>   		return -ENODEV;
>
> +	/* Every model supports the "custom" profile */
> +	priv->supported_profiles[PLATFORM_PROFILE_CUSTOM] =3D
> +		AWCC_SPECIAL_PROFILE_CUSTOM;
> +
> +	set_bit(PLATFORM_PROFILE_CUSTOM, choices);
> +
>   	if (awcc->gmode) {
>   		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =3D
> -			AWCC_THERMAL_MODE_GMODE;
> +			AWCC_SPECIAL_PROFILE_GMODE;
>
>   		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   	}

