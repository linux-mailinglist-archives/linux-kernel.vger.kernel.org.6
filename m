Return-Path: <linux-kernel+bounces-552212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B168A57701
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 01:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137503B343A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106CCE545;
	Sat,  8 Mar 2025 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="s7Y0oqAJ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40237482;
	Sat,  8 Mar 2025 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741394524; cv=none; b=jRp5dIh9pG8wPSLKIEzOKyfZleVn35iywKN8NDBvBg91UJ+xoU+3iePz4p0DYk5oGYyzVXxu9/ujFIQojHanwaaUFXErgBbDTBmOr6OQj8Tms11QeqPfRBmGeH8y0v7iVnxBazC113w8VvhsYBoEAoXNb7IKDilTJu3S73BxoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741394524; c=relaxed/simple;
	bh=PLG4TJX+t/BdQzCaqxTuPM3XBeAn5gJaXhHawYE1H9w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FATux/KaFLfR8A/dETOFAq/7O1e9PTQMk62DeBkWMi0dFRJN7IKKRSMCbL67PhX0So7LxIxW5wGK4r2xZSqgIeAwCoZm3PsGjjzAks0JbYtlhLMf29j479D6Jy2nQt01zZIjf9w3/u6LdkDr7QSZmrTs1x7HDr24BMLvviHXj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=s7Y0oqAJ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741394512; x=1741999312; i=w_armin@gmx.de;
	bh=PLG4TJX+t/BdQzCaqxTuPM3XBeAn5gJaXhHawYE1H9w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s7Y0oqAJytVvGXguwuH4zVtT7JdgIKzYDNnsYjDQ3TtuNCFBa7N3iHM7H0pCc1Kn
	 ZpFGYkol1il/ZdLAgcpGhC6vP7wMtaNzVBD2GQC/GyJFdR17XHpJDSCjdXYztSBd6
	 hBks/y2A+8sXa9v2rt2sRF5hrZ7gCLc6fGAOIro/9pn2LTnGOsWm8b7mTldnZP/wr
	 za+6DdhnIByomu6XopkfmW6FHKOCdy/QqDvaBsEOqxPQ6JuhxTbmkkrxfF4SbFIv6
	 saWZb8Z4BfbH0JJ8QzEF2x48OAhNGFaTiALEMp0GGQ0FWghQvIcTN4ZgpcXpOMzNs
	 rW+aIvRadmp0neVnrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGN2-1tZjbq0Vmg-00Yv48; Sat, 08
 Mar 2025 01:41:52 +0100
Message-ID: <231333f8-8b00-4e56-bfcb-e11c264b35b2@gmx.de>
Date: Sat, 8 Mar 2025 01:41:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] platform/x86: Add Lenovo Gamezone WMI Driver
From: Armin Wolf <W_Armin@gmx.de>
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
 <dd6f0d07-d629-40ce-9009-1a0919d93493@gmx.de>
Content-Language: en-US
In-Reply-To: <dd6f0d07-d629-40ce-9009-1a0919d93493@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:COpQRXcC4uLhuCHc5+l/e/T/GvS55ZlD5A9NnICCHNQgMYx2rMS
 zzm94v02LLXnmalPjKaLHIogqhPwMX0DC3z65+MTg8Rt3jTc19aC9o1roLxMI/uLsDWM58n
 /2Ly1gY38O6JS7lwxqvVzWP3C4ld+RqEwKhTeJx72WZFP3UNBf0CAhOxhD16zANzgZPEdW8
 BGLk1O47eyPY2mh0Y7YCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e/Ldu4BdfMk=;ZTb9j+0m8VimHi+6bYiYiuMwGRk
 /UdrwMC8iBXIQs6HJqKtq9NgccA0jTG5fUG+RQz8+pcQ2VV9Ufk4QVU/cc9ZZaLS9/hYeLE1F
 47w5NT22Xy0UnQhDLLCOzEqP+6yF+RcMrid+mCHhSXaeVRI6ojZjrxVLLcvqcq4JULtS6XU3M
 aAx5LjAGkISBnToI7Y5J/NmVupgjaZL/SBVOP1tfb5wsfUHJRuR05y3tAyLo9aWUEnUwsrn+Y
 vbPEr81d1mpEiytR3o0apnvniW0LpyOzc9cDUMOOWs65YDEQZ66l2cveU5TbUrIPIFOqrRn1R
 eDT9Xzqdb4HI3iE9OV0w99pMiCKnJpv+/gBjhNhlVqNsZ3Z7cYf7Tk06j3jhNmtRyO5nRcRZ+
 X9K2miTNmsRYUZRqUAy/WcU8za59foYAD1BtsipGUgzBze8iwPAGU/yL5RPTwodkLPZoeXMJF
 4Xkh/EcaE+3WjjwUNDhJguPNGz1eu7B+eQ+GoQKJGGrMBbSf9XDDoS+OtzVyx7Xuyv1pZGBZr
 TXDvLGGtqZKJKL+BCAWKh4hwOFXAyllNwIhJHn7PABhCzOH0e7D7dpkw9qmSzdF69HfuD3lW6
 s6cHLW2QAgg0W+lVDSUwK2bLFmB6jiVusrjK7xcmTe9EB9SPv8jdKoDrCJNPqWxAT5+MDTtbj
 bdd51IEWNA038xgvL4OujaILuZvfXYqRsb7v/TqtvTVOmTLA2IYpYUD+PzO1KZ//pLW+F3mH+
 JipnHkylMtHynEwhm5lLyw2G2mtYTfsPOSlza8XCjcVoE1CfhkqrML83QjrTWahnDlPcwcZEs
 NahOgJaWfC0JwxqRUyCzYR9O1C9loIbNeoPJ8J/NBBWl/vv/sbbfiyfnjr34vlAIDZ5AdHHjk
 ACXYY977LYCQP0sFAU2pJ7n7ltED6zbXzVyhz7JP0vKBFpi9sWSgpURTxjGv3TELBkHz9dN3Z
 RTjyTal4wjvQGNcMx8iwnz0s7s9EzpEH1AK1vsUFfvTxcU5/EHhV53SCQ3MR2cnnvPrsnKDrU
 oy9oSSpYYHacflq9u/dPS7t/HM23XARYmQ8ZA3kFhi7dHFx9PXbYW7RSWIb3SXo78JlrccePu
 nkX/ocjRidzv5SLNTsaQrv/VQo0X1iD5GLNUh8AkV8oOgpMzHV1eBpmgwQvfJw+Kpiyi+P5hu
 cksr8O21BczoPUOyw7l4UXzogYLt4hZeWmBfjIvKkNsKBr1kX3GM2NTLWdlhK6wJpHaMwrdsJ
 rjDfpvm3yHdY8+d30c5ymjs8KZp0zgzB5MsRRWSzpuMAHiOXT4wcvtwW2omGUSXlHkTkoX5jS
 iXAi2kT63mirGXvpkds8c7L6lc9kGUA5sCsuISYLlI2JhYZhgtz/k2fmo3+9cnd9h1ObTfidW
 al4xqdqcehgf5XzUOrzA8UnGuz5282SLgjim8oK8IEX2/9NWrHsAyT/5DT

Am 07.03.25 um 23:47 schrieb Armin Wolf:

> Am 25.02.25 um 22:59 schrieb Derek J. Clark:
>
>> Adds lenovo-wmi-gamezone.c which provides a driver for the Lenovo
>> Gamezone WMI interface that comes on Lenovo "Gaming Series" hardware.
>> Provides ACPI platform profiles over WMI.
>>
>> Adds lenovo-wmi.h and lenovo-wmi.c which provide helper functions for
>> wmidev_evaluate_method as well as prototypes for exported functions.
>> v3:
>> - Use notifier chain to report platform profile changes to any
>> =C2=A0=C2=A0 subscribed drivers.
>> - Adds THERMAL_MODE_EVENT GUID and .notify function to trigger notifier
>> =C2=A0=C2=A0 chain.
>> - Adds support for Extreme Mode profile on supported hardware, as well
>> =C2=A0=C2=A0 as a DMI quirk table for some devices that report extreme =
mode
>> version
>> =C2=A0=C2=A0 support but so not have it fully implemented.
>> - Update to include recent changes to platform-profile.
>> v2:
>> - Use devm_kmalloc to ensure driver can be instanced, remove global
>> =C2=A0=C2=A0 reference.
>> - Ensure reverse Christmas tree for all variable declarations.
>> - Remove extra whitespace.
>> - Use guard(mutex) in all mutex instances, global mutex.
>> - Use pr_fmt instead of adding the driver name to each pr_err.
>> - Remove noisy pr_info usage.
>> - Rename gamezone_wmi to lenovo_wmi_gz_priv and gz_wmi to priv.
>> - Remove GZ_WMI symbol exporting.
>>
>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>> ---
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 3 +
>> =C2=A0 drivers/platform/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +
>> =C2=A0 drivers/platform/x86/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>> =C2=A0 drivers/platform/x86/lenovo-wmi-gamezone.c | 374 +++++++++++++++=
++++++
>> =C2=A0 drivers/platform/x86/lenovo-wmi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 77 +++++
>> =C2=A0 drivers/platform/x86/lenovo-wmi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 62 ++++
>> =C2=A0 6 files changed, 534 insertions(+)
>> =C2=A0 create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
>> =C2=A0 create mode 100644 drivers/platform/x86/lenovo-wmi.c
>> =C2=A0 create mode 100644 drivers/platform/x86/lenovo-wmi.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e20c32b3c480..cf7f4fce1a25 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13157,6 +13157,9 @@ L: platform-driver-x86@vger.kernel.org
>> =C2=A0 S:=C2=A0=C2=A0=C2=A0 Maintained
>> =C2=A0 F:=C2=A0=C2=A0=C2=A0 Documentation/wmi/devices/lenovo-wmi-gamezo=
ne.rst
>> =C2=A0 F:=C2=A0=C2=A0=C2=A0 Documentation/wmi/devices/lenovo-wmi-other.=
rst
>> +F:=C2=A0=C2=A0=C2=A0 drivers/platform/x86/lenovo-wmi-gamezone.c
>> +F:=C2=A0=C2=A0=C2=A0 drivers/platform/x86/lenovo-wmi.c
>> +F:=C2=A0=C2=A0=C2=A0 drivers/platform/x86/lenovo-wmi.h
>> =C2=A0 =C2=A0 LETSKETCH HID TABLET DRIVER
>> =C2=A0 M:=C2=A0=C2=A0=C2=A0 Hans de Goede <hdegoede@redhat.com>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
>> index 7e20a58861eb..875822e6bd65 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -459,6 +459,22 @@ config IBM_RTL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state =3D 0 (BIOS SMIs on)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state =3D 1 (BIOS SMIs off)
>> =C2=A0 +config LENOVO_WMI
>> +=C2=A0=C2=A0=C2=A0 tristate
>> +=C2=A0=C2=A0=C2=A0 depends on ACPI_WMI
>
> Please rename this module to LENOVO_WMI_HELPERS.
>
>> +
>> +config LENOVO_WMI_GAMEZONE
>> +=C2=A0=C2=A0=C2=A0 tristate "Lenovo GameZone WMI Driver"
>> +=C2=A0=C2=A0=C2=A0 depends on ACPI_WMI
>> +=C2=A0=C2=A0=C2=A0 select ACPI_PLATFORM_PROFILE
>> +=C2=A0=C2=A0=C2=A0 select LENOVO_WMI
>> +=C2=A0=C2=A0=C2=A0 help
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say Y here if you have a WMI aware Leno=
vo Legion device and
>> would like to use the
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 platform-profile firmware interface to =
manage power usage.
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this driver as a module, cho=
ose M here: the module
>> will
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be called lenovo-wmi-gamezone.
>> +
>> =C2=A0 config IDEAPAD_LAPTOP
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Lenovo IdeaPad Laptop Extras"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ACPI
>> diff --git a/drivers/platform/x86/Makefile
>> b/drivers/platform/x86/Makefile
>> index 5f6307246e69..4a7b2d14eb82 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -67,7 +67,9 @@ obj-$(CONFIG_THINKPAD_ACPI)=C2=A0=C2=A0=C2=A0 +=3D th=
inkpad_acpi.o
>> =C2=A0 obj-$(CONFIG_THINKPAD_LMI)=C2=A0=C2=A0=C2=A0 +=3D think-lmi.o
>> =C2=A0 obj-$(CONFIG_YOGABOOK)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +=3D lenovo-yogabook.o
>> =C2=A0 obj-$(CONFIG_YT2_1380)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +=3D
>> lenovo-yoga-tab2-pro-1380-fastcharger.o
>> +obj-$(CONFIG_LENOVO_WMI)=C2=A0=C2=A0=C2=A0 +=3D lenovo-wmi.o
>> =C2=A0 obj-$(CONFIG_LENOVO_WMI_CAMERA)=C2=A0=C2=A0=C2=A0 +=3D lenovo-wm=
i-camera.o
>> +obj-$(CONFIG_LENOVO_WMI_GAMEZONE)=C2=A0=C2=A0=C2=A0 +=3D lenovo-wmi-ga=
mezone.o
>> =C2=A0 =C2=A0 # Intel
>> =C2=A0 obj-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D intel/
>> diff --git a/drivers/platform/x86/lenovo-wmi-gamezone.c
>> b/drivers/platform/x86/lenovo-wmi-gamezone.c
>> new file mode 100644
>> index 000000000000..d5329fecba47
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo-wmi-gamezone.c
>> @@ -0,0 +1,374 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Lenovo GameZone WMI interface driver. The GameZone WMI interface
>> provides
>> + * platform profile and fan curve settings for devices that fall
>> under the
>> + * "Gaming Series" of Lenovo Legion devices.
>> + *
>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>> + */
>> +
>> +#include "linux/container_of.h"
>> +#include "linux/printk.h"
>> +#include <linux/cleanup.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/dmi.h>
>> +#include <linux/list.h>
>> +#include <linux/notifier.h>
>> +#include <linux/platform_profile.h>
>> +#include <linux/types.h>
>> +#include <linux/wmi.h>
>> +#include "lenovo-wmi.h"
>> +
>> +/* Interface GUIDs */
>> +#define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
>> +#define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
>> +
>> +/* Method IDs */
>> +#define WMI_METHOD_ID_SMARTFAN_SUPP 43 /* IsSupportSmartFan */
>> +#define WMI_METHOD_ID_SMARTFAN_SET 44 /* SetSmartFanMode */
>> +#define WMI_METHOD_ID_SMARTFAN_GET 45 /* GetSmartFanMode */
>> +
>> +enum lenovo_wmi_gz_type {
>> +=C2=A0=C2=A0=C2=A0 GAMEZONE_FULL =3D 1,
>> +=C2=A0=C2=A0=C2=A0 THERMAL_MODE,
>> +};
>> +
>> +#define GAMEZONE_WMI_DEVICE(guid, type)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .guid_string =3D (guid), .context =3D &(enum lenovo=
_wmi_gz_type) \
>> + {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
>> +static DEFINE_MUTEX(gz_chain_mutex);
>> +
>> +struct lenovo_wmi_gz_priv {
>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option current_profile;
>
> This variable is only assigned and never read, please remove it.
>
>> +=C2=A0=C2=A0=C2=A0 struct wmi_device *wdev;
>> +=C2=A0=C2=A0=C2=A0 bool extreme_supported;
>> +=C2=A0=C2=A0=C2=A0 struct device *ppdev; /*platform profile device */
>> +=C2=A0=C2=A0=C2=A0 enum lenovo_wmi_gz_type type;
>> +=C2=A0=C2=A0=C2=A0 struct blocking_notifier_head nhead;
>> +};
>> +
>> +struct quirk_entry {
>> +=C2=A0=C2=A0=C2=A0 bool extreme_supported;
>> +};
>> +
>> +static struct quirk_entry quirk_no_extreme_bug =3D {
>> +=C2=A0=C2=A0=C2=A0 .extreme_supported =3D false,
>> +};
>
> Can you make this const?
>
>> +
>> +/* Platform Profile Methods & Setup */
>> +static int
>> +lenovo_wmi_gz_platform_profile_supported(struct lenovo_wmi_gz_priv
>> *priv,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *supported)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return lenovo_wmidev_evaluate_method_1(priv->wdev, =
0x0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 WMI_METHOD_ID_SMARTFAN_SUPP, 0, supported);
>> +}
>> +
>> +static int lenovo_wmi_gz_profile_get(struct device *dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_=
option *profile)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata=
(dev);
>> +=C2=A0=C2=A0=C2=A0 int sel_prof;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev,=
 0x0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 WMI_METHOD_ID_SMARTFAN_GET, 0, &sel_prof);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (sel_prof) {
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_QUIET:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PROFI=
LE_LOW_POWER;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_BALANCED:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PROFI=
LE_BALANCED;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_PERFORMANCE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (priv->extreme_supported=
) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *pr=
ofile =3D PLATFORM_PROFILE_BALANCED_PERFORMANCE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PROFI=
LE_PERFORMANCE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_EXTREME:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PROFI=
LE_PERFORMANCE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_CUSTOM:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PROFI=
LE_CUSTOM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 priv->current_profile =3D *profile;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D blocking_notifier_call_chain(&gz_chain_head=
,
>> THERMAL_MODE_EVENT,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &sel_prof)=
;
>
> Is it really necessary to call the notifier here? AFAIK the notifier
> needs to be called
> only:
>
> =C2=A0- when the platform profile was changed either by the user or the
> firmware.
> =C2=A0- when a new notifier handler was registered so that the handler d=
oes
> not have to wait for the next user input
>
> Please only call the notifier in those two situations.

I thought about this a bit and i came to the conclusion that my proposal w=
ould not work. The problem is that if no
gamezone driver is available the notifier handler will not be called at al=
l.

I instead suggest that you move the notifier inside the lenovo-wmi-other d=
river. Then the gamezone driver registers itself
with this notifier and supplies the current platform profile if the lenovo=
-wmi-other driver requests it. In this case
it would make sense to cache the current platform profile.

Thanks,
Armin Wolf

>
>> +=C2=A0=C2=A0=C2=A0 if (ret =3D=3D NOTIFY_BAD)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Failed to send noti=
fication to call chain for WMI
>> event %u\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 priv->type);
>
> Use dev_err() here please.
>
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static int lenovo_wmi_gz_profile_set(struct device *dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_=
option profile)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata=
(dev);
>> +=C2=A0=C2=A0=C2=A0 int sel_prof;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (profile) {
>> +=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_LOW_POWER:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel_prof =3D SMARTFAN_MODE_=
QUIET;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_BALANCED:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel_prof =3D SMARTFAN_MODE_=
BALANCED;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel_prof =3D SMARTFAN_MODE_=
PERFORMANCE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_PERFORMANCE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (priv->extreme_supported=
) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
_prof =3D SMARTFAN_MODE_EXTREME;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel_prof =3D SMARTFAN_MODE_=
PERFORMANCE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_CUSTOM:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel_prof =3D SMARTFAN_MODE_=
CUSTOM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev,=
 0x0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 WMI_METHOD_ID_SMARTFAN_SET, sel_prof, NULL);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static const struct dmi_system_id fwbug_list[] =3D {
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ident =3D "Legion Go 8APU1=
",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI=
_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI=
_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D &quirk_no_=
extreme_bug,
>> +=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ident =3D "Legion Go S 8AR=
P1",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI=
_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI=
_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP1"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D &quirk_no_=
extreme_bug,
>> +=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ident =3D "Legion Go S 8AP=
U1",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .matches =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI=
_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI=
_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU1"),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data =3D &quirk_no_=
extreme_bug,
>> +=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 {},
>> +
>> +};
>> +
>> +static bool extreme_supported(int profile_support_ver)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const struct dmi_system_id *dmi_id;
>> +=C2=A0=C2=A0=C2=A0 struct quirk_entry *quirks;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (profile_support_ver < 6)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +
>> +=C2=A0=C2=A0=C2=A0 dmi_id =3D dmi_first_match(fwbug_list);
>> +=C2=A0=C2=A0=C2=A0 if (!dmi_id)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +
>> +=C2=A0=C2=A0=C2=A0 quirks =3D dmi_id->driver_data;
>> +=C2=A0=C2=A0=C2=A0 return quirks->extreme_supported;
>> +}
>> +
>> +static int lenovo_wmi_platform_profile_probe(void *drvdata,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsigned long *choices)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct lenovo_wmi_gz_priv *priv =3D drvdata;
>> +=C2=A0=C2=A0=C2=A0 enum platform_profile_option profile;
>
> Unused variable, please remove.
>
>> +=C2=A0=C2=A0=C2=A0 int profile_support_ver;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D lenovo_wmi_gz_platform_profile_supported(pr=
iv,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &profile_support_ver);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (profile_support_ver < 1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>> +
>> +=C2=A0=C2=A0=C2=A0 priv->extreme_supported =3D extreme_supported(profi=
le_support_ver);
>> +
>> +=C2=A0=C2=A0=C2=A0 set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>> +=C2=A0=C2=A0=C2=A0 set_bit(PLATFORM_PROFILE_BALANCED, choices);
>> +=C2=A0=C2=A0=C2=A0 set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>> +=C2=A0=C2=A0=C2=A0 set_bit(PLATFORM_PROFILE_CUSTOM, choices);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (priv->extreme_supported)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(PLATFORM_PROFILE_BA=
LANCED_PERFORMANCE, choices);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static const struct platform_profile_ops
>> lenovo_wmi_gz_platform_profile_ops =3D {
>> +=C2=A0=C2=A0=C2=A0 .probe =3D lenovo_wmi_platform_profile_probe,
>> +=C2=A0=C2=A0=C2=A0 .profile_get =3D lenovo_wmi_gz_profile_get,
>> +=C2=A0=C2=A0=C2=A0 .profile_set =3D lenovo_wmi_gz_profile_set,
>> +};
>> +
>> +/* Notifier Methods */
>> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 guard(mutex)(&gz_chain_mutex);
>
> The blocking notifier already does the locking itself. Please remove
> this mutex.
>
>> +=C2=A0=C2=A0=C2=A0 return blocking_notifier_chain_register(&gz_chain_h=
ead, nb);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_register_notifier, "GZ_WMI");
>
> Can you name the namespace similar to "LENOVO_GAMEZONE_WMI" please?
>
>> +
>> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 guard(mutex)(&gz_chain_mutex);
>> +=C2=A0=C2=A0=C2=A0 return blocking_notifier_chain_unregister(&gz_chain=
_head, nb);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_unregister_notifier, "GZ_WMI");
>> +
>> +static void devm_lenovo_wmi_gz_unregister_notifier(void *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct notifier_block *nb =3D data;
>> +
>> +=C2=A0=C2=A0=C2=A0 lenovo_wmi_gz_unregister_notifier(nb);
>> +}
>> +
>> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct notifier_block =
*nb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D lenovo_wmi_gz_register_notifier(nb);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 return devm_add_action_or_reset(dev,
>> devm_lenovo_wmi_gz_unregister_notifier, nb);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_lenovo_wmi_gz_register_notifier, "GZ_WMI");
>> +
>> +/* Driver Methods */
>> +static void lenovo_wmi_gz_notify(struct wmi_device *wdev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 union acpi_object *obj)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct lenovo_wmi_gz_priv *tm_priv =3D dev_get_drvd=
ata(&wdev->dev);
>> +=C2=A0=C2=A0=C2=A0 struct lenovo_wmi_gz_priv *gz_priv =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 container_of(&gz_chain_head=
, struct lenovo_wmi_gz_priv, nhead);
>
> I fear that this will not work because gz_chain_head is a global
> variable, not a field inside
> struct lenovo_wmi_gz_priv. Also this would crash the kernel should the
> main gamezone driver be
> unbound from its WMI device.
>
> I suggest you move the WMI driver for the WMI event into a separate
> module. Then you use another notifier
> inside the new module to allow the gamezone driver to listen for
> events. For example this separate WMI event driver
> could use the "val" argument inside blocking_notifier_call_chain() to
> specify the type of event (like THERMAL_MODE_CHANGED)
> and the "v" argument to pass a pointer to a u32 variable containing
> the new thermal mode.
>
> This also allows you to extend the separate WMI driver later to
> support more WMI event GUIDs.
>
>> +=C2=A0=C2=A0=C2=A0 int sel_prof;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (obj->type !=3D ACPI_TYPE_INTEGER)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (tm_priv->type) {
>> +=C2=A0=C2=A0=C2=A0 case THERMAL_MODE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel_prof =3D obj->integer.v=
alue;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Update primary Gamezone instance */
>> +=C2=A0=C2=A0=C2=A0 switch (sel_prof) {
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_QUIET:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gz_priv->current_profile =
=3D PLATFORM_PROFILE_LOW_POWER;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_BALANCED:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gz_priv->current_profile =
=3D PLATFORM_PROFILE_BALANCED;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_PERFORMANCE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gz_priv->extreme_suppor=
ted) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gz_=
priv->current_profile =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 PLATFORM_PROFILE_BALANCED_PERFORMANCE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gz_priv->current_profile =
=3D PLATFORM_PROFILE_PERFORMANCE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_EXTREME:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gz_priv->current_profile =
=3D PLATFORM_PROFILE_PERFORMANCE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case SMARTFAN_MODE_CUSTOM:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gz_priv->current_profile =
=3D PLATFORM_PROFILE_CUSTOM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 }
>
> Please use platform_profile_notify() to notify userspace of the new
> platform profile settings.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D blocking_notifier_call_chain(&gz_chain_head=
,
>> THERMAL_MODE_EVENT,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &sel_prof)=
;
>> +=C2=A0=C2=A0=C2=A0 if (ret =3D=3D NOTIFY_BAD)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("Failed to send noti=
fication to call chain for WMI
>> event %u\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 tm_priv->type);
>> +}
>> +
>> +static int lenovo_wmi_gz_probe(struct wmi_device *wdev, const void
>> *context)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct lenovo_wmi_gz_priv *priv =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devm_kzalloc(&wdev->dev, si=
zeof(*priv), GFP_KERNEL);
>
> Please do the call to devm_kzalloc() on a separate line:
>
> =C2=A0=C2=A0=C2=A0=C2=A0struct lenovo_wmi_gz_priv *priv;
>
> =C2=A0=C2=A0=C2=A0=C2=A0priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv),=
 GFP_KERNEL);
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!priv)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!context)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 priv->wdev =3D wdev;
>> +=C2=A0=C2=A0=C2=A0 priv->type =3D *((enum lenovo_wmi_gz_type *)context=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 dev_set_drvdata(&wdev->dev, priv);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (priv->type !=3D GAMEZONE_FULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 priv->nhead =3D gz_chain_head;
>> +=C2=A0=C2=A0=C2=A0 priv->ppdev =3D platform_profile_register(&wdev->de=
v,
>> "lenovo-wmi-gamezone",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv=
, &lenovo_wmi_gz_platform_profile_ops);
>
> Please check if platform_profile_register() was successful and return
> an error if not.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +static const struct wmi_device_id lenovo_wmi_gz_id_table[] =3D {
>> +=C2=A0=C2=A0=C2=A0 { GAMEZONE_WMI_DEVICE(LENOVO_GAMEZONE_GUID, GAMEZON=
E_FULL) },
>> +=C2=A0=C2=A0=C2=A0 { GAMEZONE_WMI_DEVICE(THERMAL_MODE_EVENT_GUID, THER=
MAL_MODE) },
>> +=C2=A0=C2=A0=C2=A0 {}
>> +};
>> +
>> +static struct wmi_driver lenovo_wmi_gz_driver =3D {
>> +=C2=A0=C2=A0=C2=A0 .driver =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "lenovo_wmi_gamez=
one",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe_type =3D PROBE_PREFE=
R_ASYNCHRONOUS,
>> +=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 .id_table =3D lenovo_wmi_gz_id_table,
>> +=C2=A0=C2=A0=C2=A0 .probe =3D lenovo_wmi_gz_probe,
>> +=C2=A0=C2=A0=C2=A0 .notify =3D lenovo_wmi_gz_notify,
>> +=C2=A0=C2=A0=C2=A0 .no_singleton =3D true,
>> +};
>> +
>> +module_wmi_driver(lenovo_wmi_gz_driver);
>> +
>> +MODULE_IMPORT_NS("LENOVO_WMI");
>> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_gz_id_table);
>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>> +MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/platform/x86/lenovo-wmi.c
>> b/drivers/platform/x86/lenovo-wmi.c
>> new file mode 100644
>> index 000000000000..0de2c37e69bd
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo-wmi.c
>> @@ -0,0 +1,77 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI
>> interface is
>> + * broken up into multiple GUID interfaces that require
>> cross-references
>> + * between GUID's for some functionality. The "Custom Method"
>> interface is a
>> + * legacy interface for managing and displaying CPU & GPU power and
>> hwmon
>> + * settings and readings. The "Other Mode" interface is a modern
>> interface
>> + * that replaces or extends the "Custom Method" interface methods. The
>> + * "Gamezone" interface adds advanced features such as fan profiles an=
d
>> + * overclocking. The "Lighting" interface adds control of various
>> status
>> + * lights related to different hardware components. "Other Mode" uses
>> + * the data structs LENOVO_CAPABILITY_DATA_00,
>> LENOVO_CAPABILITY_DATA_01
>> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
>> + *
>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>> + *
>> + */
>> +
>> +#include <linux/wmi.h>
>> +#include "lenovo-wmi.h"
>> +
>> +/* wmidev_evaluate_method helper functions */
>> +static int lenovo_wmidev_evaluate_method(struct wmi_device *wdev, u8
>> instance,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 method_id, struct =
acpi_buffer *in,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_buffer *ou=
t)
>> +{
>> +=C2=A0=C2=A0=C2=A0 acpi_status status;
>> +
>> +=C2=A0=C2=A0=C2=A0 status =3D wmidev_evaluate_method(wdev, instance, m=
ethod_id, in,
>> out);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +};
>> +
>> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8
>> instance,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 method_id, u32 arg0, u32=
 arg1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 *retval)
>> +{
>
> Please give this method a more descriptive name.
>
>> +=C2=A0=C2=A0=C2=A0 struct wmi_method_args args =3D { arg0, arg1 };
>> +=C2=A0=C2=A0=C2=A0 struct acpi_buffer input =3D { (acpi_size)sizeof(ar=
gs), &args };
>
> Cast to acpi_size is unnecessary here.
>
>> +=C2=A0=C2=A0=C2=A0 struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFE=
R, NULL };
>> +=C2=A0=C2=A0=C2=A0 union acpi_object *ret_obj __free(kfree) =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 int err;
>> +
>> +=C2=A0=C2=A0=C2=A0 err =3D lenovo_wmidev_evaluate_method(wdev, instanc=
e, method_id,
>> &input,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &out=
put);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (retval) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret_obj =3D (union acpi_obj=
ect *)output.pointer;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret_obj)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn -ENODATA;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret_obj->type !=3D ACPI=
_TYPE_INTEGER)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn -ENXIO;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *retval =3D (u32)ret_obj->i=
nteger.value;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_2, "LENOVO_WMI");
>
> Can you please rename the namespace to "LENOVO_WMI_HELPERS"?
>
>> +
>> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8
>> instance,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 method_id, u32 arg0, u32=
 *retval)
>> +{
>
> Same as above.
>
>> +=C2=A0=C2=A0=C2=A0 return lenovo_wmidev_evaluate_method_2(wdev, instan=
ce,
>> method_id, arg0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0, retval);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_1, "LENOVO_WMI");
>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>> +MODULE_DESCRIPTION("Lenovo WMI Common Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/platform/x86/lenovo-wmi.h
>> b/drivers/platform/x86/lenovo-wmi.h
>> new file mode 100644
>> index 000000000000..113928b4fc0f
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo-wmi.h
>> @@ -0,0 +1,62 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI
>> interface is
>> + * broken up into multiple GUID interfaces that require
>> cross-references
>> + * between GUID's for some functionality. The "Custom Method"
>> interface is a
>> + * legacy interface for managing and displaying CPU & GPU power and
>> hwmon
>> + * settings and readings. The "Other Mode" interface is a modern
>> interface
>> + * that replaces or extends the "Custom Method" interface methods. The
>> + * "Gamezone" interface adds advanced features such as fan profiles an=
d
>> + * overclocking. The "Lighting" interface adds control of various
>> status
>> + * lights related to different hardware components. "Other Mode" uses
>> + * the data structs LENOVO_CAPABILITY_DATA_00,
>> LENOVO_CAPABILITY_DATA_01
>> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
>> + *
>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>> + *
>> + */
>> +#include <linux/notifier.h>
>> +#include <linux/platform_profile.h>
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> This causes a build error on my machine. Please only use this macro
> inside source files
> for modules and not inside header files.
>
>> +
>> +#ifndef _LENOVO_WMI_H_
>> +#define _LENOVO_WMI_H_
>> +
>> +#include <linux/bits.h>
>> +#include <linux/types.h>
>> +#include <linux/wmi.h>
>> +
>> +struct wmi_method_args {
>> +=C2=A0=C2=A0=C2=A0 u32 arg0;
>> +=C2=A0=C2=A0=C2=A0 u32 arg1;
>> +};
>> +
>> +/* gamezone structs */
>> +enum thermal_mode {
>> +=C2=A0=C2=A0=C2=A0 SMARTFAN_MODE_QUIET =3D 0x01,
>> +=C2=A0=C2=A0=C2=A0 SMARTFAN_MODE_BALANCED =3D 0x02,
>> +=C2=A0=C2=A0=C2=A0 SMARTFAN_MODE_PERFORMANCE =3D 0x03,
>> +=C2=A0=C2=A0=C2=A0 SMARTFAN_MODE_EXTREME =3D 0xE0, /* Ver 6+ */
>> +=C2=A0=C2=A0=C2=A0 SMARTFAN_MODE_CUSTOM =3D 0xFF,
>> +};
>> +
>> +enum lenovo_wmi_action {
>> +=C2=A0=C2=A0=C2=A0 THERMAL_MODE_EVENT =3D 1,
>> +};
>> +
>> +/* wmidev_evaluate_method helper functions */
>> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8
>> instance,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 method_id, u32 arg0, u32=
 arg1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 *retval);
>> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8
>> instance,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 method_id, u32 arg0, u32=
 *retval);
>> +
>> +/* lenovo_wmi_gz_driver notifier functions */
>> +int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned
>> long action,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enum platform_profile_option *profile);
>> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb);
>> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb);
>> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct notifier_block =
*nb);
>
> Can you please create a separate header file for each driver?
> Otherwise this header file
> will contain many different things from different drivers, which will
> maybe not even be
> available depending on the Kconfig settings.
>
> Thanks,
> Armin Wolf
>
>> +#endif /* !_LENOVO_WMI_H_ */

