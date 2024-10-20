Return-Path: <linux-kernel+bounces-373473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACF69A5735
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 00:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A1F28242D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59C36124;
	Sun, 20 Oct 2024 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uMSPjn/L"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654119882B;
	Sun, 20 Oct 2024 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729462206; cv=none; b=MvSUct5SrJOBHFFoOZ5hnzotfvqVVDkkNHgKPzEMzXlbo1nSsCuAh2eQY965MaCG4f1xfAClLPuxT1q45B8deEU6qv1Lv4FrMy6ysGIYSFzO1f2bkqCQzkgCV3MJmpXorHNVneZkorGQIGRLvbiNP6x+QQTLYmTLoryEzVeAvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729462206; c=relaxed/simple;
	bh=jwwAXexRroeBxLjtGT3YHkd9x0GXam6zEDjxbKq9OJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdeBcClUAFw2mvyM+b+hHVOC8+mFxKIu9N7vLo+7HqeI7Cyay2izDEwlFvPQ+H702w5SwEVOtwhxYwj0fcGSagNifjHv8oczSX+TSWOwHGooEZC1so/xtjqG6QdO/Q2Oaq57PPjtKv1VkCwtwmoRtkvE3Zp+wAoK9hmSD65Af5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uMSPjn/L; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729462196; x=1730066996; i=w_armin@gmx.de;
	bh=PoAv5kdFR9auKioJMgfmjoHFcd8GTY3QnD1hXOHNb6E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uMSPjn/LC6Z2RiUcv67nh09TFcenHehNvFJKXFdUUCWlQG+mOV0V3eeoZpfDvrh1
	 sv/ENbsUubSmQM9f/+Kwc7zDY1u0ryJhQl1RVUEG5gQOcb9/3pvPDgp5K1IuzEt0t
	 2sMkmiIY8hpMUxDvpjLJtYC0UThyomWBeQ2yNiBhECsm3f0E0fWbOxZ82NmE9Ql2H
	 MC21CAitKUNApfcaeg4Ren7azEpWgeal5WO583CaD11q/w1yo3mfwBfA6uRRDJKCZ
	 vqw/r0hPWCByq0hSjgoxqQoKZx4Uwr+OVTpnHgaGXY6kzry1LheQpAZGVqiVyeqxy
	 4ttIhoplwxPxqOcAiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBm1e-1tCUwh48Tc-00HD9n; Mon, 21
 Oct 2024 00:09:56 +0200
Message-ID: <50918b70-47b1-4a16-ab29-7c270880b920@gmx.de>
Date: Mon, 21 Oct 2024 00:09:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] alienware-wmi: WMAX interface documentation
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241017081211.126214-2-kuurtb@gmail.com>
 <20241017081708.127666-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241017081708.127666-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XvBZxE24mnbS93YulbFgVHZHYEXqcm682CeTA+KPQsCRqlMJoE1
 Wog6VZaRNomAr+8/JmgEu+TRWH3u8Cpz6qBaHtXEdOkxqNOgtFze8C7BoyKzB+6XE0vglam
 vkRR5rE7iA/xD8TTiGvDet5f0v65Mv8fZUzoGBiAFm0dVo6vP89U6yqQD6g6eynaFwI1Cfh
 E1DWyfuW/EdRXhhh5a/4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Rq2WcnTzqI0=;dUvkmHoDjoZXaCCboO8MIGYAMZX
 EeCYQvOFh063biOoWJBg+Q3gw+j7hg81k9zHiyl9U8zqd2SfqRPU/3bxlEw4FDlWOJBkofleP
 hHAVsmRx7AwWZEMs/rSGgwHQwuRi0BEwNY0Ev615F1iy+kRj7q8ERqbOflpcQ5aNcsKrAP4a9
 l+aL+dTm9nOzr1S6/cUMb3mW9bpNaXwC9L05aW3pQY8kPtZ7dMKj/w6YdJsnQRLxGWNhnAMcN
 bRwEKQXcoiDtmi/RNo9uh6T/eF3QUxNKFMQ43ikiRuGPU4/UpxpD0v7Y6oCCKS7L1B0O7TUH/
 DL9mBx6uA7kI7T67lDuQPqyFcDMZ+HiVS04hxDMtRl1NIhacDCovb5N7riUJ95wjDHQCEjpPn
 o25Rfc/ASmdXSfiNXT0LWYWsQaxlf2U0ENVvt61hJqdD7LulSaI0D5NXnxz7d4w0ZVy000Rax
 a8cnAgEkMdhIGG24hR5yzAq1YgSqF6xuzM6177rWwWvmbOF7TfnePL/weYJa9Hw5peDiq9JjP
 X92EU4uDGO0rAry2we2eOl/v74SYoexotHbP7gmdVrKWxICpxltyU9cQKoGAkLUcx1F9rxFKL
 NvESb8kALzUiSGB4Xo/fAAdIOJLiFIh/iNMK719Fhz/pwnh2YM2o+fyGcSFyOdNl7aFuMl8/A
 uG/BIPBqZFvJE+fku5+HzVjrsBntqDzOKWUD8QqwVZ9Fp/LiCfJarbQWWfTKZvfC4f/h9LK2K
 14ul6gFgqXHNpgOGfFWNvRRPfDz5QfkZ+eiP1zy+xNQr8p7SfPKxofa2eAZaWVqfiSKtKjaU4
 HBYOcwQavKgd6AdBOsAgu+a/J01vku5xfKw5A+/S7eVEw=

Am 17.10.24 um 10:17 schrieb Kurt Borja:

> Added documentation for new WMAX interface, present on some Alienware
> X-Series, Alienware M-Series and Dell's G-Series laptops.
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> ---
> v6:
>   - Fixed typos
>   - Included new file in MAINTAINERS
> ---
>   Documentation/wmi/devices/alienware-wmi.rst | 366 ++++++++++++++++++++
>   MAINTAINERS                                 |   1 +
>   2 files changed, 367 insertions(+)
>   create mode 100644 Documentation/wmi/devices/alienware-wmi.rst
>
> diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation=
/wmi/devices/alienware-wmi.rst
> new file mode 100644
> index 000000000..f2fb845d7
> --- /dev/null
> +++ b/Documentation/wmi/devices/alienware-wmi.rst
> @@ -0,0 +1,366 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Dell AWCC WMI interface driver (alienware-wmi)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The WMI device WMAX has been implemented for many Alienware and Dell's =
G-Series
> +models. Throughout these models, two implementations have been identifi=
ed. The
> +first one, used by older systems, deals with HDMI, brightness, RGB, amp=
lifier
> +and deep sleep control. The second one used by newer systems deals prim=
arily
> +with thermal, overclocking, and GPIO control.
> +
> +It is suspected that the latter is used by Alienware Command Center (AW=
CC) to
> +manage manufacturer predefined thermal profiles. The alienware-wmi driv=
er
> +exposes Thermal_Information and Thermal_Control methods through the Pla=
tform
> +Profile API to mimic AWCC's behavior.
> +
> +This newer interface, named AWCCMethodFunction has been reverse enginee=
red, as
> +Dell has not provided any official documentation. We will try to descri=
be to the
> +best of our ability its discovered inner workings.
> +
> +.. note::
> +   The following method description may vary between models.
> +
> +WMI interface description
> +-------------------------
> +
> +The WMI interface description can be decoded from the embedded binary M=
OF (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> + [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("=
WMI Function"), guid("{A70591CE-A997-11DA-B012-B622A1EF5492}")]
> + class AWCCWmiMethodFunction {
> +   [key, read] string InstanceName;
> +   [read] boolean Active;
> +
> +   [WmiMethodId(13), Implemented, read, write, Description("Return Over=
clocking Report.")] void Return_OverclockingReport([out] uint32 argr);
> +   [WmiMethodId(14), Implemented, read, write, Description("Set OCUIBIO=
S Control.")] void Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr=
);
> +   [WmiMethodId(15), Implemented, read, write, Description("Clear OC Fa=
ilSafe Flag.")] void Clear_OCFailSafeFlag([out] uint32 argr);
> +   [WmiMethodId(19), Implemented, read, write, Description("Get Fan Sen=
sors.")] void GetFanSensors([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(20), Implemented, read, write, Description("Thermal Inf=
ormation.")] void Thermal_Information([in] uint32 arg2, [out] uint32 argr)=
;
> +   [WmiMethodId(21), Implemented, read, write, Description("Thermal Con=
trol.")] void Thermal_Control([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(23), Implemented, read, write, Description("MemoryOCCon=
trol.")] void MemoryOCControl([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(26), Implemented, read, write, Description("System Info=
rmation.")] void SystemInformation([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(28), Implemented, read, write, Description("Power Infor=
mation.")] void PowerInformation([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(32), Implemented, read, write, Description("FW Update G=
PIO toggle.")] void FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr=
);
> +   [WmiMethodId(33), Implemented, read, write, Description("Read Total =
of GPIOs.")] void ReadTotalofGPIOs([out] uint32 argr);
> +   [WmiMethodId(34), Implemented, read, write, Description("Read GPIO p=
in Status.")] void ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr)=
;
> +   [WmiMethodId(35), Implemented, read, write, Description("Read Chassi=
s Color.")] void ReadChassisColor([out] uint32 argr);
> +   [WmiMethodId(36), Implemented, read, write, Description("Read Platfo=
rm Properties.")] void ReadPlatformProperties([out] uint32 argr);
> +   [WmiMethodId(128), Implemented, read, write, Description("Caldera SW=
 installation.")] void CalderaSWInstallation([out] uint32 argr);
> +   [WmiMethodId(129), Implemented, read, write, Description("Caldera SW=
 is released.")] void CalderaSWReleased([out] uint32 argr);
> +   [WmiMethodId(130), Implemented, read, write, Description("Caldera Co=
nnection Status.")] void CalderaConnectionStatus([in] uint32 arg2, [out] u=
int32 argr);
> +   [WmiMethodId(131), Implemented, read, write, Description("Surprise U=
nplugged Flag Status.")] void SurpriseUnpluggedFlagStatus([out] uint32 arg=
r);
> +   [WmiMethodId(132), Implemented, read, write, Description("Clear Surp=
rise Unplugged Flag.")] void ClearSurpriseUnpluggedFlag([out] uint32 argr)=
;
> +   [WmiMethodId(133), Implemented, read, write, Description("Cancel Und=
ock Request.")] void CancelUndockRequest([out] uint32 argr);
> +   [WmiMethodId(135), Implemented, read, write, Description("Devices in=
 Caldera.")] void DevicesInCaldera([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(136), Implemented, read, write, Description("Notify BIO=
S for SW ready to disconnect Caldera.")] void NotifyBIOSForSWReadyToDiscon=
nectCaldera([out] uint32 argr);
> +   [WmiMethodId(160), Implemented, read, write, Description("Tobii SW i=
nstallation.")] void TobiiSWinstallation([out] uint32 argr);
> +   [WmiMethodId(161), Implemented, read, write, Description("Tobii SW R=
eleased.")] void TobiiSWReleased([out] uint32 argr);
> +   [WmiMethodId(162), Implemented, read, write, Description("Tobii Came=
ra Power Reset.")] void TobiiCameraPowerReset([out] uint32 argr);
> +   [WmiMethodId(163), Implemented, read, write, Description("Tobii Came=
ra Power On.")] void TobiiCameraPowerOn([out] uint32 argr);
> +   [WmiMethodId(164), Implemented, read, write, Description("Tobii Came=
ra Power Off.")] void TobiiCameraPowerOff([out] uint32 argr);
> + };
> +
> +Some of these methods get quite intricate so we will describe them usin=
g
> +pseudo-code that vaguely resembles the original ASL code.
> +
> +Argument Structure
> +------------------
> +
> +All input arguments have type **uint32** and their structure is very si=
milar
> +between methods. Usually, the first byte corresponds to a specific *ope=
ration*
> +the method performs, and the subsequent bytes correspond to *arguments*=
 passed
> +to this *operation*. For example, if an operation has code 0x01 and req=
uires an
> +ID 0xA0, the argument you would pass to the method is 0xA001.
> +
> +
> +Thermal Methods
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 0x01:
> +         argr =3D 1
> +
> + if BYTE_0(arg2) =3D=3D 0x02:
> +         argr =3D UNKNOWN_CONSTANT
> +
> + if BYTE_0(arg2) =3D=3D 0x03:
> +         if BYTE_1(arg2) =3D=3D 0x00:
> +                 argr =3D FAN_ID_0
> +
> +         if BYTE_1(arg2) =3D=3D 0x01:
> +                 argr =3D FAN_ID_1
> +
> +         if BYTE_1(arg2) =3D=3D 0x02:
> +                 argr =3D FAN_ID_2
> +
> +         if BYTE_1(arg2) =3D=3D 0x03:
> +                 argr =3D FAN_ID_3
> +
> +         if BYTE_1(arg2) =3D=3D 0x04:
> +                 argr =3D SENSOR_ID_CPU | 0x0100
> +
> +         if BYTE_1(arg2) =3D=3D 0x05:
> +                 argr =3D SENSOR_ID_GPU | 0x0100
> +
> +         if BYTE_1(arg2) =3D=3D 0x06:
> +                 argr =3D THERMAL_MODE_QUIET_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x07:
> +                 argr =3D THERMAL_MODE_BALANCED_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x08:
> +                 argr =3D THERMAL_MODE_BALANCED_PERFORMANCE_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x09:
> +                 argr =3D THERMAL_MODE_PERFORMANCE_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x0A:
> +                 argr =3D THERMAL_MODE_LOW_POWER_ID
> +
> +         if BYTE_1(arg2) =3D=3D 0x0B:
> +                 argr =3D THERMAL_MODE_GMODE_ID
> +
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> + if BYTE_0(arg2) =3D=3D 0x04:
> +         if is_valid_sensor(BYTE_1(arg2)):
> +                 argr =3D SENSOR_TEMP_C
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> + if BYTE_0(arg2) =3D=3D 0x05:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr =3D FAN_RPM()
> +
> + if BYTE_0(arg2) =3D=3D 0x06:
> +         skip
> +
> + if BYTE_0(arg2) =3D=3D 0x07:
> +         argr =3D 0
> +
> + If BYTE_0(arg2) =3D=3D 0x08:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr =3D 0
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> + if BYTE_0(arg2) =3D=3D 0x09:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr =3D FAN_UNKNOWN_STAT_0()
> +
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> + if BYTE_0(arg2) =3D=3D 0x0A:
> +         argr =3D THERMAL_MODE_BALANCED_ID
> +
> + if BYTE_0(arg2) =3D=3D 0x0B:
> +         argr =3D CURRENT_THERMAL_MODE()
> +
> + if BYTE_0(arg2) =3D=3D 0x0C:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr =3D FAN_UNKNOWN_STAT_1()
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> +WMI method Thermal_Control([in] uint32 arg2, [out] uint32 argr)
> +---------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 0x01:
> +         if is_valid_thermal_profile(BYTE_1(arg2)):
> +                 SET_THERMAL_PROFILE(BYTE_1(arg2))
> +                 argr =3D 0
> +
> + if BYTE_0(arg2) =3D=3D 0x02:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 SET_FAN_SPEED_MULTIPLIER(BYTE_2(arg2))
> +                 argr =3D 0
> +         else:
> +                 argr =3D 0xFFFFFFFF
> +
> +.. note::
> +   While you can manually change the fan speed multiplier with this met=
hod,
> +   Dell's BIOS tends to overwrite this changes anyway.
> +
> +These are the known thermal profile codes:
> +
> +::
> +
> + CUSTOM                         0x00
> +
> + QUIET                          0x96
> + BALANCED                       0x97
> + BALANCED_PERFORMANCE           0x98
> + PERFORMANCE                    0x99
> +
> + QUIET_USTT                     0xA3
> + BALANCED_USTT                  0xA0
> + BALANCED_PERFORMANCE_USTT      0xA1
> + PERFORMANCE_USTT               0xA4
> + LOW_POWER_USTT                 0xA5
> +
> + GMODE                          0xAB
> +
> +Usually if a model doesn't support the first four profiles they will su=
pport
> +the User Selectable Thermal Tables (USTT) profiles and vice-versa.
> +
> +GMODE replaces PERFORMANCE in G-Series laptops.
> +
> +WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 1:
> +        if is_valid_fan(BYTE_1(arg2)):
> +                argr =3D 1
> +        else:
> +                argr =3D 0
> +
> + if BYTE_0(arg2) =3D=3D 2:
> +        if is_valid_fan(BYTE_1(arg2)):
> +                if BYTE_2(arg2) =3D=3D 0:
> +                        argr =3D=3D SENSOR_ID
> +                else
> +                        argr =3D=3D 0xFFFFFFFF
> +        else:
> +                argr =3D 0
> +
> +Overclocking Methods
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. warning::
> +   These methods have not been tested and are only partially reverse
> +   engineered.
> +
> +WMI method Return_OverclockingReport([out] uint32 argr)
> +-------------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr =3D 0
> +
> +CSMI is an unknown operation.
> +
> +WMI method Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr =3D 0
> +
> +CSMI is an unknown operation.
> +
> +WMI method Clear_OCFailSafeFlag([out] uint32 argr)
> +--------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr =3D 0
> +
> +CSMI is an unknown operation.
> +
> +
> +WMI method MemoryOCControl([in] uint32 arg2, [out] uint32 argr)
> +---------------------------------------------------------------
> +
> +AWCC supports memory overclocking, but this method is very intricate an=
d has
> +not been deciphered yet.
> +
> +GPIO methods
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These methods are probably related to some kind of firmware update syst=
em,
> +through a GPIO device.
> +
> +.. warning::
> +   These methods have not been tested and are only partially reverse
> +   engineered.
> +
> +WMI method FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr)
> +------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 0:
> +         if BYTE_1(arg2) =3D=3D 1:
> +                 SET_PIN_A_HIGH()
> +         else:
> +                 SET_PIN_A_LOW()
> +
> + if BYTE_0(arg2) =3D=3D 1:
> +         if BYTE_1(arg2) =3D=3D 1:
> +                 SET_PIN_B_HIGH()
> +
> +         else:
> +                 SET_PIN_B_LOW()
> +
> + else:
> +         argr =3D 1
> +
> +WMI method ReadTotalofGPIOs([out] uint32 argr)
> +----------------------------------------------
> +
> +::
> +
> + argr =3D 0x02
> +
> +WMI method ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr)
> +------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) =3D=3D 0:
> +         argr =3D PIN_A_STATUS
> +
> + if BYTE_0(arg2) =3D=3D 1:
> +         argr =3D PIN_B_STATUS
> +
> +Other information Methods
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +WMI method SystemInformation([in] uint32 arg2, [out] uint32 argr)
> +-----------------------------------------------------------------
> +
> +Returns unknown information.
> +
> +WMI method PowerInformation([in] uint32 arg2, [out] uint32 argr)
> +----------------------------------------------------------------
> +
> +Returns unknown information.
> +
> +WMI method ReadChassisColor([out] uint32 argr)
> +----------------------------------------------
> +
> +::
> +
> + argr =3D CHASSIS_COLOR_ID
> +
> +WMI method ReadPlatformProperties([out] uint32 argr)
> +----------------------------------------------------
> +
> +Returns unknown information.
> +
> +Acknowledgements
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for documentin=
g
> +and testing available thermal profile codes.
> +
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c27f31907..25f6de4c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -792,6 +792,7 @@ F:	drivers/perf/alibaba_uncore_drw_pmu.c
>   ALIENWARE WMI DRIVER
>   L:	Dell.Client.Kernel@dell.com
>   S:	Maintained
> +F:	Documentation/wmi/devices/alienware-wmi.rst
>   F:	drivers/platform/x86/dell/alienware-wmi.c
>
>   ALLEGRO DVT VIDEO IP CORE DRIVER

