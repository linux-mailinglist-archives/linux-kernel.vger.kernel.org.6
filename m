Return-Path: <linux-kernel+bounces-577622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCABA71F98
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B2B3A4F83
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92F1F874C;
	Wed, 26 Mar 2025 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xQPNu1Eh"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A819CC0E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018461; cv=none; b=tPZ1XiItQwHW1A4nA4cLk7aMZQ+3nDxwKJ0a768vYXk8M3VOaHx5im3WC5TojWwEJ8BxYmt94REmu+uOrLCKQuQXMEwJASiazzNoBY/p5lEj6Ik27vzhf19+lrq6KmhQJOQOzefwLRSeNjDlpD68GMMcowUTiaaqGgrr5StoctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018461; c=relaxed/simple;
	bh=5nCnCTjC97EvOEyULxWOfRsf/9KNWIprqf6lGGqHLLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6ZyTQD9G3u0DoviWqpDEJeAgktNXpQVMU70lNzlmrNHIxHLsbYEymNDp6xw0QFCyqwhme6UE/3qEeqAubbvCk2BO121dFQNsGd7AjwonwzF6t79TBtkKZefWmzcs0/NKg6mTIsl66h+OrrRt65HxPscjEMA9zc8CjlHgqZUbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xQPNu1Eh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6318e95e-f408-4573-b2d7-4486542bb887@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743018456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83N2vaVcprt8lcLjrhPWEU4hgKWzrhbCrD77a9k3SVg=;
	b=xQPNu1EhLu3MAWzGitwewUcLcRITqr93XX/OBAWf8ynP7w52oMHVZjNsDbP0w/FJmjebfA
	kVgxDPS55fnuv4tfnSrNLaZ1O5BVXMk6Sj6a/oRQvz4vJs7ColA3I0AGGb0I9MLCGX6OLI
	kItGfj+CaFzvOU6J48cF0P849Sz9hIE=
Date: Wed, 26 Mar 2025 12:47:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/6 RESEND] platform/x86: Add Lenovo WMI Events Driver
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Mario Limonciello <superm1@kernel.org>, Luke Jones <luke@ljones.dev>,
 Xino Ni <nijs1@lenovo.com>, Zhixin Zhang <zhangzx36@lenovo.com>,
 Mia Shao <shaohz1@lenovo.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 "Cody T . -H . Chiu" <codyit@gmail.com>, John Martens <johnfanv2@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250317144326.5850-1-derekjohn.clark@gmail.com>
 <20250317144326.5850-4-derekjohn.clark@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20250317144326.5850-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/17/25 7:43 AM, Derek J. Clark wrote:
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

WMI events are working on my Legion Go and Legion Go S.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>

> ---
> v4:
>  - Remove the Thermal Mode Event GUID from Gamezone and add this driver.
> ---
>  MAINTAINERS                              |   2 +
>  drivers/platform/x86/Kconfig             |   4 +
>  drivers/platform/x86/Makefile            |   1 +
>  drivers/platform/x86/lenovo-wmi-events.c | 132 +++++++++++++++++++++++
>  drivers/platform/x86/lenovo-wmi-events.h |  21 ++++
>  5 files changed, 160 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-wmi-events.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-events.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a370a18b806..6dde75922aaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13164,6 +13164,8 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>  F:	Documentation/wmi/devices/lenovo-wmi-other.rst
> +F:	drivers/platform/x86/lenovo-wmi-events.c
> +F:	drivers/platform/x86/lenovo-wmi-events.h
>  F:	drivers/platform/x86/lenovo-wmi-helpers.c
>  F:	drivers/platform/x86/lenovo-wmi-helpers.h
>  
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index bece1ba61417..13b8f4ac5dc5 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -459,6 +459,10 @@ config IBM_RTL
>  	 state = 0 (BIOS SMIs on)
>  	 state = 1 (BIOS SMIs off)
>  
> +config LENOVO_WMI_EVENTS
> +	tristate
> +	depends on ACPI_WMI
> +
>  config LENOVO_WMI_HELPERS
>  	tristate
>  	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 5a9f4e94f78b..fc039839286a 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>  obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>  obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
>  obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
> +obj-$(CONFIG_LENOVO_WMI_EVENTS)	+= lenovo-wmi-events.o
>  obj-$(CONFIG_LENOVO_WMI_HELPERS)	+= lenovo-wmi-helpers.o
>  
>  # Intel
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

