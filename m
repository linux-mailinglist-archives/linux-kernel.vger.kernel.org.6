Return-Path: <linux-kernel+bounces-552078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A136A57520
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688FE3B6969
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8425743D;
	Fri,  7 Mar 2025 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZQWhU34s"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452F18BC36;
	Fri,  7 Mar 2025 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387674; cv=none; b=LLELzzefZraJn8doIr374VCtoy4/jJYGy4KAzA53p7SJRb1kqHBGuVoEu5U7dF5diqvy0KO4RpHywAnwxhXFVk/Um2Qm9zmdakSQ0vMCT/HaH7g22jj8V0P6b0SlPmqhB/OklIz6ydkacKaVPvD3hYaI7wVoI1mehAoOoMOFUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387674; c=relaxed/simple;
	bh=JyEowR5c6RgtzLMvsrhjjNQi+HmXSQYuMaum3U/lUs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPGsujEfIVYztxk/u0hiUeexv2Tn8kBUrMflWaMp3zt4GREExv2u7BnR0q06QwPg8P9WZ0YpMZi2QyWpesxurGG7yNKPzI6p0FulAX/TmMtPD55cGs306bunfHieFMNn3OpHAUxHjXgohq959s1dTTnHIEmx/Q0YHgsrVKHkgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZQWhU34s; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741387655; x=1741992455; i=w_armin@gmx.de;
	bh=5GqonAOJsyz/c/sZmcEwxwQ0iKLXHyD7pgKioGnjYr4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZQWhU34scDIwT+zkGXrILYyYjALINhygYDv3we/2FPRhOu8mY3lQLObY6CLhqXSn
	 MyUzAJV11SBoXzgxKk5rfys1xoS0SZQnAZkKdyx3zsnPgqZHBImIKmUR8I1epmWGA
	 4CpjiowBo1de9G5PDIwkecXnLp7lYSDX6O9vbhn3fpJ0FIKoMnZqDRk091pKWzbxl
	 6aZ/hHAH73UhX1DiT3iKDVNb5KElunFibPa5VA8bxyJY9q/tyTqlv8/goX6fNDSHG
	 1PTSHdJ+wrux1aH4uJuAZfZ+nqxxih5b6ncjAbGjH1lsy+tNsXzHWlGDLm2R/Ty1V
	 jdNDo69OVaTuHGWvTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjjCL-1tNMwm2NI3-00eXK3; Fri, 07
 Mar 2025 23:47:35 +0100
Message-ID: <dd6f0d07-d629-40ce-9009-1a0919d93493@gmx.de>
Date: Fri, 7 Mar 2025 23:47:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] platform/x86: Add Lenovo Gamezone WMI Driver
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Mario Limonciello <superm1@kernel.org>,
 Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>,
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225220037.16073-1-derekjohn.clark@gmail.com>
 <20250225220037.16073-3-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250225220037.16073-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tTdW9PgvIClNqu98cm5sbhrpD0716tAp57+/QxMkPZgh93OFmFV
 N8Ix/mtcSeSIb/hc2TpGMEnLHowq8j/hy4JlvfYfoyOXtzeU80ZGHUScVBKlNkDhrqcifKU
 fovn5EM9VMScI3LvFclZXg1g8ZmaoQDSn5hYe9V3JTPepJUSF71DJgKD8tTIFJ8tAc8BOpD
 EwR/KnjC4o2I+B+NeE1kw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tMibFADHE5s=;usiksvt3r5VdlVco7qd5B6h49qy
 GPZCKf7NDWMgMdUql1/YaTyuTfjDNxIn1FuMUW4ACmA7FuHWjvz538YKFLiosYxTd6n0lcIoz
 F/go6jveEGdZ7cPk2XidzHQeYkfsb+tvBcVofFgos85dV3lGmfXi558poXVW63lA1EAUl2eIz
 ZbPJuk+Tlu5eBadRmjVk4+Olq7XBQrF6kG+Scci627xHr4BUfQdyp3n3WIGBKNrA6oK1HFsNb
 6ERr8m/Gm8bDUwELJ7eCLWaNvmcGksbmuHnf560MwS5JUT/vCsPn5SqKwwVCqFTc21iajGOiE
 Tma/PCpeeg2eKC0FaJcNDssrkv1tErxZOKvomfB8Qk1hnOkZgPaTynvo5ApapLEa247iW3Cmn
 E0GFd3K9MGNmP7MZiWMNslWOpN3VE6sFVoYwZDmPEs6+/liez/c7/qjOBMcAwGVjbSHOVsypF
 Bma0zfvspeAlzBGp1kWxnFbizfHP6jTTg9FkPPoilQ6tEWwHCuwb0e6Tlo4QaUfYKprrsW4Ew
 f1kjOn2Ieg4wMVKDMag1E/43Xlp0ICrlAHKeRa7jRpPKj5wfVJBwKlnDszQgzWBZmrAzkwHVE
 3bI2SEFjTavmF9hY4laW7k8F67r46ZNh8F7BJ1tE5cQZbVPNrNhJoDpELcdLiNNhB/lZyekOQ
 tuHNmsVwFfRCPONJg5Ph/lEqCNerL0iBVzAaUlLQbYvLgOR4P9Gy2oBxvdvH77CX7y533Rxpi
 tfkK0BKvCPlZxZcA6sIQYfp6qWSc4QA8WP493IUFyzsCSC6KtgNmcShE0N1r78+IssTj6k+LO
 wiE9Au648p7WwN5BSTTG5v5d+KW79BUXVaZrY5aMtnWTT91vjXWm8Qj3zjcTjbM2sYU0xFH4o
 HB7lVPZMObcADia0WisMP9p8EzqGUGT58NT7FGzCUfCEmzMjln1hiOrDnCP9vXMhu+gm8dj5t
 ybthddbcy91B4FMsgRo5u6RwGvg7Ef+C9bw/2GCyGkEM9JTjEEoRR8KGEBrxK2es0zldXREG0
 OHCIKxCw6+7YhbmKnGsrCefQLo0mRM2RMloPzqjpqy9RY4jrqflqO9CAaP2XsZ+tQBzj2xgXl
 pYY/BYlVxiy+PUr3BiXJ9w5flBSy9JUvk8SdilpWZvlJUs1xfSs/56bkYMBFkjW30gNj06g1q
 cJKQdubMWoOR24hgTPTWelkNCmZlwxqrPxd/4YSy9iWQcLeTGXUXWySuLRDdrjWdqyoJYvb3J
 eZVkeFOsz5dOHM/IWWghhjybdzg7WLl3Jr79ffYhvvWS1AUEZOAhsU0ZJWuRGwnvVKB8fDRh/
 6miuGFKbXuXui8gcX3Af/lexu5tnmYEstPOqKhmI6Oka9+kr4Ul3Ix3awuyvCXP0rfNnNJPoh
 LVFp+ozUfHylM6rlZfgNU4rXu8PrAlcZwBQltRw5FsxeEAw1WqJbJ9k7BI

Am 25.02.25 um 22:59 schrieb Derek J. Clark:

> Adds lenovo-wmi-gamezone.c which provides a driver for the Lenovo
> Gamezone WMI interface that comes on Lenovo "Gaming Series" hardware.
> Provides ACPI platform profiles over WMI.
>
> Adds lenovo-wmi.h and lenovo-wmi.c which provide helper functions for
> wmidev_evaluate_method as well as prototypes for exported functions.
> v3:
> - Use notifier chain to report platform profile changes to any
>    subscribed drivers.
> - Adds THERMAL_MODE_EVENT GUID and .notify function to trigger notifier
>    chain.
> - Adds support for Extreme Mode profile on supported hardware, as well
>    as a DMI quirk table for some devices that report extreme mode versio=
n
>    support but so not have it fully implemented.
> - Update to include recent changes to platform-profile.
> v2:
> - Use devm_kmalloc to ensure driver can be instanced, remove global
>    reference.
> - Ensure reverse Christmas tree for all variable declarations.
> - Remove extra whitespace.
> - Use guard(mutex) in all mutex instances, global mutex.
> - Use pr_fmt instead of adding the driver name to each pr_err.
> - Remove noisy pr_info usage.
> - Rename gamezone_wmi to lenovo_wmi_gz_priv and gz_wmi to priv.
> - Remove GZ_WMI symbol exporting.
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   MAINTAINERS                                |   3 +
>   drivers/platform/x86/Kconfig               |  16 +
>   drivers/platform/x86/Makefile              |   2 +
>   drivers/platform/x86/lenovo-wmi-gamezone.c | 374 +++++++++++++++++++++
>   drivers/platform/x86/lenovo-wmi.c          |  77 +++++
>   drivers/platform/x86/lenovo-wmi.h          |  62 ++++
>   6 files changed, 534 insertions(+)
>   create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
>   create mode 100644 drivers/platform/x86/lenovo-wmi.c
>   create mode 100644 drivers/platform/x86/lenovo-wmi.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e20c32b3c480..cf7f4fce1a25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13157,6 +13157,9 @@ L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>   F:	Documentation/wmi/devices/lenovo-wmi-other.rst
> +F:	drivers/platform/x86/lenovo-wmi-gamezone.c
> +F:	drivers/platform/x86/lenovo-wmi.c
> +F:	drivers/platform/x86/lenovo-wmi.h
>
>   LETSKETCH HID TABLET DRIVER
>   M:	Hans de Goede <hdegoede@redhat.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 7e20a58861eb..875822e6bd65 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -459,6 +459,22 @@ config IBM_RTL
>   	 state =3D 0 (BIOS SMIs on)
>   	 state =3D 1 (BIOS SMIs off)
>
> +config LENOVO_WMI
> +	tristate
> +	depends on ACPI_WMI

Please rename this module to LENOVO_WMI_HELPERS.

> +
> +config LENOVO_WMI_GAMEZONE
> +	tristate "Lenovo GameZone WMI Driver"
> +	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
> +	select LENOVO_WMI
> +	help
> +	  Say Y here if you have a WMI aware Lenovo Legion device and would li=
ke to use the
> +	  platform-profile firmware interface to manage power usage.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called lenovo-wmi-gamezone.
> +
>   config IDEAPAD_LAPTOP
>   	tristate "Lenovo IdeaPad Laptop Extras"
>   	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index 5f6307246e69..4a7b2d14eb82 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -67,7 +67,9 @@ obj-$(CONFIG_THINKPAD_ACPI)	+=3D thinkpad_acpi.o
>   obj-$(CONFIG_THINKPAD_LMI)	+=3D think-lmi.o
>   obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook.o
>   obj-$(CONFIG_YT2_1380)		+=3D lenovo-yoga-tab2-pro-1380-fastcharger.o
> +obj-$(CONFIG_LENOVO_WMI)	+=3D lenovo-wmi.o
>   obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera.o
> +obj-$(CONFIG_LENOVO_WMI_GAMEZONE)	+=3D lenovo-wmi-gamezone.o
>
>   # Intel
>   obj-y				+=3D intel/
> diff --git a/drivers/platform/x86/lenovo-wmi-gamezone.c b/drivers/platfo=
rm/x86/lenovo-wmi-gamezone.c
> new file mode 100644
> index 000000000000..d5329fecba47
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-gamezone.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Lenovo GameZone WMI interface driver. The GameZone WMI interface pro=
vides
> + * platform profile and fan curve settings for devices that fall under =
the
> + * "Gaming Series" of Lenovo Legion devices.
> + *
> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> + */
> +
> +#include "linux/container_of.h"
> +#include "linux/printk.h"
> +#include <linux/cleanup.h>
> +#include <linux/dev_printk.h>
> +#include <linux/dmi.h>
> +#include <linux/list.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_profile.h>
> +#include <linux/types.h>
> +#include <linux/wmi.h>
> +#include "lenovo-wmi.h"
> +
> +/* Interface GUIDs */
> +#define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
> +#define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
> +
> +/* Method IDs */
> +#define WMI_METHOD_ID_SMARTFAN_SUPP 43 /* IsSupportSmartFan */
> +#define WMI_METHOD_ID_SMARTFAN_SET 44 /* SetSmartFanMode */
> +#define WMI_METHOD_ID_SMARTFAN_GET 45 /* GetSmartFanMode */
> +
> +enum lenovo_wmi_gz_type {
> +	GAMEZONE_FULL =3D 1,
> +	THERMAL_MODE,
> +};
> +
> +#define GAMEZONE_WMI_DEVICE(guid, type)                              \
> +	.guid_string =3D (guid), .context =3D &(enum lenovo_wmi_gz_type) \
> +	{                                                            \
> +		type                                                 \
> +	}
> +
> +static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
> +static DEFINE_MUTEX(gz_chain_mutex);
> +
> +struct lenovo_wmi_gz_priv {
> +	enum platform_profile_option current_profile;

This variable is only assigned and never read, please remove it.

> +	struct wmi_device *wdev;
> +	bool extreme_supported;
> +	struct device *ppdev; /*platform profile device */
> +	enum lenovo_wmi_gz_type type;
> +	struct blocking_notifier_head nhead;
> +};
> +
> +struct quirk_entry {
> +	bool extreme_supported;
> +};
> +
> +static struct quirk_entry quirk_no_extreme_bug =3D {
> +	.extreme_supported =3D false,
> +};

Can you make this const?

> +
> +/* Platform Profile Methods & Setup */
> +static int
> +lenovo_wmi_gz_platform_profile_supported(struct lenovo_wmi_gz_priv *pri=
v,
> +					 int *supported)
> +{
> +	return lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
> +					       WMI_METHOD_ID_SMARTFAN_SUPP, 0, supported);
> +}
> +
> +static int lenovo_wmi_gz_profile_get(struct device *dev,
> +				     enum platform_profile_option *profile)
> +{
> +	struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
> +	int sel_prof;
> +	int ret;
> +
> +	ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
> +					      WMI_METHOD_ID_SMARTFAN_GET, 0, &sel_prof);
> +	if (ret)
> +		return ret;
> +
> +	switch (sel_prof) {
> +	case SMARTFAN_MODE_QUIET:
> +		*profile =3D PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	case SMARTFAN_MODE_BALANCED:
> +		*profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case SMARTFAN_MODE_PERFORMANCE:
> +		if (priv->extreme_supported) {
> +			*profile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +			break;
> +		}
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case SMARTFAN_MODE_EXTREME:
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case SMARTFAN_MODE_CUSTOM:
> +		*profile =3D PLATFORM_PROFILE_CUSTOM;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	priv->current_profile =3D *profile;
> +
> +	ret =3D blocking_notifier_call_chain(&gz_chain_head, THERMAL_MODE_EVEN=
T,
> +					   &sel_prof);

Is it really necessary to call the notifier here? AFAIK the notifier needs=
 to be called
only:

  - when the platform profile was changed either by the user or the firmwa=
re.
  - when a new notifier handler was registered so that the handler does no=
t have to wait for the next user input

Please only call the notifier in those two situations.

> +	if (ret =3D=3D NOTIFY_BAD)
> +		pr_err("Failed to send notification to call chain for WMI event %u\n"=
,
> +		       priv->type);

Use dev_err() here please.

> +	return 0;
> +}
> +
> +static int lenovo_wmi_gz_profile_set(struct device *dev,
> +				     enum platform_profile_option profile)
> +{
> +	struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
> +	int sel_prof;
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		sel_prof =3D SMARTFAN_MODE_QUIET;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		sel_prof =3D SMARTFAN_MODE_BALANCED;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> +		sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		if (priv->extreme_supported) {
> +			sel_prof =3D SMARTFAN_MODE_EXTREME;
> +			break;
> +		}
> +		sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_CUSTOM:
> +		sel_prof =3D SMARTFAN_MODE_CUSTOM;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
> +					      WMI_METHOD_ID_SMARTFAN_SET, sel_prof, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct dmi_system_id fwbug_list[] =3D {
> +	{
> +		.ident =3D "Legion Go 8APU1",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
> +		},
> +		.driver_data =3D &quirk_no_extreme_bug,
> +	},
> +	{
> +		.ident =3D "Legion Go S 8ARP1",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1"),
> +		},
> +		.driver_data =3D &quirk_no_extreme_bug,
> +	},
> +	{
> +		.ident =3D "Legion Go S 8APU1",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1"),
> +		},
> +		.driver_data =3D &quirk_no_extreme_bug,
> +	},
> +	{},
> +
> +};
> +
> +static bool extreme_supported(int profile_support_ver)
> +{
> +	const struct dmi_system_id *dmi_id;
> +	struct quirk_entry *quirks;
> +
> +	if (profile_support_ver < 6)
> +		return false;
> +
> +	dmi_id =3D dmi_first_match(fwbug_list);
> +	if (!dmi_id)
> +		return true;
> +
> +	quirks =3D dmi_id->driver_data;
> +	return quirks->extreme_supported;
> +}
> +
> +static int lenovo_wmi_platform_profile_probe(void *drvdata,
> +					     unsigned long *choices)
> +{
> +	struct lenovo_wmi_gz_priv *priv =3D drvdata;
> +	enum platform_profile_option profile;

Unused variable, please remove.

> +	int profile_support_ver;
> +	int ret;
> +
> +	ret =3D lenovo_wmi_gz_platform_profile_supported(priv,
> +						       &profile_support_ver);
> +	if (ret)
> +		return ret;
> +
> +	if (profile_support_ver < 1)
> +		return -ENODEV;
> +
> +	priv->extreme_supported =3D extreme_supported(profile_support_ver);
> +
> +	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
> +	set_bit(PLATFORM_PROFILE_BALANCED, choices);
> +	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
> +	set_bit(PLATFORM_PROFILE_CUSTOM, choices);
> +
> +	if (priv->extreme_supported)
> +		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
> +
> +	return 0;
> +}
> +
> +static const struct platform_profile_ops lenovo_wmi_gz_platform_profile=
_ops =3D {
> +	.probe =3D lenovo_wmi_platform_profile_probe,
> +	.profile_get =3D lenovo_wmi_gz_profile_get,
> +	.profile_set =3D lenovo_wmi_gz_profile_set,
> +};
> +
> +/* Notifier Methods */
> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb)
> +{
> +	guard(mutex)(&gz_chain_mutex);

The blocking notifier already does the locking itself. Please remove this =
mutex.

> +	return blocking_notifier_chain_register(&gz_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_register_notifier, "GZ_WMI");

Can you name the namespace similar to "LENOVO_GAMEZONE_WMI" please?

> +
> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb)
> +{
> +	guard(mutex)(&gz_chain_mutex);
> +	return blocking_notifier_chain_unregister(&gz_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_unregister_notifier, "GZ_WMI");
> +
> +static void devm_lenovo_wmi_gz_unregister_notifier(void *data)
> +{
> +	struct notifier_block *nb =3D data;
> +
> +	lenovo_wmi_gz_unregister_notifier(nb);
> +}
> +
> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
> +					 struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	ret =3D lenovo_wmi_gz_register_notifier(nb);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_lenovo_wmi_gz_unregister_not=
ifier, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_lenovo_wmi_gz_register_notifier, "GZ_WMI");
> +
> +/* Driver Methods */
> +static void lenovo_wmi_gz_notify(struct wmi_device *wdev,
> +				 union acpi_object *obj)
> +{
> +	struct lenovo_wmi_gz_priv *tm_priv =3D dev_get_drvdata(&wdev->dev);
> +	struct lenovo_wmi_gz_priv *gz_priv =3D
> +		container_of(&gz_chain_head, struct lenovo_wmi_gz_priv, nhead);

I fear that this will not work because gz_chain_head is a global variable,=
 not a field inside
struct lenovo_wmi_gz_priv. Also this would crash the kernel should the mai=
n gamezone driver be
unbound from its WMI device.

I suggest you move the WMI driver for the WMI event into a separate module=
. Then you use another notifier
inside the new module to allow the gamezone driver to listen for events. F=
or example this separate WMI event driver
could use the "val" argument inside blocking_notifier_call_chain() to spec=
ify the type of event (like THERMAL_MODE_CHANGED)
and the "v" argument to pass a pointer to a u32 variable containing the ne=
w thermal mode.

This also allows you to extend the separate WMI driver later to support mo=
re WMI event GUIDs.

> +	int sel_prof;
> +	int ret;
> +
> +	if (obj->type !=3D ACPI_TYPE_INTEGER)
> +		return;
> +
> +	switch (tm_priv->type) {
> +	case THERMAL_MODE:
> +		sel_prof =3D obj->integer.value;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	/* Update primary Gamezone instance */
> +	switch (sel_prof) {
> +	case SMARTFAN_MODE_QUIET:
> +		gz_priv->current_profile =3D PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	case SMARTFAN_MODE_BALANCED:
> +		gz_priv->current_profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case SMARTFAN_MODE_PERFORMANCE:
> +		if (gz_priv->extreme_supported) {
> +			gz_priv->current_profile =3D
> +				PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +			break;
> +		}
> +		gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case SMARTFAN_MODE_EXTREME:
> +		gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case SMARTFAN_MODE_CUSTOM:
> +		gz_priv->current_profile =3D PLATFORM_PROFILE_CUSTOM;
> +		break;
> +	default:
> +		break;
> +	}

Please use platform_profile_notify() to notify userspace of the new platfo=
rm profile settings.

> +
> +	ret =3D blocking_notifier_call_chain(&gz_chain_head, THERMAL_MODE_EVEN=
T,
> +					   &sel_prof);
> +	if (ret =3D=3D NOTIFY_BAD)
> +		pr_err("Failed to send notification to call chain for WMI event %u\n"=
,
> +		       tm_priv->type);
> +}
> +
> +static int lenovo_wmi_gz_probe(struct wmi_device *wdev, const void *con=
text)
> +{
> +	struct lenovo_wmi_gz_priv *priv =3D
> +		devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);

Please do the call to devm_kzalloc() on a separate line:

	struct lenovo_wmi_gz_priv *priv;

	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);

> +
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (!context)
> +		return -EINVAL;
> +
> +	priv->wdev =3D wdev;
> +	priv->type =3D *((enum lenovo_wmi_gz_type *)context);
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	if (priv->type !=3D GAMEZONE_FULL)
> +		return 0;
> +
> +	priv->nhead =3D gz_chain_head;
> +	priv->ppdev =3D platform_profile_register(&wdev->dev, "lenovo-wmi-game=
zone",
> +						priv, &lenovo_wmi_gz_platform_profile_ops);

Please check if platform_profile_register() was successful and return an e=
rror if not.

> +
> +	return 0;
> +}
> +
> +static const struct wmi_device_id lenovo_wmi_gz_id_table[] =3D {
> +	{ GAMEZONE_WMI_DEVICE(LENOVO_GAMEZONE_GUID, GAMEZONE_FULL) },
> +	{ GAMEZONE_WMI_DEVICE(THERMAL_MODE_EVENT_GUID, THERMAL_MODE) },
> +	{}
> +};
> +
> +static struct wmi_driver lenovo_wmi_gz_driver =3D {
> +	.driver =3D {
> +		.name =3D "lenovo_wmi_gamezone",
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table =3D lenovo_wmi_gz_id_table,
> +	.probe =3D lenovo_wmi_gz_probe,
> +	.notify =3D lenovo_wmi_gz_notify,
> +	.no_singleton =3D true,
> +};
> +
> +module_wmi_driver(lenovo_wmi_gz_driver);
> +
> +MODULE_IMPORT_NS("LENOVO_WMI");
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_gz_id_table);
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo-wmi.c b/drivers/platform/x86/le=
novo-wmi.c
> new file mode 100644
> index 000000000000..0de2c37e69bd
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interface =
is
> + * broken up into multiple GUID interfaces that require cross-reference=
s
> + * between GUID's for some functionality. The "Custom Method" interface=
 is a
> + * legacy interface for managing and displaying CPU & GPU power and hwm=
on
> + * settings and readings. The "Other Mode" interface is a modern interf=
ace
> + * that replaces or extends the "Custom Method" interface methods. The
> + * "Gamezone" interface adds advanced features such as fan profiles and
> + * overclocking. The "Lighting" interface adds control of various statu=
s
> + * lights related to different hardware components. "Other Mode" uses
> + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DATA_0=
1
> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
> + *
> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> + *
> + */
> +
> +#include <linux/wmi.h>
> +#include "lenovo-wmi.h"
> +
> +/* wmidev_evaluate_method helper functions */
> +static int lenovo_wmidev_evaluate_method(struct wmi_device *wdev, u8 in=
stance,
> +					 u32 method_id, struct acpi_buffer *in,
> +					 struct acpi_buffer *out)
> +{
> +	acpi_status status;
> +
> +	status =3D wmidev_evaluate_method(wdev, instance, method_id, in, out);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +};
> +
> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instanc=
e,
> +				    u32 method_id, u32 arg0, u32 arg1,
> +				    u32 *retval)
> +{

Please give this method a more descriptive name.

> +	struct wmi_method_args args =3D { arg0, arg1 };
> +	struct acpi_buffer input =3D { (acpi_size)sizeof(args), &args };

Cast to acpi_size is unnecessary here.

> +	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *ret_obj __free(kfree) =3D NULL;
> +	int err;
> +
> +	err =3D lenovo_wmidev_evaluate_method(wdev, instance, method_id, &inpu=
t,
> +					    &output);
> +
> +	if (err)
> +		return err;
> +
> +	if (retval) {
> +		ret_obj =3D (union acpi_object *)output.pointer;
> +		if (!ret_obj)
> +			return -ENODATA;
> +
> +		if (ret_obj->type !=3D ACPI_TYPE_INTEGER)
> +			return -ENXIO;
> +
> +		*retval =3D (u32)ret_obj->integer.value;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_2, "LENOVO_WMI");

Can you please rename the namespace to "LENOVO_WMI_HELPERS"?

> +
> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 instanc=
e,
> +				    u32 method_id, u32 arg0, u32 *retval)
> +{

Same as above.

> +	return lenovo_wmidev_evaluate_method_2(wdev, instance, method_id, arg0=
,
> +					       0, retval);
> +}
> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_1, "LENOVO_WMI");
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo WMI Common Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86/le=
novo-wmi.h
> new file mode 100644
> index 000000000000..113928b4fc0f
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interface =
is
> + * broken up into multiple GUID interfaces that require cross-reference=
s
> + * between GUID's for some functionality. The "Custom Method" interface=
 is a
> + * legacy interface for managing and displaying CPU & GPU power and hwm=
on
> + * settings and readings. The "Other Mode" interface is a modern interf=
ace
> + * that replaces or extends the "Custom Method" interface methods. The
> + * "Gamezone" interface adds advanced features such as fan profiles and
> + * overclocking. The "Lighting" interface adds control of various statu=
s
> + * lights related to different hardware components. "Other Mode" uses
> + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DATA_0=
1
> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
> + *
> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> + *
> + */
> +#include <linux/notifier.h>
> +#include <linux/platform_profile.h>
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

This causes a build error on my machine. Please only use this macro inside=
 source files
for modules and not inside header files.

> +
> +#ifndef _LENOVO_WMI_H_
> +#define _LENOVO_WMI_H_
> +
> +#include <linux/bits.h>
> +#include <linux/types.h>
> +#include <linux/wmi.h>
> +
> +struct wmi_method_args {
> +	u32 arg0;
> +	u32 arg1;
> +};
> +
> +/* gamezone structs */
> +enum thermal_mode {
> +	SMARTFAN_MODE_QUIET =3D 0x01,
> +	SMARTFAN_MODE_BALANCED =3D 0x02,
> +	SMARTFAN_MODE_PERFORMANCE =3D 0x03,
> +	SMARTFAN_MODE_EXTREME =3D 0xE0, /* Ver 6+ */
> +	SMARTFAN_MODE_CUSTOM =3D 0xFF,
> +};
> +
> +enum lenovo_wmi_action {
> +	THERMAL_MODE_EVENT =3D 1,
> +};
> +
> +/* wmidev_evaluate_method helper functions */
> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instanc=
e,
> +				    u32 method_id, u32 arg0, u32 arg1,
> +				    u32 *retval);
> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 instanc=
e,
> +				    u32 method_id, u32 arg0, u32 *retval);
> +
> +/* lenovo_wmi_gz_driver notifier functions */
> +int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned lon=
g action,
> +				enum platform_profile_option *profile);
> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb);
> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb);
> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
> +					 struct notifier_block *nb);

Can you please create a separate header file for each driver? Otherwise th=
is header file
will contain many different things from different drivers, which will mayb=
e not even be
available depending on the Kconfig settings.

Thanks,
Armin Wolf

> +#endif /* !_LENOVO_WMI_H_ */

