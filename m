Return-Path: <linux-kernel+bounces-577621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00479A71F91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146E3841331
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC04621ABA4;
	Wed, 26 Mar 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MbZk9cC8"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804A1F4734
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018386; cv=none; b=A6OsrMCxSSPjFTyNYlOAqLHVYjnS09c9FFNVgpqXdLL58W2f2GwGsLow4ZiyekMyelz8w4BkeoQ0G9dHxLC4gVfC63wYgEWEbzRp5TfG//gI8GAblUJ28oRp5ZdlkzSLxa/cFD+7nbvbBpMEVTiVzP2A+QJxynpLL8t/pQzjK+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018386; c=relaxed/simple;
	bh=7o5ipESF1n74USomiVTP0aSI5G1knR2d4jmiY+WIn9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZkaKpn3Sqs37SR2d2vWV4CIiTEkJpSMK09qyzkIaC1wPyag9yCPIdpapxmD+jXJGIRFu3y/2wyCMa2rmcsMEAiZA5nKccA3OpBxh5gHQqm3EB/jTE58tATdaXmPIh/DY9yw8RIBRH6bMujcpBRR2u6cQcJRFUnACt3w/XbqMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MbZk9cC8; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3228bdd0-545f-49cd-849b-a38c2988374e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743018381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0Oq97sZ3K5gk2m6m6FyxWbcbb/mq5WF9fJ4MjK9gvM=;
	b=MbZk9cC8H295eiqXUarCZJ6Q4OfZc82VQTGDnbXhFb0dZuIr5nLegqvmJiTLhmrNVIYP+m
	ZDX6cmz/E8+nrh/atTKMJ4n1G1EJjEW5a3Aa1msLEmBIEN446tkRn6kaN29LwqOhluFrTE
	gu4y90D2BaWN2YFzEcP7WNDtax9th0I=
Date: Wed, 26 Mar 2025 12:45:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/6 RESEND] platform/x86: Add lenovo-wmi-helpers
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
 <20250317144326.5850-3-derekjohn.clark@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20250317144326.5850-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/17/25 7:43 AM, Derek J. Clark wrote:
> Adds documentation for all new lenovo-wmi drivers.
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

The helpers are working with the other drivers on my Legion Go
and Legion Go S. I left one minor comment for a typo in-line.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>

> ---
> v4:
>  - Changed namespace to LENOVO_WMI_HELPERS from LENOVO_WMI.
>  - Changed filenames to lenovo-wmi-helpers from lenovo-wmi.
>  - Removed structs and functions implemented by other drivers.
> ---
>  MAINTAINERS                               |  2 +
>  drivers/platform/x86/Kconfig              |  4 ++
>  drivers/platform/x86/Makefile             |  1 +
>  drivers/platform/x86/lenovo-wmi-helpers.c | 64 +++++++++++++++++++++++
>  drivers/platform/x86/lenovo-wmi-helpers.h | 24 +++++++++
>  5 files changed, 95 insertions(+)
>  create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.c
>  create mode 100644 drivers/platform/x86/lenovo-wmi-helpers.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 675f4b26426d..3a370a18b806 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13164,6 +13164,8 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>  F:	Documentation/wmi/devices/lenovo-wmi-other.rst
> +F:	drivers/platform/x86/lenovo-wmi-helpers.c
> +F:	drivers/platform/x86/lenovo-wmi-helpers.h
>  
>  LENOVO WMI HOTKEY UTILITIES DRIVER
>  M:	Jackie Dong <xy-jackie@139.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 43407e76476b..bece1ba61417 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -459,6 +459,10 @@ config IBM_RTL
>  	 state = 0 (BIOS SMIs on)
>  	 state = 1 (BIOS SMIs off)
>  
> +config LENOVO_WMI_HELPERS
> +	tristate
> +	depends on ACPI_WMI
> +
>  config IDEAPAD_LAPTOP
>  	tristate "Lenovo IdeaPad Laptop Extras"
>  	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 650dfbebb6c8..5a9f4e94f78b 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>  obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>  obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
>  obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
> +obj-$(CONFIG_LENOVO_WMI_HELPERS)	+= lenovo-wmi-helpers.o
>  
>  # Intel
>  obj-y				+= intel/
> diff --git a/drivers/platform/x86/lenovo-wmi-helpers.c b/drivers/platform/x86/lenovo-wmi-helpers.c
> new file mode 100644
> index 000000000000..36d553502223
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-helpers.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Lenovo Legion WMI helpers driver. The Lenovo Legion WMI interface is
> + * broken up into multiple GUID interfaces that require cross-references
> + * between GUID's for some functionality. The "Custom Method" interface is a
> + * legacy interface for managing and displaying CPU & GPU power and hwmon
> + * settings and readings. The "Other Mode" interface is a modern interface
> + * that replaces or extends the "Custom Method" interface methods. The
> + * "Gamezone" interface adds advanced features such as fan profiles and
> + * overclocking. The "Lighting" interface adds control of various status
> + * lights related to different hardware components. Each of these drivers
> + * uses a common procedure to get data fro the WMI interface, enumerated here.
"fro" should be "from" right?

> + *
> + * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + *
> + */
> +
> +#include <linux/wmi.h>
> +#include "lenovo-wmi-helpers.h"
> +
> +/*
> + * lwmi_dev_evaluate_method() - Helper function to call wmidev_evaluate_method
> + * for Lenovo WMI device method calls that return an ACPI integer.
> + * @wdev: Pointer to the WMI device to be called.
> + * @instance: Instance of the called method.
> + * @method_id: WMI Method ID for the method to be called.
> + * @buf: Buffer of all arguments for the given method_id.
> + * @size: Length of the buffer.
> + * @retval: Pointer for the return value to be assigned.
> + *
> + * Returns: 0, or an error.
> + */
> +int lwmi_dev_evaluate_method(struct wmi_device *wdev, u8 instance,
> +			     u32 method_id, unsigned char *buf, size_t size,
> +			     u32 *retval)
> +{
> +	struct acpi_buffer input = { size, buf };
> +	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *ret_obj __free(kfree) = NULL;
> +	acpi_status status;
> +
> +	status = wmidev_evaluate_method(wdev, instance, method_id, &input,
> +					&output);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (retval) {
> +		ret_obj = output.pointer;
> +		if (!ret_obj)
> +			return -ENODATA;
> +
> +		if (ret_obj->type != ACPI_TYPE_INTEGER)
> +			return -ENXIO;
> +
> +		*retval = (u32)ret_obj->integer.value;
> +	}
> +	return 0;
> +};
> +EXPORT_SYMBOL_NS_GPL(lwmi_dev_evaluate_method, "LENOVO_WMI_HELPERS");
> +
> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo WMI Helpers Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo-wmi-helpers.h b/drivers/platform/x86/lenovo-wmi-helpers.h
> new file mode 100644
> index 000000000000..7e0d7870790e
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo-wmi-helpers.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright(C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + *
> + */
> +#include <linux/notifier.h>
> +#include <linux/platform_profile.h>
> +
> +#ifndef _LENOVO_WMI_HELPERS_H_
> +#define _LENOVO_WMI_HELPERS_H_
> +
> +#include <linux/types.h>
> +#include <linux/wmi.h>
> +
> +struct wmi_method_args_32 {
> +	u32 arg0;
> +	u32 arg1;
> +};
> +
> +int lwmi_dev_evaluate_method(struct wmi_device *wdev, u8 instance,
> +			     u32 method_id, unsigned char *buf, size_t size,
> +			     u32 *retval);
> +
> +#endif /* !_LENOVO_WMI_HELPERS_H_ */


