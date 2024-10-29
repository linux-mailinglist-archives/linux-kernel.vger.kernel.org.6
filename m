Return-Path: <linux-kernel+bounces-387817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB69B5687
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD77284DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7538020B1EF;
	Tue, 29 Oct 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YvgROrh5"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2263205AB4;
	Tue, 29 Oct 2024 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243523; cv=none; b=Y2YBVakMJzmxNvz0lzrrJpi+0w9S6oPkRsZru8hFWsMPfLmrkNFzjFENnJSajY7xZOOT7Ba/lzXZVGGbwAfaZQHaYXBxT9Uq0DFJdG9jrJu4LVkyuRyPVnf7A919nOVIP36HSj8gUSV3uFAUrfdMy/RKhp4Ir45NkvRYBfvVeBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243523; c=relaxed/simple;
	bh=cUakANUUpWDabIU6CZu08T5Ws1r1C5uwE610Ypw4A8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgLutbMyDKaAeSyzpviX9bK5ZLertrAQxxAC9v4ZvDxwAvSWqe7h5i4n6Jj0cjITZISjSZcJfeThcx/W6u0QPKYw5YAfbLMoOQVT/gZ8qjgwkyTQMEZ06oKwZZeOO5k6PGpWehcheoa8siYdniCVUaCDR+BoiqAnB2aDQjxWmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YvgROrh5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730243512; x=1730848312; i=w_armin@gmx.de;
	bh=Ff+jJzmlIqN27G3YiYnkZuBkrlqaB7mXn2YnAnuo3TU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YvgROrh5s4kXpiSG0Kcotkay30d7As7tHNnL9TL/Iw9M+Lo1nTgDNkQ+dZ035PKh
	 +xBBHD0aLVBNl0qWbvxfpsfyULZEOf/ymVrYy5tmxb42cSHdyr9QMw1F9XBaV3EV5
	 MvEt1N18+umCslH8S/PtentPLRjkjqj2k+/YHPYg5OzRJL7rJuPvNQiyVg7hTayXm
	 dVhXqZ45cJ0eJWc/P+chgOv2i67aacdb7NnSVhqRGAx19j/XeuMMepzyaCNhUwBgm
	 dCGXppKJR5hyhU1NIQZ8/CufyI0ekYKcTg9A8bsIsxSx1siILeRyyddK/pYGzS/mG
	 zTZMimim0fEBVhyjIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1tLmE13yRO-00SCm8; Wed, 30
 Oct 2024 00:11:52 +0100
Message-ID: <c780277a-cf52-42a4-803f-c29674a31715@gmx.de>
Date: Wed, 30 Oct 2024 00:11:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/5] alienware-wmi: added platform profile support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Kurt Borja <kuurtb@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
References: <20241029135107.5582-2-kuurtb@gmail.com>
 <20241029135341.5906-1-kuurtb@gmail.com>
 <9caaa4f1-9605-da2a-9afd-8f40ed33719f@linux.intel.com>
 <pvsp76cvdqp7irpa52mr3canryyzilgvyijhtqvxzhix3diavj@bcfuduinqlcb>
 <12f980ac-f1d3-a802-37a9-cb6e03b046de@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <12f980ac-f1d3-a802-37a9-cb6e03b046de@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:chBC1nYm15xrFnlrzVrI33Bvg5n7j+Jj/sEMCfudfnLoXmIoxJ7
 3iflTZrxDKzkEcx4Q3TkLbKxV03lkXd2flzp4/zT84B73TiTACvTgMyHf+E4xJwbOVF87/2
 poa3J7vkgcgBCKpqXYzCAtftCytGCJ6I4KHLRutWRNjmbZ/tW9Kd2hJcNIx6c7lDqjLEPuP
 1cJmHtujZnXLh+qis3gbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8zmYp64SNY4=;6JtEFtcw6Y+iId8WK3jiE+D5HHO
 Y8jLuc6tmGGQKyAB0bgrvGo1CqQR9VFpJ/VzQsH/a1zGgNcr74kbnjS5kTbO62lKSMpOFkrnL
 sq9RbuErXyPPRkOy/AkpKYkwdkhJ8BFdt/aOzaEj58F55OrHsmapevEjwFMkH9V4tez+O2Egh
 kk/vJPwt8IySGDny9j2KUEbH8aw4yCK56Ps1LsBAVr6PcTRHIfTpSUl/s7JbzDywQfJ8wbGAH
 4gnJwWQNjaZIyma7h3/dB7RNTffrB1VrWb0gLoy5cpvi9rBmCqDv9G1mTaYr45PceKjq0VyhP
 E5YyQr2yXyxMOqWV72byGib+rk4lZIRt6n0AXIHxbOFsVcLWzujSdkx4Ef2HYnxOdNWFUAbId
 HC5P1y6Eo/QJhEHCR2FHdJL/l1WyeCStBmVW5Gqp4CTZsA/noDIBLAjd4tYB09Mgvhw5c71+E
 hAN5EWHLj1ypcjnOKXzhJOg46chZLMyYRAAqjALfnQnvQw31wzfrBI0kMiLFPnglyUlkFkSD3
 kc4TMLSl0RB6iq1xmJqMc18kJ3B9ukZ+4LeGxrOqxdEEvKPNL2ZwnBAVjR5Bh58BTwf/X917e
 dT0rhILKe1jORWRfHVcwjj8rQE9PrZ7PcCLFx+ox9ybZk83KggaLjebZ1znIhq5k6FoqgK4jX
 cLvB235BfsUp6FRg6kzQ6AFDCyTxe4niUfRRTsTzVVRPphXwlJn8o3zV8vshgv+KGgASDwmoy
 /NAYQrqNQqs/z1YdixbMuUcvOXX9a4gh2mO8f2+HnzYfwjzluYNVz48l7JvBLmeqOIMwjuKC4
 HcXG76Gcuol4fWPi3mhtX6kg==

Am 29.10.24 um 18:06 schrieb Ilpo J=C3=A4rvinen:

> On Tue, 29 Oct 2024, Kurt Borja wrote:
>
>> On Tue, Oct 29, 2024 at 05:44:05PM +0200, Ilpo J=C3=A4rvinen wrote:
>>> On Tue, 29 Oct 2024, Kurt Borja wrote:
>>>
>>>> Implements platform profile support for Dell laptops with new WMAX th=
ermal
>>>> interface, present on some Alienware X-Series, Alienware M-Series and
>>>> Dell's G-Series laptops. This interface is suspected to be used by
>>>> Alienware Command Center (AWCC), which is not available for linux
>>>> systems, to manage thermal profiles.
>>>>
>>>> This implementation makes use of three WMI methods, namely
>>>> THERMAL_CONTROL, THERMAL_INFORMATION and GAME_SHIFT_STATUS, which tak=
e
>>>> u32 as input and output arguments. Each method has a set of supported
>>>> operations specified in their respective enums.
>>>>
>>>> Not all models with WMAX WMI interface support these methods. Because=
 of
>>>> this, models have to manually declare support through new quirks
>>>> `thermal` for THERMAL_CONTROL and THERMAL_INFORMATION and `gmode` for
>>>> GAME_SHIFT_STATUS.
>>>>
>>>> Wrappers written for these methods support multiple operations.
>>>>
>>>> THERMAL_CONTROL switches thermal modes through operation
>>>> ACTIVATE_PROFILE. Available thermal codes are auto-detected at runtim=
e
>>>> and matched against a list of known thermal codes:
>>>>
>>>> Thermal Table "User Selectable Thermal Tables" (USTT):
>>>> 	BALANCED			0xA0
>>>> 	BALANCED_PERFORMANCE		0xA1
>>>> 	COOL				0xA2
>>>> 	QUIET				0xA3
>>>> 	PERFORMANCE			0xA4
>>>> 	LOW_POWER			0xA5
>>>>
>>>> Thermal Table Basic:
>>>> 	QUIET				0x96
>>>> 	BALANCED			0x97
>>>> 	BALANCED_PERFORMANCE		0x98
>>>> 	PERFORMANCE			0x99
>>>>
>>>> Devices are known to implement only one of these tables without mixin=
g
>>>> their thermal codes.
>>>>
>>>> The fact that the least significant digit of every thermal code is
>>>> consecutive of one another is exploited to efficiently match codes
>>>> through arrays.
>>>>
>>>> Autodetection of available codes is done through operation LIST_IDS o=
f
>>>> method THERMAL_INFORMATION. This operation lists fan IDs, CPU sensor =
ID,
>>>> GPU sensor ID and available thermal profile codes, *in that order*. A=
s
>>>> number of fans and thermal codes is very model dependent, almost ever=
y
>>>> ID is scanned and matched based on conditions found on
>>>> is_wmax_thermal_code(). The known upper bound for the number of IDs i=
s
>>>> 13, corresponding to a device that have 4 fans, 2 sensors and 7 therm=
al
>>>> codes.
>>>>
>>>> Additionally G-Series laptops have a key called G-key, which (with AW=
CC
>>>> proprietary driver) switches the thermal mode to an special mode name=
d
>>>> GMODE with code 0xAB and changes Game Shift Status to 1. Game Shift i=
s a
>>>> mode the manufacturer claims, increases gaming performance.
>>>>
>>>> GAME_SHIFT_STATUS method is used to mimic this behavior when selectin=
g
>>>> PLATFORM_PROFILE_PERFORMANCE option.
>>>>
>>>> All of these profiles are known to only change fan speed profiles,
>>>> although there are untested claims that some of them also change powe=
r
>>>> profiles.
>>>>
>>>> Activating a thermal mode with method THERMAL_CONTROL may cause short
>>>> hangs. This is a known problem present on every platform.
>>>>
>>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>>> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>>>> ---
>>>> v10:
>>>>   - Corrected THERMAL_MODE_BASIC_BALANCED -> THERMAL_MODE_BASIC_QUIET=
 in
>>>>     is_wmax_thermal_code() logic
>>>>   - `thermal` and `gmode` quirks now have to be manually selected,
>>>>     because not all Dell devices posses the new WMI thermal methods.
>>>>   - Because of the above reason, errors in create_thermal_profile are=
 now
>>>>     propagated
>>>> v9:
>>>>   - Bool comparisons are now coherent with their type
>>>> v8:
>>>>   - Fixed alignment in wmax_mode_to_platform_profile[]
>>>>   - Quirk thermal and gmode changed from u8 -> bool
>>>>   - Autodetected quirk entries are not initialized
>>>>   - is_wmax_thermal_code refactored to increase readibility
>>>>   - is_wmax_thermal_code now covers all possibilities
>>>>   - Better commit message
>>>> v7:
>>>>   - Method operations are now clearly listed as separate enums
>>>>   - wmax_thermal_modes are now listed without codes in order to suppo=
rt
>>>>     autodetection, as well as getting and setting thermal profiles
>>>>     cleanly through arrays
>>>>   - Added wmax_mode_to_platform_profile[]
>>>>   - Added struct wmax_u32_args to replace bit mask approach of
>>>>     constructing arguments for wmax methods
>>>>   - create_thermal_profile now autodetects available thermal codes
>>>>     through operation 0x03 of THERMAL_INFORMATION method. These are
>>>>     codes are stored in supported_thermal_profiles[]
>>>>   - thermal_profile_get now uses wmax_mode_to_platform_profile[] inst=
ead of
>>>>     switch-case approach
>>>>   - thermal_profile_set now uses supported_thermal_profiles[] instead=
 of
>>>>     switch-case approach
>>>>   - When gmode is autodetected, thermal_profile_set also sets Game Sh=
ift
>>>>     status accordingly
>>>> v6:
>>>>   - Fixed alignment on some function definitions
>>>>   - Fixed braces on if statment
>>>>   - Removed quirk thermal_ustt
>>>>   - Now quirk thermal can take values defined in enum WMAX_THERMAL_TA=
BLE.
>>>>   - Proper removal of thermal_profile
>>>> ---
>>>>   drivers/platform/x86/dell/Kconfig         |   1 +
>>>>   drivers/platform/x86/dell/alienware-wmi.c | 306 +++++++++++++++++++=
+++
>>>>   2 files changed, 307 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86=
/dell/Kconfig
>>>> index 68a49788a..b06d634cd 100644
>>>> --- a/drivers/platform/x86/dell/Kconfig
>>>> +++ b/drivers/platform/x86/dell/Kconfig
>>>> @@ -21,6 +21,7 @@ config ALIENWARE_WMI
>>>>   	depends on LEDS_CLASS
>>>>   	depends on NEW_LEDS
>>>>   	depends on ACPI_WMI
>>>> +	select ACPI_PLATFORM_PROFILE
>>>>   	help
>>>>   	 This is a driver for controlling Alienware BIOS driven
>>>>   	 features.  It exposes an interface for controlling the AlienFX
>>>> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/plat=
form/x86/dell/alienware-wmi.c
>>>> index b27f3b64c..1d62c2ce7 100644
>>>> --- a/drivers/platform/x86/dell/alienware-wmi.c
>>>> +++ b/drivers/platform/x86/dell/alienware-wmi.c
>>>> @@ -8,8 +8,11 @@
>>>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>>
>>>>   #include <linux/acpi.h>
>>>> +#include <linux/bitfield.h>
>>>> +#include <linux/bits.h>
>>>>   #include <linux/module.h>
>>>>   #include <linux/platform_device.h>
>>>> +#include <linux/platform_profile.h>
>>>>   #include <linux/dmi.h>
>>>>   #include <linux/leds.h>
>>>>
>>>> @@ -25,6 +28,13 @@
>>>>   #define WMAX_METHOD_AMPLIFIER_CABLE	0x6
>>>>   #define WMAX_METHOD_DEEP_SLEEP_CONTROL	0x0B
>>>>   #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
>>>> +#define WMAX_METHOD_THERMAL_INFORMATION	0x14
>>>> +#define WMAX_METHOD_THERMAL_CONTROL	0x15
>>>> +#define WMAX_METHOD_GAME_SHIFT_STATUS	0x25
>>>> +
>>>> +#define WMAX_THERMAL_MODE_GMODE		0xAB
>>>> +
>>>> +#define WMAX_FAILURE_CODE		0xFFFFFFFF
>>>>
>>>>   MODULE_AUTHOR("Mario Limonciello <mario.limonciello@outlook.com>");
>>>>   MODULE_DESCRIPTION("Alienware special feature control");
>>>> @@ -49,11 +59,59 @@ enum WMAX_CONTROL_STATES {
>>>>   	WMAX_SUSPEND =3D 3,
>>>>   };
>>>>
>>>> +enum WMAX_THERMAL_INFORMATION_OPERATIONS {
>>>> +	WMAX_OPERATION_LIST_IDS			=3D 0x03,
>>>> +	WMAX_OPERATION_CURRENT_PROFILE		=3D 0x0B,
>>>> +};
>>>> +
>>>> +enum WMAX_THERMAL_CONTROL_OPERATIONS {
>>>> +	WMAX_OPERATION_ACTIVATE_PROFILE		=3D 0x01,
>>>> +};
>>>> +
>>>> +enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
>>>> +	WMAX_OPERATION_TOGGLE_GAME_SHIFT	=3D 0x01,
>>>> +	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	=3D 0x02,
>>>> +};
>>>> +
>>>> +enum WMAX_THERMAL_TABLES {
>>>> +	WMAX_THERMAL_TABLE_BASIC		=3D 0x90,
>>>> +	WMAX_THERMAL_TABLE_USTT			=3D 0xA0,
>>>> +};
>>>> +
>>>> +enum wmax_thermal_mode {
>>>> +	THERMAL_MODE_USTT_BALANCED,
>>>> +	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
>>>> +	THERMAL_MODE_USTT_COOL,
>>>> +	THERMAL_MODE_USTT_QUIET,
>>>> +	THERMAL_MODE_USTT_PERFORMANCE,
>>>> +	THERMAL_MODE_USTT_LOW_POWER,
>>>> +	THERMAL_MODE_BASIC_QUIET,
>>>> +	THERMAL_MODE_BASIC_BALANCED,
>>>> +	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
>>>> +	THERMAL_MODE_BASIC_PERFORMANCE,
>>>> +	THERMAL_MODE_LAST,
>>>> +};
>>>> +
>>>> +static const enum platform_profile_option wmax_mode_to_platform_prof=
ile[THERMAL_MODE_LAST] =3D {
>>>> +	[THERMAL_MODE_USTT_BALANCED]			=3D PLATFORM_PROFILE_BALANCED,
>>>> +	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	=3D PLATFORM_PROFILE_BALAN=
CED_PERFORMANCE,
>>>> +	[THERMAL_MODE_USTT_COOL]			=3D PLATFORM_PROFILE_COOL,
>>>> +	[THERMAL_MODE_USTT_QUIET]			=3D PLATFORM_PROFILE_QUIET,
>>>> +	[THERMAL_MODE_USTT_PERFORMANCE]			=3D PLATFORM_PROFILE_PERFORMANCE,
>>>> +	[THERMAL_MODE_USTT_LOW_POWER]			=3D PLATFORM_PROFILE_LOW_POWER,
>>>> +	[THERMAL_MODE_BASIC_QUIET]			=3D PLATFORM_PROFILE_QUIET,
>>>> +	[THERMAL_MODE_BASIC_BALANCED]			=3D PLATFORM_PROFILE_BALANCED,
>>>> +	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	=3D PLATFORM_PROFILE_BALA=
NCED_PERFORMANCE,
>>>> +	[THERMAL_MODE_BASIC_PERFORMANCE]		=3D PLATFORM_PROFILE_PERFORMANCE,
>>>> +};
>>>> +
>>>>   struct quirk_entry {
>>>>   	u8 num_zones;
>>>>   	u8 hdmi_mux;
>>>>   	u8 amplifier;
>>>>   	u8 deepslp;
>>>> +	bool thermal;
>>>> +	bool gmode;
>>>>   };
>>>>
>>>>   static struct quirk_entry *quirks;
>>>> @@ -64,6 +122,8 @@ static struct quirk_entry quirk_inspiron5675 =3D {
>>>>   	.hdmi_mux =3D 0,
>>>>   	.amplifier =3D 0,
>>>>   	.deepslp =3D 0,
>>>> +	.thermal =3D false,
>>>> +	.gmode =3D false,
>>>>   };
>>>>
>>>>   static struct quirk_entry quirk_unknown =3D {
>>>> @@ -71,6 +131,8 @@ static struct quirk_entry quirk_unknown =3D {
>>>>   	.hdmi_mux =3D 0,
>>>>   	.amplifier =3D 0,
>>>>   	.deepslp =3D 0,
>>>> +	.thermal =3D false,
>>>> +	.gmode =3D false,
>>>>   };
>>>>
>>>>   static struct quirk_entry quirk_x51_r1_r2 =3D {
>>>> @@ -78,6 +140,8 @@ static struct quirk_entry quirk_x51_r1_r2 =3D {
>>>>   	.hdmi_mux =3D 0,
>>>>   	.amplifier =3D 0,
>>>>   	.deepslp =3D 0,
>>>> +	.thermal =3D false,
>>>> +	.gmode =3D false,
>>>>   };
>>>>
>>>>   static struct quirk_entry quirk_x51_r3 =3D {
>>>> @@ -85,6 +149,8 @@ static struct quirk_entry quirk_x51_r3 =3D {
>>>>   	.hdmi_mux =3D 0,
>>>>   	.amplifier =3D 1,
>>>>   	.deepslp =3D 0,
>>>> +	.thermal =3D false,
>>>> +	.gmode =3D false,
>>>>   };
>>>>
>>>>   static struct quirk_entry quirk_asm100 =3D {
>>>> @@ -92,6 +158,8 @@ static struct quirk_entry quirk_asm100 =3D {
>>>>   	.hdmi_mux =3D 1,
>>>>   	.amplifier =3D 0,
>>>>   	.deepslp =3D 0,
>>>> +	.thermal =3D false,
>>>> +	.gmode =3D false,
>>>>   };
>>>>
>>>>   static struct quirk_entry quirk_asm200 =3D {
>>>> @@ -99,6 +167,8 @@ static struct quirk_entry quirk_asm200 =3D {
>>>>   	.hdmi_mux =3D 1,
>>>>   	.amplifier =3D 0,
>>>>   	.deepslp =3D 1,
>>>> +	.thermal =3D false,
>>>> +	.gmode =3D false,
>>>>   };
>>>>
>>>>   static struct quirk_entry quirk_asm201 =3D {
>>>> @@ -106,6 +176,17 @@ static struct quirk_entry quirk_asm201 =3D {
>>>>   	.hdmi_mux =3D 1,
>>>>   	.amplifier =3D 1,
>>>>   	.deepslp =3D 1,
>>>> +	.thermal =3D false,
>>>> +	.gmode =3D false,
>>>> +};
>>>> +
>>>> +static struct quirk_entry quirk_x_series =3D {
>>>> +	.num_zones =3D 2,
>>>> +	.hdmi_mux =3D 0,
>>>> +	.amplifier =3D 0,
>>>> +	.deepslp =3D 0,
>>>> +	.thermal =3D true,
>>>> +	.gmode =3D false,
>>>>   };
>>> So now gmode is always false unless the module parameter from patch 4 =
is
>>> given?
>> G-Series laptops can also register a quirk_entry with gmode set in the
>> future. I can do it ahead of time, but I don't have a G-Series laptop t=
o
>> test it.
> Understood. I'm fine with this in the current form if it's fine for Armi=
n
> too.

I am fine with this, we can add the necessary quirks later should someone =
have access
to the necessary hardware.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>

