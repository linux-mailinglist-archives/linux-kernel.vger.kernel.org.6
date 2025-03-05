Return-Path: <linux-kernel+bounces-545903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B0A4F34D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30BE16F526
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDEB282EE;
	Wed,  5 Mar 2025 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bFVW1lLi"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD62746B;
	Wed,  5 Mar 2025 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137103; cv=none; b=WID9HTsYYJuZZZR2JbFOrV5tzqNPnH2+xkcqWtfplPevXulkGWWOkJ5IBOSMJfGVAtmtX86xke64K3qH5SrOWyI9oyPDSa9VAl1L05zMRp+a5ml2Yj9Bgp0kjkPAJljBsrkJJG6xBzKcOzoy3KVZ4O9G4fAxcz4T+28uygW1YLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137103; c=relaxed/simple;
	bh=n9cPXjibYBe/hTlCxfzoikVfmeXWipI0tJrlvjSafwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K++nxH3JO/JW3UQzzCGJurKbJjAHh2Uf3MPsOvcgAhZ3Hu19yNUfwAzIl3bSpXet7ZER0OROnKuxgX0Zqe6nSnAKRw8wC1QnAoJvTJtHfbC/kU+vVSsMxU/UhKMjmPt4LjHKQhwAOOFMk0f1yH59U0b8mWavvYT1buuPj0IePI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bFVW1lLi; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741137085; x=1741741885; i=w_armin@gmx.de;
	bh=n9cPXjibYBe/hTlCxfzoikVfmeXWipI0tJrlvjSafwY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bFVW1lLiFMhVyW0K7+HUVijBzTkusYceSDEhzTeMk4zzAeQC/xES27aQX47rk/eV
	 8DCrgc0hl4lxamLIYrZgJZXBBCKH0TwrLshYBchXXoyB3bs2OaDCDEgpvfMFkXEeX
	 6NWrA9h/Dkgt6cZkhIvUa3saBYeQEQcIRlz4HMOOJD2iNOsGR4Il3yTRPa7CCoN6o
	 8aG9wbyon7LKiyMhzl/OtNaE611uj3MQW/KQM9HL2YaA5ecJ9fR9ZIo4bRYd5n/Mg
	 uw5+orq7cmChh54/8rqiED5kyb4OElRIpe4EbwwPycAM/iugViHyAK1dhdiONb0H4
	 qclkRFJGKP5hnzG+WQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1tzmh41tox-00DVa0; Wed, 05
 Mar 2025 02:11:25 +0100
Message-ID: <58a51e80-48d0-4c65-ad9a-50f164471b8f@gmx.de>
Date: Wed, 5 Mar 2025 02:11:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: amd: Add ISP platform info
To: "Nirujogi, Pratap" <pnirujog@amd.com>, Hans de Goede
 <hdegoede@redhat.com>, Pratap Nirujogi <pratap.nirujogi@amd.com>,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 benjamin.chan@amd.com, bin.du@amd.com, king.li@amd.com,
 gjorgji.rosikopulos@amd.com, dominic.antony@amd.com
References: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
 <cd25d131-bead-4a38-98dc-1011c2843286@redhat.com>
 <3d57b624-7753-4a4d-9051-0a55cbdff1ec@amd.com>
 <3beeeb19-3791-4090-860e-45b8df2568a7@gmx.de>
 <053f72c4-4055-4b79-9cd5-c6d1f1f23268@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <053f72c4-4055-4b79-9cd5-c6d1f1f23268@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lfni13WKexdeSENJFBfc3Zj5fcRTbEKWShQ4vLHEkZ5mUf5Sfh0
 5pHwyYu3DfYH2oVXEJAMHrJI7oAvEXaSKZHULzZ+S94/rv+gJT5vvQxTnWOw6QJhdQXkKHt
 OCEWukEY+ylL8kD7bCiKNu4414Cvb44inRIBTKsUjQQ6fnwPkWEDk5YcUPQQEhpFMLQjkMV
 XEfLv/74E5neUNzA5ej0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e0urIapJPlk=;vVs87gHxH+YnMlRrkH14/Xccr/g
 OBEt0suzBFg+UeDCTpR0dywwu/TI9uTLTJJ3UeH+9AGDVW44VrdDc2ux7hLrJQAZI7VBHb5Z9
 W0lNKiJaO0k/XEu34NFmnCfRLak08X6SJG5SJdPrkg2DCG4CW/Ywh+dhbPNumwhXPstuRrBPx
 3dDOZuQPcd/e9YJi7FkJj21sHNV5qKeIKkLo3JwNFYc9PBVSfMn7hE0DjicPXA8w51JM/cqO7
 oVGyofUvYsCPyaZD5OsLbHOlweceNxPrGoCKji4NDr2d/IdUM9LnuCbU6p8e9O3C6u4e30FWq
 WeB6hJuFP1ehVq+ePC/J6fmw1Fp7tgD13VBI+7eR7CJewEo/X6udJy+eFFKn7Yku1sfqz1MlO
 pJrHfTr9nziEnV8rEvW/CiLvj2AxoTQjtzH7tZc11yXeOePiODqRXoIreokUl2twpKAKrnlTZ
 iwkPcs7YcDNLWpr2D4Spk4jxMG8bH7P9J0Emj7Mkzio/qev5ZjKCXbvrwEk4aLRzLI9f6Pmdx
 ddP4bmZt/jA786pxVsx57ushF3VH0gTgd88j9d6UzGuL63nbfKKWt34Po1Ei93cadRh2j93pH
 PiLbbz2dTKJbgU6moAXW9nhXudtx0COoCc5MCteF2b4U8P5Fgc2gej6QhSZwwZ/tZ1JUh6v6S
 /RQkI0OGc8sZyhmg2sYI2wOs8us1CgT9oCrn73WRF77AG6ayKBQowXvl/Bsq9n85jhu7SsQ4V
 3PfbrQ4AUZQmBjpMJP+gRYktb2NmQcxavzBarx4BzKXq145aa1z24UIW5+Ct6haYLBnS18K+8
 3r4KNKaVN273AjDWtWZ1VEpwT+kh0GnzmbeaEVwTLC/c5C5ndggZdVjV1bLO1HRRhj47mlN3Q
 ij+jI8KArm8fX2BbjsHXNy+AlacSezgGNYWc/O3pd3IBTgO4VDTNEjHJ/KIlP5yssSZ83yJ6t
 NGhpxlopCz3m2LvxoBfyfXzbvrp4AdRHyNOR6BeFZ3KJZummrPd2sXO7QDLibOSAEQgFqb9gw
 p1iW9Er9Eqtqp6GlMUcULE/Dnw06yq69qtxCmsuEU/XpW69tzS5hejTdGpoTrZamWwI4M3HB+
 WQKd744FkD3Ac2/QsApwh5w4CynOQnm3ePrw9nx3cA1wy0ohFTRkl9SfKYzn5q2fKlRIOAsOL
 VwRYStx8i4LF41ciXSeiH1zTXeIlugzPufOANnQHrGKNxEHkTmjqk4lRcTuOnVh8UZK/PjQ5D
 K+ysK7UNYV67hpNktVeI82OvYKoRU0FmkOTsJ6WKRbtAsOJwr+AMq+81FMgLlL0zIdG//5NZj
 lmUrAn8xIEyYyZt+F+YIEMfTMobdW8LG0jMfyrKr0hxM//bO3vuCRgHP+O8no+vmMFQXMJOOA
 3UJ2czO/gGi62pKGDhVFwi71fJWiFWXAZCWSCgyI2HDN/DhPFaaRvniZOhl4h2gJy0GGZwkl4
 HdCoDgNuqGZUEoV1evETyYTnva04=

Am 04.03.25 um 18:44 schrieb Nirujogi, Pratap:

> Hi Armin,
>
> Thanks for your comment.
>
> Thanks,
> Pratap
>
> On 3/3/2025 6:56 PM, Armin Wolf wrote:
>> Caution: This message originated from an External Source. Use proper
>> caution when opening attachments, clicking links, or responding.
>>
>>
>> Am 04.03.25 um 00:14 schrieb Nirujogi, Pratap:
>>
>>> Hi Hans,
>>>
>>> Thanks for your review. Please see the inline comments and let us know
>>> your insights.
>>>
>>> Thanks,
>>> Pratap
>>>
>>>
>>> On 3/3/2025 8:41 AM, Hans de Goede wrote:
>>>> Caution: This message originated from an External Source. Use proper
>>>> caution when opening attachments, clicking links, or responding.
>>>>
>>>>
>>>> Hi Pratap,
>>>>
>>>> Thank you for your patch.
>>>>
>>>> On 28-Feb-25 18:02, Pratap Nirujogi wrote:
>>>>> Add ov05c i2c boardinfo and GPIO pin info for AMD ISP platform.
>>>>>
>>>>> Details of the resources added:
>>>>>
>>>>> - Added i2c bus number for AMD ISP platform is 99.
>>>>> - Added GPIO 85 to allow ISP driver to enable and disable ISP access=
.
>>>>> - Added GPIO 0 to allow sensor driver to enable and disable sensor
>>>>> module.
>>>>>
>>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>>> ---
>>>>> =C2=A0 drivers/platform/x86/amd/Kconfig=C2=A0=C2=A0 | 11 +++++
>>>>> =C2=A0 drivers/platform/x86/amd/Makefile=C2=A0 |=C2=A0 1 +
>>>>> =C2=A0 drivers/platform/x86/amd/amd_isp.c | 72
>>>>> ++++++++++++++++++++++++++++++
>>>>> =C2=A0 3 files changed, 84 insertions(+)
>>>>> =C2=A0 create mode 100644 drivers/platform/x86/amd/amd_isp.c
>>>>>
>>>>> diff --git a/drivers/platform/x86/amd/Kconfig
>>>>> b/drivers/platform/x86/amd/Kconfig
>>>>> index c3e086ea64fc..4b373edd750d 100644
>>>>> --- a/drivers/platform/x86/amd/Kconfig
>>>>> +++ b/drivers/platform/x86/amd/Kconfig
>>>>> @@ -32,3 +32,14 @@ config AMD_WBRF
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This mechanism will=
 only be activated on platforms that
>>>>> advertise a
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 need for it.
>>>>> +
>>>>> +config AMD_ISP_PLATFORM
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 bool "AMD platform with ISP4 that supports=
 Camera sensor
>>>>> device"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 depends on I2C && X86_64 && AMD_ISP4
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 help
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For AMD platform that support =
Image signal processor
>>>>> generation 4, it
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is necessary to add platform s=
pecific camera sensor module
>>>>> board info
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 which includes the sensor driv=
er device id and the i2c
>>>>> address.
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If you have a AMD platform tha=
t support ISP4 and with a
>>>>> sensor
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 connected to it, say Y here
>>>>> diff --git a/drivers/platform/x86/amd/Makefile
>>>>> b/drivers/platform/x86/amd/Makefile
>>>>> index 56f62fc9c97b..0d89e2d4f7e6 100644
>>>>> --- a/drivers/platform/x86/amd/Makefile
>>>>> +++ b/drivers/platform/x86/amd/Makefile
>>>>> @@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D pmc/
>>>>> =C2=A0 obj-$(CONFIG_AMD_HSMP)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D hsmp/
>>>>> =C2=A0 obj-$(CONFIG_AMD_PMF)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D pmf/
>>>>> =C2=A0 obj-$(CONFIG_AMD_WBRF)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D wbrf.o
>>>>> +obj-$(CONFIG_AMD_ISP_PLATFORM)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
+=3D amd_isp.o
>>>>> diff --git a/drivers/platform/x86/amd/amd_isp.c
>>>>> b/drivers/platform/x86/amd/amd_isp.c
>>>>> new file mode 100644
>>>>> index 000000000000..751f209e9509
>>>>> --- /dev/null
>>>>> +++ b/drivers/platform/x86/amd/amd_isp.c
>>>>> @@ -0,0 +1,72 @@
>>>>> +/* SPDX-License-Identifier: MIT */
>>>>> +/*
>>>>> + * Copyright 2025 Advanced Micro Devices, Inc.
>>>>> + *
>>>>> + * Permission is hereby granted, free of charge, to any person
>>>>> obtaining a
>>>>> + * copy of this software and associated documentation files (the
>>>>> "Software"),
>>>>> + * to deal in the Software without restriction, including without
>>>>> limitation
>>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>>> sublicense,
>>>>> + * and/or sell copies of the Software, and to permit persons to
>>>>> whom the
>>>>> + * Software is furnished to do so, subject to the following
>>>>> conditions:
>>>>> + *
>>>>> + * The above copyright notice and this permission notice shall be
>>>>> included in
>>>>> + * all copies or substantial portions of the Software.
>>>>> + *
>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>>> EXPRESS OR
>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>>> MERCHANTABILITY,
>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>>>>> EVENT SHALL
>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>>>>> DAMAGES OR
>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>>> OTHERWISE,
>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>>>>> USE OR
>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>> + */
>>>>> +
>>>>> +#include <linux/init.h>
>>>>> +#include <linux/i2c.h>
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/gpio/machine.h>
>>>>> +
>>>>> +#define AMDISP_I2C_BUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 99
>>>>
>>>> I'm not a fan of using static i2c-bus numbers for this. static bus
>>>> numbers are
>>>> something of the past and we typically do not use these on x86
>>>> anymore.
>>>>
>>>> Using this static number + i2c_register_board_info() also requires
>>>> this code
>>>> to be builtin rather then modular which is also undesirable.
>>>>
>>>> For a more dynamic way of manually adding i2c-devices see:
>>>>
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/
>>>> linux.git/tree/drivers/platform/x86/dell/dell-lis3lv02d.c
>>>>
>>>>
>>>> But a better question here is why instantiate the sensor i2c device
>>>> manually at all.
>>>>
>>>> ACPI has a standardized way to describe I2C-clients which tyically
>>>> is used for all I2C devices on ACPI platforms like I2C touchscreens /
>>>> touchpads / audio-codecs / accelerometers / etc.
>>>> I don't see why the camera sensor on AMD platforms is so special that
>>>> it could not be described in ACPI using an ACPI child-device of the
>>>> i2c-controller with a ACPI resource (_CRS entry) of the
>>>> I2cSerialBusV2()
>>>> type.
>>>>
>>>> Likewise the sensor enable GPIO should also be described in the ACPI
>>>> table as a Gpio type resource in the same _CRS table.
>>>>
>>>
>>> We have to take this approach because ISP is a child to GFX PCI device
>>> in AMD HW architectures, and since it is not an independent device,
>>> its device specific configuration (gpio pin ids, i2c-bus number etc.)
>>> is not registered in ACPI.
>>>
>>>> Can you run acpidump -o acpidump.txt on a laptop with this camera
>>>> sensor and send me the acpidupm.txt offlist ? Please run this
>>>> on a production hardware laptop model using production firmware.
>>>>
>>>
>>> Please refer the attached acpidump.txt
>>>
>>>> I suspect that Windows will also be using the ACPI description
>>>> for the sensor so we really should figure out what Windows is doing
>>>> here.
>>>>
>>>
>>> Yes, same ACPI configuration for both Windows and Linux. Similar
>>> approach followed even on windows to control the isp gpio pins.
>>>
>> The OMNI5C10 ACPI device has a _DSM method that supports the GUID
>> f8fd3bff-21b7-4a99-bdc8-c414a3e9453c. Do you know
>> more about the purpose of this method?
>>
>> Thanks,
>> Armin Wolf
>>
>
> This GUID is windows specific. Sorry, I'm not completely sure on what
> exactly it is used for. I'm thinking it is used to distinguish the
> different sensor modules that OEMs supports on different SKUs. I confirm
> its not applicable for Linux.
>
Ok, thanks for checking :)

>>>> As Mario mentioned we cannot just assume that the GPIOs +
>>>> sensor address and model are valid for all laptops. Ideally we should
>>>> be getting this information from ACPI rather then hardcoding it
>>>> in the kernel.
>>>>
>>>
>>> Yes, we initially assumed CONFIG_AMD_ISP_PLATFORM=3Dy will be set only
>>> on the intended platforms, but as that assumption is not valid, the
>>> below
>>> check is added in v2 patch checking the specific ov05c acpi hw id to
>>> present before running the driver.
>>>
>>> /* check for valid platform before configuring isp4 board resources */
>>> =C2=A0=C2=A0=C2=A0 if (!acpi_dev_found(AMDISP_ACPI_CAM_HID))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>>>
>>>>> +
>>>>> +static struct gpiod_lookup_table isp_gpio_table =3D {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .dev_id =3D "amd_isp_capture",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .table =3D {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp",
>>>>> GPIO_ACTIVE_HIGH),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>> +};
>>>>
>>>> This too really should be an Gpio() type ACPI resource on the ACPI
>>>> device
>>>> node for the ISP.
>>>>
>>>> How/where is this "amd_isp_capture" device created ?
>>>>
>>>
>>> "amd_isp_capture" is the V4L2 ISP driver in this case. The patches for
>>> ISP driver are yet to be submitted. It will be loaded during AMDGPU
>>> device probe on the AMD platforms supporting isp4.2 HW. AMDGPU
>>> reference to trigger the isp device probe:
>>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/
>>> amdgpu/isp_v4_1_1.c#L108
>>>
>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>>>
>>>>> +
>>>>> +static struct gpiod_lookup_table isp_sensor_gpio_table =3D {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .dev_id =3D "ov05c",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .table =3D {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 GPIO_LOOKUP("amdisp-pinctrl", 0, "sensor0_enable",
>>>>> GPIO_ACTIVE_HIGH),
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { }
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 },
>>>>> +};
>>>>> +
>>>>> +static struct i2c_board_info sensor_info =3D {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 .dev_name =3D "ov05c",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 I2C_BOARD_INFO("ov05c", 0x10),
>>>>> +};
>>>>> +
>>>>> +static int __init amd_isp_init(void)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_add_lookup_table(&isp_gpio_table);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_add_lookup_table(&isp_sensor_gpio_ta=
ble);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D i2c_register_board_info(AMDISP_I2C=
_BUS, &sensor_info, 1);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pr_err("%s: cannot register i2c board devices:%s",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, sensor_info.dev=
_name);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>> +}
>>>>> +
>>>>> +arch_initcall(amd_isp_init);
>>>>> +
>>>>> +MODULE_AUTHOR("Benjamin Chan <benjamin.chan@amd.com>");
>>>>> +MODULE_AUTHOR("Pratap Nirujogi <pratap.nirujogi@amd.com>");
>>>>> +MODULE_DESCRIPTION("AMD ISP Platform parameters");
>>>>> +MODULE_LICENSE("GPL and additional rights");
>>>>
>

