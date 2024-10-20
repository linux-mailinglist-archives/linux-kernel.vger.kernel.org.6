Return-Path: <linux-kernel+bounces-373435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E49A569D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A95281663
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE01A198A05;
	Sun, 20 Oct 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WTJDXR2D"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF0197A7A;
	Sun, 20 Oct 2024 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729455178; cv=none; b=LW4pSeU203ynqZtqUJhK1ZNGaMBplFcs6JmCj8KGO3ozO1j90wTcU0EThjAC4y6ZVrFxLi4+PsvSXstlWnuH4N+NqcIgH1KGAJk/bk1nmSrzhfDMsDXE+m+T46yCPt+xKvMFPDHXIYR0+eqba4atg5ghK02GXlkpM9Vk+4TrD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729455178; c=relaxed/simple;
	bh=RVU2HOIU02Y5yMv5d6sfbFeFyS0b6R7akEoXwr1aSJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrdmvB8cqOb3K/Tbn/I1CSto6ba7U919Ni72jOMgqpUav7azz5TdeThd998Ag4YyCHb9wD0u2Wsn14c5S7n6ohtB0pgjGtvxSMDMsly/9Af5s1qHw8lCW8P6/kEwM5jMulJJLE1uqvO1hUUdwCw7TcaeljqclgHArkMoiuyHx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WTJDXR2D; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729455169; x=1730059969; i=w_armin@gmx.de;
	bh=rO2R34p38jWBOFEOamikPTe589HOCCR6d/57IHlEp/g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WTJDXR2D3by1m37G1xTxirqCNbynNSLLS1XqfI0eCjYnEXGpUqzjohH/3rVnsQGh
	 em6XsMTdTkYjMbxgbGP2gN9bdzo9ecfGZXtISldMnesxbN1WZUVxHxitCfBWOI3f/
	 Hd2X/YViyKSMpGNdTNcRBWtnu0+rKpGKJ8ux/EqqIWHG7co/gFFc6fH+RDpgnEimN
	 VOoXEntWt2CIl5xeBkNjixY+BlUKFXXZpuye4mdKK+oxD5idP4wx9ngYP902gxnBC
	 cAmLsW8C7H/bjdZoh1UrOh5JijTBm1YLOTGVwMy/wmckmL2eBigAmT2mIDbULOCAD
	 QcmU6Tu3N0DL0/SrNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1t0ikt2pUR-00F7Nx; Sun, 20
 Oct 2024 22:12:48 +0200
Message-ID: <8f49e3a9-e9ce-44d4-8d9a-4447202f2b61@gmx.de>
Date: Sun, 20 Oct 2024 22:12:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] alienware-wmi: added platform profile support
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241017081211.126214-2-kuurtb@gmail.com>
 <20241017081524.127072-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241017081524.127072-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aZ8h97699QgufzaGSNsjCdccDyvTBo+Lbdj0AIHNBxJXr0nfkSA
 RKseT9yWTFZRC3bJzV4iKOsQf2YlISUzrSSt10pdtn2y+Lo9jsXXFeCmn0ikBL/Px1gye+9
 q1QL9XIZ9E9qSQtpDgjZ+850QrioC4BvbbfZWKvVabKWIx/v9dAxRhk6ZGCaumDfHr2fsCe
 cIFmoFVX3suBYMKTI2eLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XHJ+UhNXxPk=;VF6myVC5GfHceBTvPkqrl7FJgMv
 Mp7MZCnYRVQAYbRbUYKJXFymZ4LxBXA3oEJzhalBfdlUV9y1b5a/0Vip+ZPB1sBZkv4IWQKgA
 1rVAokLP7qHRSEMPq44vBrGqT4CNGg9D30PhhpdkXCwOwzxYRZvFW/dFzvAaKiT53WL7MAfXi
 NEZ2KQdcM5H/SvAk+2/Ga6UTCJNGgqnr2hVufADPChLv4nSjL0kpTPQICuVwgPAnr/hFzDp+G
 hCTGpMEaU2/DR7HFyotfC3EuYVXrVHcE4P3fp6eq+mWBRaqBAijY9w4o6y2hnXfcYFaH440Vc
 qsYcTQGZywLgxkjmOrGXnYRzIVuAnJij9CbwBjKDi4eNDd5vN0eexle8jcDu97Vt+rP+K4/mL
 sRZxO9u8gRvBXGp5/hAl/exqC4Mmq8IXpLAWDKZUFpAo1fTFYKFtgyXBoll94HXlnYTVR1QnG
 dyqvDaTmZMvPClYt+Lp5SPgE0GR+hRtAMke1H2OV28DJd7arPTI7Ep6oiKV0WTmnj3XRrbPxL
 DmnUadzcEgBSb3UWOcBaXcfsU6k+ZMgwVHC/fC5dbyhmU/nvDVJX/UYtyVbRc0mFu8bURhe39
 J6VJckizRnn5bv+mX75hD9U8OBurP7CoVSri4J5fPKSKVBXcuUZp6npEaaeNa5WTwnKxzThCp
 fwlC9L93pJlaOlDFG+LfqwPXPxh3kmgror0JzxJN+il0IHbqXowRECNo35z9Gl1HI4NXWArdi
 pxcCQUrvZw+GCPhYE7E6iUoLAxwppNC0ZMjvTDvFthELQefSwEwHpHlLZU9/DgQ/100RlSbb5
 QiBdi82Dmp10X+6VJp1BDeaA==

Am 17.10.24 um 10:15 schrieb Kurt Borja:

> Implements platform profile support for Dell laptops with new WMAX
> thermal interface, present on some Alienware X-Series, Alienware
> M-Series and Dell's G-Series laptops.
>
> This implementation supports three sets of thermal tables declared in
> enum WMAX_THERMAL_TABLE and gmode, using quirks *thermal* and *gmode*
> respectively. These sets are found in most Dell's devices that support
> WMAX's thermal interface.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> ---
> v6:
>   - Fixed alignment on some function definitions
>   - Fixed braces on if statment
>   - Removed quirk thermal_ustt
>   - Now quirk thermal can take values defined in enum WMAX_THERMAL_TABLE=
.
>   - Proper removal of thermal_profile
> ---
>   drivers/platform/x86/dell/Kconfig         |   1 +
>   drivers/platform/x86/dell/alienware-wmi.c | 251 ++++++++++++++++++++++
>   2 files changed, 252 insertions(+)
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
> index b27f3b64c..37a898273 100644
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
> @@ -49,11 +58,33 @@ enum WMAX_CONTROL_STATES {
>   	WMAX_SUSPEND =3D 3,
>   };
>
> +enum WMAX_THERMAL_TABLE {
> +	WMAX_THERMAL_TABLE_SIMPLE	=3D 1,
> +	WMAX_THERMAL_TABLE_USTT		=3D 2,
> +	WMAX_THERMAL_TABLE_USTT_COOL	=3D 3,
> +};
> +
> +enum WMAX_THERMAL_PROFILE {
> +	WMAX_THERMAL_QUIET			=3D 0x96,
> +	WMAX_THERMAL_BALANCED			=3D 0x97,
> +	WMAX_THERMAL_BALANCED_PERFORMANCE	=3D 0x98,
> +	WMAX_THERMAL_PERFORMANCE		=3D 0x99,
> +	WMAX_THERMAL_USTT_LOW_POWER		=3D 0xA5,
> +	WMAX_THERMAL_USTT_COOL			=3D 0xA2,
> +	WMAX_THERMAL_USTT_QUIET			=3D 0xA3,
> +	WMAX_THERMAL_USTT_BALANCED		=3D 0xA0,
> +	WMAX_THERMAL_USTT_BALANCED_PERFORMANCE	=3D 0xA1,
> +	WMAX_THERMAL_USTT_PERFORMANCE		=3D 0xA4,
> +	WMAX_THERMAL_GMODE			=3D 0xAB,
> +};
> +
>   struct quirk_entry {
>   	u8 num_zones;
>   	u8 hdmi_mux;
>   	u8 amplifier;
>   	u8 deepslp;
> +	u8 thermal;
> +	u8 gmode;
>   };
>
>   static struct quirk_entry *quirks;
> @@ -64,6 +95,8 @@ static struct quirk_entry quirk_inspiron5675 =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_unknown =3D {
> @@ -71,6 +104,8 @@ static struct quirk_entry quirk_unknown =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_x51_r1_r2 =3D {
> @@ -78,6 +113,8 @@ static struct quirk_entry quirk_x51_r1_r2 =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_x51_r3 =3D {
> @@ -85,6 +122,8 @@ static struct quirk_entry quirk_x51_r3 =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 1,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_asm100 =3D {
> @@ -92,6 +131,8 @@ static struct quirk_entry quirk_asm100 =3D {
>   	.hdmi_mux =3D 1,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_asm200 =3D {
> @@ -99,6 +140,8 @@ static struct quirk_entry quirk_asm200 =3D {
>   	.hdmi_mux =3D 1,
>   	.amplifier =3D 0,
>   	.deepslp =3D 1,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_asm201 =3D {
> @@ -106,6 +149,17 @@ static struct quirk_entry quirk_asm201 =3D {
>   	.hdmi_mux =3D 1,
>   	.amplifier =3D 1,
>   	.deepslp =3D 1,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
> +};
> +
> +static struct quirk_entry quirk_x15_r1 =3D {
> +	.num_zones =3D 2,
> +	.hdmi_mux =3D 0,
> +	.amplifier =3D 0,
> +	.deepslp =3D 0,
> +	.thermal =3D WMAX_THERMAL_TABLE_USTT,
> +	.gmode =3D 0,
>   };
>
>   static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -169,6 +223,15 @@ static const struct dmi_system_id alienware_quirks[=
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
> @@ -218,6 +281,7 @@ static struct platform_device *platform_device;
>   static struct device_attribute *zone_dev_attrs;
>   static struct attribute **zone_attrs;
>   static struct platform_zone *zone_data;
> +static struct platform_profile_handler pp_handler;
>
>   static struct platform_driver platform_driver =3D {
>   	.driver =3D {
> @@ -761,6 +825,184 @@ static int create_deepsleep(struct platform_device=
 *dev)
>   	return ret;
>   }
>
> +/*
> + * Thermal Profile control
> + *  - Provides thermal profile control through the Platform Profile API
> + */
> +#define WMAX_ARGUMENT_MASK	GENMASK(15, 8)
> +#define WMAX_PROFILE_ACTIVATE	0x01
> +
> +static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
> +{
> +	return FIELD_PREP(WMAX_ARGUMENT_MASK, prof) | WMAX_PROFILE_ACTIVATE;
> +}
> +
> +static int thermal_profile_get(struct platform_profile_handler *pprof,
> +			       enum platform_profile_option *profile)
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
> +	case WMAX_THERMAL_USTT_COOL:
> +		*profile =3D PLATFORM_PROFILE_COOL;
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
> +			       enum platform_profile_option profile)
> +{
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
> +	case PLATFORM_PROFILE_COOL:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_USTT_COOL);
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
> +	switch (quirks->thermal) {
> +	case WMAX_THERMAL_TABLE_SIMPLE:
> +		pp_handler.profile_set =3D thermal_profile_set;
> +		break;
> +	case WMAX_THERMAL_TABLE_USTT:
> +		pp_handler.profile_set =3D thermal_profile_set_ustt;
> +		set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
> +		set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
> +		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
> +		break;
> +	case WMAX_THERMAL_TABLE_USTT_COOL:
> +		pp_handler.profile_set =3D thermal_profile_set_ustt;
> +		set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
> +		set_bit(PLATFORM_PROFILE_QUIET, pp_handler.choices);
> +		set_bit(PLATFORM_PROFILE_COOL, pp_handler.choices);
> +		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, pp_handler.choices);
> +		break;
> +	}

Please add a default statement here to return -EINVAL just in case.

Other than that:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +
> +	set_bit(PLATFORM_PROFILE_BALANCED, pp_handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
> +
> +	return platform_profile_register(&pp_handler);
> +}
> +
> +static void remove_thermal_profile(void)
> +{
> +	if (quirks->thermal > 0)
> +		platform_profile_remove();
> +}
> +
>   static int __init alienware_wmi_init(void)
>   {
>   	int ret;
> @@ -808,6 +1050,12 @@ static int __init alienware_wmi_init(void)
>   			goto fail_prep_deepsleep;
>   	}
>
> +	if (quirks->thermal > 0) {
> +		ret =3D create_thermal_profile();
> +		if (ret)
> +			goto fail_prep_thermal_profile;
> +	}
> +
>   	ret =3D alienware_zone_init(platform_device);
>   	if (ret)
>   		goto fail_prep_zones;
> @@ -816,6 +1064,8 @@ static int __init alienware_wmi_init(void)
>
>   fail_prep_zones:
>   	alienware_zone_exit(platform_device);
> +	remove_thermal_profile();
> +fail_prep_thermal_profile:
>   fail_prep_deepsleep:
>   fail_prep_amplifier:
>   fail_prep_hdmi:
> @@ -835,6 +1085,7 @@ static void __exit alienware_wmi_exit(void)
>   	if (platform_device) {
>   		alienware_zone_exit(platform_device);
>   		remove_hdmi(platform_device);
> +		remove_thermal_profile();
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}

