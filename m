Return-Path: <linux-kernel+bounces-373442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7C9A56B2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB111F21C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B626E197A92;
	Sun, 20 Oct 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uUQalniM"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17438EBE;
	Sun, 20 Oct 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729456761; cv=none; b=IkcrCvkbULbQIs232VflukuD1CWGwqRcTCPXZuopS5lNlVSy2Y00G6kW7KLo9B6kTZ6zEUag0FNwx6M7qWl3qSGfouhkC2S/RhLH/WlrpD/NO63T8YQIdKJy8If/3OAX9kQhqxj7xoLXw+ZmthLyNkoD4sJE5b07NMslt/biIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729456761; c=relaxed/simple;
	bh=qDk/uVXxBxhPmM/l7Yd3sEYYKA6N6FdGvkAK0GZ3T6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phq/6BYYzZjnR77d/pZCNlFWUcOX09GrMckHZrWbvqpAT7yG0IjcIUrgGDwYrzEvq42OP/CWUrqQFBbgcvxHv3G/cPoWMZ3wDaFv5m1P4yJNAlTtleDX9E8sA64mwtLBy0zMXqzpINzFpk7WYUBML7C6xucUbKUcHdcL4whM31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uUQalniM; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729456750; x=1730061550; i=w_armin@gmx.de;
	bh=tB0KhQuW6vMiap/q/GmnHpSMa66rSmIrhgNuj+afQiU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uUQalniM7fBA8v8n8ZLAeJU7B5maS0Fm5AWIine5+zShULdTqq/qoOdYDKaSJ/jq
	 sEnLgSKS3xAV3w5mGfug46AAh4LNWolJnrnBWL0lIUlFu7ZYngc64xlwBcUsGWdAB
	 yDLOwNj6FAFeUrS+LolfmoUvJffs/YVgWrrvuGbQgZ8nGRLzSdofkthpwYBPOB/6M
	 MF47V+9nHQVGEhtPEqdH72QR/uXu0PpuUdfaTU42iR9JG1lnRhImm7hW63MIkjcOi
	 28kXQEJNlpeuT8fr0CB6VVjx82KerHl71FTAjFBgos4npoAZ/eur0kX5YVEqyUddP
	 SZIkHOtYTw33Qe3WFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2j2-1tgtCO02Zm-00hoag; Sun, 20
 Oct 2024 22:39:10 +0200
Message-ID: <9d30b2ce-68e4-4080-9068-d1c0b5a59284@gmx.de>
Date: Sun, 20 Oct 2024 22:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] alienware-wmi: added autodetect_thermal_profile
 for devices with quirk_unknown
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241017081211.126214-2-kuurtb@gmail.com>
 <20241017081631.127333-3-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241017081631.127333-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hZSCVxuYGhxq4OKklgL1srPcglkzWg5SAV885tMgKB2yyLabC98
 Yu2aOkYu3+KGNXGGJmrhM5LhGLZz56Mkmy180D3R9ayhiafKvEZg1v57eynIdsn7YQWF8FA
 CztlmYjEqzslPk395o5ympokdGP9Cv3ZAI03oprQxYMDNI4NREmlQkLHGRxeUc5S9BkgRSw
 NuybaWUFJV73ehe21fNDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QwWl+Z9n1qo=;qa6F6rqg8+96COwpTzEMu+LcHWJ
 Kz6y38+AfaltsiH3JHYsQryofEdrBERxAJWE4ATBih7VS26fLJfjMHR4jN+34r71gGnvyucYO
 L6eX+hiMu8wis1vUSD0PMf1Tpg3tPiCHaNT6odjcU247RiWAptLwc15ytkUwV9YZQoITCL3As
 qCIgi1VkyZGEEigq34yDBrnR0e3wYXL70U4k8rjwlpDX7BvsybfRB/gYfagS1/vwZf70h0X0C
 AL0HZ/m7260u63JN4f1Y03lef+0B0U6pFb53MZQb9BI6L9S3AF8BlXL1D5cCcV4BTersOSVmx
 ZHD52viueytORrynoiWPYdABA+ZSAhUkdhupiQwcJP1CMi/IHwQGANdn2H9b22e6d7XlW72LM
 AUAPoHQ6XFpVnushyuiw1ZnmOJW6WCXttPj08wy7NlcZFx/LlznTVQqvV3oTEK9ZlqkfltjsD
 fbpMiIASP/hRIfyD0nNBzcj9iQKvdijGtyB22d1usY7o4rE3Lgi4ueC7ujJoigZSU/fk4wpjN
 NEkj9UEPHIdz70WGjtIzc+Kwh2WRbPxi8paE+nHA75K/4nzc2wwUm1mUqka7lCtj/DYuZio0D
 RG+kbYAB8ndj9fWzwVIz6YQaHAQLxlyAnTIEHKDkKFW45WjX8EbIWIai1jmCBfv9KfDeMGgX6
 Jw7h96us4jsTbnUk1C8zKVv1jPKvIHg/mxxghBGHuoike85YG5wWK5oJvwLVmIHiJWWJZ0wsi
 2D6Afo7nlgo22NZA4ydvfPlC09MFdWb2rW4sjQoY6Vdl+zNSbzTdgaj3iotO9cu79aeAsr24R
 vNb9hhj1JIDfAGpYbu/wt+rK5ZRQvfKg7ymQulNmlFbO4=

Am 17.10.24 um 10:16 schrieb Kurt Borja:

> Added autodetect_thermal_profile for devices with quirk_unknown.
> Autodetection is done through basic conditions most devices with WMAX's
> thermal interface meet. Function exits returning 0 in case of errors.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> ---
> I apologize for the late inclusion. This feature can extend support to
> many devices without having to list them in alienware_quirks.
>
> The conditions for selecting the automatic thermal profile are based on
> observations on a lot of *issues* in AWCC open source alternatives.
>
> I observed only Dell's G-Series laptops have WMAX_THERMAL_BALANCED
> avaliable and when it's present none of the other profiles are
> avaliable, except for GMODE. When a model has USTT profiles avaliable
> usually they have all USTT profiles avaliable, except for cool on mostly
> Alienware devices.
>
> I made another implementation of this function, brute-forcing operation
> 0x03 of Thermal_Information, which is the operation that varies the most
> across models. I found the implementation too cumbersome to include in
> this series, but it could potentially extend support of this driver to
> all posible devices with this interface automatically.

I like this patch, automatic configuration is always a nice feature.

Please add support for operation 0x03, this way the driver can work automa=
tically
without users having to submit patches adding quirks for their machines.

Maybe you can use an array for storing the supported thermal mode ids, lik=
e this:

enum thermal_modes =3D {
	THERMAL_MODE_QUIET,
	...
	THERMAL_MODE_LOW_POWER,
	THERMAL_MODE_MAX
};

const enumplatform_profile_option  thermal_mode_to_platform_profile[THERMA=
L_MODE_MAX] =3D {
	[THERMAL_MODE_QUIET] =3DPLATFORM_PROFILE_QUIET, ...
};

const enumthermal_modes platform_profile_to_thermal_mode[PLATFORM_PROFILE_=
LAST] =3D {
	[PLATFORM_PROFILE_LOW_POWER] =3D THERMAL_MODE_LOW_POWER, ...
};


u8 thermal_modes[THERMAL_MODE_MAX] =3D {};

for (int i =3D 0; i < THERMAL_MODE_MAX; i++) {
	thermal_modes[i] =3D call_operation_3(0x06 + i);
	// TODO: Error handling
	if (thermal_modes[i] =3D=3D 0xFFFFFFFF)
		continue;

	set_bit(supported_profiles, thermal_mode_to_platform_profile[i]);
}

then you can use platform_profile_to_thermal_mode[] when setting the platf=
orm profile
and thermal_mode_to_platform_profile[] when getting the platform profile.
I will leave it up to you on how to handle the existence of GMode.

This of course is only a rough idea, you can change anything you want in t=
he above pseudo-code.

Thanks,
Armin Wolf

>
> Another possibility is just including every device I observed into
> alienware_quirks, which I can do but I want to know your opinion first.
> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 42 +++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index 37a898273..a11ff4851 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -30,8 +30,11 @@
>   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
>   #define WMAX_METHOD_THERMAL_INFORMATION	0x14
>   #define WMAX_METHOD_THERMAL_CONTROL	0x15
> +#define WMAX_METHOD_GMODE_STATUS	0x25
>
> +#define WMAX_ARG_GET_DEFAULT_PROF	0x0A
>   #define WMAX_ARG_GET_CURRENT_PROF	0x0B
> +#define WMAX_ARG_GET_GMODE_STATUS	0x02
>
>   #define WMAX_FAILURE_CODE		0xFFFFFFFF
>
> @@ -968,6 +971,42 @@ static int thermal_profile_set_ustt(struct platform=
_profile_handler *pprof,
>   	return 0;
>   }
>
> +static int autodetect_thermal_profile(void)
> +{
> +	acpi_status status;
> +	u32 in_args;
> +	u32 default_profile;
> +	u32 gmode;
> +
> +	in_args =3D WMAX_ARG_GET_DEFAULT_PROF;
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_INFORMATION, &default_profile);
> +
> +	if (ACPI_FAILURE(status))
> +		return 0;
> +
> +	in_args =3D WMAX_ARG_GET_GMODE_STATUS;
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_GMODE_STATUS, &gmode);
> +
> +	if (ACPI_FAILURE(status))
> +		return 0;
> +
> +	if (default_profile =3D=3D WMAX_THERMAL_BALANCED && gmode =3D=3D 1) {
> +		quirks->thermal =3D WMAX_THERMAL_TABLE_SIMPLE;
> +		quirks->gmode =3D 1;
> +		return 0;
> +	}
> +
> +	if (default_profile =3D=3D WMAX_THERMAL_USTT_BALANCED)
> +		quirks->thermal =3D WMAX_THERMAL_TABLE_USTT;
> +
> +	if (gmode =3D=3D 0 || gmode =3D=3D 1)
> +		quirks->gmode =3D 1;
> +
> +	return 0;
> +}
> +
>   static int create_thermal_profile(void)
>   {
>   	pp_handler.profile_get =3D thermal_profile_get;
> @@ -1050,6 +1089,9 @@ static int __init alienware_wmi_init(void)
>   			goto fail_prep_deepsleep;
>   	}
>
> +	if (interface =3D=3D WMAX && quirks =3D=3D &quirk_unknown)
> +		autodetect_thermal_profile();
> +
>   	if (quirks->thermal > 0) {
>   		ret =3D create_thermal_profile();
>   		if (ret)

