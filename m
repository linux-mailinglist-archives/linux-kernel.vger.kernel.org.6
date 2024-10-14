Return-Path: <linux-kernel+bounces-364455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E699D4E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74681B24B95
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C274B1B85C0;
	Mon, 14 Oct 2024 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cMlM7Xvx"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B4318035;
	Mon, 14 Oct 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924060; cv=none; b=O0HxWoQp805wyJBY4NGULgZV+fKqmm3vpAw9HbSmOXxL7Fi9In0Zkz8BBtVG4Z9BbbUJKtAweKucyC5os7R+9tiuCGnRAv6GxSpRTm69yDdmAlanhuIAFuEFl+ZwIZIZVQsTrYPuDGw7CwDtA6bFzTcIabwFjyH7s+AIx1AJoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924060; c=relaxed/simple;
	bh=wxKf1Aa5DEvp2yp46uAgDpg3FdUt9hlbQVHbCpjUJ90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnqGR8eQLUHY/cJqZqV4syVDWgnud1Zi+jyHv0H9zFgiaVSxa7Okv5KjV7jZ6xTj9E565f2GVlWxaEdqWQ5i7rhDHoIjoEG/jbB1UWAKmEi4QGLc8eUfa4ik3jh8tmYgqei94Qbz9Xi8g2L+xy5MkHN+pxHRB6dY6+NGgu1CtpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cMlM7Xvx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728924050; x=1729528850; i=w_armin@gmx.de;
	bh=OO0lNQkB8R8mW3dq6Q1+D34SBYiHPk7W2W9mQWwI8zk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cMlM7XvxtX2cjIb1pPkOKFyRYMW+BH0Y55eETF/KSS8A0+mR2jdFeFVZQaZhZs6F
	 fg7rIXzzYBZga/cpi2wIUrZKvY8MVFV11D5txrmIJLKJn9Ub42NgJScJZd0GlWP7f
	 hj8rWBPEGrETbtsaKOvN34Mq5GxQGh4/RVvjgHReFTqfu+sT2lAKg5IcSOEqmd+5p
	 +7xh/G9T0WGm1kTMFenhnvUHNSr5r63DiUBz9w+wU3oyfNRq4boUbQK0Lm6TYlQkK
	 8lcVIJbHdGR1nAte4y+3nPYha1r/X0rvbcSo4tpRklxz7aziwL3pxYBplO8n1Wmz/
	 g3R3hfU4+09A5t4QqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UZG-1t0wM40ubi-005qv0; Mon, 14
 Oct 2024 18:40:50 +0200
Message-ID: <4541ab16-254b-425d-8224-faae4669235e@gmx.de>
Date: Mon, 14 Oct 2024 18:40:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] alienware-wmi: added platform profile support
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241012015849.19036-3-kuurtb@gmail.com>
 <20241012020237.20057-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241012020237.20057-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FU6NsMIwo82/+a2bIgmupPoQp3V/D0q2h3MzW8a//gqHYU0eTKH
 7u6aQ2hjxtGzTkD2ND+RvElo3lA3SPX+KRrUMz3HiSknkcPyI+8Qbeh3e8RAgIvuQ3ceFwQ
 pxlDDVbD3JSu1zKhluXsWkMNyzxoLsz8t3xAChPUlhMNsNteLfq3x8MIWg1aqOvtrmZ9Ehw
 sXjNPGZfxG5rZuEpvSL0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Sk1PS5VhvE=;fxVkzToAxnowYJ4lkMg0iHrjuiB
 RhldIy9e9UCOgprN9fP0a+CKqEJem8yOfAfqtezUNB3q8w10TbPugYZ0gRgbRigWFOIMjkW0T
 2yDUozgpVxOSutoHM+0hie/06wPXuLhqvNwlLfJwofXq94BrTWMrppYAzHUVWibzv76pHWxkm
 8DfeEWVYRoeCKJvxKWh9lcpv5UbHylY8yPDnlpGFyMXkxYbUD5tsm7dPSsBEiQkDB1kKVbW0m
 ma2oEz5iELuQ2+N82UPHExOq/FcYXGbBI78uIHaNSP11OG2mDBkhSQc6a0z5hajew1rEbk+7d
 bNfokEK4bVca5xNySxD/bTFTqHRDz9tLpxP9v91foW8wD0nSI/p5hJUXgXJOqtOIMSgzgpcPg
 BARx4bM1naKpPYr7PTje2XId3ceYSAbjh8tMpGOzGB9eIvWQBIaBhlf8E196MRrjkn5Cq1oMO
 rh+QJAlQjs5FI1vfEaQVxtXF4QfQcFZ5OX0oKXtN5NJeQDI6ndFL1JD4LDeBSqqQlk4a/TXLz
 cforLEvAgFqBvMTWsBbSqOEwZF5PngxZUlHsLOHNu1mvL5ggRaKWqHEkUXkgDr1myUkrmi8SJ
 6QjS/Rus/Owrc7R6MDmnPVngC61QGrcpsuu/GyvzO92Ye2Mq4Y5/ynCwKBIfGzlqe7YL/DMQQ
 1v/9Cjb0Hd45Mz2Yi56TX5G8s7TiT5/tfYxyVn4JifAi5ZASWWlJT9O832UowlHBn6bOF4k+3
 NN+HzBezmeG+s0nxhuHmVLoNBHg3RJf0a58LbY9KAbzBDkD3xpL5EQwWF1CkZU8bc//OrPptf
 KM7tjonrWeCFMdKVKNOyj7f4QSFW7R7Ye0g4rdXK71gJo=

Am 12.10.24 um 04:02 schrieb Kurt Borja:

> Implements platform profile support for Dell laptops with new WMAX
> thermal interface, present on some Alienware X-Series, Alienware
> M-Series and Dell's G-Series laptops. This implementation supports two
> sets of thermal profile codes, namely *thermal* and *thermal_ustt*, plus
> additional quirk *gmode* for Dell's G-Series laptops.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/Kconfig         |   1 +
>   drivers/platform/x86/dell/alienware-wmi.c | 236 ++++++++++++++++++++++
>   2 files changed, 237 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
> index 68a49788a..b06d634cd 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -21,6 +21,7 @@ config ALIENWARE_WMI
>   	depends on LEDS_CLASS
>   	depends on NEW_LEDS
>   	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
>   	help
>   	 This is a driver for controlling Alienware BIOS driven
>   	 features.  It exposes an interface for controlling the AlienFX
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index b27f3b64c..6e30e9376 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -8,8 +8,11 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>   #include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>   #include <linux/dmi.h>
>   #include <linux/leds.h>
>
> @@ -25,6 +28,12 @@
>   #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
>   #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
>   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> +
> +#define WMAX_ARG_GET_CURRENT_PROF	0x0B
> +
> +#define WMAX_FAILURE_CODE		0xFFFFFFFF
>
>   MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
>   MODULE_DESCRIPTION("Alienware special feature control");
> @@ -49,11 +58,27 @@ enum WMAX_CONTROL_STATES {
>   	WMAX_SUSPEND =3D 3,
>   };
>
> +enum WMAX_THERMAL_PROFILE {
> +	WMAX_THERMAL_QUIET =3D 0x96,
> +	WMAX_THERMAL_BALANCED =3D 0x97,
> +	WMAX_THERMAL_BALANCED_PERFORMANCE =3D 0x98,
> +	WMAX_THERMAL_PERFORMANCE =3D 0x99,
> +	WMAX_THERMAL_USTT_LOW_POWER =3D 0xA5,
> +	WMAX_THERMAL_USTT_QUIET =3D 0xA3,
> +	WMAX_THERMAL_USTT_BALANCED =3D 0xA0,
> +	WMAX_THERMAL_USTT_BALANCED_PERFORMANCE =3D 0xA1,
> +	WMAX_THERMAL_USTT_PERFORMANCE =3D 0xA4,
> +	WMAX_THERMAL_GMODE =3D 0xAB,
> +};
> +
>   struct quirk_entry {
>   	u8 num_zones;
>   	u8 hdmi_mux;
>   	u8 amplifier;
>   	u8 deepslp;
> +	u8 thermal;
> +	u8 thermal_ustt;
> +	u8 gmode;
>   };
>
>   static struct quirk_entry *quirks;
> @@ -64,6 +89,9 @@ static struct quirk_entry quirk_inspiron5675 =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.thermal_ustt =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_unknown =3D {
> @@ -71,6 +99,9 @@ static struct quirk_entry quirk_unknown =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.thermal_ustt =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_x51_r1_r2 =3D {
> @@ -78,6 +109,9 @@ static struct quirk_entry quirk_x51_r1_r2 =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.thermal_ustt =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_x51_r3 =3D {
> @@ -85,6 +119,9 @@ static struct quirk_entry quirk_x51_r3 =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 1,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.thermal_ustt =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_asm100 =3D {
> @@ -92,6 +129,9 @@ static struct quirk_entry quirk_asm100 =3D {
>   	.hdmi_mux =3D 1,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.thermal_ustt =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_asm200 =3D {
> @@ -99,6 +139,9 @@ static struct quirk_entry quirk_asm200 =3D {
>   	.hdmi_mux =3D 1,
>   	.amplifier =3D 0,
>   	.deepslp =3D 1,
> +	.thermal =3D 0,
> +	.thermal_ustt =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_asm201 =3D {
> @@ -106,6 +149,19 @@ static struct quirk_entry quirk_asm201 =3D {
>   	.hdmi_mux =3D 1,
>   	.amplifier =3D 1,
>   	.deepslp =3D 1,
> +	.thermal =3D 0,
> +	.thermal_ustt =3D 0,
> +	.gmode =3D 0,
> +};
> +
> +static struct quirk_entry quirk_x15_r1 =3D {
> +	.num_zones =3D 2,
> +	.hdmi_mux =3D 0,
> +	.amplifier =3D 0,
> +	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.thermal_ustt =3D 1,
> +	.gmode =3D 0,
>   };
>
>   static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -169,6 +225,15 @@ static const struct dmi_system_id alienware_quirks[=
] __initconst =3D {
>   		},
>   		.driver_data =3D &quirk_asm201,
>   	},
> +	{
> +		.callback =3D dmi_matched,
> +		.ident =3D "Alienware x15 R1",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1")
> +		},
> +		.driver_data =3D &quirk_x15_r1,
> +	},
>   	{
>   		.callback =3D dmi_matched,
>   		.ident =3D "Dell Inc. Inspiron 5675",
> @@ -218,6 +283,7 @@ static struct platform_device *platform_device;
>   static struct device_attribute *zone_dev_attrs;
>   static struct attribute **zone_attrs;
>   static struct platform_zone *zone_data;
> +static struct platform_profile_handler pp_handler;
>
>   static struct platform_driver platform_driver =3D {
>   	.driver =3D {
> @@ -761,6 +827,168 @@ static int create_deepsleep(struct platform_device=
 *dev)
>   	return ret;
>   }
>
> +/*
> + * Thermal Profile control
> + *  - Provides thermal profile control through the Platform Profile API
> + */
> +#define WMAX_PROFILE_MASK	GENMASK(15, 8)
> +#define WMAX_PROFILE_ACTIVATE	BIT(0)
> +
> +static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
> +{
> +	return FIELD_PREP(WMAX_PROFILE_MASK, prof) | WMAX_PROFILE_ACTIVATE;
> +}
> +
> +static int thermal_profile_get(struct platform_profile_handler *pprof,
> +				enum platform_profile_option *profile)

Alignment should match open parenthesis.

> +{
> +	acpi_status status;
> +	u32 in_args =3D WMAX_ARG_GET_CURRENT_PROF;
> +	u32 out_data;
> +
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_INFORMATION, &out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (out_data =3D=3D WMAX_FAILURE_CODE)
> +		return -EBADRQC;
> +
> +	switch (out_data) {
> +	case WMAX_THERMAL_USTT_LOW_POWER:
> +		*profile =3D PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	case WMAX_THERMAL_QUIET:
> +	case WMAX_THERMAL_USTT_QUIET:
> +		*profile =3D PLATFORM_PROFILE_QUIET;
> +		break;
> +	case WMAX_THERMAL_BALANCED:
> +	case WMAX_THERMAL_USTT_BALANCED:
> +		*profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case WMAX_THERMAL_BALANCED_PERFORMANCE:
> +	case WMAX_THERMAL_USTT_BALANCED_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +		break;
> +	case WMAX_THERMAL_GMODE:
> +	case WMAX_THERMAL_PERFORMANCE:
> +	case WMAX_THERMAL_USTT_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	return 0;
> +}
> +
> +static int thermal_profile_set(struct platform_profile_handler *pprof,
> +				enum platform_profile_option profile)
> +{

Alignment should match open parenthesis.

> +	acpi_status status;
> +	u32 in_args;
> +	u32 out_data;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_QUIET:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_QUIET);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_BALANCED);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_BALANCED_PERFORMANCE);
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		if (quirks->gmode > 0)
> +			in_args =3D profile_to_wmax_arg(WMAX_THERMAL_GMODE);
> +		else
> +			in_args =3D profile_to_wmax_arg(WMAX_THERMAL_PERFORMANCE);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (out_data =3D=3D WMAX_FAILURE_CODE)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int thermal_profile_set_ustt(struct platform_profile_handler *pp=
rof,
> +				    enum platform_profile_option profile)
> +{
> +	acpi_status status;
> +	u32 in_args;
> +	u32 out_data;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_USTT_LOW_POWER);
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_USTT_QUIET);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_USTT_BALANCED);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_USTT_BALANCED_PERFORMANC=
E);
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		if (quirks->gmode > 0)
> +			in_args =3D profile_to_wmax_arg(WMAX_THERMAL_GMODE);
> +		else
> +			in_args =3D profile_to_wmax_arg(WMAX_THERMAL_USTT_PERFORMANCE);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (out_data =3D=3D WMAX_FAILURE_CODE)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int create_thermal_profile(void)
> +{
> +	pp_handler.profile_get =3D thermal_profile_get;
> +
> +	if (quirks->thermal > 0)
> +		pp_handler.profile_set =3D thermal_profile_set;

Braces {} should be used on all arms of this statement.

> +	else {
> +		pp_handler.profile_set =3D thermal_profile_set_ustt;
> +		set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
> +	}
> +
> +	set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, pp_handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +
> +	return platform_profile_register(&pp_handler);
> +}
> +
> +static void remove_thermal_profile(void)
> +{
> +	if (quirks->thermal > 0)
> +		platform_profile_remove();

platform_profile_remove() should also be called when quirks->thermal_ustt =
is set.

> +}
> +
>   static int __init alienware_wmi_init(void)
>   {
>   	int ret;
> @@ -808,6 +1036,12 @@ static int __init alienware_wmi_init(void)
>   			goto fail_prep_deepsleep;
>   	}
>
> +	if (quirks->thermal > 0 || quirks->thermal_ustt > 0) {
> +		ret =3D create_thermal_profile();
> +		if (ret)
> +			goto fail_prep_thermal_profile;
> +	}
> +
>   	ret =3D alienware_zone_init(platform_device);
>   	if (ret)
>   		goto fail_prep_zones;
> @@ -818,6 +1052,7 @@ static int __init alienware_wmi_init(void)
>   	alienware_zone_exit(platform_device);
>   fail_prep_deepsleep:
>   fail_prep_amplifier:
> +fail_prep_thermal_profile:

fail_prep_thermal_profile should come before fail_prep_deepsleep for prope=
r rollback in case of an error.
Also fail_prep_zones should call remove_thermal_profile().

>   fail_prep_hdmi:
>   	platform_device_del(platform_device);
>   fail_platform_device2:
> @@ -835,6 +1070,7 @@ static void __exit alienware_wmi_exit(void)
>   	if (platform_device) {
>   		alienware_zone_exit(platform_device);
>   		remove_hdmi(platform_device);
> +		remove_thermal_profile();

Please move remove_thermal_profile() above remove_hdmi().

Otherwise, the patch look good.

Thanks,
Armin Wolf

>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}

