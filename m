Return-Path: <linux-kernel+bounces-356578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749A2996396
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3492814AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6D18D623;
	Wed,  9 Oct 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BwX0RM8F"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF718C33B;
	Wed,  9 Oct 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463371; cv=none; b=tMS61Id4V6wOq9GmaWmrfnXmuuGqJSoYEHqly4Ci2tZI1UPO2Q1JRkS3/CwF9TQMFD8QT/0ITsnqa24KbLl67bS0wODfxsi+AteGY2VU9MmxDQfTXen1mpppNxah954TyGF7Je9uQrReI34bYIWOqGP05l7xfz8zyGDQ2thObf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463371; c=relaxed/simple;
	bh=WEb0ng1tE+gKSr9kGRpj2WjHc7xVuN2XDQugDlIGkEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gszUZHkUncULP/RjQoKBB17GmOLMVBehaMHGMmsTT2+x75Fq8R/saZgt3528cU5RqM/kgnxp0QstIe+s+ZtJFjXRA7Sac4KS54HgD2H2byAeWhGCo/mDGLVIApdbKoBRS4YzvJjJuoSX4fX33HiLdMhA2AVbNPyyrseGg4hqHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BwX0RM8F; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728463355; x=1729068155; i=w_armin@gmx.de;
	bh=7E83mFwEOOttucaRBgFtgSpnAaBp0voySZVGbeb3uvY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BwX0RM8F8MTL1yt+yMb+MuAbmc/NwqfVwxqLcs32yY2QvhlqdhAii2mlPCJsrzG/
	 h8kXYD1oJ9vtn1ksQonhJF82zv9mOv9DR7+orZVvGN2klPkNIz90K0UUf2TPTA9lD
	 aZJgy+Qbx3FUQnSQHB+MghcuRLYmz8nhjMF+gKmrtB5dndMquD+Kz+/5xUSfjtIhB
	 K2IJ1Dn2wh7voSQLnHI6J7jAJ1xv7FgV7wpyztcNycj97mS/VDJz3KFNb0+Lpxzf+
	 otFBL/yCBC9bn9W4WLcFio1DK6tX6vDTXfdh/iqDm41uH26iRpXhldr3Wd86hvdHe
	 hyvos9TndbULaWBEDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.211.110] ([141.76.189.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1tzGYo3Ru8-017wcv; Wed, 09
 Oct 2024 10:42:34 +0200
Message-ID: <d7ecb190-285a-4229-a8c8-3105b1f31d5d@gmx.de>
Date: Wed, 9 Oct 2024 10:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] alienware-wmi: Dell AWCC platform_profile support
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20241007093324.49631-3-kuurtb@gmail.com>
 <20241008195642.36677-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241008195642.36677-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NR5Ybfz2PLbDkgOuIolgxaSvieN4/7pPVnjrrrAtNFdUdd5OpS/
 VUNciENQrBV7zy5yqwVaGhFgQZ0XX8KQ+f04mdXgsBiPV2OKEj/uwKjijcunMWYhLsjCcmJ
 L4vHyAAqKK8kMVjoJHJpxjiCfBjkODlvRzMyo7cRM2nBHxLkdaivV1wD3iLJ8wvfoeV4bmd
 afEgkRCVkYC6y7YfhWf9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dOESyrr/Ac8=;7PYRe4rvVwcsLUeKnC4pHQBFCiA
 H6YVg6Zv72Wou+HYpsQ/ucINGkBcHviDGRg9z8ryUBopCrCPa1xdAgHiHmpGAg70G0rNcsyro
 PLKlAhG6V8oetluFuy83h4HbrF8Xt0/O6GWfWmHjRozdHfFOGhIJ+9VHFgRNVK4oV1eanmVdg
 rCVJMzekvueL5T/aeoTYafJV+AFoba54rB8/krGIKJBLLR/M2c6Vxo/xz91BtkKxdPyQ0Hh0c
 EmV1bGlIucTmhfMBJ9qW71BnJjPT8nMLZHx8oulUz3Ptohh+qtfD/zA9+SUFK518E5R2grV57
 rZ6BkEZYJMLAHKCJSaXD2hFABrzX6xzfit5/iV9ECQc7LmjxO4wGgGu5Tb5giVjkAOWVltsCj
 3RzW+tuhElZekEObp0zDsEEm31zfQyzsLROJgZEGkgED4+2BBiaTXuBaV7aRCeVueIn5avkcF
 1D6vhvsJNzfu64FplHKQIUE8PDhWqFbW5VLFORTyLIa51uIKVPpUZgsnj7bSOT135r589I7PI
 gZOEiBaHwLU+wT6b4UQuYIeWdCokP7HSywRByOUO9e5WTZjDcklEmRlwE7rienHE6rkdQjYTp
 eI2yQM+QsksUGK5frHc5Q2KgYCqf+OPVtTJuAXmgZwBMEOWLZsKhEAaqrI+IaB6wIhwH0+SWe
 0abY2SA8KXp8YI/+FgbDYC5to5Mg18x+kIhijmyGiupAQtLr19kIKyyGVu6gvTDbZ0Ob8e2Qt
 EIafujFMvvcuskf36/6n1yFok3/nIDM4utyznMYSRjtwzsE1etHrQnQWecSEQatmxMNpztxIR
 mnuVPXDmbdPsoDIaYjfCvOnNYZbetOv+SrS1tKi6FB6NY=

Am 08.10.24 um 21:56 schrieb Kurt Borja:

> This patch adds platform_profile support for Dell devices which implemen=
t
> User Selectable Thermal Tables (USTT) that are meant to be controlled by
> Alienware Command Center (AWCC). These devices may include newer Alienwa=
re
> M-Series, Alienware X-Series and Dell's G-Series. This patch, was tested
> by me on an Alienware x15 R1.
>
> It is suspected that Alienware Command Center manages thermal profiles
> through the WMI interface, specifically through a device with identifier
> \_SB_.AMW1.WMAX. This device was reverse engineered and the relevant
> functionality is documented here [1]. This driver interacts with this
> WMI device and thus is able to mimic AWCC's thermal profiles functionali=
ty
> through the platform_profile API. In consequence the user would be able
> to set and retrieve thermal profiles, which are just fan speed profiles.

Can you write a short piece of documentation at Documentation/wmi/devices/
to describe the Alienware WMI interface? This would be helpful for future =
developers.

> This driver was heavily inspired on inspur_platform_profile, special
> thanks.
>
> Notes:
>   - Performance (FullSpeed) profile is a special profile which has it's =
own
>     entry in the Firmware Settings of the Alienware x15 R1. It also chan=
ges
>     the color of the F1 key. I suspect this behavior would be replicated=
 in
>     other X-Series or M-Series laptops.
>   - G-Mode is a profile documented on [1] which mimics the behavior of
>     FullSpeed mode but it does not have an entry on the Firmware Setting=
s of
>     the Alienware x15 R1, this may correspond to the G-Mode functionalit=
y on
>     G-Series laptops (activated by a special button) but I cannot test i=
t. I
>     did not include this code in the driver as G-Mode causes unexpected
>     behavior on X-Series laptops.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> ---
> v3:
>   - Removed extra empty line
>   - 0x0B named WMAX_ARG_GET_CURRENT_PROF
>   - Removed casts to the same type on functions added in this patch
>   - Thermal profile to WMAX argument is now an static function and makes
>     use of in-built kernel macros
>   - Platform profile is now removed only if it was created first
>   - create_platform_profile is now create_thermal_profile to avoid
>     confusion
>   - profile_get and profile_set functions renamed too to match the above
> v2:
>   - Moved functionality to alienware-wmi driver
>   - Added thermal and gmode quirks to add support based on dmi match
>   - Performance profile is now GMODE for devices that support it
>   - alienware_wmax_command now is insize agnostic to support new thermal
>     methods
> ---
>   drivers/platform/x86/dell/Kconfig         |   1 +
>   drivers/platform/x86/dell/alienware-wmi.c | 238 ++++++++++++++++++++--
>   2 files changed, 226 insertions(+), 13 deletions(-)
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
> index f5ee62ce1..e3ef4b10b 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -10,6 +10,7 @@
>   #include <linux/acpi.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>   #include <linux/dmi.h>
>   #include <linux/leds.h>
>
> @@ -25,6 +26,10 @@
>   #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
>   #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
>   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
> +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
> +#define WMAX_METHOD_THERMAL_CONTROL	0x15
> +
> +#define WMAX_ARG_GET_CURRENT_PROF	0x0B
>
>   MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
>   MODULE_DESCRIPTION("Alienware special feature control");
> @@ -49,11 +54,22 @@ enum WMAX_CONTROL_STATES {
>   	WMAX_SUSPEND =3D 3,
>   };
>
> +enum WMAX_THERMAL_PROFILE {
> +	WMAX_THERMAL_QUIET =3D 0xA3,
> +	WMAX_THERMAL_BALANCED =3D 0xA0,
> +	WMAX_THERMAL_BALANCED_PERFORMANCE =3D 0xA1,
> +	WMAX_THERMAL_PERFORMANCE =3D 0xA4,
> +	WMAX_THERMAL_GMODE =3D 0xAB,
> +	WMAX_THERMAL_LOW_POWER	=3D 0xA5,
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
> @@ -64,6 +80,8 @@ static struct quirk_entry quirk_inspiron5675 =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_unknown =3D {
> @@ -71,6 +89,8 @@ static struct quirk_entry quirk_unknown =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_x51_r1_r2 =3D {
> @@ -78,6 +98,8 @@ static struct quirk_entry quirk_x51_r1_r2 =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_x51_r3 =3D {
> @@ -85,6 +107,8 @@ static struct quirk_entry quirk_x51_r3 =3D {
>   	.hdmi_mux =3D 0,
>   	.amplifier =3D 1,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_asm100 =3D {
> @@ -92,6 +116,8 @@ static struct quirk_entry quirk_asm100 =3D {
>   	.hdmi_mux =3D 1,
>   	.amplifier =3D 0,
>   	.deepslp =3D 0,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_asm200 =3D {
> @@ -99,6 +125,8 @@ static struct quirk_entry quirk_asm200 =3D {
>   	.hdmi_mux =3D 1,
>   	.amplifier =3D 0,
>   	.deepslp =3D 1,
> +	.thermal =3D 0,
> +	.gmode =3D 0,
>   };
>
>   static struct quirk_entry quirk_asm201 =3D {
> @@ -106,6 +134,17 @@ static struct quirk_entry quirk_asm201 =3D {
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
> +	.thermal =3D 1,
> +	.gmode =3D 0,
>   };
>
>   static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -169,6 +208,15 @@ static const struct dmi_system_id alienware_quirks[=
] __initconst =3D {
>   		     },
>   	 .driver_data =3D &quirk_asm201,
>   	 },
> +	 {
> +	 .callback =3D dmi_matched,
> +	 .ident =3D "Alienware x15 R1",
> +	 .matches =3D {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R1")
> +		    },
> +	 .driver_data =3D &quirk_x15_r1,
> +	},
>   	 {
>   	 .callback =3D dmi_matched,
>   	 .ident =3D "Dell Inc. Inspiron 5675",
> @@ -218,6 +266,7 @@ static struct platform_device *platform_device;
>   static struct device_attribute *zone_dev_attrs;
>   static struct attribute **zone_attrs;
>   static struct platform_zone *zone_data;
> +static struct platform_profile_handler pp_handler;
>
>   static struct platform_driver platform_driver =3D {
>   	.driver =3D {
> @@ -500,7 +549,7 @@ static void alienware_zone_exit(struct platform_devi=
ce *dev)
>   	kfree(zone_attrs);
>   }
>
> -static acpi_status alienware_wmax_command(struct wmax_basic_args *in_ar=
gs,
> +static acpi_status alienware_wmax_command(void *in_args, size_t insize,
>   					  u32 command, int *out_data)
>   {

Can you split this change into a separate patch? This would make review a =
bit easier.

>   	acpi_status status;
> @@ -508,7 +557,7 @@ static acpi_status alienware_wmax_command(struct wma=
x_basic_args *in_args,
>   	struct acpi_buffer input;
>   	struct acpi_buffer output;
>
> -	input.length =3D (acpi_size) sizeof(*in_args);
> +	input.length =3D (acpi_size) insize;

Please drop the cast to acpi_size.

>   	input.pointer =3D in_args;
>   	if (out_data) {
>   		output.length =3D ACPI_ALLOCATE_BUFFER;
> @@ -541,8 +590,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
>   		.arg =3D 0,
>   	};
>   	status =3D
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> -				   (u32 *) &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_CABLE, (u32 *) &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -562,8 +611,8 @@ static ssize_t show_hdmi_source(struct device *dev,
>   		.arg =3D 0,
>   	};
>   	status =3D
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> -				   (u32 *) &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_STATUS, (u32 *) &out_data);
>
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 1)
> @@ -589,7 +638,8 @@ static ssize_t toggle_hdmi_source(struct device *dev=
,
>   		args.arg =3D 3;
>   	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
>
> -	status =3D alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL=
);
> +	status =3D alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_HDMI_SOURCE, NULL);
>
>   	if (ACPI_FAILURE(status))
>   		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
> @@ -642,8 +692,8 @@ static ssize_t show_amplifier_status(struct device *=
dev,
>   		.arg =3D 0,
>   	};
>   	status =3D
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> -				   (u32 *) &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_AMPLIFIER_CABLE, (u32 *) &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -694,8 +744,8 @@ static ssize_t show_deepsleep_status(struct device *=
dev,
>   	struct wmax_basic_args in_args =3D {
>   		.arg =3D 0,
>   	};
> -	status =3D alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STA=
TUS,
> -					(u32 *) &out_data);
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_DEEP_SLEEP_STATUS, (u32 *) &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> @@ -723,8 +773,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
>   		args.arg =3D 2;
>   	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, bu=
f);
>
> -	status =3D alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTRO=
L,
> -					NULL);
> +	status =3D alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
>
>   	if (ACPI_FAILURE(status))
>   		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
> @@ -760,6 +810,160 @@ static int create_deepsleep(struct platform_device=
 *dev)
>   	return ret;
>   }
>
> +/*
> + * Thermal Profile control
> + *  - Provides thermal profile control through the Platform Profile API
> + */
> +#define PROFILE_MASK		GENMASK(15,8)
> +#define PROFILE_ACTIVATE	BIT(0)
> +
> +static u32 profile_to_wmax_arg(enum WMAX_THERMAL_PROFILE prof)
> +{
> +	return FIELD_PREP(PROFILE_MASK, prof) | PROFILE_ACTIVATE;
> +}
> +
> +static int thermal_profile_get(struct platform_profile_handler *pprof,
> +				enum platform_profile_option *profile)
> +{
> +	acpi_status status;
> +	u32 in_args =3D WMAX_ARG_GET_CURRENT_PROF;
> +	u32 out_data;
> +
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_INFORMATION, &out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EOPNOTSUPP;

Please return -EIO.

> +
> +	if (out_data =3D=3D 0xFFFFFFFF)
> +		return -EBADRQC;
> +
> +	switch (out_data) {
> +	case WMAX_THERMAL_LOW_POWER:
> +		*profile =3D PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	case WMAX_THERMAL_QUIET:
> +		*profile =3D PLATFORM_PROFILE_QUIET;
> +		break;
> +	case WMAX_THERMAL_BALANCED:
> +		*profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case WMAX_THERMAL_BALANCED_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +		break;
> +	case WMAX_THERMAL_PERFORMANCE:
> +	case WMAX_THERMAL_GMODE:
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
> +	acpi_status status;
> +	u32 in_args;
> +	u32 out_data;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
> +		break;
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
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_PERFORMANCE);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EOPNOTSUPP;

Return -EIO.

> +
> +	if (out_data =3D=3D 0xFFFFFFFF)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int gmode_thermal_profile_set(struct platform_profile_handler *p=
prof,
> +				     enum platform_profile_option profile)
> +{
> +	acpi_status status;
> +	u32 in_args;
> +	u32 out_data;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_LOW_POWER);
> +		break;
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
> +		in_args =3D profile_to_wmax_arg(WMAX_THERMAL_GMODE);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_THERMAL_CONTROL, &out_data);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EOPNOTSUPP;

Return -EIO.

Otherwise the patch looks quite good.

Thanks,
Armin Wolf

> +
> +	if (out_data =3D=3D 0xFFFFFFFF)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int create_thermal_profile(void)
> +{
> +	pp_handler.profile_get =3D thermal_profile_get;
> +
> +	if (quirks->gmode > 0)
> +		pp_handler.profile_set =3D gmode_thermal_profile_set;
> +	else
> +		pp_handler.profile_set =3D thermal_profile_set;
> +
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, pp_handler.choices);
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
> +}
> +
>   static int __init alienware_wmi_init(void)
>   {
>   	int ret;
> @@ -807,6 +1011,12 @@ static int __init alienware_wmi_init(void)
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
> @@ -817,6 +1027,7 @@ static int __init alienware_wmi_init(void)
>   	alienware_zone_exit(platform_device);
>   fail_prep_deepsleep:
>   fail_prep_amplifier:
> +fail_prep_thermal_profile:
>   fail_prep_hdmi:
>   	platform_device_del(platform_device);
>   fail_platform_device2:
> @@ -834,6 +1045,7 @@ static void __exit alienware_wmi_exit(void)
>   	if (platform_device) {
>   		alienware_zone_exit(platform_device);
>   		remove_hdmi(platform_device);
> +		remove_thermal_profile();
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}

