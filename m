Return-Path: <linux-kernel+bounces-353293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D15E992BAD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E47FEB25073
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB41E1D31A9;
	Mon,  7 Oct 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="nbxSS7HK"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F081D1F63;
	Mon,  7 Oct 2024 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303911; cv=none; b=DJGZJLflnsfAiAx2nOvyWCLZIaamwm2zEgMrcyhhttVcpz0m7gc3bm1GpQwSWNz65tiKllOcsjZiqZeteSbvZTq1r1hUItaqeg8eV5KuvJSEvbqUjr5d8yky8vCg+fniPqS0d0f5lUyWm4L0/45ldpyascSzuaN4/SPkxYTG4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303911; c=relaxed/simple;
	bh=7iMlEqT0QMz0tNmJynvDYX31i/Ls/xsgK5/LfmWffBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uz/KHM5BY/HTR5hwSpKzVM9U7Yvgfed1587735zg/79wp8M3J17D+JtdlcwKCxJgOsmRfQnQTIEaxLDHvemibKvYFFXqVs56duWQUlc+YYJ6HRbgLbLS6yW1kHkCQMp0/HHKyr6m3jvi1kkku/6cmB/sjGVG3SqphRA6B/VfR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=nbxSS7HK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728303898; x=1728908698; i=w_armin@gmx.de;
	bh=Tg0ZX8vWoR7VIUEI9tZbgk98JYq12799ZkcUM96uN+s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nbxSS7HKxR9FQ8Mgm07HkCXzJdgMwH+DLnrLUX6vJ0bE39EuPImOesQVJyTOnr9u
	 sPA0yUnC1pKcho1YKgs8bDxP3vWpGR3qdlsb4S3cMDRXr0P//4bm88tTux+jljsfk
	 eavy35kMKwRUKpB3SKgVGkuKZRFIZgtpnR5GMfkYxh53w6i3ahBPeZIxM9QBdldc3
	 6Ah0GS3wPHXiVDqrMHp66hllpDE8lT7Of6cXVeQxDXzo5a91wNRBjnAObuBHXmkgz
	 sV+6a8h885toIrhRzZusjbPkA8jyoQW6ZI0MkWPthixclRZsX35qoIQPPzy383vny
	 W6/BIz6whI0ghBo4/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.211.110] ([141.76.189.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1tMSXv41IU-00L9hu; Mon, 07
 Oct 2024 14:24:58 +0200
Message-ID: <771d20f1-ebf3-48d9-98ef-ec79b94c7949@gmx.de>
Date: Mon, 7 Oct 2024 14:24:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Dell AWCC platform_profile support
To: Kurt Borja <kuurtb@gmail.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241007093324.49631-3-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241007093324.49631-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HP0lAUM6piEVLNWVq58Ofa7cDJEbLGw1kCwycDnEtcLmK0HCfqR
 FIpV4ggXnVvnPGu6rucTa458/ehAyrOtITdlFklyaL2+mfdR3g2bgxW45BdR4aSq3Mczqhu
 fDY6ZC9a7hTWVCT1PkJYsuv2Xe1ru0gCUeksJGWCP2JmV1slA3xGhAAbw9hyp3GtVTxmDaE
 VNbAe3oMtXNcYwiWsZoqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eFgPKhOk/JU=;S7B8H22GFLsENgsYcCEDPxylwj+
 orKShZv50X/kafTg5jufAwmfyJ2E/sgavcgHa5i+OM4UjcevNZ7yiceT+rpm6IMQTS5ryRZLT
 6isb3mi55X+AYVyn8HSoSdYyW+w6HCYuXPb8VzqHM/Ln1mMxZ8hOyZvEtS7nfKdTbr/SvLRPs
 4oDhJuyEPNU0hMnwpGJuOPsMXROwc8BnsPsAsw3Ap/QVBol4jGxS/q/n6EBgPe+HghzQ+5Ig/
 jF7wksWDE0aQ71YWUUhfuSobZlucWiBBdsPGwv+zMODUGn7JZYY3TOpxYFatuqgLX6s0FD9E9
 pZhWD6e/TaX9ClWFpyD5CXkw6b1B306Vop7/hlud+Mhyw3zsE8dT4vKHTBn+QBNaF4toSoFcz
 U+5aT0dU+TH+foIJ+j72IS62CBzxRpx76Fvt2hwe5XCABeK8KFqGq6LA461tDX4oKkw0DnFn5
 JzVrs8mGT6eY0ZQArdglllJ7xC/Cxv61Zvo5huqIdTH/pimg+CSPoIaDufSu9MV6NcEyINF5i
 A35yI311Mnwg51yKaRDwZUqUW2JhaBbR4X9D0A+Mla4lFN+fvEi2mda9x3uin6ACx6Q/rN37k
 S/NdtGbztjtifChQxQZN4vv/ZGV5kz5AhoPvJY0ALFky2WOAtIAf39hHlIBSfX6PJA141kfpn
 +//DgOGse3wOn741DP5b8sPQ5DdE64Z1QdJ/NktSRySD7kCOZ0/U3LYEaVT7HASr1N9pUC5eA
 rOumuXq0ULqykLkOMDS7t/xofO+daaZZ4gL3acLNg2VaKYqtzbPuOnvtEnmJ2dRyD1dIS/m/l
 CmTdMmQ0UoXiABssQBx8m3U5tw16cAAYj0m1eKPTk4IIc=

Am 07.10.24 um 11:33 schrieb Kurt Borja:

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
>
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
> Thanks for your time and patiente in advance.
>
> Regards,
>
> Kurt
>
> [1] https://gist.github.com/kuu-rt/b22328ff2b454be505387e2a38c61ee4

Hi,

this WMI device is already handled by the alienware-wmi driver. Could you =
please integrate
this functionality into this driver instead of creating a new one?

Thanks,
Armin Wolf

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/Kconfig         |   9 +
>   drivers/platform/x86/dell/Makefile        |   1 +
>   drivers/platform/x86/dell/dell-wmi-awcc.c | 204 ++++++++++++++++++++++
>   3 files changed, 214 insertions(+)
>   create mode 100644 drivers/platform/x86/dell/dell-wmi-awcc.c
>
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/de=
ll/Kconfig
> index 68a49788a..20300ff98 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -27,6 +27,15 @@ config ALIENWARE_WMI
>   	 zones on Alienware machines that don't contain a dedicated AlienFX
>   	 USB MCU such as the X51 and X51-R2.
>
> +config AWCC_PLATFORM_PROFILE
> +	tristate "AWCC Platform Profile support"
> +	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
> +	help
> +	 This driver provides platform_profile support for selecting thermal
> +	 profiles on Dell devices with User Selectable Thermal Tables,
> +	 controlled by AWCC's WMI interface.
> +
>   config DCDBAS
>   	tristate "Dell Systems Management Base Driver"
>   	default m
> diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/d=
ell/Makefile
> index 79d60f1bf..bfef99580 100644
> --- a/drivers/platform/x86/dell/Makefile
> +++ b/drivers/platform/x86/dell/Makefile
> @@ -23,4 +23,5 @@ obj-$(CONFIG_DELL_WMI_AIO)		+=3D dell-wmi-aio.o
>   obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+=3D dell-wmi-descriptor.o
>   obj-$(CONFIG_DELL_WMI_DDV)		+=3D dell-wmi-ddv.o
>   obj-$(CONFIG_DELL_WMI_LED)		+=3D dell-wmi-led.o
> +obj-$(CONFIG_AWCC_PLATFORM_PROFILE)	+=3D dell-wmi-awcc.o
>   obj-$(CONFIG_DELL_WMI_SYSMAN)		+=3D dell-wmi-sysman/
> diff --git a/drivers/platform/x86/dell/dell-wmi-awcc.c b/drivers/platfor=
m/x86/dell/dell-wmi-awcc.c
> new file mode 100644
> index 000000000..0837d1bc6
> --- /dev/null
> +++ b/drivers/platform/x86/dell/dell-wmi-awcc.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  WMI driver for Dell's AWCC platform_profile
> + *
> + *  Copyright (c) Kurt Borja <kuurtb@gmail.com>
> + *
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/platform_profile.h>
> +#include <linux/wmi.h>
> +
> +#define PROF_TO_ARG(mode) ((mode << 8) | 1)
> +
> +#define DELL_AWCC_GUID "A70591CE-A997-11DA-B012-B622A1EF5492"
> +
> +enum awcc_wmi_method {
> +	AWCC_WMI_THERMAL_INFORMATION =3D 0x14,
> +	AWCC_WMI_THERMAL_CONTROL =3D 0x15,
> +};
> +
> +enum awcc_tmp_profile {
> +	AWCC_TMP_PROFILE_BALANCED =3D 0xA0,
> +	AWCC_TMP_PROFILE_BALANCED_PERFORMANCE =3D 0xA1,
> +	AWCC_TMP_PROFILE_COOL =3D 0xA2,
> +	AWCC_TMP_PROFILE_QUIET =3D 0xA3,
> +	AWCC_TMP_PROFILE_PERFORMANCE =3D 0xA4,
> +	AWCC_TMP_PROFILE_LOW_POWER =3D 0xA5,
> +};
> +
> +struct awcc_wmi_priv {
> +	struct wmi_device *wdev;
> +	struct platform_profile_handler handler;
> +};
> +
> +static int awcc_wmi_query(struct wmi_device *wdev, enum awcc_wmi_method=
 method,
> +			  u32 arg, u32 *res)
> +{
> +	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	const struct acpi_buffer in =3D { sizeof(arg), &arg };
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret =3D 0;
> +
> +	status =3D wmidev_evaluate_method(wdev, 0x0, method, &in, &out);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	obj =3D out.pointer;
> +	if (!obj)
> +		return -ENODATA;
> +
> +	if (obj->type !=3D ACPI_TYPE_INTEGER) {
> +		ret =3D -EINVAL;
> +		goto out_free;
> +	}
> +
> +	if (obj->integer.value <=3D U32_MAX)
> +		*res =3D (u32)obj->integer.value;
> +	else
> +		ret =3D -ERANGE;
> +
> +out_free:
> +	kfree(obj);
> +
> +	return ret;
> +}
> +
> +static int awcc_platform_profile_get(struct platform_profile_handler *p=
prof,
> +				     enum platform_profile_option *profile)
> +{
> +	struct awcc_wmi_priv *priv =3D
> +		container_of(pprof, struct awcc_wmi_priv, handler);
> +
> +	u32 res;
> +	int ret;
> +
> +	ret =3D awcc_wmi_query(priv->wdev, AWCC_WMI_THERMAL_INFORMATION, 0x0B,
> +			     &res);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (res < 0)
> +		return -EBADRQC;
> +
> +	switch (res) {
> +	case AWCC_TMP_PROFILE_LOW_POWER:
> +		*profile =3D PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	case AWCC_TMP_PROFILE_QUIET:
> +		*profile =3D PLATFORM_PROFILE_QUIET;
> +		break;
> +	case AWCC_TMP_PROFILE_BALANCED:
> +		*profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case AWCC_TMP_PROFILE_BALANCED_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +		break;
> +	case AWCC_TMP_PROFILE_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +
> +	return 0;
> +}
> +
> +static int awcc_platform_profile_set(struct platform_profile_handler *p=
prof,
> +				     enum platform_profile_option profile)
> +{
> +	struct awcc_wmi_priv *priv =3D
> +		container_of(pprof, struct awcc_wmi_priv, handler);
> +
> +	u32 arg;
> +	u32 res;
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		arg =3D PROF_TO_ARG(AWCC_TMP_PROFILE_LOW_POWER);
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		arg =3D PROF_TO_ARG(AWCC_TMP_PROFILE_QUIET);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		arg =3D PROF_TO_ARG(AWCC_TMP_PROFILE_BALANCED);
> +		break;
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> +		arg =3D PROF_TO_ARG(AWCC_TMP_PROFILE_BALANCED_PERFORMANCE);
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		arg =3D PROF_TO_ARG(AWCC_TMP_PROFILE_PERFORMANCE);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret =3D awcc_wmi_query(priv->wdev, AWCC_WMI_THERMAL_CONTROL, arg, &res=
);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (res < 0)
> +		return -EBADRQC;
> +
> +	return 0;
> +}
> +
> +static int awcc_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct awcc_wmi_priv *priv;
> +
> +	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->wdev =3D wdev;
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	priv->handler.profile_set =3D awcc_platform_profile_set;
> +	priv->handler.profile_get =3D awcc_platform_profile_get;
> +
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_QUIET, priv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, priv->handler.choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
> +
> +	return platform_profile_register(&priv->handler);
> +}
> +
> +static void awcc_wmi_remove(struct wmi_device *wdev)
> +{
> +	platform_profile_remove();
> +}
> +
> +static const struct wmi_device_id awcc_wmi_id_table[] =3D {
> +	{ .guid_string =3D DELL_AWCC_GUID },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(wmi, awcc_wmi_id_table);
> +
> +static struct wmi_driver awcc_wmi_driver =3D {
> +	.driver =3D {
> +		.name =3D "dell-wmi-awcc-platform-profile",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table =3D awcc_wmi_id_table,
> +	.probe =3D awcc_wmi_probe,
> +	.remove =3D awcc_wmi_remove,
> +	.no_singleton =3D true,
> +};
> +
> +module_wmi_driver(awcc_wmi_driver);
> +
> +MODULE_AUTHOR("Kurt Borja");
> +MODULE_DESCRIPTION("Dell AWCC WMI driver");
> +MODULE_LICENSE("GPL");

