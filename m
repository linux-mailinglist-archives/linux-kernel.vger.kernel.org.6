Return-Path: <linux-kernel+bounces-556925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3093AA5D0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630323B79AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C4E264A68;
	Tue, 11 Mar 2025 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="i6KqrtZo"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9CE3FD1;
	Tue, 11 Mar 2025 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725041; cv=none; b=rFXMjwzuObfT8L1sOogzXsFZnuo2lMeAy0wA+HKRClCp/65A2TaVg0/hBGcxS16GXv0aiDUv440rkV3RagZbrGF1lwkB5W7EvSQXUeTqeV+8kjymV/IgegWeTQ06kj+1veVcZpP5/Ty9GYmbiN0UQMVMnc2RQttA2ujtLAnYp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725041; c=relaxed/simple;
	bh=46at/I5ydrLEd6kUtYbKEz58BOPNBYaXkp9M5Abf/Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBii8oCnDh8Rf84FxOTuvyM5okCk7k7tYvBpWdHFC65FeGtcYNK/umMflh5mcDO08gahNz4sqoQrpbsbE2DGvK54lbv2jZ+xZSuuNDZ2O1EbVuhwJTISKtvzevXY12qRglY3yPHpxV4OgYn05pL8aH3de2OBy3rm7GWnAJKHEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=i6KqrtZo; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741725018; x=1742329818; i=w_armin@gmx.de;
	bh=xg/e1QaTTiZdwdE7sRI3TBFUJAruRn327FFkY5FQ7FU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i6KqrtZo5cwsTaQsOBwycSt7LbivpJqIb5KNjUXDhaujywiQVlsaCmoScP2QuC29
	 7sHoyPOjHupmznOILyUFP9tk1SOIieN53ZEGVMg8mMYVV1E69RtmDM0irr1TluJps
	 tgjmkLjSA84/7GRLuTOyCkRbBaBKUKRh6Wv8mxv24PkyFGlvdfYsZ6BaWVu0ezJG6
	 3WBVNxzn4sX+b5VCxQvWrSbjar9e72miec5lBFPmzGTJEsClijUyNjhj7Q0xOudXa
	 BAQqACKMKjpZw7iIGquptR1mXmu6kfwczAZ1yeliBziDEyK2DKgfQrlPPvGwpXgUV
	 /J67yK3+siNOh2HrnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1tKxLV326a-00efr5; Tue, 11
 Mar 2025 21:30:18 +0100
Message-ID: <229b2b2e-8404-4589-b364-af4a4a4c9461@gmx.de>
Date: Tue, 11 Mar 2025 21:30:15 +0100
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAFqHKTn7gjjAzJET2776z4HV+_=AigdKCnLZB7GOZNb_ib=Uhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:syze3dTOcgh9zWS9RKBOwF81/He7Ln2nMd+tfVHJg1Q1vagM0SZ
 4+oOsEMhz2ODfwahJg06yEFi1dUMg1qu9PDPzakWiW+6wAnsH8FNJco5E1NgGTZAi/Jhfge
 rcx9lXRzCEU0vLbzvfPoynE1Xe2jph6+mE5qBJxJJLC3pb6GfQoFqTDU8qlHVkrZ/PSjWeh
 ctLrNUiMAUzsY5ZpI4RDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dn5G5nJ4T0Y=;plvXzg+mGT3hQxAz4IF6eBTh1ID
 pXi7GWCWZdS6eFfQfdYe6/kvQQXbWPT1PpgzoqFhN0jMXoFFe5MgsS5RE8omZf7tK1/4UqkbF
 FZsTcFnCrYGkupZ6nvKOyOedadY0+jQpZdrT1XUif4Te9R9A/dfF6N+ZxuqNIUbOxup55omMK
 0KkFEqGIzMmZSCQ5OG2r+3W0SF+wmZDxLEC9J6RUCADlsUqK40EiEfy2Wc0SXPkCuByPzmcei
 tl/3hrBiakh+KMTEEybDXYWKDSqCeikHSHiH3kIcKXaaBjyk9s4sic1w/5y3FXKAo65PUXq9r
 4bcbJhouypUyPwbxYGICrCO60+dlKDXddZG7LGlM8LfJaBOF+4VCAb3Oe80xM1kddR1WlhTo6
 yASYhuVFfiRCBlbWFfS9tnyEfAJ1MKmpbpPw5oFqmrRb03bXtS7cepKszjJG5AOdRPOJvJIe+
 dQr1l9Pjb7NNLRDC4T5qHwMKlx+VfjaGMzzuwby0iaPtjlELMOX1SBGNg6RuB8H27Kyop7o5M
 QJuedSwgxTFaNnPJIYixHZWf0rv7aP08qnoJhYyQI8g1wB/Sc7CV1DZH0bJI3Jd/4uwjye+EN
 NKk4wwI9Opxx8kUr3PybLKkXuSYTf97KBClmzEZ1MBWDhu/GayANSlPM3FRBwBRlAkVipUjUu
 f86nGyo6073bk2WD2ggxpljDF+EDSvgsn785q7MV/Vcz7xiWZakWzs1SOQywGbap5xhECvIJu
 Ihbfk69eJMPN6pqzZpOD1M/REHzcun2xBaGcO5sUBYOAFenmaMODbfVxYIewxUH6VRivitTbi
 yRJvCmmq2QTL9wFTApryOqr8c14dEtMTtfxx+Jj+unwqX0wPitHq3x+J0JLRdQIVcfJa4PkLE
 xRYJgL+6OEtXDiK++ufJCJcVDcddKJMl98G5pPOZ7bG400OjQ+nGVZysKfMtEGBzXxDRUxQM2
 u6EHmz09HxV6WQ0HT2X31xJXELfbRCDcd76lngAHIABtXmLINvKYFr4o7gIAIzjEDd2PvfEgv
 nyS7lpAQFGlbX47wnJlKGjETBmfnZIdP7bCHRtq3PsicHgDEZyND54H/acJhlLOFRg644W6GM
 bzPA2m9sDcb/KxBqALXiu2c3wZ3QH5eZcPW8zxgIX4MJbNBNFCjSDt3+qR980s+o/O6HTJuM1
 1hheIYq8Ms+e3yuUXACxKojIzbT3hasVpoP5e5TT/U2ZRXQOgOy4CoB/+d5yhdnWlP5+P6VT1
 rKyfuOaPe4r1pRQZQZAxdZ75enRzlLxo0+Eahk0cT+GoQyoD1Tu7MXmQwAKnZsmGGeZ3MPNch
 II1GIYhzRM2kHErAwpRhnm1f5zksTJmnsllYnoG6dAfcWXlGUmPMNJGXBjUXZxVQaDM0Wq0aT
 BxnaMB+gjiCz2z9nvcAk7eJL/W7Y1n5ap/lsu9avz00bnq/rcRO2xd0UZgGdiXIaQfKbx98jD
 D+B+OuBuN5TldNR7C2Q5skVEkzyQ=

Am 10.03.25 um 23:11 schrieb Derek John Clark:

> On Fri, Mar 7, 2025 at 2:48=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote=
:
>> Am 25.02.25 um 22:59 schrieb Derek J. Clark:
>>
>>> Adds lenovo-wmi-gamezone.c which provides a driver for the Lenovo
>>> Gamezone WMI interface that comes on Lenovo "Gaming Series" hardware.
>>> Provides ACPI platform profiles over WMI.
>>>
>>> Adds lenovo-wmi.h and lenovo-wmi.c which provide helper functions for
>>> wmidev_evaluate_method as well as prototypes for exported functions.
>>> v3:
>>> - Use notifier chain to report platform profile changes to any
>>>     subscribed drivers.
>>> - Adds THERMAL_MODE_EVENT GUID and .notify function to trigger notifie=
r
>>>     chain.
>>> - Adds support for Extreme Mode profile on supported hardware, as well
>>>     as a DMI quirk table for some devices that report extreme mode ver=
sion
>>>     support but so not have it fully implemented.
>>> - Update to include recent changes to platform-profile.
>>> v2:
>>> - Use devm_kmalloc to ensure driver can be instanced, remove global
>>>     reference.
>>> - Ensure reverse Christmas tree for all variable declarations.
>>> - Remove extra whitespace.
>>> - Use guard(mutex) in all mutex instances, global mutex.
>>> - Use pr_fmt instead of adding the driver name to each pr_err.
>>> - Remove noisy pr_info usage.
>>> - Rename gamezone_wmi to lenovo_wmi_gz_priv and gz_wmi to priv.
>>> - Remove GZ_WMI symbol exporting.
>>>
>>> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
>>> ---
>>>    MAINTAINERS                                |   3 +
>>>    drivers/platform/x86/Kconfig               |  16 +
>>>    drivers/platform/x86/Makefile              |   2 +
>>>    drivers/platform/x86/lenovo-wmi-gamezone.c | 374 ++++++++++++++++++=
+++
>>>    drivers/platform/x86/lenovo-wmi.c          |  77 +++++
>>>    drivers/platform/x86/lenovo-wmi.h          |  62 ++++
>>>    6 files changed, 534 insertions(+)
>>>    create mode 100644 drivers/platform/x86/lenovo-wmi-gamezone.c
>>>    create mode 100644 drivers/platform/x86/lenovo-wmi.c
>>>    create mode 100644 drivers/platform/x86/lenovo-wmi.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e20c32b3c480..cf7f4fce1a25 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -13157,6 +13157,9 @@ L:    platform-driver-x86@vger.kernel.org
>>>    S:  Maintained
>>>    F:  Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>>>    F:  Documentation/wmi/devices/lenovo-wmi-other.rst
>>> +F:   drivers/platform/x86/lenovo-wmi-gamezone.c
>>> +F:   drivers/platform/x86/lenovo-wmi.c
>>> +F:   drivers/platform/x86/lenovo-wmi.h
>>>
>>>    LETSKETCH HID TABLET DRIVER
>>>    M:  Hans de Goede <hdegoede@redhat.com>
>>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconf=
ig
>>> index 7e20a58861eb..875822e6bd65 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -459,6 +459,22 @@ config IBM_RTL
>>>         state =3D 0 (BIOS SMIs on)
>>>         state =3D 1 (BIOS SMIs off)
>>>
>>> +config LENOVO_WMI
>>> +     tristate
>>> +     depends on ACPI_WMI
>> Please rename this module to LENOVO_WMI_HELPERS.
> Acked
>
>>> +
>>> +config LENOVO_WMI_GAMEZONE
>>> +     tristate "Lenovo GameZone WMI Driver"
>>> +     depends on ACPI_WMI
>>> +     select ACPI_PLATFORM_PROFILE
>>> +     select LENOVO_WMI
>>> +     help
>>> +       Say Y here if you have a WMI aware Lenovo Legion device and wo=
uld like to use the
>>> +       platform-profile firmware interface to manage power usage.
>>> +
>>> +       To compile this driver as a module, choose M here: the module =
will
>>> +       be called lenovo-wmi-gamezone.
>>> +
>>>    config IDEAPAD_LAPTOP
>>>        tristate "Lenovo IdeaPad Laptop Extras"
>>>        depends on ACPI
>>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Make=
file
>>> index 5f6307246e69..4a7b2d14eb82 100644
>>> --- a/drivers/platform/x86/Makefile
>>> +++ b/drivers/platform/x86/Makefile
>>> @@ -67,7 +67,9 @@ obj-$(CONFIG_THINKPAD_ACPI) +=3D thinkpad_acpi.o
>>>    obj-$(CONFIG_THINKPAD_LMI)  +=3D think-lmi.o
>>>    obj-$(CONFIG_YOGABOOK)              +=3D lenovo-yogabook.o
>>>    obj-$(CONFIG_YT2_1380)              +=3D lenovo-yoga-tab2-pro-1380-=
fastcharger.o
>>> +obj-$(CONFIG_LENOVO_WMI)     +=3D lenovo-wmi.o
>>>    obj-$(CONFIG_LENOVO_WMI_CAMERA)     +=3D lenovo-wmi-camera.o
>>> +obj-$(CONFIG_LENOVO_WMI_GAMEZONE)    +=3D lenovo-wmi-gamezone.o
>>>
>>>    # Intel
>>>    obj-y                               +=3D intel/
>>> diff --git a/drivers/platform/x86/lenovo-wmi-gamezone.c b/drivers/plat=
form/x86/lenovo-wmi-gamezone.c
>>> new file mode 100644
>>> index 000000000000..d5329fecba47
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/lenovo-wmi-gamezone.c
>>> @@ -0,0 +1,374 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Lenovo GameZone WMI interface driver. The GameZone WMI interface p=
rovides
>>> + * platform profile and fan curve settings for devices that fall unde=
r the
>>> + * "Gaming Series" of Lenovo Legion devices.
>>> + *
>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>>> + */
>>> +
>>> +#include "linux/container_of.h"
>>> +#include "linux/printk.h"
>>> +#include <linux/cleanup.h>
>>> +#include <linux/dev_printk.h>
>>> +#include <linux/dmi.h>
>>> +#include <linux/list.h>
>>> +#include <linux/notifier.h>
>>> +#include <linux/platform_profile.h>
>>> +#include <linux/types.h>
>>> +#include <linux/wmi.h>
>>> +#include "lenovo-wmi.h"
>>> +
>>> +/* Interface GUIDs */
>>> +#define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
>>> +#define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B5F=
"
>>> +
>>> +/* Method IDs */
>>> +#define WMI_METHOD_ID_SMARTFAN_SUPP 43 /* IsSupportSmartFan */
>>> +#define WMI_METHOD_ID_SMARTFAN_SET 44 /* SetSmartFanMode */
>>> +#define WMI_METHOD_ID_SMARTFAN_GET 45 /* GetSmartFanMode */
>>> +
>>> +enum lenovo_wmi_gz_type {
>>> +     GAMEZONE_FULL =3D 1,
>>> +     THERMAL_MODE,
>>> +};
>>> +
>>> +#define GAMEZONE_WMI_DEVICE(guid, type)                              =
\
>>> +     .guid_string =3D (guid), .context =3D &(enum lenovo_wmi_gz_type)=
 \
>>> +     {                                                            \
>>> +             type                                                 \
>>> +     }
>>> +
>>> +static BLOCKING_NOTIFIER_HEAD(gz_chain_head);
>>> +static DEFINE_MUTEX(gz_chain_mutex);
>>> +
>>> +struct lenovo_wmi_gz_priv {
>>> +     enum platform_profile_option current_profile;
>> This variable is only assigned and never read, please remove it.
> You're correct for this version. I re-added it when working on the
> notifier chain but didn't end up using it. I'll make sure no unused
> variables are in the next version.
>
>>> +     struct wmi_device *wdev;
>>> +     bool extreme_supported;
>>> +     struct device *ppdev; /*platform profile device */
>>> +     enum lenovo_wmi_gz_type type;
>>> +     struct blocking_notifier_head nhead;
>>> +};
>>> +
>>> +struct quirk_entry {
>>> +     bool extreme_supported;
>>> +};
>>> +
>>> +static struct quirk_entry quirk_no_extreme_bug =3D {
>>> +     .extreme_supported =3D false,
>>> +};
>> Can you make this const?
>>
>>> +
>>> +/* Platform Profile Methods & Setup */
>>> +static int
>>> +lenovo_wmi_gz_platform_profile_supported(struct lenovo_wmi_gz_priv *p=
riv,
>>> +                                      int *supported)
>>> +{
>>> +     return lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
>>> +                                            WMI_METHOD_ID_SMARTFAN_SU=
PP, 0, supported);
>>> +}
>>> +
>>> +static int lenovo_wmi_gz_profile_get(struct device *dev,
>>> +                                  enum platform_profile_option *profi=
le)
>>> +{
>>> +     struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
>>> +     int sel_prof;
>>> +     int ret;
>>> +
>>> +     ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
>>> +                                           WMI_METHOD_ID_SMARTFAN_GET=
, 0, &sel_prof);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     switch (sel_prof) {
>>> +     case SMARTFAN_MODE_QUIET:
>>> +             *profile =3D PLATFORM_PROFILE_LOW_POWER;
>>> +             break;
>>> +     case SMARTFAN_MODE_BALANCED:
>>> +             *profile =3D PLATFORM_PROFILE_BALANCED;
>>> +             break;
>>> +     case SMARTFAN_MODE_PERFORMANCE:
>>> +             if (priv->extreme_supported) {
>>> +                     *profile =3D PLATFORM_PROFILE_BALANCED_PERFORMAN=
CE;
>>> +                     break;
>>> +             }
>>> +             *profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>> +             break;
>>> +     case SMARTFAN_MODE_EXTREME:
>>> +             *profile =3D PLATFORM_PROFILE_PERFORMANCE;
>>> +             break;
>>> +     case SMARTFAN_MODE_CUSTOM:
>>> +             *profile =3D PLATFORM_PROFILE_CUSTOM;
>>> +             break;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     priv->current_profile =3D *profile;
>>> +
>>> +     ret =3D blocking_notifier_call_chain(&gz_chain_head, THERMAL_MOD=
E_EVENT,
>>> +                                        &sel_prof);
>> Is it really necessary to call the notifier here? AFAIK the notifier ne=
eds to be called
>> only:
>>
>>    - when the platform profile was changed either by the user or the fi=
rmware.
>>    - when a new notifier handler was registered so that the handler doe=
s not have to wait for the next user input
>>
>> Please only call the notifier in those two situations.
>>
> I was originally calling it here to solve a problem with synchronizing
> the drivers. Lenovo-wmi-other registers a notifier block before
> gamezone inits the platform profile. That means I can't use _notify
> during the _register to get the initial profile to the block members.
> Since the platform profile makes an initial request after it registers
> this is a simple way to propagate when the platform profile is ready.
> I'm not sure of another way to trigger a notification chain once the
> information is available.
>
>>> +     if (ret =3D=3D NOTIFY_BAD)
>>> +             pr_err("Failed to send notification to call chain for WM=
I event %u\n",
>>> +                    priv->type);
>> Use dev_err() here please.
>>
>>> +     return 0;
>>> +}
>>> +
>>> +static int lenovo_wmi_gz_profile_set(struct device *dev,
>>> +                                  enum platform_profile_option profil=
e)
>>> +{
>>> +     struct lenovo_wmi_gz_priv *priv =3D dev_get_drvdata(dev);
>>> +     int sel_prof;
>>> +     int ret;
>>> +
>>> +     switch (profile) {
>>> +     case PLATFORM_PROFILE_LOW_POWER:
>>> +             sel_prof =3D SMARTFAN_MODE_QUIET;
>>> +             break;
>>> +     case PLATFORM_PROFILE_BALANCED:
>>> +             sel_prof =3D SMARTFAN_MODE_BALANCED;
>>> +             break;
>>> +     case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>>> +             sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
>>> +             break;
>>> +     case PLATFORM_PROFILE_PERFORMANCE:
>>> +             if (priv->extreme_supported) {
>>> +                     sel_prof =3D SMARTFAN_MODE_EXTREME;
>>> +                     break;
>>> +             }
>>> +             sel_prof =3D SMARTFAN_MODE_PERFORMANCE;
>>> +             break;
>>> +     case PLATFORM_PROFILE_CUSTOM:
>>> +             sel_prof =3D SMARTFAN_MODE_CUSTOM;
>>> +             break;
>>> +     default:
>>> +             return -EOPNOTSUPP;
>>> +     }
>>> +
>>> +     ret =3D lenovo_wmidev_evaluate_method_1(priv->wdev, 0x0,
>>> +                                           WMI_METHOD_ID_SMARTFAN_SET=
, sel_prof, NULL);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct dmi_system_id fwbug_list[] =3D {
>>> +     {
>>> +             .ident =3D "Legion Go 8APU1",
>>> +             .matches =3D {
>>> +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"=
),
>>> +             },
>>> +             .driver_data =3D &quirk_no_extreme_bug,
>>> +     },
>>> +     {
>>> +             .ident =3D "Legion Go S 8ARP1",
>>> +             .matches =3D {
>>> +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8ARP=
1"),
>>> +             },
>>> +             .driver_data =3D &quirk_no_extreme_bug,
>>> +     },
>>> +     {
>>> +             .ident =3D "Legion Go S 8APU1",
>>> +             .matches =3D {
>>> +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Legion Go S 8APU=
1"),
>>> +             },
>>> +             .driver_data =3D &quirk_no_extreme_bug,
>>> +     },
>>> +     {},
>>> +
>>> +};
>>> +
>>> +static bool extreme_supported(int profile_support_ver)
>>> +{
>>> +     const struct dmi_system_id *dmi_id;
>>> +     struct quirk_entry *quirks;
>>> +
>>> +     if (profile_support_ver < 6)
>>> +             return false;
>>> +
>>> +     dmi_id =3D dmi_first_match(fwbug_list);
>>> +     if (!dmi_id)
>>> +             return true;
>>> +
>>> +     quirks =3D dmi_id->driver_data;
>>> +     return quirks->extreme_supported;
>>> +}
>>> +
>>> +static int lenovo_wmi_platform_profile_probe(void *drvdata,
>>> +                                          unsigned long *choices)
>>> +{
>>> +     struct lenovo_wmi_gz_priv *priv =3D drvdata;
>>> +     enum platform_profile_option profile;
>> Unused variable, please remove.
>>
>>> +     int profile_support_ver;
>>> +     int ret;
>>> +
>>> +     ret =3D lenovo_wmi_gz_platform_profile_supported(priv,
>>> +                                                    &profile_support_=
ver);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     if (profile_support_ver < 1)
>>> +             return -ENODEV;
>>> +
>>> +     priv->extreme_supported =3D extreme_supported(profile_support_ve=
r);
>>> +
>>> +     set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
>>> +     set_bit(PLATFORM_PROFILE_BALANCED, choices);
>>> +     set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>>> +     set_bit(PLATFORM_PROFILE_CUSTOM, choices);
>>> +
>>> +     if (priv->extreme_supported)
>>> +             set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct platform_profile_ops lenovo_wmi_gz_platform_profi=
le_ops =3D {
>>> +     .probe =3D lenovo_wmi_platform_profile_probe,
>>> +     .profile_get =3D lenovo_wmi_gz_profile_get,
>>> +     .profile_set =3D lenovo_wmi_gz_profile_set,
>>> +};
>>> +
>>> +/* Notifier Methods */
>>> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb)
>>> +{
>>> +     guard(mutex)(&gz_chain_mutex);
>> The blocking notifier already does the locking itself. Please remove th=
is mutex.
>>
> Good to know, will fix, ty.
>
>>> +     return blocking_notifier_chain_register(&gz_chain_head, nb);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_register_notifier, "GZ_WMI");
>> Can you name the namespace similar to "LENOVO_GAMEZONE_WMI" please?
>>
> Acked
>
>>> +
>>> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb)
>>> +{
>>> +     guard(mutex)(&gz_chain_mutex);
>>> +     return blocking_notifier_chain_unregister(&gz_chain_head, nb);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmi_gz_unregister_notifier, "GZ_WMI");
>>> +
>>> +static void devm_lenovo_wmi_gz_unregister_notifier(void *data)
>>> +{
>>> +     struct notifier_block *nb =3D data;
>>> +
>>> +     lenovo_wmi_gz_unregister_notifier(nb);
>>> +}
>>> +
>>> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
>>> +                                      struct notifier_block *nb)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret =3D lenovo_wmi_gz_register_notifier(nb);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     return devm_add_action_or_reset(dev, devm_lenovo_wmi_gz_unregist=
er_notifier, nb);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(devm_lenovo_wmi_gz_register_notifier, "GZ_WMI");
>>> +
>>> +/* Driver Methods */
>>> +static void lenovo_wmi_gz_notify(struct wmi_device *wdev,
>>> +                              union acpi_object *obj)
>>> +{
>>> +     struct lenovo_wmi_gz_priv *tm_priv =3D dev_get_drvdata(&wdev->de=
v);
>>> +     struct lenovo_wmi_gz_priv *gz_priv =3D
>>> +             container_of(&gz_chain_head, struct lenovo_wmi_gz_priv, =
nhead);
>> I fear that this will not work because gz_chain_head is a global variab=
le, not a field inside
>> struct lenovo_wmi_gz_priv. Also this would crash the kernel should the =
main gamezone driver be
>> unbound from its WMI device.
>>
>> I suggest you move the WMI driver for the WMI event into a separate mod=
ule. Then you use another notifier
>> inside the new module to allow the gamezone driver to listen for events=
. For example this separate WMI event driver
>> could use the "val" argument inside blocking_notifier_call_chain() to s=
pecify the type of event (like THERMAL_MODE_CHANGED)
>> and the "v" argument to pass a pointer to a u32 variable containing the=
 new thermal mode.
> I can do this, but we explicitly discussed doing it in one driver for
> all gamezone GUIDs. If I do this I'd like to confirm I won't need to
> revert on this later.
> As for naming, what would you suggest? Depending on scope it would
> either cover all lenovo_wmi-* events, or just the gamezone events.
>
> Kconfig: LENOVO_WMI_EVENTS | LENOVO_WMI_GAMEZONE_EVENTS
> .c: lenovo-wmi-events.c | lenovo-wmi-gamezone-events.c

I think there was a misunderstand here, with "one driver for all gamezone =
GUIDs" i meant
"one driver for all gamezone _event_ GUIDs". Sorry for that.

Personally i would favor the lenovo-wmi-events name. With this we can add =
support for additional
WMI events later.

>> This also allows you to extend the separate WMI driver later to support=
 more WMI event GUIDs.
> There are 4 more gamezone event GUIDs that the Legion Go doesn't
> implement, so that would be a good place for them. I haven't added
> them as I cannot test them with my hardware.

This is fine, getting only the platform profile interface to work is a goo=
d start.

>>> +     int sel_prof;
>>> +     int ret;
>>> +
>>> +     if (obj->type !=3D ACPI_TYPE_INTEGER)
>>> +             return;
>>> +
>>> +     switch (tm_priv->type) {
>>> +     case THERMAL_MODE:
>>> +             sel_prof =3D obj->integer.value;
>>> +             break;
>>> +     default:
>>> +             return;
>>> +     }
>>> +
>>> +     /* Update primary Gamezone instance */
>>> +     switch (sel_prof) {
>>> +     case SMARTFAN_MODE_QUIET:
>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_LOW_POWER;
>>> +             break;
>>> +     case SMARTFAN_MODE_BALANCED:
>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_BALANCED;
>>> +             break;
>>> +     case SMARTFAN_MODE_PERFORMANCE:
>>> +             if (gz_priv->extreme_supported) {
>>> +                     gz_priv->current_profile =3D
>>> +                             PLATFORM_PROFILE_BALANCED_PERFORMANCE;
>>> +                     break;
>>> +             }
>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMANC=
E;
>>> +             break;
>>> +     case SMARTFAN_MODE_EXTREME:
>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_PERFORMANC=
E;
>>> +             break;
>>> +     case SMARTFAN_MODE_CUSTOM:
>>> +             gz_priv->current_profile =3D PLATFORM_PROFILE_CUSTOM;
>>> +             break;
>>> +     default:
>>> +             break;
>>> +     }
>> Please use platform_profile_notify() to notify userspace of the new pla=
tform profile settings.
> That makes sense.
>
>>> +
>>> +     ret =3D blocking_notifier_call_chain(&gz_chain_head, THERMAL_MOD=
E_EVENT,
>>> +                                        &sel_prof);
>>> +     if (ret =3D=3D NOTIFY_BAD)
>>> +             pr_err("Failed to send notification to call chain for WM=
I event %u\n",
>>> +                    tm_priv->type);
>>> +}
>>> +
>>> +static int lenovo_wmi_gz_probe(struct wmi_device *wdev, const void *c=
ontext)
>>> +{
>>> +     struct lenovo_wmi_gz_priv *priv =3D
>>> +             devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>> Please do the call to devm_kzalloc() on a separate line:
>>
>>          struct lenovo_wmi_gz_priv *priv;
>>
>>          priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>>
> Understood
>
>>> +
>>> +     if (!priv)
>>> +             return -ENOMEM;
>>> +
>>> +     if (!context)
>>> +             return -EINVAL;
>>> +
>>> +     priv->wdev =3D wdev;
>>> +     priv->type =3D *((enum lenovo_wmi_gz_type *)context);
>>> +
>>> +     dev_set_drvdata(&wdev->dev, priv);
>>> +
>>> +     if (priv->type !=3D GAMEZONE_FULL)
>>> +             return 0;
>>> +
>>> +     priv->nhead =3D gz_chain_head;
>>> +     priv->ppdev =3D platform_profile_register(&wdev->dev, "lenovo-wm=
i-gamezone",
>>> +                                             priv, &lenovo_wmi_gz_pla=
tform_profile_ops);
>> Please check if platform_profile_register() was successful and return a=
n error if not.
>>
> Will do, ty.
>
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct wmi_device_id lenovo_wmi_gz_id_table[] =3D {
>>> +     { GAMEZONE_WMI_DEVICE(LENOVO_GAMEZONE_GUID, GAMEZONE_FULL) },
>>> +     { GAMEZONE_WMI_DEVICE(THERMAL_MODE_EVENT_GUID, THERMAL_MODE) },
>>> +     {}
>>> +};
>>> +
>>> +static struct wmi_driver lenovo_wmi_gz_driver =3D {
>>> +     .driver =3D {
>>> +             .name =3D "lenovo_wmi_gamezone",
>>> +             .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>>> +     },
>>> +     .id_table =3D lenovo_wmi_gz_id_table,
>>> +     .probe =3D lenovo_wmi_gz_probe,
>>> +     .notify =3D lenovo_wmi_gz_notify,
>>> +     .no_singleton =3D true,
>>> +};
>>> +
>>> +module_wmi_driver(lenovo_wmi_gz_driver);
>>> +
>>> +MODULE_IMPORT_NS("LENOVO_WMI");
>>> +MODULE_DEVICE_TABLE(wmi, lenovo_wmi_gz_id_table);
>>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>> +MODULE_DESCRIPTION("Lenovo GameZone WMI Driver");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/drivers/platform/x86/lenovo-wmi.c b/drivers/platform/x86/=
lenovo-wmi.c
>>> new file mode 100644
>>> index 000000000000..0de2c37e69bd
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/lenovo-wmi.c
>>> @@ -0,0 +1,77 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interfac=
e is
>>> + * broken up into multiple GUID interfaces that require cross-referen=
ces
>>> + * between GUID's for some functionality. The "Custom Method" interfa=
ce is a
>>> + * legacy interface for managing and displaying CPU & GPU power and h=
wmon
>>> + * settings and readings. The "Other Mode" interface is a modern inte=
rface
>>> + * that replaces or extends the "Custom Method" interface methods. Th=
e
>>> + * "Gamezone" interface adds advanced features such as fan profiles a=
nd
>>> + * overclocking. The "Lighting" interface adds control of various sta=
tus
>>> + * lights related to different hardware components. "Other Mode" uses
>>> + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DATA=
_01
>>> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
>>> + *
>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>>> + *
>>> + */
>>> +
>>> +#include <linux/wmi.h>
>>> +#include "lenovo-wmi.h"
>>> +
>>> +/* wmidev_evaluate_method helper functions */
>>> +static int lenovo_wmidev_evaluate_method(struct wmi_device *wdev, u8 =
instance,
>>> +                                      u32 method_id, struct acpi_buff=
er *in,
>>> +                                      struct acpi_buffer *out)
>>> +{
>>> +     acpi_status status;
>>> +
>>> +     status =3D wmidev_evaluate_method(wdev, instance, method_id, in,=
 out);
>>> +
>>> +     if (ACPI_FAILURE(status))
>>> +             return -EIO;
>>> +
>>> +     return 0;
>>> +};
>>> +
>>> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 insta=
nce,
>>> +                                 u32 method_id, u32 arg0, u32 arg1,
>>> +                                 u32 *retval)
>>> +{
>> Please give this method a more descriptive name.
>>
> Okay. I followed the convention in asus_wmi here as it takes 2 args
> and _1 takes one arg. When I add fan profiles later I'll need one that
> takes one u64 arg as well, and I think some other GUID's I don't yet
> have implemented have 3 or 4 u16 args. Do you have a suggestion on how
> you'd prefer them named? My instinct would be to simplify to three,
> _u16, _u32, _u64, and pass 0 to unused args instead of having a second
> _1 helper.

Good question, would it make sense to just pass the arguments as a single =
byte buffer?

>>> +     struct wmi_method_args args =3D { arg0, arg1 };
>>> +     struct acpi_buffer input =3D { (acpi_size)sizeof(args), &args };
>> Cast to acpi_size is unnecessary here.
> Acked
>
>>> +     struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
>>> +     union acpi_object *ret_obj __free(kfree) =3D NULL;
>>> +     int err;
>>> +
>>> +     err =3D lenovo_wmidev_evaluate_method(wdev, instance, method_id,=
 &input,
>>> +                                         &output);
>>> +
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     if (retval) {
>>> +             ret_obj =3D (union acpi_object *)output.pointer;
>>> +             if (!ret_obj)
>>> +                     return -ENODATA;
>>> +
>>> +             if (ret_obj->type !=3D ACPI_TYPE_INTEGER)
>>> +                     return -ENXIO;
>>> +
>>> +             *retval =3D (u32)ret_obj->integer.value;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_2, "LENOVO_WMI");
>> Can you please rename the namespace to "LENOVO_WMI_HELPERS"?
> Yes
>
>>> +
>>> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 insta=
nce,
>>> +                                 u32 method_id, u32 arg0, u32 *retval=
)
>>> +{
>> Same as above.
>>
>>> +     return lenovo_wmidev_evaluate_method_2(wdev, instance, method_id=
, arg0,
>>> +                                            0, retval);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(lenovo_wmidev_evaluate_method_1, "LENOVO_WMI");
>>> +MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
>>> +MODULE_DESCRIPTION("Lenovo WMI Common Driver");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/drivers/platform/x86/lenovo-wmi.h b/drivers/platform/x86/=
lenovo-wmi.h
>>> new file mode 100644
>>> index 000000000000..113928b4fc0f
>>> --- /dev/null
>>> +++ b/drivers/platform/x86/lenovo-wmi.h
>>> @@ -0,0 +1,62 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later
>>> + *
>>> + * Lenovo Legion WMI interface driver. The Lenovo Legion WMI interfac=
e is
>>> + * broken up into multiple GUID interfaces that require cross-referen=
ces
>>> + * between GUID's for some functionality. The "Custom Method" interfa=
ce is a
>>> + * legacy interface for managing and displaying CPU & GPU power and h=
wmon
>>> + * settings and readings. The "Other Mode" interface is a modern inte=
rface
>>> + * that replaces or extends the "Custom Method" interface methods. Th=
e
>>> + * "Gamezone" interface adds advanced features such as fan profiles a=
nd
>>> + * overclocking. The "Lighting" interface adds control of various sta=
tus
>>> + * lights related to different hardware components. "Other Mode" uses
>>> + * the data structs LENOVO_CAPABILITY_DATA_00, LENOVO_CAPABILITY_DATA=
_01
>>> + * and LENOVO_CAPABILITY_DATA_02 structs for capability information.
>>> + *
>>> + * Copyright(C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
>>> + *
>>> + */
>>> +#include <linux/notifier.h>
>>> +#include <linux/platform_profile.h>
>>> +
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> This causes a build error on my machine. Please only use this macro ins=
ide source files
>> for modules and not inside header files.
> This also causes a build error on my machine inside the .c sources.
> I'm not sure why.

The reason for this is that some drivers including this header file also d=
efine this macro.
In general this macro should only be used inside source files for modules.

Thanks,
Armin Wolf

>>> +
>>> +#ifndef _LENOVO_WMI_H_
>>> +#define _LENOVO_WMI_H_
>>> +
>>> +#include <linux/bits.h>
>>> +#include <linux/types.h>
>>> +#include <linux/wmi.h>
>>> +
>>> +struct wmi_method_args {
>>> +     u32 arg0;
>>> +     u32 arg1;
>>> +};
>>> +
>>> +/* gamezone structs */
>>> +enum thermal_mode {
>>> +     SMARTFAN_MODE_QUIET =3D 0x01,
>>> +     SMARTFAN_MODE_BALANCED =3D 0x02,
>>> +     SMARTFAN_MODE_PERFORMANCE =3D 0x03,
>>> +     SMARTFAN_MODE_EXTREME =3D 0xE0, /* Ver 6+ */
>>> +     SMARTFAN_MODE_CUSTOM =3D 0xFF,
>>> +};
>>> +
>>> +enum lenovo_wmi_action {
>>> +     THERMAL_MODE_EVENT =3D 1,
>>> +};
>>> +
>>> +/* wmidev_evaluate_method helper functions */
>>> +int lenovo_wmidev_evaluate_method_2(struct wmi_device *wdev, u8 insta=
nce,
>>> +                                 u32 method_id, u32 arg0, u32 arg1,
>>> +                                 u32 *retval);
>>> +int lenovo_wmidev_evaluate_method_1(struct wmi_device *wdev, u8 insta=
nce,
>>> +                                 u32 method_id, u32 arg0, u32 *retval=
);
>>> +
>>> +/* lenovo_wmi_gz_driver notifier functions */
>>> +int lenovo_wmi_gz_notifier_call(struct notifier_block *nb, unsigned l=
ong action,
>>> +                             enum platform_profile_option *profile);
>>> +int lenovo_wmi_gz_register_notifier(struct notifier_block *nb);
>>> +int lenovo_wmi_gz_unregister_notifier(struct notifier_block *nb);
>>> +int devm_lenovo_wmi_gz_register_notifier(struct device *dev,
>>> +                                      struct notifier_block *nb);
>> Can you please create a separate header file for each driver? Otherwise=
 this header file
>> will contain many different things from different drivers, which will m=
aybe not even be
>> available depending on the Kconfig settings.
> Can do.
>
> Cheers,
> - Derek
>
>> Thanks,
>> Armin Wolf
>>
>>> +#endif /* !_LENOVO_WMI_H_ */

