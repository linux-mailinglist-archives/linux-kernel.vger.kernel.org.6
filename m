Return-Path: <linux-kernel+bounces-552012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC0CA57404
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885A116F63E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598BE2080FD;
	Fri,  7 Mar 2025 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fFDlzNIW"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8685931;
	Fri,  7 Mar 2025 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384295; cv=none; b=Tjl1ozSzmH/UIM1PfoiBRWdeLhln92tnuJ/D38A2pW2LjH/ANB+AcI37a/vrV35dRc9WXP7flMhfamE6Bg8pniRjVxxnZQicqY+z7j++iMQ8ohcJWp0N0YtFRP7J3QW3KaNbgUS07hWRjxyf7iPTWpW4lYV2REWPSlwcxSQP5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384295; c=relaxed/simple;
	bh=QmRaKuwhwjAP+MJK3mrXkFdlZEvMtzJw/cwB/eymRu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDn0C4rljo8csxWDXx6rmmsBgKExbuQoL+YTYIvmj0Komc6xVdAMK5dUTOsQqwAHcnLYmhq09hVOhGG+xa7k7ZfKZ6N2tSkNX2ysZiAkMtQawugw5s4QYGRKetG1EQT0dDdVvOhzeP1HvYLefmqYukvtYTjhkEuuKWp3LoyKV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fFDlzNIW; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741384275; x=1741989075; i=w_armin@gmx.de;
	bh=MI1KjYcm/+Pg2YdI5yTM43Uq5OYlENdzJXZiXMTzqdY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fFDlzNIW5882H1pi91zzl8atTMf9j2HkMhbMEOz2WcWfEIKwLgT9pTcUe24Hr7Hc
	 h4PY/oU0VAtb3rGHlT7WgXvBMsjCFYoyg7254L9eM/mMuL9SEih1Fv3iBvG7LS7M0
	 bbrkggjNLlPaO+diV+RqDT3ZyL6oM9FaPWBY03tRvK89NNOMoZvB8dcwyvcBD6mDk
	 H9oUUf/TJgjO9/n6lST3uzsF9NutI8it+K/SBQipAzrGiQS1cikdNF7obO4tCwDY+
	 9Dh5IogyY+anpDZQlMgA1bxERsNcZEZCygjPsFMp9fepNYM5M58dNMzICdMWp2F47
	 ur4PIRT/7FW7M5+AaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1tUWCQ02Vd-00lC26; Fri, 07
 Mar 2025 22:51:15 +0100
Message-ID: <e46d95cc-800f-43e0-8064-77e784b40b7a@gmx.de>
Date: Fri, 7 Mar 2025 22:51:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] platform/x86: Add lenovo-wmi drivers Documentation
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
 <20250225220037.16073-2-derekjohn.clark@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250225220037.16073-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T+4JSgcN9QyMtWcRa2VMRbqGcrjrHVhFb+x2DsmKg2jbfe4s5e+
 PMpUIQS8o6sEJ48BN1Bvr9ke9Mebn0SWUpDN1CnCM27v/gA9c3KsjWv5jOakp9a48WB0bR1
 JiYkrFUbl+wsWljU0uf45GygAvzLJG4r+T7wcDaX0TiZXEyQBJlnwp/aI5I/ETZ0KNPvqTb
 vwL8zT8Br/4Q6wBOk+hjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JuS6CBq87z8=;Te6tSu3Oe4M2ILhQXY+pf9zNpLX
 Ire/w2kCdPQWkH9TsOHaZu/tetEV5BFhfgOqwa6kcfX8NbBFMwBSAkjrzKSF5eI3av3DBi7zL
 UfMr4/35B4IZZKvqexUxvuAmexDJzDhHy/zN7GU/Tx682RQR5pm1A6PAumy6E0t6N59wnnp6L
 hYI55jI/qPDKorl2YgJVZ3vRWB7yiQS7QqCzFLhxbsOR64SpWsCQ3GfmBjf3hHJv6/GcYqDUA
 D3OhW5ZSGr/PylV1tYw6H1Sdf6ROcYkKRrQpJbGn+EfqvHUmrxyig+xnXMQNJYSslLSVL+8B7
 lMunhLqCFWAnQnoB66CXvHRC94WTSn1aqLf/j5FegImmcymNA4pn2fIlR484NDC8qgQRYjf0F
 6PZTyYmmSWdHGkZU2Ehx6RI+t6F5y9bn7eGvi1hrkIr5p7MWrganxx4fxcFEffmnl7eupNEJk
 W/oevB7A9BEfG+2kEKdEmemf+J1VtifqCJqkGC/kyMjO2n4wRvaHsMSkWYvyzrs9IHrXg+j1y
 DGxaAkx255V00R5mcVkEGl319SCHcaxI3BS/87fyfG1YryfPlA5FXXP5xbXztSLLiBPO9rGu6
 DHiqPA3XXt5YRFShU4kAPwkg7KlH4Oc5k8Lsrm7yXEsGVyLqnNzKn9A8ERq5A71gNbPoGXzmW
 kfa/em+22y6+3ArySbreEZ0LtGBqNEUuuvxUOHLKr9gqZiPFUrPwQ3zvNjO1Ubx+mcHoVbD4m
 W5PT5aGtASKgqiCKI1gUSOMPvfn9QvC3xcfAHr6VRQ9UcIWNq0Vio4SfCc5UxcRJAYb22Ms9j
 opajQ+yE8Dfo8jWAr1FyLUxcJRcLnoJVUwBC0kWJgg7ileNosqspyR4owqOjinmJvRE33+drq
 5PNMlbCc7H8cgFZ2Ba/YlHFmVUS642P5V7dt49mELOISbOfqk07xd/6xQS8K5IiwPB5JOVe+n
 2dXImdQ/xt+SxVGC28AB2MR2oh1jpY1zE+44muaU7MNY+CdYB044BiZXB0kneQvr1R5Hl+lFl
 arJKOXn84k8LLesmT4goYqeAQIxsWWsXX04fXy4i+X/FepljX+bAIf41F8oFIZ4U5eQca1wFS
 qiOaoZL5GA7VA+zjNWkWW74aXkUZJp1cY83+3PTaMQiyoBo3w7YUojczNeDrk/0RnQDHHOXxP
 sRtTqVSJTjY5VLlSN/uktENtC4eubzZOhVH/g1w89rgvUuH7KGyMjqXJoa7G31A+OX5dNliMD
 HzK3+GQtn77aypm30zVzBs6ZGaJnUqgH3IX2nE3uTwV7KGV/IHri0YoEi4Q41yWdkRUQ8Y4Ie
 V7wikDw3N/+cljBJGAl6wj9pPO6pEk6c8v5C/zjPHrFjIlVu2Zv89QKpqzBXA/Wh78mU6a9B/
 tiTysVD2MTzLU02w5Ql26HmDnhCoXHgS+pdh68VctKVjXAqjVKgMlL4zCc2mLsbnGtlswcptd
 cMhZ6O7UGnIzFfYfQmgfT+lMZ22I=

Am 25.02.25 um 22:59 schrieb Derek J. Clark:

> Adds documentation for all new lenovo-wmi drivers.
>
> v3:
> - Split documentation into multiple files, one for each parent
>    driver for the Gamezone and Other Mode WMI interfaces.
> - Add MOF data for all parent and child interfaces.
> - Remove lenovo-wmi-camera.c driver from v2 documentation.
> v2:
> - Update description of Custom Profile to include the need to manually
>    set it.
> - Remove all references to Legion hardware.
> - Add section for lenovo-wmi-camera.c driver as it follows the same
>    naming convention.
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>   .../wmi/devices/lenovo-wmi-gamezone.rst       | 355 ++++++++++++++++++
>   .../wmi/devices/lenovo-wmi-other-method.rst   | 142 +++++++
>   MAINTAINERS                                   |   7 +
>   3 files changed, 504 insertions(+)
>   create mode 100644 Documentation/wmi/devices/lenovo-wmi-gamezone.rst
>   create mode 100644 Documentation/wmi/devices/lenovo-wmi-other-method.r=
st
>
> diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documen=
tation/wmi/devices/lenovo-wmi-gamezone.rst
> new file mode 100644
> index 000000000000..1dc281fdd99d
> --- /dev/null
> +++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> @@ -0,0 +1,355 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Lenovo WMI Interface Gamezone Driver (lenovo-wmi-gamezone)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The Lenovo WMI gamezone interface is broken up into multiple GUIDs,
> +The priamry "Gamezone" GUID provides advanced features such as fan
> +profiles and overclocking. It is paired with multiple event GUIDs
> +and data block GUIDs that provide context for the various methods.
> +
> +Gamezone Data
> +-------------
> +WMI GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"

Maybe formatting the GUID as monospace text would look better here.

> +
> +The Gamezone Data WMI interface provides platform-profile and fan curve
> +settings for devices that fall under the "Gaming Series" of Lenovo devi=
ces.
> +It uses a notifier chain to inform other Lenovo WMI interface drivers o=
f the
> +current platform profile when it changes.
> +
> +The following platform profiles are supported:
> + - low-power
> + - balanced
> + - balanced-performance
> + - performance
> + - custom
> +
> +Balanced-Perfornance and Performance Profiles
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profil=
e
> +enabled in their BIOS. For these devices, the performance platform prof=
ile
> +will correspond to the BIOS Extreme Mode, while the balanced-performanc=
e
> +platform profile will correspond to the BIOS Performance mode. For lega=
cy
> +devices, the performance platform prfile will correspond with the BIOS
> +Performance mode.
> +
> +Custom Profile
> +~~~~~~~~~~~~~~
> +The custom profile represents a hardware mode on Lenovo devices that en=
ables
> +user modifications to Package Power Tracking (PPT) and fan curve settin=
gs.
> +When an attribute exposed by the Other Mode WMI interface is to be modi=
fied,
> +the Gamezone driver must first be switched to the "custom" profile manu=
ally,
> +or the setting will have no effect. If another profile is set from the =
list
> +of supported profiles, the BIOS will override any user PPT settings whe=
n
> +switching to that profile.
> +
> +Gamezone Thermal Mode Event
> +---------------------------
> +WMI GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
> +

Same as above.

> +The Gamezone Thermal Mode Event interface notifies the system when the =
platform
> +profile has changed, either through the hardware event (Fn+Q for laptop=
s or
> +Legion + Y for Go Series), or through the Gamezone WMI interface.
> +
> +
> +WMI interface description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +The WMI interface description can be decoded from the embedded binary M=
OF (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("LENOVO_GAMEZONE_DATA class"),
> +   guid("{887B54E3-DDDC-4B2C-8B88-68A26A8835D0}")]
> +  class LENOVO_GAMEZONE_DATA {
> +  	[key, read] string InstanceName;
> +  	[read] boolean Active;

The MOF definition mixes tabs and spaces and is not properly indented. Ple=
ase fix this.

> +
> +  	[WmiMethodId(4), Implemented, Description("Is SupportGpu OverClock")=
]
> +    void IsSupportGpuOC([out, Description("Is SupportGpu OverClock")] u=
int32 Data);
> +
> +  	[WmiMethodId(11), Implemented, Description("Get AslCode Version")]
> +    void GetVersion ([out, Description("AslCode version")] UINT32 Data)=
;
> +
> +  	[WmiMethodId(12), Implemented, Description("Fan cooling capability")=
]
> +    void IsSupportFanCooling([out, Description("Fan cooling capability"=
)] UINT32 Data);
> +
> +  	[WmiMethodId(13), Implemented, Description("Set Fan cooling on/off")=
]
> +    void SetFanCooling ([in, Description("Set Fan cooling on/off")] UIN=
T32 Data);
> +
> +  	[WmiMethodId(14), Implemented, Description("cpu oc capability")]
> +    void IsSupportCpuOC ([out, Description("cpu oc capability")] UINT32=
 Data);
> +
> +  	[WmiMethodId(15), Implemented, Description("bios has overclock capab=
ility")]
> +    void IsBIOSSupportOC ([out, Description("bios has overclock capabil=
ity")] UINT32 Data);
> +
> +  	[WmiMethodId(16), Implemented, Description("enable or disable overcl=
ock in bios")]
> +    void SetBIOSOC ([in, Description("enable or disable overclock in bi=
os")] UINT32 Data);
> +
> +  	[WmiMethodId(18), Implemented, Description("Get CPU temperature")]
> +    void GetCPUTemp ([out, Description("Get CPU temperature")] UINT32 D=
ata);
> +
> +  	[WmiMethodId(19), Implemented, Description("Get GPU temperature")]
> +    void GetGPUTemp ([out, Description("Get GPU temperature")] UINT32 D=
ata);
> +
> +  	[WmiMethodId(20), Implemented, Description("Get Fan cooling on/off s=
tatus")]
> +    void GetFanCoolingStatus ([out, Description("Get Fan cooling on/off=
 status")] UINT32 Data);
> +
> +  	[WmiMethodId(21), Implemented, Description("EC support disable windo=
ws key capability")]
> +    void IsSupportDisableWinKey ([out, Description("EC support disable =
windows key capability")] UINT32 Data);
> +
> +  	[WmiMethodId(22), Implemented, Description("Set windows key disable/=
enable")]
> +    void SetWinKeyStatus ([in, Description("Set windows key disable/ena=
ble")] UINT32 Data);
> +
> +  	[WmiMethodId(23), Implemented, Description("Get windows key disable/=
enable status")]
> +    void GetWinKeyStatus ([out, Description("Get windows key disable/en=
able status")] UINT32 Data);
> +
> +  	[WmiMethodId(24), Implemented, Description("EC support disable touch=
pad capability")]
> +    void IsSupportDisableTP ([out, Description("EC support disable touc=
hpad capability")] UINT32 Data);
> +
> +  	[WmiMethodId(25), Implemented, Description("Set touchpad disable/ena=
ble")]
> +    void SetTPStatus ([in, Description("Set touchpad disable/enable")] =
UINT32 Data);
> +
> +  	[WmiMethodId(26), Implemented, Description("Get touchpad disable/ena=
ble status")]
> +    void GetTPStatus ([out, Description("Get touchpad disable/enable st=
atus")] UINT32 Data);
> +
> +  	[WmiMethodId(30), emented, 	Description("Get Keyboard feature list")=
]
> +    void GetKeyboardfeaturelist ([out, Description("Get Keyboard featur=
e list")] UINT32 Data);
> +
> +  	[WmiMethodId(31), emented, 	Description("Get Memory OC Information")=
]
> +    void GetMemoryOCInfo ([out, Description("Get Memory OC Information"=
)] UINT32 Data);
> +
> +  	[WmiMethodId(32), emented, 	Description("Water Cooling feature capab=
ility")]
> +    void IsSupportWaterCooling ([out, Description("Water Cooling featur=
e capability")] UINT32 Data);
> +
> +  	[WmiMethodId(33), emented, 	Description("Set Water Cooling status")]
> +    void SetWaterCoolingStatus ([in, Description("Set Water Cooling sta=
tus")] UINT32 Data);
> +
> +  	[WmiMethodId(34), emented, 	Description("Get Water Cooling status")]
> +    void GetWaterCoolingStatus ([out, Description("Get Water Cooling st=
atus")] UINT32 Data);
> +
> +  	[WmiMethodId(35), emented, 	Description("Lighting feature capability=
")]
> +    void IsSupportLightingFeature ([out, Description("Lighting feature =
capability")] UINT32 Data);
> +
> +  	[WmiMethodId(36), emented, 	Description("Set keyboard light off or o=
n to max")]
> +    void SetKeyboardLight ([in, Description("keyboard light off or on s=
witch")] UINT32 Data);
> +
> +  	[WmiMethodId(37), emented, 	Description("Get keyboard light on/off s=
tatus")]
> +    void GetKeyboardLight ([out, Description("Get keyboard light on/off=
 status")] UINT32 Data);
> +
> +  	[WmiMethodId(38), emented, 	Description("Get Macrokey scan code")]
> +    void GetMacrokeyScancode ([in, Description("Macrokey index")] UINT3=
2 idx, [out, Description("Scan code")] UINT32 scancode);
> +
> +  	[WmiMethodId(39), emented, 	Description("Get Macrokey count")]
> +    void GetMacrokeyCount ([out, Description("Macrokey count")] UINT32 =
Data);
> +
> +  	[WmiMethodId(40), emented, 	Description("Support G-Sync feature")]
> +    void IsSupportGSync ([out, Description("Support G-Sync feature")] U=
INT32 Data);
> +
> +  	[WmiMethodId(41), emented, 	Description("Get G-Sync Statust")]
> +    void GetGSyncStatus ([out, Description("Get G-Sync Statust")] UINT3=
2 Data);
> +
> +  	[WmiMethodId(42), emented, 	Description("Set G-Sync Statust")]
> +    void SetGSyncStatus ([in, Description("Set G-Sync Statust")] UINT32=
 Data);
> +
> +  	[WmiMethodId(43), emented, 	Description("Support Smart Fan feature")=
]
> +    void IsSupportSmartFan ([out, Description("Support Smart Fan featur=
e")] UINT32 Data);
> +
> +  	[WmiMethodId(44), emented, 	Description("Set Smart Fan Mode")]
> +    void SetSmartFanMode ([in, Description("Set Smart Fan Mode")] UINT3=
2 Data);
> +
> +  	[WmiMethodId(45), emented, 	Description("Get Smart Fan Mode")]
> +    void GetSmartFanMode ([out, Description("Get Smart Fan Mode")] UINT=
32 Data);
> +
> +  	[WmiMethodId(46), emented, 	Description("Get Smart Fan Setting Mode"=
)]
> +    void GetSmartFanSetting ([out, Description("Get Smart Setting Mode"=
)] UINT32 Data);
> +
> +  	[WmiMethodId(47), emented, 	Description("Get Power Charge Mode")]
> +    void GetPowerChargeMode ([out, Description("Get Power Charge Mode")=
] UINT32 Data);
> +
> +  	[WmiMethodId(48), emented, Description("Get Gaming Product Info")]
> +    void GetProductInfo ([out, Description("Get Gaming Product Info")] =
UINT32 Data);
> +
> +  	[WmiMethodId(49), emented, Description("Over Drive feature capabilit=
y")]
> +    void IsSupportOD ([out, Description("Over Drive feature capability"=
)] UINT32 Data);
> +
> +  	[WmiMethodId(50), emented, Description("Get Over Drive status")]
> +    void GetODStatus ([out, Description("Get Over Drive status")] UINT3=
2 Data);
> +
> +  	[WmiMethodId(51), emented, Description("Set Over Drive status")]
> +    void SetODStatus ([in, Description("Set Over Drive status")] UINT32=
 Data);
> +
> +  	[WmiMethodId(52), emented, Description("Set Light Control Owner")]
> +    void SetLightControlOwner ([in, Description("Set Light Control Owne=
r")] UINT32 Data);
> +
> +  	[WmiMethodId(53), emented, Description("Set DDS Control Owner")]
> +    void SetDDSControlOwner ([in, Description("Set DDS Control Owner")]=
 UINT32 Data);
> +
> +  	[WmiMethodId(54), emented, Description("Get the flag of restore OC v=
alue")]
> +    void IsRestoreOCValue ([in, Description("Clean this flag")] UINT32 =
idx, [out, Description("Restore oc value flag")] UINT32 Data);
> +
> +  	[WmiMethodId(55), emented, 	Description("Get Real Thremal Mode")]
> +    void GetThermalMode ([out, Description("Real Thremal Mode")] UINT32=
 Data);
> +
> +  	[WmiMethodId(56), emented, 	Description("Get the OC switch status in=
 BIOS")]
> +    void GetBIOSOCMode ([out, Description("OC Mode")] UINT32 Data);
> +
> +  	[WmiMethodId(59), emented, 	Description("Get hardware info support v=
ersion")]
> +    void GetHardwareInfoSupportVersion ([out, Description("version")] U=
INT32 Data);
> +
> +  	[WmiMethodId(60), emented, 	Description("Get Cpu core 0 max frequenc=
y")]
> +    void GetCpuFrequency ([out, Description("frequency")] UINT32 Data);
> +
> +  	[WmiMethodId(62), emented, 	Description("Check the Adapter type fit =
for OC")]
> +    void IsACFitForOC ([out, Description("AC check result")] UINT32 Dat=
a);
> +
> +  	[WmiMethodId(63), emented, 	Description("Is support IGPU mode")]
> +    void IsSupportIGPUMode ([out, Description("IGPU modes")] UINT32 Dat=
a);
> +
> +  	[WmiMethodId(64), emented, 	Description("Get IGPU Mode Status")]
> +    void GetIGPUModeStatus([out, Description("IGPU Mode Status")] UINT3=
2 Data);
> +
> +  	[WmiMethodId(65), emented, 	Description("Set IGPU Mode")]
> +    void SetIGPUModeStatus([in, Description("IGPU Mode")] UINT32 mode, =
[out, Description("return code")] UINT32 Data);
> +
> +  	[WmiMethodId(66), emented, Description("Notify DGPU Status")]
> +    void NotifyDGPUStatus([in, Description("DGPU status")] UINT32 statu=
s, [out, Description("return code")] UINT32 Data);
> +
> +  	[WmiMethodId(67), emented, 	Description("Is changed Y log")]
> +    void IsChangedYLog([out, Description("Is changed Y Log")] UINT32 Da=
ta);
> +
> +  	[WmiMethodId(68), emented, Description("Get DGPU Hardwawre ID")]
> +    void GetDGPUHWId([out, Description("Get DGPU Hardware ID")] string =
Data);
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("Definition of CPU OC parameter list"),
> +   guid("{B7F3CA0A-ACDC-42D2-9217-77C6C628FBD2}")]
> +  class LENOVO_GAMEZONE_CPU_OC_DATA {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description("OC tune id.")]
> +      uint32 Tuneid;
> +
> +      [WmiDataId(2), read, Description("Default value.")]
> +      uint32 DefaultValue;
> +
> +      [WmiDataId(3), read, Description("OC Value.")]
> +      uint32 OCValue;
> +
> +      [WmiDataId(4), read, Description("Min Value.")]
> +      uint32 MinValue;
> +
> +      [WmiDataId(5), read, Description("Max Value.")]
> +      uint32 MaxValue;
> +
> +      [WmiDataId(6), read, Description("Scale Value.")]
> +      uint32 ScaleValue;
> +
> +      [WmiDataId(7), read, Description("OC Order id.")]
> +      uint32 OCOrderid;
> +
> +      [WmiDataId(8), read, Description("NON-OC Order id.")]
> +      uint32 NOCOrderid;
> +
> +      [WmiDataId(9), read, Description("Delay time in ms.")]
> +      uint32 Interval;
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("Definition of GPU OC parameter list"),
> +   guid("{887B54E2-DDDC-4B2C-8B88-68A26A8835D0}")]
> +  class LENOVO_GAMEZONE_GPU_OC_DATA {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description("P-State ID.")]
> +      uint32 PStateID;
> +
> +      [WmiDataId(2), read, Description("CLOCK ID.")]
> +      uint32 ClockID;
> +
> +      [WmiDataId(3), read, Description("Default value.")]
> +      uint32 defaultvalue;
> +
> +      [WmiDataId(4), read, Description("OC Offset freqency.")]
> +      uint32 OCOffsetFreq;
> +
> +      [WmiDataId(5), read, Description("OC Min offset value.")]
> +      uint32 OCMinOffset;
> +
> +      [WmiDataId(6), read, Description("OC Max offset value.")]
> +      uint32 OCMaxOffset;
> +
> +      [WmiDataId(7), read, Description("OC Offset Scale.")]
> +      uint32 OCOffsetScale;
> +
> +      [WmiDataId(8), read, Description("OC Order id.")]
> +      uint32 OCOrderid;
> +
> +      [WmiDataId(9), read, Description("NON-OC Order id.")]
> +      uint32 NOCOrderid;
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("Fancooling finish event"),
> +   guid("{BC72A435-E8C1-4275-B3E2-D8B8074ABA59}")]
> +  class LENOVO_GAMEZONE_FAN_COOLING_EVENT: WMIEvent {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description("Fancooling clean finish event")=
]
> +      uint32 EventId;
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("Smart Fan mode change event"),
> +   guid("{D320289E-8FEA-41E0-86F9-611D83151B5F}")]
> +  class LENOVO_GAMEZONE_SMART_FAN_MODE_EVENT: WMIEvent {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description("Smart Fan Mode change event")]
> +      uint32 mode;
> +
> +  	  [WmiDataId(2), read, Description("version of FN+Q")]
> +      uint32 version;
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("Smart Fan setting mode change event"),
> +   guid("{D320289E-8FEA-41E1-86F9-611D83151B5F}")]
> +  class LENOVO_GAMEZONE_SMART_FAN_SETTING_EVENT: WMIEvent {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description("Smart Fan Setting mode change e=
vent")]
> +      uint32 mode;
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("POWER CHARGE MODE Change EVENT"),
> +   guid("{D320289E-8FEA-41E0-86F9-711D83151B5F}")]
> +  class LENOVO_GAMEZONE_POWER_CHARGE_MODE_EVENT: WMIEvent {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description("POWER CHARGE MODE Change EVENT"=
)]
> +      uint32 mode;
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("Thermal Mode Real Mode change event"),
> +   guid("{D320289E-8FEA-41E0-86F9-911D83151B5F}")]
> +  class LENOVO_GAMEZONE_THERMAL_MODE_EVENT: WMIEvent {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description("Thermal Mode Real Mode")]
> +      uint32 mode;
> +  };
> diff --git a/Documentation/wmi/devices/lenovo-wmi-other-method.rst b/Doc=
umentation/wmi/devices/lenovo-wmi-other-method.rst
> new file mode 100644
> index 000000000000..d555f1ed9588
> --- /dev/null
> +++ b/Documentation/wmi/devices/lenovo-wmi-other-method.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Lenovo WMI Interface Other Mode Driver (lenovo-wmi-other)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Lenovo WMI Other Mode interface is broken up into multiple GUIDs,
> +The primary Other Mode interface provides advanced power tuning feature=
s
> +such as Package Power Tracking (PPT). It is paired with multiple data b=
lock
> +GUIDs that provide context for the various methods.
> +
> +
> +Other Mode
> +------------
> +WMI GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"

The suggestion with the monospace formatting applies here too.

> +
> +The Other Mode WMI interface uses the fw_attributes class to expose
> +various WMI attributes provided by the interface in the sysfs. This ena=
bles
> +CPU and GPU power limit tuning as well as various other attributes for
> +devices that fall under the "Gaming Series" of Lenovo devices. Each
> +attribute exposed by the Other Mode interface has corresponding
> +capability data blocks which allow the driver to probe details about th=
e
> +attribute. Each attibute has multiple pages, one for each of the platfo=
rm
> +profiles managed by the Gamezone interface. Attributes are exposed in s=
ysfs
> +under the following path:
> +
> +::
> +/sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>/
> +
> +LENOVO_CAPABILITY_DATA_01
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +WMI GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"

Same as above.

> +
> +The LENOVO_CAPABILITY_DATA_01 interface provides information on various
> +power limits of integrated CPU and GPU components.
> +
> +The following attributes are supported:
> + - ppt_pl1_spl: Platform Profile Tracking Sustained Power Limit
> + - ppt_pl2_sppt: Platform Profile Tracking Slow Package Power Tracking
> + - ppt_pl3_fppt: Platform Profile Tracking Fast Package Power Tracking
> +
> +Each attribute has the following properties:
> + - current_value
> + - default_value
> + - display_name
> + - max_value
> + - min_value
> + - scalar_increment
> + - type
> +
> +
> +WMI interface description
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +The WMI interface description can be decoded from the embedded binary M=
OF (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("LENOVO_OTHER_METHOD class"),
> +   guid("{dc2a8805-3a8c-41ba-a6f7-092e0089cd3b}")]
> +  class LENOVO_OTHER_METHOD {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiMethodId(17), Implemented, Description("Get Feature Value ")]
> +      void GetFeatureValue([in] uint32 IDs, [out] uint32 value);
> +
> +      [WmiMethodId(18), Implemented, Description("Set Feature Value ")]
> +      void SetFeatureValue([in] uint32 IDs, [in] uint32 value);
> +
> +      [WmiMethodId(19), Implemented, Description("Get Data By Command "=
)]
> +      void GetDataByCommand([in] uint32 IDs, [in] uint32 Command, [out]=
 uint32 DataSize, [out, WmiSizeIs("DataSize")] uint32 Data[]);
> +
> +      [WmiMethodId(99), Implemented, Description("Get Data By Package f=
or TAC")]
> +      void GetDataByPackage([in, Max(40)] uint8 Input[], [out] uint32 D=
ataSize, [out, WmiSizeIs("DataSize")] uint8 Data[]);
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("LENOVO CAPABILITY DATA 00"),
> +   guid("{362a3afe-3d96-4665-8530-96dad5bb300e}")]
> +  class LENOVO_CAPABILITY_DATA_00 {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description(" IDs.")]
> +      uint32 IDs;
> +
> +      [WmiDataId(2), read, Description("Capability.")]
> +      uint32 Capability;
> +
> +      [WmiDataId(3), read, Description("Capability Default Value.")]
> +      uint32 DefaultValue;
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("LENOVO CAPABILITY DATA 01"),
> +   guid("{7a8f5407-cb67-4d6e-b547-39b3be018154}")]
> +  class LENOVO_CAPABILITY_DATA_01 {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description(" IDs.")]
> +      uint32 IDs;
> +
> +      [WmiDataId(2), read, Description("Capability.")]
> +      uint32 Capability;
> +
> +      [WmiDataId(3), read, Description("Default Value.")]
> +      uint32 DefaultValue;
> +
> +      [WmiDataId(4), read, Description("Step.")]
> +      uint32 Step;
> +
> +      [WmiDataId(5), read, Description("Minimum Value.")]
> +      uint32 MinValue;
> +
> +      [WmiDataId(6), read, Description("Maximum Value.")]
> +      uint32 MaxValue;
> +  };
> +
> +  [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"),
> +   Description("LENOVO CAPABILITY DATA 02"),
> +   guid("{bbf1f790-6c2f-422b-bc8c-4e7369c7f6ab}")]
> +  class LENOVO_CAPABILITY_DATA_02 {
> +      [key, read] string InstanceName;
> +      [read] boolean Active;
> +
> +      [WmiDataId(1), read, Description(" IDs.")]
> +      uint32 IDs;
> +
> +      [WmiDataId(2), read, Description("Capability.")]
> +      uint32 Capability;
> +
> +      [WmiDataId(3), read, Description("Data Size.")]
> +      uint32 DataSize;
> +
> +      [WmiDataId(4), read, Description("Default Value"), WmiSizeIs("Dat=
aSize")]
> +      uint8 DefaultValue[];
> +  };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f78d6bcbc7b..e20c32b3c480 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13151,6 +13151,13 @@ S:	Maintained
>   W:	http://legousb.sourceforge.net/
>   F:	drivers/usb/misc/legousbtower.c
>
> +LENOVO WMI drivers
> +M:	Derek J. Clark <derekjohn.clark@gmail.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/wmi/devices/lenovo-wmi-gamezone.rst
> +F:	Documentation/wmi/devices/lenovo-wmi-other.rst

Just a side note: when rebasing your work on the current for-next branch y=
ou will have to resolve a minor merge
conflict here due to the new Lenovo hotkey utilities driver.

Apart from the formatting issues the remaining patch looks good to me.

Thanks,
Armin Wolf

> +
>   LETSKETCH HID TABLET DRIVER
>   M:	Hans de Goede <hdegoede@redhat.com>
>   L:	linux-input@vger.kernel.org

