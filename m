Return-Path: <linux-kernel+bounces-426685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAA89DF6A7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7E02817EE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA51D79A3;
	Sun,  1 Dec 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="HU/Tap4W"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0491F94D;
	Sun,  1 Dec 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733074900; cv=none; b=RqmGKyeoVEkUWPsbP5vpwosDXHJDa2Px0D/tN+QMamD2GaLRN6DN3hCfUG/ueOMOiTf/ScTJqZCBJqHg1jjnOIH3AR9/Cam9VeO1FCjHKoXffaXv9XLisL0f5Y0H79QIrJ2DXQPQSjAv5NhxtdQVx9M4iglj7uTCOb4UOuUrkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733074900; c=relaxed/simple;
	bh=oMkRlb7msNrgFRRQHRDAuvenkWWOKN9QFc7Utb/Wby0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPenWu2VOkWiGG52V+ZS+yZIrlZtwBDI1d123NmwfqaMKQtKgPl+6IhIeoQ016rmyL08KweLFKOHON1lJS1tVE9Cwcmnb0beSnwfrdzqVOyaP5e2Fp1HurCim4lspQMdMQXhTSf354w9sC9KXGEgd+Dp4TJW6+QtxXgG+Uh+FRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=HU/Tap4W; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733074888; x=1733679688; i=w_armin@gmx.de;
	bh=Fj5Y17eQDn06kFjLHrN2HV6OZfvOURIsGq4efoqRPR4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HU/Tap4WjdfK/sZAblGeUJPkaftNGgOOUmPOr8GrcAazah5iKGur2QmTndSf5pDu
	 XQt/7sy1akFfiVB7ejc6z7Pg3Ti2+04Vmiz6GLoEBWc80W50zjZXmEjJspgG9pzWw
	 hZOt6Z1IH1YuXIGZb+VtWlevG2xt0KGkz/MwrqH6GD425JlKqju6k4DfPAvq6Wzqj
	 yBHfbfAy86acSEZ3A1NrZsfnjsMERYE5jD4IkpOfeXoqg1LR4GDaNd6ftKBYKSjFa
	 71e+LOxUqEZwThd09/5uWFZCCtCOgFITb/h2+i7pXAurcND0Z4NFEEkKmjysbpJ1/
	 cPSuLUlo8oljlHj3Dg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1tJQFK2fR0-00DjXI; Sun, 01
 Dec 2024 18:41:28 +0100
Message-ID: <eb40d2a6-6313-4ca6-bc09-ad147471813f@gmx.de>
Date: Sun, 1 Dec 2024 18:41:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] platform: x86: tuxi: Implement TUXEDO TUXI ACPI
 TFAN as thermal subsystem
To: Werner Sembach <wse@tuxedocomputers.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241127112141.42920-1-wse@tuxedocomputers.com>
 <20241127112141.42920-2-wse@tuxedocomputers.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241127112141.42920-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mf4PxrpF49nLF4aDJeMv1HnJKjJGZoObs+efvwrz1hbsFWuE+Hy
 M5HFIQLPJ3ztt0T23YTxqCStln/OEskG7FMXB15qIqIPbSTbk2N9nSfV9dMNigjKhv4xXvR
 soP6KIfA29xX0L1pydj8g0v71cK3Zt59wk3QKb3gPR2NBpyfmd7iqPgNVOBK/iMIVI/kj77
 iVhvY7pblwGe9EH0Pnt+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S23X6yYJs2Y=;QvKoxBQM221P8bSfVymqq9Ox7oo
 7OiyGgzl3NTpWNdgJUKJATDQVaPN5LEvU3Qob191GqKmgAyfdPZi8zgCtKaAS7Uo393XWG9Rx
 n/+C+YAPeNXKjHT3m9YCt3eJIDe8DLae7o4IKLiz329/HxAuocK+x23nUdRAd9Pc2M39+jmyc
 TXX4aUbJBUXsmLLLSTolJapsopF9p/yv1OiDSD/J13uBqU1sTkbhoY5xOTsRMbK9ok9DkwNNt
 GT227DSnP/7KbeOOKEFdvmCtieNTRTsu16Zs9ZVPRUdyVG9oTqAGkdTYPf/IgHEZP5tasEiG/
 h6rhdddVYEnqk3n5GDwFHWr6fhMHs/pBS7TWqNHPpwLRNtTxJQMponzB+/+cjvr6YLCALW93/
 hXRqGYaKpTy8VmFZqtIL2H3QnVAp9Xmvoyw6nhACm3EBcKY9LMhZ2PR0estH6isk8mstkYOy3
 Duvre0Q9OnUUN3D9lXkYdR6Lh/2oIodfoQxPzRfgfwq2IwtWSaQ9272WS+zQ8djAmeRDRX2e9
 SzZ+9txA9K7mUvmRH98ff15zVSrbZu4UtmiTDnon+yjeHalbDzOCsQ4/dyoyhNC6tSEJm/ez3
 +aItGXBBCvGVjSnsq/dlQhR7J4Xj7cqUNX9LRklG/8GFZRm0vBrMjDI0yfBDx2XH3FhmpHJIz
 0mH6sA4FopGYpUkfz8+UacXUpfTjbmRbWAzCa//eJruVMaALP1tAf/A6chVpjFymfFiOC99v6
 TS4w+d8yCuqYxkEJaG4D9P3RbFSx9sogiT0j5cDsQDf/m746JoAqLBNwBspzHzwSi6DCKrlaX
 EZJENKqAB0/Eo6JaXF4hgaPHjfcclzOHpBr7rWnUkmsJBikB7IN8biF4AZxPYoRZCUeA0BpSJ
 ZEXnqmKHtPs49U2Wb+IzaUqO/ztLTIam6ymUcqDpr8yyEa1N2nHJ9bVPe8IdplTZBY4b8ZoM2
 mVvaJZhK+DsX1ZVqSCRu5LZXDENhmA1evKEKn/eyWFNXy/ccv790LBd4VdF4wNxFglXEYuFlj
 Iy6e8KQLdxv4uWAWSoFggDOS9QptMAQsD+53sFra9FLkH4NutBFHKyap2GKVg9kKtAU8K2L9l
 8DafpY9zzdWeleB5qmI+qh1FINmESU

Am 27.11.24 um 12:21 schrieb Werner Sembach:

> The TUXEDO Sirius 16 Gen1 & Gen2 have the custom TUXEDO Interface (TUXI)
> ACPI interface which currently consists of the TFAN device. This has ACP=
I
> functions to control the built in fans and monitor fan speeds and CPU an=
d
> GPU temprature.
>
> This driver implements this TFAN device via the thermal subsystem to all=
ow
> userspace controlled, but hardware safe, custom fan curves.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   drivers/platform/x86/Makefile                 |   3 +
>   drivers/platform/x86/tuxedo/Kbuild            |   6 +
>   drivers/platform/x86/tuxedo/nbxx/Kbuild       |   8 +
>   drivers/platform/x86/tuxedo/nbxx/Kconfig      |   9 +
>   drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c  |  96 +++++++
>   drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h  |  84 ++++++
>   .../x86/tuxedo/nbxx/acpi_tuxi_thermal.c       | 241 ++++++++++++++++++
>   .../x86/tuxedo/nbxx/acpi_tuxi_thermal.h       |  14 +
>   8 files changed, 461 insertions(+)
>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.=
c
>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.=
h
>
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index e1b1429470674..1562dcd7ad9a5 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+=3D winmate-fm07-k=
eys.o
>
>   # SEL
>   obj-$(CONFIG_SEL3350_PLATFORM)		+=3D sel3350-platform.o
> +
> +# TUXEDO
> +obj-y					+=3D tuxedo/
> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/t=
uxedo/Kbuild
> new file mode 100644
> index 0000000000000..16396a8923432
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kbuild
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +obj-y	+=3D nbxx/

Hi,

please give this directory a more descriptive name, maybe call it "tuxi"?

> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kbuild b/drivers/platform/=
x86/tuxedo/nbxx/Kbuild
> new file mode 100644
> index 0000000000000..aa4d6d66b785f
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/Kbuild
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +tuxedo_nbxx_acpi_tuxi-y			:=3D acpi_tuxi.o
> +tuxedo_nbxx_acpi_tuxi-y			+=3D acpi_tuxi_thermal.o
> +obj-$(CONFIG_TUXEDO_NBXX_ACPI_TUXI)	+=3D tuxedo_nbxx_acpi_tuxi.o
> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kconfig b/drivers/platform=
/x86/tuxedo/nbxx/Kconfig
> new file mode 100644
> index 0000000000000..93f7f86e803da
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +config TUXEDO_NBXX_ACPI_TUXI
> +	tristate "TUXEDO TUXI"
> +	help
> +	  TUXEDO TUXI driver

Please add any dependencies and a more descriptive help text.

> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c b/drivers/plat=
form/x86/tuxedo/nbxx/acpi_tuxi.c
> new file mode 100644
> index 0000000000000..6031cf731b449
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include "acpi_tuxi_thermal.h"
> +
> +#include "acpi_tuxi.h"
> +
> +static int eval_intparams(acpi_handle handle, acpi_string pathname,
> +			  unsigned long long *params, u32 params_count,
> +			  unsigned long long *retval)
> +{
> +	struct acpi_object_list arguments;
> +	unsigned long long data;
> +	acpi_status status;
> +
> +	pr_debug("Eval %s\n", pathname);
> +
> +	if (params_count > 0) {
> +		pr_debug("Params:\n");
> +
> +		arguments.count =3D params_count;
> +		arguments.pointer =3D kzalloc(
> +			params_count * sizeof(*arguments.pointer), GFP_KERNEL);
> +		for (int i =3D 0; i < params_count; ++i) {
> +			pr_debug("%llu\n", params[i]);
> +
> +			arguments.pointer[i].type =3D ACPI_TYPE_INTEGER;
> +			arguments.pointer[i].integer.value =3D params[i];
> +		}
> +		status =3D acpi_evaluate_integer(handle, pathname, &arguments,
> +					       &data);
> +		kfree(arguments.pointer);
> +	} else {
> +		status =3D acpi_evaluate_integer(handle, pathname, NULL, &data);
> +	}
> +	if (ACPI_FAILURE(status))
> +		return_ACPI_STATUS(status);

This is an internal function of ACPICA, please just return -EIO.

> +
> +	if (retval)
> +		*retval =3D data;
> +
> +	pr_debug("RetVal: %llu\n", *retval);
> +
> +	return 0;
> +}
> +
> +static int add(struct acpi_device *device) {
> +	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
> +	acpi_status status;
> +
> +	driver_data =3D devm_kzalloc(&device->dev, sizeof(*driver_data),
> +				   GFP_KERNEL);
> +	if (!driver_data)
> +		return -ENOMEM;
> +
> +	// Find subdevices
> +	status =3D acpi_get_handle(device->handle, "TFAN",
> +				 &driver_data->tfan_handle);
> +	if (ACPI_FAILURE(status))
> +		return_ACPI_STATUS(status);
> +
> +	driver_data->eval_intparams =3D &eval_intparams;
> +
> +	dev_set_drvdata(&device->dev, driver_data);
> +
> +	return tuxedo_nbxx_acpi_tuxi_thermal_add_devices(device);
> +}
> +
> +static void remove(struct acpi_device *device) {
> +	tuxedo_nbxx_acpi_tuxi_thermal_remove_devices(device);
> +}
> +
> +static const struct acpi_device_id acpi_device_ids[] =3D {
> +	{"TUXI0000", 0},
> +	{"", 0}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_device_ids);
> +
> +static struct acpi_driver acpi_driver =3D {
> +	.name =3D "tuxedo_nbxx_acpi_tuxi",
> +	.ids =3D acpi_device_ids,
> +	.ops =3D {
> +		.add =3D add,
> +		.remove =3D remove,
> +	},
> +};
> +
> +module_acpi_driver(acpi_driver);

Please implement your driver as an platform driver.

> +
> +MODULE_DESCRIPTION("TUXEDO TUXI");
> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h b/drivers/plat=
form/x86/tuxedo/nbxx/acpi_tuxi.h
> new file mode 100644
> index 0000000000000..7ffda8e0dd68a
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#ifndef __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_H__
> +#define __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_H__
> +
> +#include <linux/thermal.h>
> +#include <linux/acpi.h>
> +
> +/*
> + * Set fan speed target
> + *
> + * Set a specific fan speed (needs manual mode)
> + *
> + * Arg0: Fan index
> + * Arg1: Fan speed as a fraction of maximum speed (0-255)
> + */
> +#define TUXI_TFAN_METHOD_SET_FAN_SPEED		"SSPD"
> +
> +/*
> + * Get fan speed target
> + *
> + * Arg0: Fan index
> + * Returns: Current fan speed target a fraction of maximum speed (0-255=
)
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_SPEED		"GSPD"
> +
> +/*
> + * Get fans count
> + *
> + * Returns: Number of individually controllable fans
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_COUNT		"GCNT"
> +
> +/*
> + * Set fans mode
> + *
> + * Arg0: 0 =3D auto, 1 =3D manual
> + */
> +#define TUXI_TFAN_METHOD_SET_FAN_MODE		"SMOD"
> +
> +/*
> + * Get fans mode
> + *
> + * Returns: 0 =3D auto, 1 =3D manual
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_MODE		"GMOD"
> +
> +/*
> + * Get fan type/what the fan is pointed at
> + *
> + * Arg0: Fan index
> + * Returns: 0 =3D general, 1 =3D CPU, 2 =3D GPU
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_TYPE		"GTYP"
> +
> +/*
> + * Get fan temperature/temperature of what the fan is pointed at
> + *
> + * Arg0: Fan index
> + * Returns: Temperature sensor value in 10ths of degrees kelvin
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE	"GTMP"
> +
> +/*
> + * Get actual fan speed in RPM
> + *
> + * Arg0: Fan index
> + * Returns: Speed sensor value in revolutions per minute
> + */
> +#define TUXI_TFAN_METHOD_GET_FAN_RPM		"GRPM"
> +
> +struct tuxedo_nbxx_acpi_tuxi_driver_data_t {
> +	acpi_handle tfan_handle;
> +	int (*eval_intparams)(acpi_handle, acpi_string,
> +				  unsigned long long *, u32,
> +				  unsigned long long *);
> +	struct thermal_zone_device **tzdevs;
> +	size_t tzdevs_count;
> +};

Do you plan for this driver to have multiple backends? If not then
please remove this unnecessary indirection.

> +
> +#endif // __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_H__
> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.c b/driv=
ers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.c
> new file mode 100644
> index 0000000000000..557e3fac15779
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#include <linux/thermal.h>
> +#include <linux/minmax.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/acpi.h>
> +#include "acpi_tuxi.h"
> +
> +#include "acpi_tuxi_thermal.h"
> +
> +static struct thermal_trip tzdtrips[] =3D {
> +	{
> +		.type		=3D THERMAL_TRIP_ACTIVE,
> +		.temperature	=3D 80000,
> +		.hysteresis	=3D 5000,
> +	},
> +	{
> +		.type		=3D THERMAL_TRIP_ACTIVE,
> +		.temperature	=3D 90000,
> +		.hysteresis	=3D 5000,
> +	},
> +	{
> +		.type		=3D THERMAL_TRIP_HOT,
> +		.temperature	=3D 100000,
> +		.hysteresis	=3D 5000,
> +	},
> +	{
> +		.type		=3D THERMAL_TRIP_CRITICAL,
> +		.temperature	=3D 110000,
> +	},
> +};
> +
> +struct tz_devdata_t {
> +	struct acpi_device *parent;
> +	struct thermal_cooling_device *cdev;
> +	size_t index;
> +};
> +
> +static bool should_bind(struct thermal_zone_device *tzdev,
> +			const struct thermal_trip __always_unused *trip,
> +			struct thermal_cooling_device *cdev,
> +			struct cooling_spec __always_unused *cspec)
> +{
> +	return cdev->devdata =3D=3D tzdev;
> +}
> +
> +static int get_temp(struct thermal_zone_device *tzdev, int *temp)
> +{
> +	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
> +	struct tz_devdata_t *tz_devdata;
> +	unsigned long long data;
> +	int ret;
> +
> +	tz_devdata =3D thermal_zone_device_priv(tzdev);
> +	driver_data =3D dev_get_drvdata(&tz_devdata->parent->dev);
> +
> +	unsigned long long params[] =3D { tz_devdata->index };
> +	ret =3D driver_data->eval_intparams(driver_data->tfan_handle,
> +					  TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
> +					  params, ARRAY_SIZE(params), &data);
> +	if (ret)
> +		return ret;
> +
> +	*temp =3D data * 100 - 272000;

Please check if you can use units.h for that.

> +
> +	return 0;
> +}
> +
> +static struct thermal_zone_device_ops tzdops =3D {
> +	.should_bind =3D should_bind,
> +	.get_temp =3D get_temp,
> +};
> +
> +static struct thermal_zone_params tzdparams =3D {
> +	.governor_name =3D "user_space",
> +};
> +
> +static int get_max_state(struct thermal_cooling_device __always_unused =
*cdev,
> +		  unsigned long *state)
> +{
> +	*state =3D 255;
> +
> +	return 0;
> +}
> +
> +static int get_cur_state(struct thermal_cooling_device *cdev,
> +			 unsigned long *state)
> +{
> +	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
> +	struct thermal_zone_device *tzdev;
> +	struct tz_devdata_t *tz_devdata;
> +	unsigned long long data;
> +	int ret;
> +
> +	tzdev =3D cdev->devdata;
> +	tz_devdata =3D thermal_zone_device_priv(tzdev);
> +	driver_data =3D dev_get_drvdata(&tz_devdata->parent->dev);
> +
> +	unsigned long long params[] =3D { tz_devdata->index };
> +	ret =3D driver_data->eval_intparams(driver_data->tfan_handle,
> +					  TUXI_TFAN_METHOD_GET_FAN_SPEED,
> +					  params, ARRAY_SIZE(params), &data);
> +	if (ret)
> +		return ret;
> +
> +	*state =3D data;
> +
> +	return 0;
> +}
> +
> +static int set_cur_state(struct thermal_cooling_device *cdev,
> +			 unsigned long state) {
> +	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
> +	struct thermal_zone_device *tzdev;
> +	struct tz_devdata_t *tz_devdata;
> +	unsigned long long data;
> +	int ret;
> +
> +	tzdev =3D cdev->devdata;
> +	tz_devdata =3D thermal_zone_device_priv(tzdev);
> +	driver_data =3D dev_get_drvdata(&tz_devdata->parent->dev);
> +
> +	unsigned long long params[] =3D { tz_devdata->index, state };

Please check if "state" is greater than 255 and return -EINVAL in such a c=
ase.

> +	ret =3D driver_data->eval_intparams(driver_data->tfan_handle,
> +					  TUXI_TFAN_METHOD_SET_FAN_SPEED,
> +					  params, ARRAY_SIZE(params), &data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct thermal_cooling_device_ops tcdops =3D {
> +	.get_max_state =3D get_max_state,
> +	.get_cur_state =3D get_cur_state,
> +	.set_cur_state =3D set_cur_state,
> +};
> +
> +int tuxedo_nbxx_acpi_tuxi_thermal_add_devices(struct acpi_device *paren=
t)
> +{
> +	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
> +	struct tz_devdata_t *tz_devdata;
> +	struct thermal_zone_device **tzdevs;
> +	unsigned long long data;
> +	size_t tzdevs_count;
> +	char *type;
> +	int ret;
> +
> +	driver_data =3D dev_get_drvdata(&parent->dev);
> +
> +	ret =3D driver_data->eval_intparams(driver_data->tfan_handle,
> +					  TUXI_TFAN_METHOD_GET_FAN_COUNT, NULL,
> +					  0, &data);
> +	if (ret)
> +		return ret;
> +
> +	tzdevs_count =3D data;
> +	tzdevs =3D devm_kzalloc(&parent->dev, tzdevs_count * sizeof(*tzdevs),
> +			      GFP_KERNEL);
> +	if (!tzdevs)
> +			return -ENOMEM;
> +
> +	driver_data->tzdevs =3D tzdevs;
> +	driver_data->tzdevs_count =3D tzdevs_count;
> +
> +	for (size_t i =3D 0; i < tzdevs_count; ++i) {
> +		tz_devdata =3D devm_kzalloc(&parent->dev, sizeof(*tz_devdata),
> +					  GFP_KERNEL);
> +		if (!tz_devdata)
> +			return -ENOMEM;
> +
> +		tz_devdata->parent =3D parent;
> +		tz_devdata->index =3D i;
> +
> +		unsigned long long params[] =3D { i };
> +		ret =3D driver_data->eval_intparams(driver_data->tfan_handle,
> +						  TUXI_TFAN_METHOD_GET_FAN_TYPE,
> +						  params, ARRAY_SIZE(params),
> +						  &data);
> +		if (ret)
> +			return ret;
> +
> +		switch(data) {
> +		case 0:
> +			type =3D "tuxedo_general";
> +			break;
> +		case 1:
> +			type =3D "tuxedo_cpu";
> +			break;
> +		case 2:
> +			type =3D "tuxedo_gpu";
> +			break;
> +		default:
> +			return -EIO;
> +		}
> +
> +		tzdevs[i] =3D thermal_zone_device_register_with_trips(
> +			type, tzdtrips, ARRAY_SIZE(tzdtrips), tz_devdata, &tzdops,
> +			&tzdparams, 1000, 1000);
> +		if (IS_ERR(tzdevs[i]))
> +			return PTR_ERR(tzdevs[i]);
> +
> +		tz_devdata->cdev =3D thermal_cooling_device_register(type,
> +								   tzdevs[i],
> +								   &tcdops);
> +		if (IS_ERR(tz_devdata->cdev))
> +			return PTR_ERR(tz_devdata->cdev);

Where do you clean up those thermal zones and cooling devices should an er=
ror occur? Better use devres for that.

Thanks,
Armin Wolf

> +	}
> +
> +	unsigned long long params[] =3D { 1 };
> +	driver_data->eval_intparams(driver_data->tfan_handle,
> +				    TUXI_TFAN_METHOD_SET_FAN_MODE,
> +				    params, ARRAY_SIZE(params), &data);
> +
> +	return 0;
> +}
> +
> +void tuxedo_nbxx_acpi_tuxi_thermal_remove_devices(struct acpi_device *p=
arent) {
> +	struct tuxedo_nbxx_acpi_tuxi_driver_data_t *driver_data;
> +	struct tz_devdata_t *tz_devdata;
> +	unsigned long long data;
> +
> +	driver_data =3D dev_get_drvdata(&parent->dev);
> +
> +	unsigned long long params[] =3D { 0 };
> +	driver_data->eval_intparams(driver_data->tfan_handle,
> +				    TUXI_TFAN_METHOD_SET_FAN_MODE,
> +				    params, ARRAY_SIZE(params), &data);
> +
> +	for (int i =3D 0; i < driver_data->tzdevs_count; ++i) {
> +		tz_devdata =3D thermal_zone_device_priv(driver_data->tzdevs[i]);
> +
> +		thermal_cooling_device_unregister(tz_devdata->cdev);
> +		thermal_zone_device_unregister(driver_data->tzdevs[i]);
> +	}
> +}
> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.h b/driv=
ers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.h
> new file mode 100644
> index 0000000000000..2193fa6db0ea1
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_thermal.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#ifndef __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_THERMAL_H__
> +#define __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_THERMAL_H__
> +
> +#include <linux/acpi.h>
> +
> +int tuxedo_nbxx_acpi_tuxi_thermal_add_devices(struct acpi_device *paren=
t);
> +void tuxedo_nbxx_acpi_tuxi_thermal_remove_devices(struct acpi_device *p=
arent);
> +
> +#endif // __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_THERMAL_H__

