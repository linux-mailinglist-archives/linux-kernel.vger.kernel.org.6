Return-Path: <linux-kernel+bounces-436138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23559E81B1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F3B281DF6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787715278E;
	Sat,  7 Dec 2024 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="F06/3JcZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2B17E0;
	Sat,  7 Dec 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733597844; cv=none; b=urvb6u1KBerRg2TKqwfg5fHiW1ErFxON8pjs7nbT380946wHULkGMPpbWJQM98UbYnzOkXl92PCrk+eug0OsieBfY2+O0Rk0Qv2SWSoY40sMRxaAm8XAXO3iqxAm+gxf+02+RA9ptsg0vNMRyjAgc2rzUtxflNTXISuN1OASPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733597844; c=relaxed/simple;
	bh=GitAt/Z9tscDna0vww2gfoghg7wyDErWfr7sOL6PRn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fq17pN/Mz+mEyrKjucHQvVu5aq9yZtGAn+6er0ISzMtkKj0lM44EjCqmSPNAP5D5f7Nhy8Hz/wj9DUzorUzrFETw76lc+9dWpjvEesKN28xzJqbglpEIP2UBlbzhILy+DTclbxOspBHlow5D0HsFgOStfoSJ5gPYZ6NDuCNszzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=F06/3JcZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733597831; x=1734202631; i=w_armin@gmx.de;
	bh=exg7f7/YQyhydd4jA5c41yoeX7HhO72FyN/gYhy1v70=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=F06/3JcZbIY59ez8VcYMO0wv673xyGa9Tgddk7iq2nrUyj6AdZn5PhhXBP38rLec
	 u8nFaE+AbeWVrVWhmr1mNcf64Tp2ksnQ1XBw2GhQc+Uh1N/5xSXw42W0ECSb78aiI
	 qVYuhbtuCt/CHi7fMKzRyCZ3ikYDgxx0epKSQ3mOaR2NxEC3vvFvU2hd2Mkgi1/da
	 7suG7Zwp2pE9tAHyVCO971im7A22oE0CvPkuwIRHpctge9FsaQ2BgTOZrFTGyNak+
	 +KE1+2WXW0YNvXV/u49nUCZCdLT/b4/GJcpQLSHEEKW5cEMW4yNq0lbbaCZbKUzGs
	 E2G9jFY7VwJQ8BkDQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY6Cl-1t8G2l3OHN-00OavQ; Sat, 07
 Dec 2024 19:57:10 +0100
Message-ID: <8f41d636-31d0-4880-bf1d-9f2a07d51532@gmx.de>
Date: Sat, 7 Dec 2024 19:57:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] alienware-wmi: Fix X Series and G Series quirks
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
 linux-kernel@vger.kernel.org
References: <20241207053759.99608-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241207053759.99608-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6voFHn/rt2FQLSwav88Hbg5ZBhKNXO+Mb09UZMulypqs3pusTht
 1KgA71an/OScKf49jys5heqwFZQZFydK3t6jjVSIniSH17v3mTeBGXYUmMP7aPUQBuDbUlW
 XvWrpfYvgoWdfcsLxkbMvXK2FAYfq859LSEH5VYF9eDhGOCc9P/0QcngXdfIed/NAEOpwlp
 R9zjcWXOCdXbKx9pGaNAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U9e6MIveaOk=;mmiVZtKq58EyLBJXGkzildlpEts
 9Wn78A7S6A+sJibb78e3bV2dr6wbZCXJuzWLT1wKMowkQMG9y8dHoYQqS2VA4mVp0ykyodd+s
 jReByWYXVtyd1p2WEEHi4Yi3i8+r2o0poh1GHlZAD57YwZ/Id0Ru9Bg4SUWnNDJNIuYrQVjvg
 Cn9lbqw+C11WObwe1795/uTIHlncGS4y0xRSw9T2/MPYfBSFVz4FBhUlaPoi/MziM1xW6Ch4M
 xwaAYJvEQy44Mg8yS8enAYrqj+hfKJafZNsVb9h80R1Rcadh8sp/g2pxWEY1/qPR86rDSZZPe
 Az7w3lbxitFbbh28icdKD/7H3ptShqxbLKOBkIJ2MLsmuXE4mKp2Fl0DlUFEULp/l1ij5ULQV
 G+nXs+fOu5buVhVE5KoZ8xIdiXzTcWpq88B1GUooqSJP5yTDdoNn8kCb1jLfepasNS4V1D9AQ
 Rojg7z18jVKEmi6sLtzlH/sOSAc4K1i9+J2lqnjBy6aHQGJqxYM2+7ZCKMB6UMgRaM00+YjLb
 eVWW/FV9Xdha7CMFHPoZnlxUvv/abXPF+Z6VkGmBK58AnDw0QnyzcRmP+q8SKTG8LhCUy3QcL
 NOWRMeWYBQ0KFE/sigkpuQIZvGwZWEhwaNKTXkjmfZrjX6ElBMQdFlFW0HkWJXZlSUlmGDX2n
 gpO47bHKL58VMmZk1QnV4LuZjCqUFKpytTpolfVtQPTExtLNilToJZBxSB0xIP10M9SSmmSuD
 ULQNLXTnw9DrLyRGHrATU5nUm9lnN105gN6aWMRWIAU304uk+6mXFfMSfGctBugi7ckSU8jpU
 kITrhDOcd0r8m1F+SnYw2Yc3KdbA7MczAaiRj1/ul2sfLuWoUDZ7g4Zn6TIyTDMjzHJH7qJQd
 +I6yv+ieLuA9JL0v6GjsPaHgzKUsut5cKA4IjMJ/hWkHAyNhljFDutnaPrmY+AQveBvekekow
 LR9FJcMzz3dDbIjz7FEUtAW4TgeGBCU1LGbFAV/GD3ABcZ70lvDP79qlzQrfOXmLecWCGEB2X
 IHFSV6RVObSgu8J7rUSjXiExl0NpCJYc9mWT2Y5x+68CaEPOkoEy2Z1ZExGj9jSmDbkSiA972
 bHs/EEztEh3yO65+++Wf80bpLrKioL

Am 07.12.24 um 06:38 schrieb Kurt Borja:

> Devices that are known to support the WMI thermal interface do not
> support the legacy LED control interface. Make `.num_zones =3D 0` and
> avoid calling alienware_zone_init() if that's the case.
>
> Verified by reading the ACPI tables of all supported devices.
>
> Fixes: 9f6c43041552 ("alienware-wmi: added platform profile support")
> Fixes: 1c1eb70e7d23 ("alienware-wmi: extends the list of supported model=
s")
>
> Suggested-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Please remove the empty line after the Fixes tags. With that being address=
ed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> ---
> Suggested here:
>
> [1] https://lore.kernel.org/platform-driver-x86/38399b6a-e31c-4b99-a10e-=
01dc20649c24@gmx.de/
> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index 77465ed9b449..e69bf9a7b6c8 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -190,7 +190,7 @@ static struct quirk_entry quirk_asm201 =3D {
>   };
>
>   static struct quirk_entry quirk_g_series =3D {
> -	.num_zones =3D 2,
> +	.num_zones =3D 0,
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> @@ -199,7 +199,7 @@ static struct quirk_entry quirk_g_series =3D {
>   };
>
>   static struct quirk_entry quirk_x_series =3D {
> -	.num_zones =3D 2,
> +	.num_zones =3D 0,
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> @@ -687,6 +687,9 @@ static void alienware_zone_exit(struct platform_devi=
ce *dev)
>   {
>   	u8 zone;
>
> +	if (!quirks->num_zones)
> +		return;
> +
>   	sysfs_remove_group(&dev->dev.kobj, &zone_attribute_group);
>   	led_classdev_unregister(&global_led);
>   	if (zone_dev_attrs) {
> @@ -1229,9 +1232,11 @@ static int __init alienware_wmi_init(void)
>   			goto fail_prep_thermal_profile;
>   	}
>
> -	ret =3D alienware_zone_init(platform_device);
> -	if (ret)
> -		goto fail_prep_zones;
> +	if (quirks->num_zones > 0) {
> +		ret =3D alienware_zone_init(platform_device);
> +		if (ret)
> +			goto fail_prep_zones;
> +	}
>
>   	return 0;
>

