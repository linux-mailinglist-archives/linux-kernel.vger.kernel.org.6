Return-Path: <linux-kernel+bounces-562790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44420A632F5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511D33B058D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 00:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9D8467;
	Sun, 16 Mar 2025 00:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="N9LtAknu"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE6372;
	Sun, 16 Mar 2025 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742083282; cv=none; b=WsBIYj8q1PFPaQW0MjztsapZ9iBG1M7X/DOX4pjjeXUhW79fQjxbFP4iO2uU7movzrh5gpALabFDuP1IsmqdYeLwarYrVrVWP1xmXaPtL5P29wnMiVYKMQEtGo4Fa9LnWwA+8csS12exnOgsrA3TrSFq+APs0wxB62qUhI8svyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742083282; c=relaxed/simple;
	bh=mDvx28BFwAPA/BAPa6Teuz3dzNSscWFs2HQ+lWEI1Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NE+Z73ihwsQfF4fOFs8DS9SNnjnh535trDSdOLREiEQAwVNqzOl3KejMt3BzL9usiyMm2NRlktADEWOBUuhXf4w9hlgSOx872331tkvQ+7KXg+DcZVURt1pSsj+OWtXLBjpO4vSr0ENYLw+rd1DGz5PBg8CqbGLJoRsST8grr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=N9LtAknu; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742083276; x=1742688076; i=w_armin@gmx.de;
	bh=kAQvgYsx6ZDlQ1wtGc5W/28OKyE+xP70qh4uIb7Vimg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N9LtAknuu+3CVbGMRUXHuBjKheYJ3gpPbycVsUl9KlHZuXR1VQEE/yLlC96vta8C
	 IZ45loDm+/+LqZiPIZywI9/tQewsXDMCN5BzpxYdszg3z7cvbo1kBx/F4RaflWRh6
	 cM6Rx8kb47+FhgNsrNBnJ+SowvDELUCvXjvJTWuFFb++qMbGNv8eTVYZK5nbGENAk
	 KXtyMl9qd8jNyFLijmiPDusNbq2X8PApwr4L/PKNLkmoSVPrxubpCaWQExUMwGVtR
	 hmWTkhGlNJ4FGttE8lzrbLZlbT8cUrB/54czKjdciA/KUSKeHywLat+ozaFcrfxdo
	 pkqeyigGpFzI6x0T0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1t0Ftu2GF8-016AEc; Sun, 16
 Mar 2025 01:01:16 +0100
Message-ID: <19207b85-5842-4ff9-81b3-da80aedf7995@gmx.de>
Date: Sun, 16 Mar 2025 01:01:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] platform/x86: Add Lenovo Gamezone WMI Driver
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Mario Limonciello <superm1@kernel.org>,
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
 <CAFqHKTn7gjjAzJET2776z4HV+_=AigdKCnLZB7GOZNb_ib=Uhg@mail.gmail.com>
 <229b2b2e-8404-4589-b364-af4a4a4c9461@gmx.de>
 <CAFqHKT=KiKDxjKby_sMW4KENnXNj0P57D8C-sevq+Q_PuV2TsQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAFqHKT=KiKDxjKby_sMW4KENnXNj0P57D8C-sevq+Q_PuV2TsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cUsbCZ7NGeQObNqyPsWt6Qbk9brglOuz4kdj7rnky4w4FCVrXBu
 UrDuge3m0XekC9/rYbe4Iz+b2CKU2i6nNq8PQHQcxUmgy8UQLzQtC9UxxwtadOBM7eDThWu
 fpMdc+eqcmCVyOHJwLX8y/DkMcAnfAsOgozfp6eUmRiZrQyApYoY1TbmhdxpmcwyzgaCZ0c
 RO2gHTmAl59pDBZ2sSB3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e4+T2VAhbe8=;32wTqmxsIzPTPeUuXJwLr2eneUm
 w/IpvC9MhAJQGn9og0rt7Td+9idkN7nTsUi3gn0x7EOc2Neqh1scEP0ge5Ph4cfivqY3kSxfk
 3ecBozwrp7Ufr0HndSoLykJSwGDIbqjdVdGLnJ0GqZl8kZToM2Si/qEBwV+OogLrR5bVqNzAC
 2A/UZ8GKORefOFEXtHsUBadd3SHjZ3ElVTcUuNJ8r3ftQdPZ8V3s/tQG0NXMoYvN2WHORpm0A
 MdvXL6pizKeUTPg6AoJ4vpZr0QoyxctH9ajkfdk0N19im3d8DHtTpwt0HwAnaUI5YjJDW5EDv
 3nG373J52OM410u9+gZLwaC2SY5J2NZ4Hschhl10wPyTZ7R6hVog4LupAbc2p2CB2g0KizZ6l
 t7X79DUH35SknxBoUn9HlgcYsITIoPhMma/5r0knIFmMrcDCvo/qRO50rs0FlydC09fkEAPLu
 haZyUw8NS3Cpe5Gb73CYQEowndnd2CvnCb5fHe42j9icckZvLsoYFj2cOmwAifm/j9nNXGilb
 zP5JADJ3026veAho9ti3MVAHpYiuBPpbg9pkSFEPJrDByq5Kk899jSSE0lbYuMG7I99VfDrWr
 Lv15t48HbM2lV5rNBC8vrlQtR0H8VYfQI0VfePX8sLMmy1vR6++FdT0/R2k6/1JDuunEZSK+N
 wq+BOJ+HZ4Gc7UUgyCwVF8e95FLj4C4Un6qOq9XM0DLzZfHPqCv8Qomigfi93bPxH2t4J4ktY
 zDfik7BwBLmmISdgaChVYQqleRG6wOrkRDs5l9fGHDcUXwMRqwKswxQV8qU+ZxUUdyzhxuDAP
 Hng25VNicYtKYCTvtpwi/J6VIxTIpKh3tbeA0k3VT/ghXebYiRmfwZRhe9/ONKGQyXOZjBR28
 R2jATUJS/DXaOfoxQ4JUFFtKAUiMIn1Vy5CWDVQJryU2BM61nkb5rIbdhipdsVv7+jg7hXGKs
 FUEpA8RA/lIvNPkmFYh5qOw/fv95TqAoW5g4mpluVj+2P/43m7PKuRly8WkWRfBz4AM/ZZoqS
 2ez63DyWQ8Pbs6PBgBiRH40inkMwuNjOGhCGi4yNZ9PybQ1JoRWC7wjbMb6linePP4seFMO5f
 S3y1FO2E2FwwJ8F9hQ5KaJne3SJcv43GihP8RWsBUNwlGr1GY/a8tfUNWGahVhBCCSUUpnsyH
 YQtrEYfDVlSHiOVBFfGnBSBDzg/N2nYNYQJi5N6mGTBEkNq+O6yXdWaFzShpz6DNDIkHKCSmn
 fISfrk85wp6UddDUsNrNUwhH3XgNQcHpeOVZt0DkwD1+Hu2VikAC3NEIKXnnR1P953WiHXMNY
 tFJXLs6N7oRilKEt1mpIH15X2wmOjfYdBpsB7//pg37ndNbfEEJ6wsoXdonve5euGmor2JHXw
 tZxk5+r+GjfVmmmAMvSDEZXph2akdR8wjqMX8yLcQymD/T+kFsm8Mx+4N3qPyvXfBv/zfYXeW
 Mo44E8i52Cw7zE9n+XoswWp5pOWs=

Am 14.03.25 um 22:29 schrieb Derek John Clark:

> On Tue, Mar 11, 2025 at 1:30=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 10.03.25 um 23:11 schrieb Derek John Clark:
>>
>>> On Fri, Mar 7, 2025 at 2:48=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
>>>> Am 25.02.25 um 22:59 schrieb Derek J. Clark:
>>>>
>>>>> Adds lenovo-wmi-gamezone.c which provides a driver for the Lenovo
>>>>> Gamezone WMI interface that comes on Lenovo "Gaming Series" hardware=
.
>>>>> Provides ACPI platform profiles over WMI.
>>>>>
>>>>> Adds lenovo-wmi.h and lenovo-wmi.c which provide helper functions fo=
r
>>>>> wmidev_evaluate_method as well as prototypes for exported functions.
>>>>> v3:
>>>>> - Use notifier chain to report platform profile changes to any
>>>>>      subscribed drivers.
>>>>> - Adds THERMAL_MODE_EVENT GUID and .notify function to trigger notif=
ier
>>>>>      chain.
>>>>> - Adds support for Extreme Mode profile on supported hardware, as we=
ll
>>>>>      as a DMI quirk table for some devices that report extreme mode =
version
>>>>>      support but so not have it fully implemented.
>>>>> - Update to include recent changes to platform-profile.
>>>>> v2:
>>>>> - Use devm_kmalloc to ensure driver can be instanced, remove global
>>>>>      reference.
>>>>> - Ensure reverse Christmas tree for all variable declarations.
>>>>> - Remove extra whitespace.
>>>>> - Use guard(mutex) in all mutex instances, global mutex.
>>>>> - Use pr_fmt instead of adding the driver name to each pr_err.
>>>>> - Remove noisy pr_info usage.
>>>>> - Rename gamezone_wmi to lenovo_wmi_gz_priv and gz_wmi to priv.
>>>>> - Remove GZ_WMI symbol exporting.
>>>>>
>>>>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>>>> ---
>>>>>     MAINTAINERS                                |   3 +
>>>>>     drivers/platform/x86/Kconfig               |  16 +
>>>>>     drivers/platform/x86/Makefile              |   2 +
>>>>>     drivers/platform/x86/lenovo-wmi-gamezone.c | 374 +++++++++++++++=
++++++
>>>>>     drivers/platform/x86/lenovo-wmi.c          |  77 +++++
>>>>>     drivers/platform/x86/lenovo-wmi.h          |  62 ++++
>>>>>     6 files changed, 534 insertions(+)
>>>>>     create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
>>>>>     create mode 100644 drivers/platform/x86/lenovo-wmi.c
>>>>>     create mode 100644 drivers/platform/x86/lenovo-wmi.h
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index e20c32b3c480..cf7f4fce1a25 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -13157,6 +13157,9 @@ L:    platform-driver-x86@vger.kernel.org
>>>>>     S:  Maintained
>>>>>     F:  Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>>>>>     F:  Documentation/wmi/devices/lenovo-wmi-other.rst
>>>>> +F:   drivers/platform/x86/lenovo-wmi-gamezone.c
>>>>> +F:   drivers/platform/x86/lenovo-wmi.c
>>>>> +F:   drivers/platform/x86/lenovo-wmi.h
>>>>>
>>>>>     LETSKETCH HID TABLET DRIVER
>>>>>     M:  Hans de Goede <hdegoede@redhat.com>
>>>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kco=
nfig
>>>>> index 7e20a58861eb..875822e6bd65 100644
>>>>> --- a/drivers/platform/x86/Kconfig
>>>>> +++ b/drivers/platform/x86/Kconfig
>>>>> @@ -459,6 +459,22 @@ config IBM_RTL
>>>>>          state =3D 0 (BIOS SMIs on)
>>>>>          state =3D 1 (BIOS SMIs off)
>>>>>
>>>>> +config LENOVO_WMI
>>>>> +     tristate
>>>>> +     depends on ACPI_WMI
>>>> Please rename this module to LENOVO_WMI_HELPERS.
>>> Acked
>>>
>>>>> +
>>>>> +config LENOVO_WMI_GAMEZONE
>>>>> +     tristate "Lenovo GameZone WMI Driver"
>>>>> +     depends on ACPI_WMI
>>>>> +     select ACPI_PLATFORM_PROFILE
>>>>> +     select LENOVO_WMI
>>>>> +     help
>>>>> +       Say Y here if you have a WMI aware Lenovo Legion device and =
would like to use the
>>>>> +       platform-profile firmware interface to manage power usage.
>>>>> +
>>>>> +       To compile this driver as a module, choose M here: the modul=
e will
>>>>> +       be called lenovo-wmi-gamezone.
>>>>> +
>>>>>     config IDEAPAD_LAPTOP
>>>>>         tristate "Lenovo IdeaPad Laptop Extras"
>>>>>         depends on ACPI
>>>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Ma=
kefile
>>>>> index 5f6307246e69..4a7b2d14eb82 100644
>>>>> --- a/drivers/platform/x86/Makefile
>>>>> +++ b/drivers/platform/x86/Makefile
>>>>> @@ -67,7 +67,9 @@ obj-$(CONFIG_THINKPAD_ACPI) +=3D thinkpad_acpi.o
>>>>>     obj-$(CONFIG_THINKPAD_LMI)  +=3D think-lmi.o
>>>>>     obj-$(CONFIG_YOGABOOK)              +=3D lenovo-yogabook.o
>>>>>     obj-$(CONFIG_YT2_1380)              +=3D lenovo-yoga-tab2-pro-13=
80-fastcharger.o
>>>>> +obj-$(CONFIG_LENOVO_WMI)     +=3D lenovo-wmi.o
>>>>>     obj-$(CONFIG_LENOVO_WMI_CAMERA)     +=3D lenovo-wmi-camera.o
>>>>> +obj-$(CONFIG_LENOVO_WMI_GAMEZONE)    +=3D lenovo-wmi-gamezone.o
>>>>>
>>>>>     # Intel
>>>>>     obj-y                               +=3D intel/
>>>>> diff --git a/drivers/platform/x86/lenovo-wmi-gamezone.c b/drivers/pl=
atform/x86/lenovo-wmi-gamezone.c
>>>>> new file mode 100644
>>>>> index 000000000000..d5329fecba47
>>>>> --- /dev/null
>>>>> +++ b/drivers/platform/x86/lenovo-wmi-gamezone.c
>>>>> @@ -0,0 +1,374 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>>> +/*
>>>>> + * Lenovo GameZone WMI interface driver. The GameZone WMI interface=
 provides
>>>>> + * platform profile and fan curve settings for devices that fall un=
der the
>>>>> + * "Gaming Series" of Lenovo Legion devices.
>>>>> + *
>>>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>>>>> + */
>>>>> +
>>>>> +#include "linux/container_of.h"
>>>>> +#include "linux/printk.h"
>>>>> +#include <linux/cleanup.h>
>>>>> +#include <linux/dev_printk.h>
>>>>> +#include <linux/dmi.h>
>>>>> +#include <linux/list.h>
>>>>> +#include <linux/notifier.h>
>>>>> +#include <linux/platform_profile.h>
>>>>> +#include <linux/types.h>
>>>>> +#include <linux/wmi.h>
>>>>> +#include "lenovo-wmi.h"
>>>>> +
>>>>> +/* Interface GUIDs */
>>>>> +#define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
>>>>> +#define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B=
5F"
>>>>> +
>>>>> +/* Method IDs */
>>>>> +#define WMI_METHOD_ID_SMARTFAN_SUPP 43 /* IsSupportSmartFan */
>>>>> +#define WMI_METHOD_ID_SMARTFAN_SET 44 /* SetSmartFanMode */
>>>>> +#define WMI_METHOD_ID_SMARTFAN_GET 45 /* GetSmartFanMode */
>>>>> +
>>>>> +enum lenovo_wmi_gz_type {
>>>>> +     GAMEZONE_FULL =3D 1,
>>>>> +     THERMAL_MODE,
>>>>> +};
>>>>> +
>>>>> +#define GAMEZONE_WMI_DEVICE(guid, type)                            =
  \
>>>>> +     .guid_string =3D (guid), .context =3D &(enum lenovo_wmi_gz_typ=
e) \
>>>>> +     {                                                            \
>>>>> +             type                                                 \
>>>>> +     }
>>>>> +
>>>>> +static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
>>>>> +static DEFINE_MUTEX(gz_chain_mutex);
>>>>> +
>>>>> +struct lenovo_wmi_gz_priv {
>>>>> +     enum platform_profile_option current_profile;
>>>> This variable is only assigned and never read, please remove it.
>>> You're correct for this version. I re-added it when working on the
>>> notifier chain but didn't end up using it. I'll make sure no unused
>>> variables are in the next version.
>>>
>>>>> +     struct wmi_device *wdev;
>>>>> +     bool extreme_supported;
>>>>> +     struct device *ppdev; /*platform profile device */
>>>>> +     enum lenovo_wmi_gz_type type;
>>>>> +     struct blocking_notifier_head nhead;
>>>>> +};
>>>>> +
>>>>> +struct quirk_entry {
>>>>> +     bool extreme_supported;
>>>>> +};
>>>>> +
>>>>> +static struct quirk_entry quirk_no_extreme_bug =3D {
>>>>> +     .extreme_supported =3D false,
>>>>> +};
>>>> Can you make this const?
> I get warnings when setting the drvdata with this as a const
>
> drivers/platform/x86/lenovo-wmi-gamezone.c:144:32: warning:
> initialization discards =E2=80=98const=E2=80=99 qualifier from pointer t=
arget type
> [-Wdiscarded-qualifiers]
>   144 |                 .driver_data =3D &quirk_no_extreme_bug,
>       |                                ^
>
Alright, then you can keep it non-const.

>>>>> +
>>>>> +/* Platform Profile Methods & Setup */
>>>>> +static int
>>>>> +lenovo_wmi_gz_platform_profile_supported(struct lenovo_wmi_gz_priv =
*priv,
>>>>> +                                      int *supported)
>>>>> +{
>>>>> +     return lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
>>>>> +                                            WMI_METHOD_ID_SMARTFAN_=
SUPP, 0, supported);
>>>>> +}
>>>>> +
>>>>> +static int lenovo_wmi_gz_profile_get(struct device *dev,
>>>>> +                                  enum platform_profile_option *pro=
file)
>>>>> +{
>>>>> +     struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
>>>>> +     int sel_prof;
>>>>> +     int ret;
>>>>> +
>>>>> +     ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
>>>>> +                                           WMI_METHOD_ID_SMARTFAN_G=
ET, 0, &sel_prof);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     switch (sel_prof) {
>>>>> +     case SMARTFAN_MODE_QUIET:
>>>>> +             *profile =3D PLATFORM_PROFILE_LOW_POWER;
>>>>> +             break;
>>>>> +     case SMARTFAN_MODE_BALANCED:
>>>>> +             *profile =3D PLATFORM_PROFILE_BALANCED;
>>>>> +             break;
>>>>> +     case SMARTFAN_MODE_PERFORMANCE:
>>>>> +             if (priv->extreme_supported) {
>>>>> +                     *profile =3D PLATFORM_PROFILE_BALANCED_PERFORM=
ANCE;
>>>>> +                     break;
>>>>> +             }
>>>>> +             *profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>>>> +             break;
>>>>> +     case SMARTFAN_MODE_EXTREME:
>>>>> +             *profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>>>> +             break;
>>>>> +     case SMARTFAN_MODE_CUSTOM:
>>>>> +             *profile =3D PLATFORM_PROFILE_CUSTOM;
>>>>> +             break;
>>>>> +     default:
>>>>> +             return -EINVAL;
>>>>> +     }
>>>>> +
>>>>> +     priv->current_profile =3D *profile;
>>>>> +
>>>>> +     ret =3D blocking_notifier_call_chain(&gz_chain_head, THERMAL_M=
ODE_EVENT,
>>>>> +                                        &sel_prof);
>>>> Is it really necessary to call the notifier here? AFAIK the notifier =
needs to be called
>>>> only:
>>>>
>>>>     - when the platform profile was changed either by the user or the=
 firmware.
>>>>     - when a new notifier handler was registered so that the handler =
does not have to wait for the next user input
>>>>
>>>> Please only call the notifier in those two situations.
>>>>
>>> I was originally calling it here to solve a problem with synchronizing
>>> the drivers. Lenovo-wmi-other registers a notifier block before
>>> gamezone inits the platform profile. That means I can't use _notify
>>> during the _register to get the initial profile to the block members.
>>> Since the platform profile makes an initial request after it registers
>>> this is a simple way to propagate when the platform profile is ready.
>>> I'm not sure of another way to trigger a notification chain once the
>>> information is available.
>>>
>>>>> +     if (ret =3D=3D NOTIFY_BAD)
>>>>> +             pr_err("Failed to send notification to call chain for =
WMI event %u\n",
>>>>> +                    priv->type);
>>>> Use dev_err() here please.
>>>>
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int lenovo_wmi_gz_profile_set(struct device *dev,
>>>>> +                                  enum platform_profile_option prof=
ile)
>>>>> +{
>>>>> +     struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
>>>>> +     int sel_prof;
>>>>> +     int ret;
>>>>> +
>>>>> +     switch (profile) {
>>>>> +     case PLATFORM_PROFILE_LOW_POWER:
>>>>> +             sel_prof =3D SMARTFAN_MODE_QUIET;
>>>>> +             break;
>>>>> +     case PLATFORM_PROFILE_BALANCED:
>>>>> +             sel_prof =3D SMARTFAN_MODE_BALANCED;
>>>>> +             break;
>>>>> +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>>>> +             sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
>>>>> +             break;
>>>>> +     case PLATFORM_PROFILE_PERFORMANCE:
>>>>> +             if (priv->extreme_supported) {
>>>>> +                     sel_prof =3D SMARTFAN_MODE_EXTREME;
>>>>> +                     break;
>>>>> +             }
>>>>> +             sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
>>>>> +             break;
>>>>> +     case PLATFORM_PROFILE_CUSTOM:
>>>>> +             sel_prof =3D SMARTFAN_MODE_CUSTOM;
>>>>> +             break;
>>>>> +     default:
>>>>> +             return -EOPNOTSUPP;
>>>>> +     }
>>>>> +
>>>>> +     ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
>>>>> +                                           WMI_METHOD_ID_SMARTFAN_S=
ET, sel_prof, NULL);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct dmi_system_id fwbug_list[] =3D {
>>>>> +     {
>>>>> +             .ident =3D "Legion Go 8APU1",
>>>>> +             .matches =3D {
>>>>> +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>>> +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU=
1"),
>>>>> +             },
>>>>> +             .driver_data =3D &quirk_no_extreme_bug,
>>>>> +     },
>>>>> +     {
>>>>> +             .ident =3D "Legion Go S 8ARP1",
>>>>> +             .matches =3D {
>>>>> +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>>> +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8A=
RP1"),
>>>>> +             },
>>>>> +             .driver_data =3D &quirk_no_extreme_bug,
>>>>> +     },
>>>>> +     {
>>>>> +             .ident =3D "Legion Go S 8APU1",
>>>>> +             .matches =3D {
>>>>> +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>>> +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8A=
PU1"),
>>>>> +             },
>>>>> +             .driver_data =3D &quirk_no_extreme_bug,
>>>>> +     },
>>>>> +     {},
>>>>> +
>>>>> +};
>>>>> +
>>>>> +static bool extreme_supported(int profile_support_ver)
>>>>> +{
>>>>> +     const struct dmi_system_id *dmi_id;
>>>>> +     struct quirk_entry *quirks;
>>>>> +
>>>>> +     if (profile_support_ver < 6)
>>>>> +             return false;
>>>>> +
>>>>> +     dmi_id =3D dmi_first_match(fwbug_list);
>>>>> +     if (!dmi_id)
>>>>> +             return true;
>>>>> +
>>>>> +     quirks =3D dmi_id->driver_data;
>>>>> +     return quirks->extreme_supported;
>>>>> +}
>>>>> +
>>>>> +static int lenovo_wmi_platform_profile_probe(void *drvdata,
>>>>> +                                          unsigned long *choices)
>>>>> +{
>>>>> +     struct lenovo_wmi_gz_priv *priv =3D drvdata;
>>>>> +     enum platform_profile_option profile;
>>>> Unused variable, please remove.
>>>>
>>>>> +     int profile_support_ver;
>>>>> +     int ret;
>>>>> +
>>>>> +     ret =3D lenovo_wmi_gz_platform_profile_supported(priv,
>>>>> +                                                    &profile_suppor=
t_ver);
>>>>> +     if (ret)
>>>>> +             return ret;
>>>>> +
>>>>> +     if (profile_support_ver < 1)
>>>>> +             return -ENODEV;
>>>>> +
>>>>> +     priv->extreme_supported =3D extreme_supported(profile_support_=
ver);
>>>>> +
>>>>> +     set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>>>> +     set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>>>> +     set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>>>> +     set_bit(PLATFORM_PROFILE_CUSTOM, choices);
>>>>> +
>>>>> +     if (priv->extreme_supported)
>>>>> +             set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices=
);
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct platform_profile_ops lenovo_wmi_gz_platform_pro=
file_ops =3D {
>>>>> +     .probe =3D lenovo_wmi_platform_profile_probe,
>>>>> +     .profile_get =3D lenovo_wmi_gz_profile_get,
>>>>> +     .profile_set =3D lenovo_wmi_gz_profile_set,
>>>>> +};
>>>>> +
>>>>> +/* Notifier Methods */
>>>>> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb)
>>>>> +{
>>>>> +     guard(mutex)(&gz_chain_mutex);
>>>> The blocking notifier already does the locking itself. Please remove =
this mutex.
>>>>
>>> Good to know, will fix, ty.
>>>
>>>>> +     return blocking_notifier_chain_register(&gz_chain_head, nb);
>>>>> +}
>>>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_register_notifier, "GZ_WMI");
>>>> Can you name the namespace similar to "LENOVO_GAMEZONE_WMI" please?
>>>>
>>> Acked
>>>
>>>>> +
>>>>> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb)
>>>>> +{
>>>>> +     guard(mutex)(&gz_chain_mutex);
>>>>> +     return blocking_notifier_chain_unregister(&gz_chain_head, nb);
>>>>> +}
>>>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_unregister_notifier, "GZ_WMI");
>>>>> +
>>>>> +static void devm_lenovo_wmi_gz_unregister_notifier(void *data)
>>>>> +{
>>>>> +     struct notifier_block *nb =3D data;
>>>>> +
>>>>> +     lenovo_wmi_gz_unregister_notifier(nb);
>>>>> +}
>>>>> +
>>>>> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
>>>>> +                                      struct notifier_block *nb)
>>>>> +{
>>>>> +     int ret;
>>>>> +
>>>>> +     ret =3D lenovo_wmi_gz_register_notifier(nb);
>>>>> +     if (ret < 0)
>>>>> +             return ret;
>>>>> +
>>>>> +     return devm_add_action_or_reset(dev, devm_lenovo_wmi_gz_unregi=
ster_notifier, nb);
>>>>> +}
>>>>> +EXPORT_SYMBOL_NS_GPL(devm_lenovo_wmi_gz_register_notifier, "GZ_WMI"=
);
>>>>> +
>>>>> +/* Driver Methods */
>>>>> +static void lenovo_wmi_gz_notify(struct wmi_device *wdev,
>>>>> +                              union acpi_object *obj)
>>>>> +{
>>>>> +     struct lenovo_wmi_gz_priv *tm_priv =3D dev_get_drvdata(&wdev->=
dev);
>>>>> +     struct lenovo_wmi_gz_priv *gz_priv =3D
>>>>> +             container_of(&gz_chain_head, struct lenovo_wmi_gz_priv=
, nhead);
>>>> I fear that this will not work because gz_chain_head is a global vari=
able, not a field inside
>>>> struct lenovo_wmi_gz_priv. Also this would crash the kernel should th=
e main gamezone driver be
>>>> unbound from its WMI device.
>>>>
>>>> I suggest you move the WMI driver for the WMI event into a separate m=
odule. Then you use another notifier
>>>> inside the new module to allow the gamezone driver to listen for even=
ts. For example this separate WMI event driver
>>>> could use the "val" argument inside blocking_notifier_call_chain() to=
 specify the type of event (like THERMAL_MODE_CHANGED)
>>>> and the "v" argument to pass a pointer to a u32 variable containing t=
he new thermal mode.
>>> I can do this, but we explicitly discussed doing it in one driver for
>>> all gamezone GUIDs. If I do this I'd like to confirm I won't need to
>>> revert on this later.
>>> As for naming, what would you suggest? Depending on scope it would
>>> either cover all lenovo_wmi-* events, or just the gamezone events.
>>>
>>> Kconfig: LENOVO_WMI_EVENTS | LENOVO_WMI_GAMEZONE_EVENTS
>>> .c: lenovo-wmi-events.c | lenovo-wmi-gamezone-events.c
>> I think there was a misunderstand here, with "one driver for all gamezo=
ne GUIDs" i meant
>> "one driver for all gamezone _event_ GUIDs". Sorry for that.
>>
>> Personally i would favor the lenovo-wmi-events name. With this we can a=
dd support for additional
>> WMI events later.
>>
> Okay, that sounds good to me.
> There is one thing I want to clarify for the gamezone driver. It will
> need to register two notifier blocks, correct? One for the "push"
> notification from events, and one for the "pull" notification call
> from other mode. My assumption is that we shouldn't use the same
> notifier_block on two chain heads, but I want to be sure before
> submitting.
>
> - Derek

Yes, using separate notification chains for WMI events and communication w=
ith
lenovo-wmi-other would make sense. This also means that you need to use se=
parate
notifier blocks for each chain.

Thanks,
Armin Wolf

>>>> This also allows you to extend the separate WMI driver later to suppo=
rt more WMI event GUIDs.
>>> There are 4 more gamezone event GUIDs that the Legion Go doesn't
>>> implement, so that would be a good place for them. I haven't added
>>> them as I cannot test them with my hardware.
>> This is fine, getting only the platform profile interface to work is a =
good start.
>>
>>>>> +     int sel_prof;
>>>>> +     int ret;
>>>>> +
>>>>> +     if (obj->type !=3D ACPI_TYPE_INTEGER)
>>>>> +             return;
>>>>> +
>>>>> +     switch (tm_priv->type) {
>>>>> +     case THERMAL_MODE:
>>>>> +             sel_prof =3D obj->integer.value;
>>>>> +             break;
>>>>> +     default:
>>>>> +             return;
>>>>> +     }
>>>>> +
>>>>> +     /* Update primary Gamezone instance */
>>>>> +     switch (sel_prof) {
>>>>> +     case SMARTFAN_MODE_QUIET:
>>>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_LOW_POWE=
R;
>>>>> +             break;
>>>>> +     case SMARTFAN_MODE_BALANCED:
>>>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_BALANCED=
;
>>>>> +             break;
>>>>> +     case SMARTFAN_MODE_PERFORMANCE:
>>>>> +             if (gz_priv->extreme_supported) {
>>>>> +                     gz_priv->current_profile =3D
>>>>> +                             PLATFORM_PROFILE_BALANCED_PERFORMANCE;
>>>>> +                     break;
>>>>> +             }
>>>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMA=
NCE;
>>>>> +             break;
>>>>> +     case SMARTFAN_MODE_EXTREME:
>>>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMA=
NCE;
>>>>> +             break;
>>>>> +     case SMARTFAN_MODE_CUSTOM:
>>>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_CUSTOM;
>>>>> +             break;
>>>>> +     default:
>>>>> +             break;
>>>>> +     }
>>>> Please use platform_profile_notify() to notify userspace of the new p=
latform profile settings.
>>> That makes sense.
>>>
>>>>> +
>>>>> +     ret =3D blocking_notifier_call_chain(&gz_chain_head, THERMAL_M=
ODE_EVENT,
>>>>> +                                        &sel_prof);
>>>>> +     if (ret =3D=3D NOTIFY_BAD)
>>>>> +             pr_err("Failed to send notification to call chain for =
WMI event %u\n",
>>>>> +                    tm_priv->type);
>>>>> +}
>>>>> +
>>>>> +static int lenovo_wmi_gz_probe(struct wmi_device *wdev, const void =
*context)
>>>>> +{
>>>>> +     struct lenovo_wmi_gz_priv *priv =3D
>>>>> +             devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>>>> Please do the call to devm_kzalloc() on a separate line:
>>>>
>>>>           struct lenovo_wmi_gz_priv *priv;
>>>>
>>>>           priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL=
);
>>>>
>>> Understood
>>>
>>>>> +
>>>>> +     if (!priv)
>>>>> +             return -ENOMEM;
>>>>> +
>>>>> +     if (!context)
>>>>> +             return -EINVAL;
>>>>> +
>>>>> +     priv->wdev =3D wdev;
>>>>> +     priv->type =3D *((enum lenovo_wmi_gz_type *)context);
>>>>> +
>>>>> +     dev_set_drvdata(&wdev->dev, priv);
>>>>> +
>>>>> +     if (priv->type !=3D GAMEZONE_FULL)
>>>>> +             return 0;
>>>>> +
>>>>> +     priv->nhead =3D gz_chain_head;
>>>>> +     priv->ppdev =3D platform_profile_register(&wdev->dev, "lenovo-=
wmi-gamezone",
>>>>> +                                             priv, &lenovo_wmi_gz_p=
latform_profile_ops);
>>>> Please check if platform_profile_register() was successful and return=
 an error if not.
>>>>
>>> Will do, ty.
>>>
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct wmi_device_id lenovo_wmi_gz_id_table[] =3D {
>>>>> +     { GAMEZONE_WMI_DEVICE(LENOVO_GAMEZONE_GUID, GAMEZONE_FULL) },
>>>>> +     { GAMEZONE_WMI_DEVICE(THERMAL_MODE_EVENT_GUID, THERMAL_MODE) }=
,
>>>>> +     {}
>>>>> +};
>>>>> +
>>>>> +static struct wmi_driver lenovo_wmi_gz_driver =3D {
>>>>> +     .driver =3D {
>>>>> +             .name =3D "lenovo_wmi_gamezone",
>>>>> +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>>>>> +     },
>>>>> +     .id_table =3D lenovo_wmi_gz_id_table,
>>>>> +     .probe =3D lenovo_wmi_gz_probe,
>>>>> +     .notify =3D lenovo_wmi_gz_notify,
>>>>> +     .no_singleton =3D true,
>>>>> +};
>>>>> +
>>>>> +module_wmi_driver(lenovo_wmi_gz_driver);
>>>>> +
>>>>> +MODULE_IMPORT_NS("LENOVO_WMI");
>>>>> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_gz_id_table);
>>>>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>>>> +MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
>>>>> +MODULE_LICENSE("GPL");
>>>>> diff --git a/drivers/platform/x86/lenovo-wmi.c b/drivers/platform/x8=
6/lenovo-wmi.c
>>>>> new file mode 100644
>>>>> index 000000000000..0de2c37e69bd
>>>>> --- /dev/null
>>>>> +++ b/drivers/platform/x86/lenovo-wmi.c
>>>>> @@ -0,0 +1,77 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>>> +/*
>>>>> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interf=
ace is
>>>>> + * broken up into multiple GUID interfaces that require cross-refer=
ences
>>>>> + * between GUID's for some functionality. The "Custom Method" inter=
face is a
>>>>> + * legacy interface for managing and displaying CPU & GPU power and=
 hwmon
>>>>> + * settings and readings. The "Other Mode" interface is a modern in=
terface
>>>>> + * that replaces or extends the "Custom Method" interface methods. =
The
>>>>> + * "Gamezone" interface adds advanced features such as fan profiles=
 and
>>>>> + * overclocking. The "Lighting" interface adds control of various s=
tatus
>>>>> + * lights related to different hardware components. "Other Mode" us=
es
>>>>> + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DA=
TA_01
>>>>> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information=
.
>>>>> + *
>>>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#include <linux/wmi.h>
>>>>> +#include "lenovo-wmi.h"
>>>>> +
>>>>> +/* wmidev_evaluate_method helper functions */
>>>>> +static int lenovo_wmidev_evaluate_method(struct wmi_device *wdev, u=
8 instance,
>>>>> +                                      u32 method_id, struct acpi_bu=
ffer *in,
>>>>> +                                      struct acpi_buffer *out)
>>>>> +{
>>>>> +     acpi_status status;
>>>>> +
>>>>> +     status =3D wmidev_evaluate_method(wdev, instance, method_id, i=
n, out);
>>>>> +
>>>>> +     if (ACPI_FAILURE(status))
>>>>> +             return -EIO;
>>>>> +
>>>>> +     return 0;
>>>>> +};
>>>>> +
>>>>> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 ins=
tance,
>>>>> +                                 u32 method_id, u32 arg0, u32 arg1,
>>>>> +                                 u32 *retval)
>>>>> +{
>>>> Please give this method a more descriptive name.
>>>>
>>> Okay. I followed the convention in asus_wmi here as it takes 2 args
>>> and _1 takes one arg. When I add fan profiles later I'll need one that
>>> takes one u64 arg as well, and I think some other GUID's I don't yet
>>> have implemented have 3 or 4 u16 args. Do you have a suggestion on how
>>> you'd prefer them named? My instinct would be to simplify to three,
>>> _u16, _u32, _u64, and pass 0 to unused args instead of having a second
>>> _1 helper.
>> Good question, would it make sense to just pass the arguments as a sing=
le byte buffer?
>>
>>>>> +     struct wmi_method_args args =3D { arg0, arg1 };
>>>>> +     struct acpi_buffer input =3D { (acpi_size)sizeof(args), &args =
};
>>>> Cast to acpi_size is unnecessary here.
>>> Acked
>>>
>>>>> +     struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>>>> +     union acpi_object *ret_obj __free(kfree) =3D NULL;
>>>>> +     int err;
>>>>> +
>>>>> +     err =3D lenovo_wmidev_evaluate_method(wdev, instance, method_i=
d, &input,
>>>>> +                                         &output);
>>>>> +
>>>>> +     if (err)
>>>>> +             return err;
>>>>> +
>>>>> +     if (retval) {
>>>>> +             ret_obj =3D (union acpi_object *)output.pointer;
>>>>> +             if (!ret_obj)
>>>>> +                     return -ENODATA;
>>>>> +
>>>>> +             if (ret_obj->type !=3D ACPI_TYPE_INTEGER)
>>>>> +                     return -ENXIO;
>>>>> +
>>>>> +             *retval =3D (u32)ret_obj->integer.value;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_2, "LENOVO_WMI")=
;
>>>> Can you please rename the namespace to "LENOVO_WMI_HELPERS"?
>>> Yes
>>>
>>>>> +
>>>>> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 ins=
tance,
>>>>> +                                 u32 method_id, u32 arg0, u32 *retv=
al)
>>>>> +{
>>>> Same as above.
>>>>
>>>>> +     return lenovo_wmidev_evaluate_method_2(wdev, instance, method_=
id, arg0,
>>>>> +                                            0, retval);
>>>>> +}
>>>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_1, "LENOVO_WMI")=
;
>>>>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>>>> +MODULE_DESCRIPTION("Lenovo WMI Common Driver");
>>>>> +MODULE_LICENSE("GPL");
>>>>> diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x8=
6/lenovo-wmi.h
>>>>> new file mode 100644
>>>>> index 000000000000..113928b4fc0f
>>>>> --- /dev/null
>>>>> +++ b/drivers/platform/x86/lenovo-wmi.h
>>>>> @@ -0,0 +1,62 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + *
>>>>> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interf=
ace is
>>>>> + * broken up into multiple GUID interfaces that require cross-refer=
ences
>>>>> + * between GUID's for some functionality. The "Custom Method" inter=
face is a
>>>>> + * legacy interface for managing and displaying CPU & GPU power and=
 hwmon
>>>>> + * settings and readings. The "Other Mode" interface is a modern in=
terface
>>>>> + * that replaces or extends the "Custom Method" interface methods. =
The
>>>>> + * "Gamezone" interface adds advanced features such as fan profiles=
 and
>>>>> + * overclocking. The "Lighting" interface adds control of various s=
tatus
>>>>> + * lights related to different hardware components. "Other Mode" us=
es
>>>>> + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DA=
TA_01
>>>>> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information=
.
>>>>> + *
>>>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>>>>> + *
>>>>> + */
>>>>> +#include <linux/notifier.h>
>>>>> +#include <linux/platform_profile.h>
>>>>> +
>>>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>> This causes a build error on my machine. Please only use this macro i=
nside source files
>>>> for modules and not inside header files.
>>> This also causes a build error on my machine inside the .c sources.
>>> I'm not sure why.
>> The reason for this is that some drivers including this header file als=
o define this macro.
>> In general this macro should only be used inside source files for modul=
es.
>>
>> Thanks,
>> Armin Wolf
>>
>>>>> +
>>>>> +#ifndef _LENOVO_WMI_H_
>>>>> +#define _LENOVO_WMI_H_
>>>>> +
>>>>> +#include <linux/bits.h>
>>>>> +#include <linux/types.h>
>>>>> +#include <linux/wmi.h>
>>>>> +
>>>>> +struct wmi_method_args {
>>>>> +     u32 arg0;
>>>>> +     u32 arg1;
>>>>> +};
>>>>> +
>>>>> +/* gamezone structs */
>>>>> +enum thermal_mode {
>>>>> +     SMARTFAN_MODE_QUIET =3D 0x01,
>>>>> +     SMARTFAN_MODE_BALANCED =3D 0x02,
>>>>> +     SMARTFAN_MODE_PERFORMANCE =3D 0x03,
>>>>> +     SMARTFAN_MODE_EXTREME =3D 0xE0, /* Ver 6+ */
>>>>> +     SMARTFAN_MODE_CUSTOM =3D 0xFF,
>>>>> +};
>>>>> +
>>>>> +enum lenovo_wmi_action {
>>>>> +     THERMAL_MODE_EVENT =3D 1,
>>>>> +};
>>>>> +
>>>>> +/* wmidev_evaluate_method helper functions */
>>>>> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 ins=
tance,
>>>>> +                                 u32 method_id, u32 arg0, u32 arg1,
>>>>> +                                 u32 *retval);
>>>>> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 ins=
tance,
>>>>> +                                 u32 method_id, u32 arg0, u32 *retv=
al);
>>>>> +
>>>>> +/* lenovo_wmi_gz_driver notifier functions */
>>>>> +int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned=
 long action,
>>>>> +                             enum platform_profile_option *profile)=
;
>>>>> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb);
>>>>> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb);
>>>>> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
>>>>> +                                      struct notifier_block *nb);
>>>> Can you please create a separate header file for each driver? Otherwi=
se this header file
>>>> will contain many different things from different drivers, which will=
 maybe not even be
>>>> available depending on the Kconfig settings.
>>> Can do.
>>>
>>> Cheers,
>>> - Derek
>>>
>>>> Thanks,
>>>> Armin Wolf
>>>>
>>>>> +#endif /* !_LENOVO_WMI_H_ */

