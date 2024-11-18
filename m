Return-Path: <linux-kernel+bounces-413414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8769D18C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900FB282D45
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813721E1312;
	Mon, 18 Nov 2024 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="DpDaGY5y"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683717597;
	Mon, 18 Nov 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957661; cv=none; b=h6QlHg2r68k5cAu5zVCymUywg9BgsGaqG63Emel2+PpKeFk4juy4omxTLc1+Ru4I99v5hs1lGBoBZaKzlBGpzvIgrmv+vDyJ9fZfHqYU2SR45b8UMlTDPVcXKrdwmGh+UwR6KWUzgV1P3u+j66o/RwGPmpDHxmKWlPMufotBirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957661; c=relaxed/simple;
	bh=Q6oXnr1ZTGLQ8eO+O27g07ydUDCazsInYK6KktQm9LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjtI0f5uPGHOu79lpfSSfmqtr5Rt+i9yUlVqa86wsPE5NNrYqLf+xVBPCy6LtO5pVw/hen221rKMdikLNt9U05F7HdRxo7XQ0dZFb+GiKCGJraGLcerqLXLZt9EXPumNj1appTSPTtJid/S7okIjGocMbNjkIl0pvcD94ZG+zpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=DpDaGY5y; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731957641; x=1732562441; i=w_armin@gmx.de;
	bh=JDgSALZIqL6FT/2dbunM20N9lL4j5NVyGYu7VNg86+Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DpDaGY5y99/62dtelpb8w6sKbBZrnwRN+EbgoaaPlJBF/CV+vuwoINYXfyQwylHt
	 l591/SvR+Ur+U18Oh1hNa4yFTYqtXMpK1CN/QtRVq6PHxQ02KCZI33lYZZk5hxuXO
	 QqkjyViDA3m/tDdyOSVdUdGuT7o+6/uh7GGTEkzVN0aA0zD8QIIupBwlmZRacevSz
	 BigReZAoZVbEbuNFtfWZPTBhVZofjUWGeE7sW/AlGpzieHt6cyB7jf1Lewvx3HgGA
	 aCfPYUK77wNfScE8oVdA0Nl6A/Nhj6m15NuQjalcVP9LT5g83oJlnFBvx0S4e+Jhe
	 dSg12+3TJUkmTt1iMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7QxL-1tpId21Rdd-00v3og; Mon, 18
 Nov 2024 20:20:41 +0100
Message-ID: <7615f753-1f6d-4824-b0e2-7de934fc8283@gmx.de>
Date: Mon, 18 Nov 2024 20:20:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Lenovo Legion Go WMI Control
To: zhixin zhang <jonmail@163.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhixin zhang <zhangzx36@lenovo.com>
References: <20241118100503.14228-1-jonmail@163.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241118100503.14228-1-jonmail@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sXOOSTTknEkjYZSzRd2WhddObZp0u8+pY2ieajPA8ffJ1wprqmW
 /LuM390PxE7TRa3vdV8a8CDFV0LJtjGnb6VqPfuIrvvplQrVh0mSfhqZBiiVOhazqej1jJv
 2xh5+jE/ddeug8yn4PBcNMO4QBdrpLrFNCM6UPj5FRebwGTlREy0GxHw5vuJrDDQ2dP2id1
 AnsHN1PUeAUdfKdC8ocIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4/q57rY5jEY=;GQbukvNLDDm8Smbd9oJ8gsob/zr
 CBAnpgP/CXkaVOUZQ+xXkG8tIT7wZ21/Jd+ns28SG44Hzoe7vzi5/vTVus8To3aSpWDqNHt5w
 G26qV5qD7nNRW12EbZRzo22cs4T1qRBrLu0gZQOk17EbMYL26XijANynnvAqGoKccD0lXOLCG
 snUJednIOKaMX80mYRqg7L3TDVfIYsdY1Og6mNiN5PKXcDd6laAG8MU8fqCeXAwd90+3NIu0i
 n05FMHFadcRc3/9RI8Uk61BEt/1EVbHUe7QCDUhFDdePdNnfN/PhHMBKFbg72wEEOE6B+JVQb
 8/cykKieEgm5TYTR7hYKZGeUrbs1bHUMsLx7DyF4CDKJ6S53AQsTMT3ASxQzWV29G7I1yCTDq
 vbXRV33Gu2ZkqgvSYRnVHWWc8U5yjHBnCazfvMNbiqO1bNt2j8B6j31auAJxjIim6mGnu9VB5
 oV6v+EYJjnen9Hml4EbEMBZMcsd2PFGbDHi3IucNuHF3HrNuvod+hG3lp/C+khA3uXzOYTWPY
 1dMAK7lrvUFeOejWIK4s65ncq8zqnGNZwmCRnZ6QmiuMnbfFUsyclMmb/tsGhxMwk1k7Z1Md/
 nwNXYVegKXVAWanWtM7vW7SBqJbEdaFJKkj+T8RsO0Uo7BKYxxcp3dYLzmY1EQ5e3O3phIJJu
 4yEagJfKGWbGpeNSJqX7mOcf00rQOEdVL5BiP0SjU4kMOvJ6bU7TvnID8be2bInspTVO45BxS
 SGZ6u6i2L3+ou93s8yi0/YeKk7aen47SNCq8Fk33HJvVR/RL4t+FURacffR3lh2Z24XRz0Nt2
 LUhKylKxKNnO7c+3GYG9kMaZu/kTms6RvdlX2r5D4Lpa+bNTu4QATETIxqih67XpzYE0AlQ4L
 wcVjVXGq4nslz0ecd0G3C/c9W2mKEaKOsVgoa+EYgQ6werVr8BcsA8Pjn

Am 18.11.24 um 11:05 schrieb zhixin zhang:

> From: zhixin zhang <zhangzx36@lenovo.com>
>
> This driver provides support for modifying the performance mode
> function of Lenovo's Legion Go series.

Thanks for submitting the driver. Apart from the styling issues (please us=
e checkpatch for the next revision),
i have a couple of issues with the general architecture of this driver:

- it tries to handle two unrelated WMI devices at the same time.

- it exposes a userspace interface for calling raw WMI methods, nothing el=
se.

- it uses procfs for this task.
_For the LEGION_GO_WMI_GAMEZONE_GUID:_

It seems to me that this WMI device is also present on other machines manu=
factured by Lenovo, so
please create a separate driver for it (you might call it "lenovo-gamezone=
-wmi").

Also please write a short documentation regarding the WMI interface used b=
y this driver:

[WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("LENO=
VO_GAMEZONE_DATA class"), guid("{887B54E3-DDDC-4B2C-8B88-68A26A8835D0}")]
class LENOVO_GAMEZONE_DATA {
   [key, read] string InstanceName;
   [read] boolean Active;

   [WmiMethodId(1), Implemented, Description("Get IR temp")] void GetIRTem=
p([out, Description("IR temperature")] uint32 Data);
   [WmiMethodId(2), Implemented, Description("Get ThermalTable ID")] void =
GetThermalTableID([out, Description("Get ThermalTable ID")] uint32 Data);
   [WmiMethodId(3), Implemented, Description("Set ThermalTable ID")] void =
SetThermalTableID([in, Description("Set ThermalTable ID")] uint32 Data);
   [WmiMethodId(4), Implemented, Description("Is SupportGpu OverClock")] v=
oid IsSupportGpuOC([out, Description("Is SupportGpu OverClock")] uint32 Da=
ta);
   [WmiMethodId(5), Implemented, Description("Get GpuGpsState")] void GetG=
puGpsState([out, Description("Get GpuGpsState")] uint32 Data);
   [WmiMethodId(6), Implemented, Description("Set GpuGpsState")] void SetG=
puGpsState([in, Description("Set GpuGpsState")] uint32 Data);
   [WmiMethodId(7), Implemented, Description("Get Fan Count")] void GetFan=
Count([out, Description("Fan Count")] uint32 Data);
   [WmiMethodId(8), Implemented, Description("Get Fan1 Speed")] void GetFa=
n1Speed([out, Description("Fan1 Speed")] uint32 Data);
   [WmiMethodId(9), Implemented, Description("Get Fan2 Speed")] void GetFa=
n2Speed([out, Description("Fan2 Speed")] uint32 Data);
   [WmiMethodId(10), Implemented, Description("Get Fan Max Speed")] void G=
etFanMaxSpeed([out, Description("Fan Max Speed")] uint32 Data);
   [WmiMethodId(11), Implemented, Description("Get AslCode Version")] void=
 GetVersion([out, Description("AslCode version")] uint32 Data);
   [WmiMethodId(12), Implemented, Description("Fan cooling capabilty")] vo=
id IsSupportFanCooling([out, Description("Fan cooling capablity")] uint32 =
Data);
   [WmiMethodId(13), Implemented, Description("Set Fan cooling on/off")] v=
oid SetFanCooling([in, Description("Set Fan cooling on/off")] uint32 Data)=
;
   [WmiMethodId(14), Implemented, Description("cpu oc capability")] void I=
sSupportCpuOC([out, Description("cpu oc capability")] uint32 Data);
   [WmiMethodId(15), Implemented, Description("bios has overclock capabili=
ty")] void IsBIOSSupportOC([out, Description("bios has overclock capabilit=
y")] uint32 Data);
   [WmiMethodId(16), Implemented, Description("enble or disable overclock =
in bios")] void SetBIOSOC([in, Description("enble or disable overclock in =
bios")] uint32 Data);
   [WmiMethodId(17), Implemented, Description("Get temperature change trig=
ger temp value")] void GetTriggerTemperatureValue([out, Description("Get t=
emperature change trigger temp value")] uint32 Data);
   [WmiMethodId(18), Implemented, Description("Get CPU temperature")] void=
 GetCPUTemp([out, Description("Get CPU temperature")] uint32 Data);
   [WmiMethodId(19), Implemented, Description("Get GPU temperature")] void=
 GetGPUTemp([out, Description("Get GPU temperature")] uint32 Data);
   [WmiMethodId(20), Implemented, Description("Get Fan cooling on/off stat=
us")] void GetFanCoolingStatus([out, Description("Get Fan cooling on/off s=
tatus")] uint32 Data);
   [WmiMethodId(21), Implemented, Description("EC support disable windows =
key capability")] void IsSupportDisableWinKey([out, Description("EC suppor=
t disable windows key capability")] uint32 Data);
   [WmiMethodId(22), Implemented, Description("Set windows key disable/ena=
ble")] void SetWinKeyStatus([in, Description("Set windows key disable/enab=
le")] uint32 Data);
   [WmiMethodId(23), Implemented, Description("Get windows key disable/ena=
ble status")] void GetWinKeyStatus([out, Description("Get windows key disa=
ble/enable status")] uint32 Data);
   [WmiMethodId(24), Implemented, Description("EC support disable touchpad=
 capability")] void IsSupportDisableTP([out, Description("EC support disab=
le touchpad capability")] uint32 Data);
   [WmiMethodId(25), Implemented, Description("Set touchpad disable/enable=
")] void SetTPStatus([in, Description("Set touchpad disable/enable")] uint=
32 Data);
   [WmiMethodId(26), Implemented, Description("Get touchpad disable/enable=
 status")] void GetTPStatus([out, Description("Get touchpad disable/enable=
 status")] uint32 Data);
   [WmiMethodId(27), Implemented, Description("Get GPU normal mode max TDP=
(W)")] void GetGPUPow([out, Description("Get GPU normal mode max TDP(W)")]=
 uint32 Data);
   [WmiMethodId(28), Implemented, Description("Get GPU OC mode max TDP(W)"=
)] void GetGPUOCPow([out, Description("Get GPU OC mode max TDP(W)")] uint3=
2 Data);
   [WmiMethodId(29), Implemented, Description("Get GPU OC type")] void Get=
GPUOCType([out, Description("Get GPU OC type")] uint32 Data);
   [WmiMethodId(30), Implemented, Description("Get Keyboard feature list")=
] void GetKeyboardfeaturelist([out, Description("Get Keyboard feature list=
")] uint32 Data);
   [WmiMethodId(31), Implemented, Description("Get Memory OC Information")=
] void GetMemoryOCInfo([out, Description("Get Memory OC Information")] uin=
t32 Data);
   [WmiMethodId(32), Implemented, Description("Water Cooling feature capab=
ility")] void IsSupportWaterCooling([out, Description("Water Cooling featu=
re capability")] uint32 Data);
   [WmiMethodId(33), Implemented, Description("Set Water Cooling status")]=
 void SetWaterCoolingStatus([in, Description("Set Water Cooling status")] =
uint32 Data);
   [WmiMethodId(34), Implemented, Description("Get Water Cooling status")]=
 void GetWaterCoolingStatus([out, Description("Get Water Cooling status")]=
 uint32 Data);
   [WmiMethodId(35), Implemented, Description("Lighting feature capability=
")] void IsSupportLightingFeature([out, Description("Lighting feature capa=
bility")] uint32 Data);
   [WmiMethodId(36), Implemented, Description("Set keyboard light off or o=
n to max")] void SetKeyboardLight([in, Description("keyboard light off or =
on switch")] uint32 Data);
   [WmiMethodId(37), Implemented, Description("Get keyboard light on/off s=
tatus")] void GetKeyboardLight([out, Description("Get keyboard light on/of=
f status")] uint32 Data);
   [WmiMethodId(38), Implemented, Description("Get Macrokey scan code")] v=
oid GetMacrokeyScancode([in, Description("Macrokey index")] uint32 idx, [o=
ut, Description("Scan code")] uint32 scancode);
   [WmiMethodId(39), Implemented, Description("Get Macrokey count")] void =
GetMacrokeyCount([out, Description("Macrokey count")] uint32 Data);
   [WmiMethodId(40), Implemented, Description("Support G-Sync feature")] v=
oid IsSupportGSync([out, Description("Support G-Sync feature")] uint32 Dat=
a);
   [WmiMethodId(41), Implemented, Description("Get G-Sync Statust")] void =
GetGSyncStatus([out, Description("Get G-Sync Statust")] uint32 Data);
   [WmiMethodId(42), Implemented, Description("Set G-Sync Statust")] void =
SetGSyncStatus([in, Description("Set G-Sync Statust")] uint32 Data);
   [WmiMethodId(43), Implemented, Description("Support Smart Fan feature")=
] void IsSupportSmartFan([out, Description("Support Smart Fan feature")] u=
int32 Data);
   [WmiMethodId(44), Implemented, Description("Set Smart Fan Mode")] void =
SetSmartFanMode([in, Description("Set Smart Fan Mode")] uint32 Data);
   [WmiMethodId(45), Implemented, Description("Get Smart Fan Mode")] void =
GetSmartFanMode([out, Description("Get Smart Fan Mode")] uint32 Data);
   [WmiMethodId(46), Implemented, Description("Get Smart Fan Setting Mode"=
)] void GetSmartFanSetting([out, Description("Get Smart Setting Mode")] ui=
nt32 Data);
   [WmiMethodId(47), Implemented, Description("Get Power Charge Mode")] vo=
id GetPowerChargeMode([out, Description("Get Power Charge Mode")] uint32 D=
ata);
   [WmiMethodId(48), Implemented, Description("Get Gaming Product Info")] =
void GetProductInfo([out, Description("Get Gaming Product Info")] uint32 D=
ata);
   [WmiMethodId(49), Implemented, Description("Over Drive feature capabili=
ty")] void IsSupportOD([out, Description("Over Drive feature capability")]=
 uint32 Data);
   [WmiMethodId(50), Implemented, Description("Get Over Drive status")] vo=
id GetODStatus([out, Description("Get Over Drive status")] uint32 Data);
   [WmiMethodId(51), Implemented, Description("Set Over Drive status")] vo=
id SetODStatus([in, Description("Set Over Drive status")] uint32 Data);
   [WmiMethodId(52), Implemented, Description("Set Light Control Owner")] =
void SetLightControlOwner([in, Description("Set Light Control Owner")] uin=
t32 Data);
   [WmiMethodId(53), Implemented, Description("Set DDS Control Owner")] vo=
id SetDDSControlOwner([in, Description("Set DDS Control Owner")] uint32 Da=
ta);
   [WmiMethodId(54), Implemented, Description("Get the flag of restore OC =
value")] void IsRestoreOCValue([in, Description("Clean this flag")] uint32=
 idx, [out, Description("Resotre oc value flag")] uint32 Data);
   [WmiMethodId(55), Implemented, Description("Get Real Thremal Mode")] vo=
id GetThermalMode([out, Description("Real Thremal Mode")] uint32 Data);
   [WmiMethodId(56), Implemented, Description("Get the OC switch status in=
 BIOS")] void GetBIOSOCMode([out, Description("OC Mode")] uint32 Data);
   [WmiMethodId(57), Implemented, Description("Set the current mode in Int=
elligent Mode")] void SetIntelligentSubMode([in, Description("mode")] uint=
32 Data);
   [WmiMethodId(58), Implemented, Description("Get the current mode in Int=
elligent Mode")] void GetIntelligentSubMode([out, Description("mode")] uin=
t32 Data);
   [WmiMethodId(59), Implemented, Description("Get hardware info support v=
ersion")] void GetHardwareInfoSupportVersion([out, Description("version")]=
 uint32 Data);
   [WmiMethodId(60), Implemented, Description("Get Cpu core 0 max frequenc=
y")] void GetCpuFrequency([out, Description("frequency")] uint32 Data);
   [WmiMethodId(61), Implemented, Description("Get Total count of Learning=
 Profile")] void GetLearningProfileCount([out, Description("profile count"=
)] uint32 Data);
   [WmiMethodId(62), Implemented, Description("Check the Adapter type fit =
for OC")] void IsACFitForOC([out, Description("AC check result")] uint32 D=
ata);
   [WmiMethodId(63), Implemented, Description("Is support IGPU mode")] voi=
d IsSupportIGPUMode([out, Description("IGPU modes")] uint32 Data);
   [WmiMethodId(64), Implemented, Description("Get IGPU Mode Status")] voi=
d GetIGPUModeStatus([out, Description("IGPU Mode Status")] uint32 Data);
   [WmiMethodId(65), Implemented, Description("Set IGPU Mode")] void SetIG=
PUModeStatus([in, Description("IGPU Mode")] uint32 mode, [out, Description=
("return code")] uint32 Data);
   [WmiMethodId(66), Implemented, Description("Notify DGPU Status")] void =
NotifyDGPUStatus([in, Description("DGPU status")] uint32 status, [out, Des=
cription("return code")] uint32 Data);
   [WmiMethodId(67), Implemented, Description("Is changed Y log")] void Is=
ChangedYLog([out, Description("Is changed Y Log")] uint32 Data);
   [WmiMethodId(68), Implemented, Description("Get DGPU Hardwawre ID")] vo=
id GetDGPUHWId([out, Description("Get DGPU Hardware ID")] string Data);
};

Since the initial version of the lenovo-gamezone-wmi will not use all WMI =
methods provided by this WMI interface,
you can restrict yourself to only documenting the WMI methods used by this=
 driver.

Also the WMI device provides a GetVersion() WMI method, likely (please cor=
rect me if i am wrong) for discovering which WMI methods are present.
The driver should call this method during probing and return -ENODEV if th=
e version number is to low for supporting the driver.

For supporting the "Smart Fan Mode": Please use the IsSupportSmartFan() WM=
I method to check if this feature is available before
using it. Also please use the platform-profile API to expose this setting =
to user space.

_For the LEGION_GO_WMI_OTHER_GUID:_

Please also create a separate driver for this WMI device (you might call i=
t "lenovo-tuning-wmi") together with some
documentation.

For exposing the the tunables you can use sysfs attributes.

Thanks,
Armin Wolf

>
> Signed-off-by: zhixin zhang <zhangzx36@lenovo.com>
> ---
>   drivers/platform/x86/Kconfig         |   9 +
>   drivers/platform/x86/Makefile        |   1 +
>   drivers/platform/x86/legion-go-wmi.c | 552 +++++++++++++++++++++++++++
>   3 files changed, 562 insertions(+)
>   create mode 100644 drivers/platform/x86/legion-go-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 3875abba5a79..d04018f69dc6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -483,6 +483,15 @@ config LENOVO_YMC
>   	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE i=
nput
>   	  events for Lenovo Yoga notebooks.
>
> +config LEGION_GO_WMI
> +	tristate "Lenovo Legion Go WMI Control"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	  This driver provides support for modifying the performance mode
> +	  function of Lenovo's Legion Go series, as well as the ability to
> +	  set CPU power consumption in custom mode.
> +
>   config SENSORS_HDAPS
>   	tristate "Thinkpad Hard Drive Active Protection System (hdaps)"
>   	depends on INPUT
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefi=
le
> index e1b142947067..74b1f107084f 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+=3D think-lmi.o
>   obj-$(CONFIG_YOGABOOK)		+=3D lenovo-yogabook.o
>   obj-$(CONFIG_YT2_1380)		+=3D lenovo-yoga-tab2-pro-1380-fastcharger.o
>   obj-$(CONFIG_LENOVO_WMI_CAMERA)	+=3D lenovo-wmi-camera.o
> +obj-$(CONFIG_LEGION_GO_WMI)	+=3D legion-go-wmi.o
>
>   # Intel
>   obj-y				+=3D intel/
> diff --git a/drivers/platform/x86/legion-go-wmi.c b/drivers/platform/x86=
/legion-go-wmi.c
> new file mode 100644
> index 000000000000..e319219c3ace
> --- /dev/null
> +++ b/drivers/platform/x86/legion-go-wmi.c
> @@ -0,0 +1,552 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * legion-go-wmi.c - Lenovo Legion Go WMI Control
> + *
> + * Copyright =C2=A9 2024 zhixin zhang <zhangzx36@lenovo.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/printk.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/proc_fs.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/version.h>
> +
> +//extern struct proc_dir_entry *acpi_root_dir;
> +struct proc_dir_entry *acpi_root_dir;
> +
> +#define BUFFER_SIZE 256
> +
> +#define LEGION_GO_WMI_GAMEZONE_GUID			"887B54E3-DDDC-4B2C-8B88-68A26A88=
35D0"
> +#define LEGION_GO_WMI_OTHER_GUID			"dc2a8805-3a8c-41ba-a6f7-092e0089cd3=
b"
> +
> +//wmi_device_id context string
> +#define LEGION_GO_WMI_GAMEZONE_CONTEXT	"GameZone"
> +#define LEGION_GO_WMI_OTHER_CONTEXT		"Other"
> +
> +//funciton name
> +#define CMD_SET_SPL				"SetSPL"
> +#define CMD_GET_SPL				"GetSPL"
> +#define CMD_SET_SPPT			"SetSPPT"
> +#define CMD_GET_SPPT			"GetSPPT"
> +#define CMD_SET_FPPT			"SetFPPT"
> +#define CMD_GET_FPPT			"GetFPPT"
> +#define CMD_SET_SMART_FAN_MODE	"SetSmartFanMode"
> +#define CMD_GET_SMART_FAN_MODE	"GetSmartFanMode"
> +
> +//function arg for ids
> +enum legion_go_wmi_ids{
> +	ARG_SPL_CUSTOM_MODE =3D 0x0102FF00,
> +	ARG_SPL_GET_VALUE =3D 0x0102FF00,
> +
> +	ARG_SPPT_CUSTOM_MODE =3D 0x0101FF00,
> +	ARG_SPPT_GET_VALUE =3D 0x0101FF00,
> +
> +	ARG_FPPT_CUSTOM_MODE =3D 0x0103FF00,
> +	ARG_FPPT_GET_VALUE =3D 0x0103FF00,
> +
> +	ARG_SMART_FAN_QUIENT_MODE =3D 0x1,
> +	ARG_SMART_FAN_BALANCE_MODE =3D 0x2,
> +	ARG_SMART_FAN_PERFORMANCE_MODE =3D 0x3,
> +	ARG_SMART_FAN_CUSTOM_MODE =3D 0xFF,
> +};
> +
> +static const struct wmi_device_id legion_go_wmi_id_table[] =3D {
> +	{ LEGION_GO_WMI_GAMEZONE_GUID, LEGION_GO_WMI_GAMEZONE_CONTEXT },
> +	{ LEGION_GO_WMI_OTHER_GUID, LEGION_GO_WMI_OTHER_CONTEXT },
> +	{ }
> +};
> +
> +
> +enum legion_go_wmi_gamezone_method {
> +	legion_go_wmi_gamezone_method	=3D 0xAA,	// WMAA, DSDT
> +	LEGION_GO_WMI_OTHER_METHOD		=3D 0xAE,	// WMAA, DSDT
> +};
> +
> +//wmi command
> +enum legion_go_wmi_command {
> +	// smart fan mode
> +	LEGION_GO_WMI_GAMEZONE_SET_SMARTFANMODE	=3D 0x2C,
> +	LEGION_GO_WMI_GAMEZONE_GET_SMARTFANMODE	=3D 0x2D,
> +	// set bois feature
> +	LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE	=3D 0x12,
> +	LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE	=3D 0x11,
> +};
> +
> +//wmi call function
> +enum legion_go_call_function {
> +	LEGION_GO_FUNC_NONE,
> +	LEGION_GO_FUNC_SET_SPL,
> +	LEGION_GO_FUNC_GET_SPL,
> +	LEGION_GO_FUNC_SET_SPPT,
> +	LEGION_GO_FUNC_GET_SPPT,
> +	LEGION_GO_FUNC_SET_FPPT,
> +	LEGION_GO_FUNC_GET_FPPT,
> +	LEGION_GO_FUNC_SET_SMART_FAN_MODE,
> +	LEGION_GO_FUNC_GET_SMART_FAN_MODE
> +};
> +
> +struct legion_go_wmi_args_3i {
> +	u32 arg1;
> +	u32 arg2;
> +	u32 arg3;
> +};
> +
> +struct legion_go_wmi_args_2i {
> +	u32 arg1;
> +	u32 arg2;
> +};
> +
> +struct legion_go_wmi_args_1i {
> +	u32 arg1;
> +};
> +
> +struct legion_go_global {
> +	struct wmi_device *legion_device[2]; //0:"GameZone"  1:"Other"
> +	enum legion_go_call_function last_call_function;
> +	bool first_read;
> +	struct proc_dir_entry *acpi_entry;
> +	char result_buffer[BUFFER_SIZE];
> +};
> +
> +static struct legion_go_global g_Legion_Go_Global =3D {
> +	.legion_device =3D {NULL, NULL},
> +	.last_call_function =3D LEGION_GO_FUNC_NONE,
> +	.first_read =3D true,
> +	.acpi_entry =3D NULL,
> +};
> +
> +static acpi_status legion_go_wmi_perform_query(struct wmi_device *wdev,
> +		enum legion_go_wmi_gamezone_method method_id,
> +		const struct acpi_buffer *in,
> +		struct acpi_buffer *out)
> +{
> +	acpi_status ret =3D wmidev_evaluate_method(wdev, 0x0, method_id, in, o=
ut);
> +
> +	if (ACPI_FAILURE(ret)) {
> +		dev_warn(&wdev->dev, "LEGION GO WMI: WMI query failed with error: %d\=
n", ret);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static acpi_status legion_go_wmi_query_integer(struct wmi_device *wdev,
> +		enum legion_go_wmi_gamezone_method method_id,
> +		const struct acpi_buffer *in,
> +		u32 *res)
> +{
> +	union acpi_object *obj;
> +	struct acpi_buffer result =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status ret;
> +
> +	ret =3D legion_go_wmi_perform_query(wdev, method_id, in, &result);
> +	if (ret) {
> +		return ret;
> +	}
> +
> +	obj =3D result.pointer;
> +	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
> +		*res =3D obj->integer.value;
> +	}
> +	else {
> +		ret =3D -EIO;
> +	}
> +
> +	kfree(result.pointer);
> +	return ret;
> +}
> +
> +
> +/**
> + * procfs write callback. Called when writing into /proc/acpi/call.
> +*/
> +static ssize_t acpi_proc_write(struct file *filp,
> +		const char __user *buff,
> +		size_t len,
> +		loff_t *data)
> +{
> +    char input[2 * BUFFER_SIZE] =3D { '\0' };
> +    union acpi_object *args;
> +    int nargs, i;
> +    char *method;
> +
> +	u32 prod_id;
> +	acpi_status ret;
> +
> +    if (len > sizeof(input) - 1) {
> +        printk(KERN_ERR "LEGION GO WMI: Input too long! (%lu)\n", len);
> +        return -ENOSPC;
> +    }
> +
> +    if (copy_from_user( input, buff, len )) {
> +        return -EFAULT;
> +    }
> +
> +    input[len] =3D '\0';
> +    if (input[len-1] =3D=3D '\n')
> +        input[len-1] =3D '\0';
> +
> +	printk("LEGION GO WMI: procfs write is %s\n", input);
> +
> +	char cmd[2 * BUFFER_SIZE] =3D { '\0' };
> +	char arg1[2 * BUFFER_SIZE] =3D { '\0' };
> +	int arg1Num =3D 0;
> +	int retNum =3D 0;
> +
> +	int pos =3D -1;
> +	for(int i=3D0;i<2 * BUFFER_SIZE;i++) {
> +		if(input[i]=3D=3D ',') {
> +			memcpy(cmd,input,i*sizeof(char));
> +			pos =3D i+1;
> +		}
> +		else if(input[i]=3D=3D'\0' && pos !=3D -1) {
> +			memcpy(arg1,input+pos,(i-pos)*sizeof(char));
> +			pos =3D i+1;
> +			break;
> +		}
> +	}
> +	if(pos =3D=3D -1) {
> +		memcpy(cmd,input,len*sizeof(char));
> +	}
> +	else {
> +		printk(KERN_ERR "LEGION GO WMI: cmd =3D %s, arg1 : %s\n", cmd,arg1);
> +		retNum =3D kstrtoint(arg1,10,&arg1Num);
> +		if(retNum !=3D 0)
> +		{
> +			printk(KERN_ERR "LEGION GO WMI: arg1 =3D %s param error!\n",arg1);
> +			return -ENOSPC;
> +		}
> +	}
> +
> +	if(ret =3D=3D 0) {
> +		if(strcmp(cmd,CMD_SET_SPL)=3D=3D0) {
> +			struct legion_go_wmi_args_2i args =3D {
> +				.arg1 =3D ARG_SPL_CUSTOM_MODE,
> +				.arg2 =3D arg1Num,
> +			};
> +			const struct acpi_buffer in =3D {
> +				.length =3D sizeof(args),
> +				.pointer =3D &args,
> +			};
> +
> +			g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_SET_SPL;
> +
> +			ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device=
[1],
> +					LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE, &in, &prod_id);
> +			if (ret =3D=3D 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetSPL result is %d\n", prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetSPL query failed with err: %d\n", ret);
> +			}
> +		}
> +		else if(strcmp(cmd,CMD_GET_SPL)=3D=3D0) {
> +			g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_GET_SPL;
> +		}
> +		else if(strcmp(cmd,CMD_SET_SPPT)=3D=3D0) {
> +			struct legion_go_wmi_args_2i args =3D {
> +				.arg1 =3D ARG_SPPT_CUSTOM_MODE,
> +				.arg2 =3D arg1Num,
> +			};
> +			const struct acpi_buffer in =3D {
> +				.length =3D sizeof(args),
> +				.pointer =3D &args,
> +			};
> +
> +			g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_SET_SPPT;
> +
> +			ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device=
[1],
> +					LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE,
> +					&in,
> +					&prod_id);
> +			if (ret =3D=3D 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetSPPT result is %d\n", prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetSPPT query failed with err: %d\n", ret);
> +			}
> +		}
> +		else if(strcmp(cmd,CMD_GET_SPPT)=3D=3D0) {
> +			g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_GET_SPPT;
> +		}
> +		else if(strcmp(cmd,CMD_SET_FPPT)=3D=3D0) {
> +			struct legion_go_wmi_args_2i args =3D {
> +				.arg1 =3D ARG_FPPT_CUSTOM_MODE,
> +				.arg2 =3D arg1Num,
> +			};
> +			const struct acpi_buffer in =3D {
> +				.length =3D sizeof(args),
> +				.pointer =3D &args,
> +			};
> +
> +			g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_SET_FPPT;
> +
> +			ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device=
[1],
> +					LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE,
> +					&in,
> +					&prod_id);
> +			if (ret =3D=3D 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetFPPT result is %d\n", prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetFPPT query failed with err: %d\n", ret);
> +			}
> +		}
> +		else if(strcmp(cmd,CMD_GET_FPPT)=3D=3D0) {
> +			g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_GET_FPPT;
> +		}
> +		else if(strcmp(cmd,CMD_SET_SMART_FAN_MODE)=3D=3D0) {
> +			if(arg1Num !=3D 1 && arg1Num !=3D 2 && arg1Num !=3D 3 && arg1Num !=
=3D 0xFF) {
> +				printk(KERN_ERR "LEGION GO WMI: %s arg1 =3D %s param error!\n",
> +						CMD_SET_SMART_FAN_MODE,arg1);
> +				return -ENOSPC;
> +			}
> +
> +			struct legion_go_wmi_args_1i args =3D {
> +				.arg1 =3D arg1Num,
> +			};
> +			const struct acpi_buffer in =3D {
> +				.length =3D sizeof(args),
> +				.pointer =3D &args,
> +			};
> +			g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_SET_SMART_F=
AN_MODE;
> +			ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device=
[0],
> +					LEGION_GO_WMI_GAMEZONE_SET_SMARTFANMODE,
> +					&in,
> +					&prod_id);
> +
> +			if (ret =3D=3D 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[0]->dev,
> +					"LEGION GO WMI: SetSmartFanMode query result is %d\n", prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[0]->dev,
> +				"LEGION GO WMI: SetSmartFanMode query failed with err: %d\n", ret);
> +			}
> +		}
> +		else if(strcmp(cmd,CMD_GET_SMART_FAN_MODE)=3D=3D0) {
> +			g_Legion_Go_Global.last_call_function =3D LEGION_GO_FUNC_GET_SMART_F=
AN_MODE;
> +		}
> +	}
> +
> +    return len;
> +}
> +
> +//read other mothod
> +acpi_status acpi_proc_read_other(struct wmi_device *wdev,
> +		enum legion_go_wmi_command cmd,
> +		struct legion_go_wmi_args_1i* args,
> +		char* funciton_name)
> +{
> +	u32 prod_id =3D 0;
> +	const struct acpi_buffer in =3D {
> +		.length =3D sizeof(*args),
> +		.pointer =3D args,
> +	};
> +	acpi_status ret =3D legion_go_wmi_query_integer(wdev, cmd,  &in, &prod=
_id);
> +	if (ret =3D=3D 0) {
> +		dev_info(&wdev->dev, "LEGION GO WMI: Integer query result is %d\n", p=
rod_id);
> +		snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,%u",funcito=
n_name,prod_id);
> +	}
> +	else {
> +		dev_warn(&wdev->dev, "LEGION GO WMI: Integer query failed with err: %=
d\n", ret);
> +		snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,error",func=
iton_name);
> +	}
> +	return ret;
> +}
> +
> +static ssize_t acpi_proc_read(struct file *filp, char __user *buff, siz=
e_t count, loff_t *off)
> +{
> +	u32 prod_id;
> +	acpi_status ret;
> +	int len =3D strlen(g_Legion_Go_Global.result_buffer);
> +
> +	memset(g_Legion_Go_Global.result_buffer,'\0',len);
> +
> +	if(g_Legion_Go_Global.last_call_function =3D=3D LEGION_GO_FUNC_NONE) {
> +		ssize_t result =3D simple_read_from_buffer(buff,
> +				count,
> +				off,
> +				g_Legion_Go_Global.result_buffer,
> +				len + 1);
> +		return result;
> +		//return -EIO;
> +	}
> +
> +
> +	switch(g_Legion_Go_Global.last_call_function) {
> +		case LEGION_GO_FUNC_SET_SPL:
> +		case LEGION_GO_FUNC_GET_SPL:
> +		{
> +			struct legion_go_wmi_args_1i args =3D {
> +				.arg1 =3D ARG_SPL_GET_VALUE,
> +			};
> +			ret =3D acpi_proc_read_other(g_Legion_Go_Global.legion_device[1],
> +				LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE,
> +				&args,
> +				CMD_GET_SPL);
> +
> +			break;
> +		}
> +		case LEGION_GO_FUNC_SET_SPPT:
> +		case LEGION_GO_FUNC_GET_SPPT:
> +		{
> +			struct legion_go_wmi_args_1i args =3D {
> +				.arg1 =3D ARG_SPPT_GET_VALUE,
> +			};
> +			ret =3D acpi_proc_read_other(g_Legion_Go_Global.legion_device[1],
> +					LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE,
> +					&args,
> +					CMD_GET_SPPT);
> +
> +			break;
> +		}
> +		case LEGION_GO_FUNC_SET_FPPT:
> +		case LEGION_GO_FUNC_GET_FPPT:
> +		{
> +			struct legion_go_wmi_args_1i args =3D {
> +				.arg1 =3D ARG_FPPT_GET_VALUE,
> +			};
> +			ret =3D acpi_proc_read_other(g_Legion_Go_Global.legion_device[1],
> +					LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE,
> +					&args,
> +					CMD_GET_FPPT);
> +
> +			break;
> +		}
> +		case LEGION_GO_FUNC_SET_SMART_FAN_MODE:
> +		case LEGION_GO_FUNC_GET_SMART_FAN_MODE:
> +		{
> +			struct legion_go_wmi_args_1i args =3D {
> +				.arg1 =3D 255,
> +			};
> +			const struct acpi_buffer in =3D {
> +				.length =3D sizeof(args),
> +				.pointer =3D &args,
> +			};
> +
> +			ret =3D legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device=
[0],
> +					LEGION_GO_WMI_GAMEZONE_GET_SMARTFANMODE,
> +					&in,
> +					&prod_id);
> +			if (ret =3D=3D 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[0]->dev,
> +						"LEGION GO WMI: Integer query result is %d\n", prod_id);
> +				snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,%u",
> +						CMD_GET_SMART_FAN_MODE,prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[0]->dev,
> +						"LEGION GO WMI: Integer query failed with err: %d\n", ret);
> +				snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,error",
> +						CMD_GET_SMART_FAN_MODE);
> +			}
> +			break;
> +		}
> +		default:
> +		{
> +			strcpy(g_Legion_Go_Global.result_buffer,"LEGION GO WMI: nothing to w=
rite");
> +		}
> +	}
> +
> +	if(g_Legion_Go_Global.first_read =3D=3D true) {
> +		char temp[BUFFER_SIZE] =3D {'\0'};
> +		strcpy(temp, g_Legion_Go_Global.result_buffer);
> +		strcpy(g_Legion_Go_Global.result_buffer+1, temp);
> +		g_Legion_Go_Global.first_read =3D false;
> +	}
> +	// output the current result buffer
> +	ssize_t result =3D simple_read_from_buffer(buff,
> +			count,
> +			off,
> +			g_Legion_Go_Global.result_buffer,
> +			len + 1);
> +
> +    return result;
> +}
> +
> +static const struct proc_ops proc_acpi_operations =3D {
> +        .proc_read     =3D acpi_proc_read,
> +        .proc_write    =3D acpi_proc_write,
> +};
> +
> +static int legion_go_wmi_probe(struct wmi_device *wdev, const void *con=
text)
> +{
> +	dev_info(&wdev->dev, "LEGION GO WMI: Probe is starting.\n");
> +
> +	if (!wmi_has_guid(LEGION_GO_WMI_OTHER_GUID)) {
> +		dev_warn(&wdev->dev, "LEGION GO WMI: No known OTHER WMI GUID found\n"=
);
> +		return -ENODEV;
> +	}
> +
> +	if (!wmi_has_guid(LEGION_GO_WMI_GAMEZONE_GUID)) {
> +		dev_warn(&wdev->dev, "LEGION GO WMI: No known GAMEZONE WMI GUID found=
\n");
> +		return -ENODEV;
> +	}
> +
> +	if (g_Legion_Go_Global.acpi_entry =3D=3D NULL) {
> +		g_Legion_Go_Global.acpi_entry =3D proc_create("legion_go_call",
> +				0660,
> +				acpi_root_dir,
> +				&proc_acpi_operations);
> +	}
> +
> +    if (g_Legion_Go_Global.acpi_entry =3D=3D NULL)
> +	{
> +      dev_warn(&wdev->dev, "LEGION GO WMI: Couldn't create procfs entry=
\n");
> +      return -ENOMEM;
> +    }
> +
> +    dev_info(&wdev->dev, "LEGION GO WMI: procfs entry at /proc/acpi/leg=
ion_go_call created.\n");
> +
> +	dev_info(&wdev->dev, "LEGION GO WMI: Probe is exiting.\n");
> +
> +	if(strcmp(context, LEGION_GO_WMI_GAMEZONE_CONTEXT)=3D=3D 0) {
> +		g_Legion_Go_Global.legion_device[0] =3D wdev;
> +	}
> +	else {
> +		g_Legion_Go_Global.legion_device[1] =3D wdev;
> +	}
> +
> +	return 0;
> +}
> +
> +static void legion_go_wmi_remove(struct wmi_device *wdev)
> +{
> +	g_Legion_Go_Global.legion_device[0] =3D NULL;
> +	g_Legion_Go_Global.legion_device[1] =3D NULL;
> +
> +    remove_proc_entry("legion_go_call", acpi_root_dir);
> +
> +    dev_info(&wdev->dev, "LEGION GO WMI: procfs entry removed\n");
> +}
> +
> +static struct wmi_driver legion_go_wmi_driver =3D {
> +	.driver =3D {
> +		.name =3D "legion-go-wmi",
> +	},
> +	.id_table =3D legion_go_wmi_id_table,
> +	.probe =3D legion_go_wmi_probe,
> +	.remove =3D legion_go_wmi_remove
> +};
> +
> +module_wmi_driver(legion_go_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, legion_go_wmi_id_table);
> +
> +MODULE_DESCRIPTION("Lenovo Legion Go WMI Driver");
> +MODULE_AUTHOR("zhixin zhang<zhangzx36@lenovo.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0.0.0");

