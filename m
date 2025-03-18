Return-Path: <linux-kernel+bounces-565448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0425CA66861
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACF93B03BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EA9190470;
	Tue, 18 Mar 2025 04:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM7QayES"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F341EA73;
	Tue, 18 Mar 2025 04:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272238; cv=none; b=ND2TkOM2anVaWd686W6xYT9uJeHQZbhpcoiQwg4R72Jf/f/TQQvohfQC1W6NQjnXmQrLUOSgFLDu8JGWiKNV7Q6SUwGIonlCpshYiqpMBd0HKQylkYGhpgMsrHS/gyIbI2lFIpAW2hknYqFfQzOjVjamoc4RgQhyV59M5CDrW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272238; c=relaxed/simple;
	bh=BuW8ZREzm4bWfSsImU71MMuDMBa4txYGx2mqLkO3lew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smjdzZKxAfbFgn0id3HbWVqRJLalUNkTDmFcCmIXRnzpnq1xwZNfTqxYZFlBRl4m5cyQBFtFLOEw5/o8neeArV9se3YQUs9x/Y6edLKtIcHs7NnkS3G+lrcsbTrvIDyHalwNC2STgYND3PMEJpPJcovfuhCfA0/z7RbLvAegix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM7QayES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731EFC4CEDD;
	Tue, 18 Mar 2025 04:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742272238;
	bh=BuW8ZREzm4bWfSsImU71MMuDMBa4txYGx2mqLkO3lew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aM7QayESxnYT0wN44/cKR/Dtqqwc0CYeMAwYECmIltqH/WcGHs1NExu+OQSCrax2P
	 HvlBrp8p2tAyN67KPVgzynBGogjQLlagYNWioEetEecXQxpXEHf2tmH7t+bIXzh1J+
	 KWE1AmLwXxHBQzP/7jSYzAPguinFluk2OdLgiVJKXnSCDdOznTSIfGnPZL71Cts0t6
	 65lwyoAv1hptv814qK5ZF6Wm6rxsi0sXuYCVfkI6DIMxkNGDHq1ynYf2byEMogNCDN
	 0rNgpCIvQ2KxUego6matlwXLJhNgdyMlp8n9X40xPQA0/Qt1e+DTrGBbxT5xbEmRja
	 howXfJFqT3O3w==
Message-ID: <6192b12d-43fb-44d9-9e7b-0c4e2da541c9@kernel.org>
Date: Mon, 17 Mar 2025 23:30:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6 RESEND] platform/x86: Add Lenovo WMI Events Driver
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
References: <20250317144326.5850-1-derekjohn.clark@gmail.com>
 <20250317144326.5850-4-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250317144326.5850-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/17/25 09:43, Derek J. Clark wrote:
> Adds lenovo-wmi-events driver. The events driver is designed as a
> general entrypoint for all Lenovo WMI Events. It acts as a notification
> chain head that will process event data and pass it on to registered
> drivers so they can react to the events.
> 
> Currently only the Gamezone interface Thermal Mode Event GUID is
> implemented in this driver. It is documented in the Gamezone
> documentation.
> 
> Suggested-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> v4:
>   - Remove the Thermal Mode Event GUID from Gamezone and add this driver.
> ---
>   MAINTAINERS                              |   2 +
>   drivers/platform/x86/Kconfig             |   4 +
>   drivers/platform/x86/Makefile            |   1 +
>   drivers/platform/x86/lenovo-wmi-events.c | 132 +++++++++++++++++++++++
>   drivers/platform/x86/lenovo-wmi-events.h |  21 ++++
>   5 files changed, 160 insertions(+)
>   create mode 100644 drivers/platform/x86/lenovo-wmi-events.c
>   create mode 100644 drivers/platform/x86/lenovo-wmi-events.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a370a18b806..6dde75922aaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13164,6 +13164,8 @@ L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>   F:	Documentation/wmi/devices/lenovo-wmi-other.rst
> +F:	drivers/platform/x86/lenovo-wmi-events.c
> +F:	drivers/platform/x86/lenovo-wmi-events.h
>   F:	drivers/platform/x86/lenovo-wmi-helpers.c
>   F:	drivers/platform/x86/lenovo-wmi-helpers.h
>   
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bece1ba61417..13b8f4ac5dc5 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -459,6 +459,10 @@ config IBM_RTL
>   	 state = 0 (BIOS SMIs on)
>   	 state = 1 (BIOS SMIs off)
>   
> +config LENOVO_WMI_EVENTS
> +	tristate
> +	depends on ACPI_WMI
> +
>   config LENOVO_WMI_HELPERS
>   	tristate
>   	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 5a9f4e94f78b..fc039839286a 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>   obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>   obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
>   obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
> +obj-$(CONFIG_LENOVO_WMI_EVENTS)	+= lenovo-wmi-events.o
>   obj-$(CONFIG_LENOVO_WMI_HELPERS)	+= lenovo-wmi-helpers.o
>   
>   # Intel
> diff --git a/drivers/platform/x86/lenovo-wmi-events.c b/drivers/platform/x86/lenovo-wmi-events.c
> new file mode 100644
> index 000000000000..3ea0face3c0d
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-events.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Lenovo WMI Events driver. Lenovo WMI interfaces provide various
> + * hardware triggered events that many drivers need to have propagated.
> + * This driver provides a uniform entrypoint for these events so that
> + * any driver that needs to respond to these events can subscribe to a
> + * notifier chain.
> + *
> + * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + */
> +
> +#include <linux/list.h>
> +#include <linux/notifier.h>
> +#include <linux/types.h>
> +#include <linux/wmi.h>
> +#include "lenovo-wmi-events.h"
> +
> +/* Interface GUIDs */
> +#define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
> +
> +#define LENOVO_WMI_EVENT_DEVICE(guid, type)                        \
> +	.guid_string = (guid), .context = &(enum lwmi_events_type) \
> +	{                                                          \
> +		type                                               \
> +	}
> +
> +static BLOCKING_NOTIFIER_HEAD(events_chain_head);
> +
> +struct lwmi_events_priv {
> +	struct wmi_device *wdev;
> +	enum lwmi_events_type type;
> +};
> +
> +/* Notifier Methods */
> +int lwmi_events_register_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&events_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(lwmi_events_register_notifier, "LENOVO_WMI_EVENTS");
> +
> +int lwmi_events_unregister_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&events_chain_head, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(lwmi_events_unregister_notifier, "LENOVO_WMI_EVENTS");
> +
> +static void devm_lwmi_events_unregister_notifier(void *data)
> +{
> +	struct notifier_block *nb = data;
> +
> +	lwmi_events_unregister_notifier(nb);
> +}
> +
> +int devm_lwmi_events_register_notifier(struct device *dev,
> +				       struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	ret = lwmi_events_register_notifier(nb);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev,
> +				devm_lwmi_events_unregister_notifier, nb);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_lwmi_events_register_notifier, "LENOVO_WMI_EVENTS");
> +
> +/* Driver Methods */
> +static void lwmi_events_notify(struct wmi_device *wdev, union acpi_object *obj)
> +{
> +	struct lwmi_events_priv *priv = dev_get_drvdata(&wdev->dev);
> +	int sel_prof;
> +	int ret;
> +
> +	switch (priv->type) {
> +	case THERMAL_MODE_EVENT:
> +		if (obj->type != ACPI_TYPE_INTEGER)
> +			return;
> +
> +		sel_prof = obj->integer.value;
> +		ret = blocking_notifier_call_chain(&events_chain_head,
> +						   THERMAL_MODE_EVENT, &sel_prof);
> +		if (ret == NOTIFY_BAD)
> +			dev_err(&wdev->dev,
> +				"Failed to send notification to call chain for WMI Events\n");
> +		break;
> +	default:
> +		return;
> +	}
> +}
> +
> +static int lwmi_events_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct lwmi_events_priv *priv;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (!context)
> +		return -EINVAL;
> +
> +	priv->wdev = wdev;
> +	priv->type = *(enum lwmi_events_type *)context;
> +
> +	dev_set_drvdata(&wdev->dev, priv);
> +	return 0;
> +}
> +
> +static const struct wmi_device_id lwmi_events_id_table[] = {
> +	{ LENOVO_WMI_EVENT_DEVICE(THERMAL_MODE_EVENT_GUID,
> +				  THERMAL_MODE_EVENT) },
> +	{}
> +};
> +
> +static struct wmi_driver lwmi_events_driver = {
> +	.driver = {
> +		.name = "lenovo_wmi_events",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.id_table = lwmi_events_id_table,
> +	.probe = lwmi_events_probe,
> +	.notify = lwmi_events_notify,
> +	.no_singleton = true,
> +};
> +
> +module_wmi_driver(lwmi_events_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, lwmi_events_id_table);
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo WMI Events Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo-wmi-events.h b/drivers/platform/x86/lenovo-wmi-events.h
> new file mode 100644
> index 000000000000..a3fa934eaa10
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-events.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + */
> +
> +#include <linux/notifier.h>
> +#include <linux/types.h>
> +
> +#ifndef _LENOVO_WMI_EVENTS_H_
> +#define _LENOVO_WMI_EVENTS_H_
> +
> +enum lwmi_events_type {
> +	THERMAL_MODE_EVENT = 1,
> +};
> +
> +int lwmi_events_register_notifier(struct notifier_block *nb);
> +int lwmi_events_unregister_notifier(struct notifier_block *nb);
> +int devm_lwmi_events_register_notifier(struct device *dev,
> +				       struct notifier_block *nb);
> +
> +#endif /* !_LENOVO_WMI_EVENTS_H_ */


