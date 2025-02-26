Return-Path: <linux-kernel+bounces-533121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97668A455D7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB543ADE69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4654419CD17;
	Wed, 26 Feb 2025 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMMPUrAG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8F26770A;
	Wed, 26 Feb 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552112; cv=none; b=WhiK1BPv15vrbq/QbFLW3KtP2bC8z56W0fvrFathycyOVDBfKBv0BXwdHHeJDcYxgAE28TROQZf5XGBbg3m+NIzbxYNGlGDvSO336Er46JN+KIecBuz6SPAgxEv/pj7VDUiw15V5SKSH1hC4+D6eIb8x/wRaqthRYVdi9Ditet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552112; c=relaxed/simple;
	bh=AMLwzFjCoY9I+wsJ+RWS++BJC+9bde0YSJMhOIPReog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXFmK0BVd3EZRC07N4BSdQbTXwTKhDxNG8Tr6L2rtV/SuuiDWFD6yMPiKUZKSgtwuLi7zMLfmGkAc5Rr5Y1pKl37Jq8Lcd2ZDsH1k68b2+iHuN+A/WPkRE1fxxngL6Kb+b4lHlyMmxQBiVc0G39cc1MezQCWP2LCNjKXjim87Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMMPUrAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688A2C4CED6;
	Wed, 26 Feb 2025 06:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740552111;
	bh=AMLwzFjCoY9I+wsJ+RWS++BJC+9bde0YSJMhOIPReog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EMMPUrAGPDrBuuVxo6Ssu729zLnEQ7tS/Wuyj5ME2XvBWcvyp+4vnrAGWFub+o0KX
	 jSkP/io1FT5gjbhip38EoL+XY8uYVeu107MTEWNGClP9GKd4c6SWGNpC+WQHjlM/0H
	 6k9qbCFqKM0wPBCmdhz/Xzh4zgKe3Fd1iRNvADKE9ruiqrEbNVNRaRPibJ+antFjjr
	 1xFGkOYdxx1z1rXL59uP9KWX6niHTx1NW4tdrlsbgFO9u3d9pN/+JJa8somGfMbaIc
	 egqhZmaYYqQHyR7QzI2WNp075foGDQ5gh5djkApTIOqQYITYkvqFamlRZ2fHfvi3K5
	 cxAcKog7TdvtA==
Message-ID: <ea4a8b87-e3d7-4550-bf18-ee21ed621276@kernel.org>
Date: Tue, 25 Feb 2025 22:41:51 -0800
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
Cc: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
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
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250225220037.16073-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/2025 13:59, Derek J. Clark wrote:
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
>    as a DMI quirk table for some devices that report extreme mode version
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
>   	 state = 0 (BIOS SMIs on)
>   	 state = 1 (BIOS SMIs off)
>   
> +config LENOVO_WMI
> +	tristate
> +	depends on ACPI_WMI
> +
> +config LENOVO_WMI_GAMEZONE
> +	tristate "Lenovo GameZone WMI Driver"
> +	depends on ACPI_WMI
> +	select ACPI_PLATFORM_PROFILE
> +	select LENOVO_WMI
> +	help
> +	  Say Y here if you have a WMI aware Lenovo Legion device and would like to use the
> +	  platform-profile firmware interface to manage power usage.

Power limits; not usage right?

> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called lenovo-wmi-gamezone.
> +
>   config IDEAPAD_LAPTOP
>   	tristate "Lenovo IdeaPad Laptop Extras"
>   	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 5f6307246e69..4a7b2d14eb82 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -67,7 +67,9 @@ obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>   obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>   obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>   obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
> +obj-$(CONFIG_LENOVO_WMI)	+= lenovo-wmi.o
>   obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
> +obj-$(CONFIG_LENOVO_WMI_GAMEZONE)	+= lenovo-wmi-gamezone.o
>   
>   # Intel
>   obj-y				+= intel/
> diff --git a/drivers/platform/x86/lenovo-wmi-gamezone.c b/drivers/platform/x86/lenovo-wmi-gamezone.c
> new file mode 100644
> index 000000000000..d5329fecba47
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-gamezone.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Lenovo GameZone WMI interface driver. The GameZone WMI interface provides
> + * platform profile and fan curve settings for devices that fall under the
> + * "Gaming Series" of Lenovo Legion devices.
> + *
> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>

I know you started in 2024, but should be 2025 now right?

> + */
> +
> +#include "linux/container_of.h"
> +#include "linux/printk.h"

Do you need these two?  If so, please sort them into the right place. 
Also shouldn't they be <linux/$foo.h>?

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
> +	GAMEZONE_FULL = 1,
> +	THERMAL_MODE,
> +};
> +
> +#define GAMEZONE_WMI_DEVICE(guid, type)                              \
> +	.guid_string = (guid), .context = &(enum lenovo_wmi_gz_type) \
> +	{                                                            \
> +		type                                                 \
> +	}
> +
> +static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
> +static DEFINE_MUTEX(gz_chain_mutex);
> +
> +struct lenovo_wmi_gz_priv {
> +	enum platform_profile_option current_profile;
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
> +static struct quirk_entry quirk_no_extreme_bug = {

Is this a bug?  You made it sound like in the documentation patch it's 
just a legacy device.

> +	.extreme_supported = false,
> +};
> +
> +/* Platform Profile Methods & Setup */
> +static int
> +lenovo_wmi_gz_platform_profile_supported(struct lenovo_wmi_gz_priv *priv,
> +					 int *supported)
> +{
> +	return lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
> +					       WMI_METHOD_ID_SMARTFAN_SUPP, 0, supported);
> +}
> +
> +static int lenovo_wmi_gz_profile_get(struct device *dev,
> +				     enum platform_profile_option *profile)
> +{
> +	struct lenovo_wmi_gz_priv *priv = dev_get_drvdata(dev);
> +	int sel_prof;
> +	int ret;
> +
> +	ret = lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
> +					      WMI_METHOD_ID_SMARTFAN_GET, 0, &sel_prof);
> +	if (ret)
> +		return ret;
> +
> +	switch (sel_prof) {
> +	case SMARTFAN_MODE_QUIET:
> +		*profile = PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	case SMARTFAN_MODE_BALANCED:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case SMARTFAN_MODE_PERFORMANCE:
> +		if (priv->extreme_supported) {
> +			*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +			break;
> +		}
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case SMARTFAN_MODE_EXTREME:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case SMARTFAN_MODE_CUSTOM:
> +		*profile = PLATFORM_PROFILE_CUSTOM;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	priv->current_profile = *profile;
> +
> +	ret = blocking_notifier_call_chain(&gz_chain_head, THERMAL_MODE_EVENT,
> +					   &sel_prof);
> +	if (ret == NOTIFY_BAD)
> +		pr_err("Failed to send notification to call chain for WMI event %u\n",
> +		       priv->type);
> +	return 0;
> +}
> +
> +static int lenovo_wmi_gz_profile_set(struct device *dev,
> +				     enum platform_profile_option profile)
> +{
> +	struct lenovo_wmi_gz_priv *priv = dev_get_drvdata(dev);
> +	int sel_prof;
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_LOW_POWER:
> +		sel_prof = SMARTFAN_MODE_QUIET;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		sel_prof = SMARTFAN_MODE_BALANCED;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> +		sel_prof = SMARTFAN_MODE_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		if (priv->extreme_supported) {
> +			sel_prof = SMARTFAN_MODE_EXTREME;
> +			break;
> +		}
> +		sel_prof = SMARTFAN_MODE_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_CUSTOM:
> +		sel_prof = SMARTFAN_MODE_CUSTOM;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ret = lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
> +					      WMI_METHOD_ID_SMARTFAN_SET, sel_prof, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct dmi_system_id fwbug_list[] = {
> +	{
> +		.ident = "Legion Go 8APU1",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
> +		},
> +		.driver_data = &quirk_no_extreme_bug,
> +	},
> +	{
> +		.ident = "Legion Go S 8ARP1",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1"),
> +		},
> +		.driver_data = &quirk_no_extreme_bug,
> +	},
> +	{
> +		.ident = "Legion Go S 8APU1",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1"),
> +		},
> +		.driver_data = &quirk_no_extreme_bug,
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
> +	dmi_id = dmi_first_match(fwbug_list);
> +	if (!dmi_id)
> +		return true;
> +
> +	quirks = dmi_id->driver_data;
> +	return quirks->extreme_supported;
> +}
> +
> +static int lenovo_wmi_platform_profile_probe(void *drvdata,
> +					     unsigned long *choices)
> +{
> +	struct lenovo_wmi_gz_priv *priv = drvdata;
> +	enum platform_profile_option profile;
> +	int profile_support_ver;
> +	int ret;
> +
> +	ret = lenovo_wmi_gz_platform_profile_supported(priv,
> +						       &profile_support_ver);
> +	if (ret)
> +		return ret;
> +
> +	if (profile_support_ver < 1)
> +		return -ENODEV;
> +
> +	priv->extreme_supported = extreme_supported(profile_support_ver);
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
> +static const struct platform_profile_ops lenovo_wmi_gz_platform_profile_ops = {
> +	.probe = lenovo_wmi_platform_profile_probe,
> +	.profile_get = lenovo_wmi_gz_profile_get,
> +	.profile_set = lenovo_wmi_gz_profile_set,
> +};
> +
> +/* Notifier Methods */
> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb)
> +{
> +	guard(mutex)(&gz_chain_mutex);
> +	return blocking_notifier_chain_register(&gz_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_register_notifier, "GZ_WMI");
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
> +	struct notifier_block *nb = data;
> +
> +	lenovo_wmi_gz_unregister_notifier(nb);
> +}
> +
> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
> +					 struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	ret = lenovo_wmi_gz_register_notifier(nb);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_lenovo_wmi_gz_unregister_notifier, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_lenovo_wmi_gz_register_notifier, "GZ_WMI");
> +
> +/* Driver Methods */
> +static void lenovo_wmi_gz_notify(struct wmi_device *wdev,
> +				 union acpi_object *obj)
> +{
> +	struct lenovo_wmi_gz_priv *tm_priv = dev_get_drvdata(&wdev->dev);
> +	struct lenovo_wmi_gz_priv *gz_priv =
> +		container_of(&gz_chain_head, struct lenovo_wmi_gz_priv, nhead);
> +	int sel_prof;
> +	int ret;
> +
> +	if (obj->type != ACPI_TYPE_INTEGER)
> +		return;
> +
> +	switch (tm_priv->type) {
> +	case THERMAL_MODE:
> +		sel_prof = obj->integer.value;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	/* Update primary Gamezone instance */
> +	switch (sel_prof) {
> +	case SMARTFAN_MODE_QUIET:
> +		gz_priv->current_profile = PLATFORM_PROFILE_LOW_POWER;
> +		break;
> +	case SMARTFAN_MODE_BALANCED:
> +		gz_priv->current_profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case SMARTFAN_MODE_PERFORMANCE:
> +		if (gz_priv->extreme_supported) {
> +			gz_priv->current_profile =
> +				PLATFORM_PROFILE_BALANCED_PERFORMANCE;
> +			break;
> +		}
> +		gz_priv->current_profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case SMARTFAN_MODE_EXTREME:
> +		gz_priv->current_profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case SMARTFAN_MODE_CUSTOM:
> +		gz_priv->current_profile = PLATFORM_PROFILE_CUSTOM;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	ret = blocking_notifier_call_chain(&gz_chain_head, THERMAL_MODE_EVENT,
> +					   &sel_prof);
> +	if (ret == NOTIFY_BAD)
> +		pr_err("Failed to send notification to call chain for WMI event %u\n",
> +		       tm_priv->type);
> +}
> +
> +static int lenovo_wmi_gz_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct lenovo_wmi_gz_priv *priv =
> +		devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> +
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (!context)
> +		return -EINVAL;
> +
> +	priv->wdev = wdev;
> +	priv->type = *((enum lenovo_wmi_gz_type *)context);
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +
> +	if (priv->type != GAMEZONE_FULL)
> +		return 0;
> +
> +	priv->nhead = gz_chain_head;
> +	priv->ppdev = platform_profile_register(&wdev->dev, "lenovo-wmi-gamezone",
> +						priv, &lenovo_wmi_gz_platform_profile_ops);
> +
> +	return 0;
> +}
> +
> +static const struct wmi_device_id lenovo_wmi_gz_id_table[] = {
> +	{ GAMEZONE_WMI_DEVICE(LENOVO_GAMEZONE_GUID, GAMEZONE_FULL) },
> +	{ GAMEZONE_WMI_DEVICE(THERMAL_MODE_EVENT_GUID, THERMAL_MODE) },
> +	{}
> +};
> +
> +static struct wmi_driver lenovo_wmi_gz_driver = {
> +	.driver = {
> +		.name = "lenovo_wmi_gamezone",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table = lenovo_wmi_gz_id_table,
> +	.probe = lenovo_wmi_gz_probe,
> +	.notify = lenovo_wmi_gz_notify,
> +	.no_singleton = true,
> +};
> +
> +module_wmi_driver(lenovo_wmi_gz_driver);
> +
> +MODULE_IMPORT_NS("LENOVO_WMI");
> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_gz_id_table);
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo-wmi.c b/drivers/platform/x86/lenovo-wmi.c
> new file mode 100644
> index 000000000000..0de2c37e69bd
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interface is
> + * broken up into multiple GUID interfaces that require cross-references
> + * between GUID's for some functionality. The "Custom Method" interface is a
> + * legacy interface for managing and displaying CPU & GPU power and hwmon
> + * settings and readings. The "Other Mode" interface is a modern interface
> + * that replaces or extends the "Custom Method" interface methods. The
> + * "Gamezone" interface adds advanced features such as fan profiles and
> + * overclocking. The "Lighting" interface adds control of various status
> + * lights related to different hardware components. "Other Mode" uses
> + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DATA_01
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
> +static int lenovo_wmidev_evaluate_method(struct wmi_device *wdev, u8 instance,
> +					 u32 method_id, struct acpi_buffer *in,
> +					 struct acpi_buffer *out)
> +{
> +	acpi_status status;
> +
> +	status = wmidev_evaluate_method(wdev, instance, method_id, in, out);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	return 0;
> +};
> +
> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instance,
> +				    u32 method_id, u32 arg0, u32 arg1,
> +				    u32 *retval)
> +{
> +	struct wmi_method_args args = { arg0, arg1 };
> +	struct acpi_buffer input = { (acpi_size)sizeof(args), &args };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *ret_obj __free(kfree) = NULL;
> +	int err;
> +
> +	err = lenovo_wmidev_evaluate_method(wdev, instance, method_id, &input,
> +					    &output);
> +
> +	if (err)
> +		return err;
> +
> +	if (retval) {
> +		ret_obj = (union acpi_object *)output.pointer;
> +		if (!ret_obj)
> +			return -ENODATA;
> +
> +		if (ret_obj->type != ACPI_TYPE_INTEGER)
> +			return -ENXIO;
> +
> +		*retval = (u32)ret_obj->integer.value;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_2, "LENOVO_WMI");
> +
> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 instance,
> +				    u32 method_id, u32 arg0, u32 *retval)
> +{
> +	return lenovo_wmidev_evaluate_method_2(wdev, instance, method_id, arg0,
> +					       0, retval);
> +}
> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_1, "LENOVO_WMI");
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo WMI Common Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86/lenovo-wmi.h
> new file mode 100644
> index 000000000000..113928b4fc0f
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interface is
> + * broken up into multiple GUID interfaces that require cross-references
> + * between GUID's for some functionality. The "Custom Method" interface is a
> + * legacy interface for managing and displaying CPU & GPU power and hwmon
> + * settings and readings. The "Other Mode" interface is a modern interface
> + * that replaces or extends the "Custom Method" interface methods. The
> + * "Gamezone" interface adds advanced features such as fan profiles and
> + * overclocking. The "Lighting" interface adds control of various status
> + * lights related to different hardware components. "Other Mode" uses
> + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DATA_01
> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
> + *
> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> + *
> + */
> +#include <linux/notifier.h>
> +#include <linux/platform_profile.h>
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
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
> +	SMARTFAN_MODE_QUIET = 0x01,
> +	SMARTFAN_MODE_BALANCED = 0x02,
> +	SMARTFAN_MODE_PERFORMANCE = 0x03,
> +	SMARTFAN_MODE_EXTREME = 0xE0, /* Ver 6+ */
> +	SMARTFAN_MODE_CUSTOM = 0xFF,
> +};
> +
> +enum lenovo_wmi_action {
> +	THERMAL_MODE_EVENT = 1,
> +};
> +
> +/* wmidev_evaluate_method helper functions */
> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 instance,
> +				    u32 method_id, u32 arg0, u32 arg1,
> +				    u32 *retval);
> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 instance,
> +				    u32 method_id, u32 arg0, u32 *retval);
> +
> +/* lenovo_wmi_gz_driver notifier functions */
> +int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned long action,
> +				enum platform_profile_option *profile);
> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb);
> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb);
> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
> +					 struct notifier_block *nb);
> +#endif /* !_LENOVO_WMI_H_ */


