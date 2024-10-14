Return-Path: <linux-kernel+bounces-364495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F99699D555
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2607C284E15
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585CC1C2DA1;
	Mon, 14 Oct 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="DsH6XQDW"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCF12CD8B;
	Mon, 14 Oct 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925828; cv=none; b=rjPmf4vMUSVTxnbICF+4AqP3O0iPs3VKYlrJ+Z9IW1+nAPbcaMQfQFeIWfauVdpQr/znEOg0L7jkI7iG0r4SlT8KPkL3TApIAWWAvSI8Zeqf1/wZ/KsEKd/mLDlEGcAsdvKdfKIehbYqNA6kEUCBkyOBEXpp59nfnc//PMtewT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925828; c=relaxed/simple;
	bh=jhHrMaX45ADXoXNlHXae6vnpmhvCqL4ZTul9HKeSmmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OguBAGgSpkbJUXJpBQi7CgC6ly5mWUUZ757JaArx8uBXHKLWb7lfmwd1A3h8eNxetUu7aVzC70TiXuUIpfuMqi6pUmA9BS4dOVSdkEmjd1Nbq+JlMPNDiBFFeyvnYeFnBT0CDiSGj/gg1xSe2+4hniz9KKyak4NcSimC4jFIyxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=DsH6XQDW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728925817; x=1729530617; i=w_armin@gmx.de;
	bh=7MTpWmdc/EdTHbaM73akHW9JZU1l+UeI/8FNYVTrG90=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DsH6XQDW6YHBVWkhHmRsBpx9EPVnbTTEh0f2yyJrEm+BNxAHazWZMqfv74PvYh2r
	 VGJGjlLHtypiX7MtvpR01gX8PEYE9tsWJLhXZeJg3PnC+3GDLIgI73gbHmenFb64g
	 TpQAL07s9RywtWt3Iu9a6as4He5F8KUy3VT2sqMEHJcWB28McrvcbcMCGLPg7ktTJ
	 9mmczWWq50mnH9EmWMb6Ag/smyFBwENzwoNUlauL4SC8dKrgOQ9J8NjW3B/IS+x7G
	 axdyQj468YZCdvhsbMbIYUc7xW8A7iqGxj9dYLpCRm+UgLPX9lZkytYBZF6AE2YYT
	 QzZZhUicJdfsRh6HWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95iR-1u3eyU0Fa3-010nEo; Mon, 14
 Oct 2024 19:10:17 +0200
Message-ID: <7737a2d6-8cdb-41f3-9666-2bdee6f1f450@gmx.de>
Date: Mon, 14 Oct 2024 19:10:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] alienware-wmi: WMAX interface documentation
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241012015849.19036-3-kuurtb@gmail.com>
 <20241012020330.20278-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241012020330.20278-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2SxuYGrm/B0Zh6/XyWlvVQGRUtQISq7VdK3/aPTmF6SCqDWsx3F
 O2VqYEVMYCgNxWOvO45fGfCHGa1oXgx4O3nyodKVmEavcYCDTOfRoV0+8O0qvZYndrmY/Qd
 xAZyRpja56SSu4ba4KDMESXrFn7QH3b3qAC1I0sj/b/kMvUIWYkZjAv3xJwYSq4l8rY4mcD
 XMDEImvlNthhitEDO8kgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QrPDCValVQo=;8pW3tq2ZJryH6DClnHp01ZMmoOS
 0D1H4v0TBDjZ3K/QwXk2v8VIZfs4xEKdgCsE/81TmmzVr7XVOdJqo0ZRJZqhPbTHoSv8PzB2B
 82BC/1hz8M0gMPubAbLr8jVWFu8oZxGPPR+UU/ZaC0T9p+VOCRo+Lerhn8ShslI7RhlEAbQ74
 qeVhUIvy2TAFdbj87JCq1dDX//NR/w4FmmX3BIvN5dMDG6O6DjT9GY2Eqewjl0tCqSkMTtejr
 AwOFFthSFc/ClqQ6/vhc1bxM0VPSTJAYM4C1QfA4BaWwXuVRZ1xic0hgi06w/zJEgxrkB56B7
 A8wH1MZjNae01rdWE938UilpO4pztqUrmz8lsRf8QgJ7MS/jo+E9pT7Yo2EHhwS4FAGpbNLFn
 1YJjLKjqQngUxTr40DBKvF+aZtnPB6CMbSebJYfBIRaCNiSlUieKT2wy22RCi/b4ove1Bl+a0
 eVlok3Uagb8kDBD/TE2R9ADrlJZillPmRkSs7qxSxnm0093vBEBnPiejrFPtxfHQ9smgFGH/i
 0+QVIg5SBq+GNALWx8KT23V/F6y7FgbuVucksy3BXPgdtfJ4PNqiNfinAkx127am7nPw/aMoX
 G+gM7cRw8+jrB0XGxVLuZThjdHG2bhuVADJ9wjWVhguEwUHv7ApTv0BKk1sDBvn2RWuMxdcTG
 6YbuWKWYucuD1EGLkEZyUjBmrfa57hIZFc+P1NDohCnk0QjubuJRZ/JTd2Ra8jQK+zc0PG19u
 ZMsEwMvL8jrmrdj31JuHoWTu6HJ2TNWZ/mfKPSSA0Kdn8NyJ1cXTgI0CaeKTRr6cezC/jtC7x
 Es5Uc0HhMlLswgmrbx2ILHKoMat6h5WTr4DAp5LB3upMk=

Am 12.10.24 um 04:03 schrieb Kurt Borja:

> Added documentation for new WMAX interface, present on some Alienware
> X-Series, Alienware M-Series and Dell's G-Series laptops.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   Documentation/wmi/devices/alienware-wmi.rst | 366 ++++++++++++++++++++
>   1 file changed, 366 insertions(+)
>   create mode 100644 Documentation/wmi/devices/alienware-wmi.rst

Please update the MAINTAINERS entry for the alienware-wmi driver to
include this documentation file.

>
> diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation/wmi/devices/alienware-wmi.rst
> new file mode 100644
> index 000000000..77460b91c
> --- /dev/null
> +++ b/Documentation/wmi/devices/alienware-wmi.rst
> @@ -0,0 +1,366 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +==============================================
> +Dell AWCC WMI interface driver (alienware-wmi)
> +==============================================
> +
> +Introduction
> +============
> +
> +The WMI device WMAX has been implemented for many Alienware and Dell's G-Series
> +models. Throughout these models, two implementations have been identified. The
> +first one, used by older systems, deals with HDMI, brightness, RGB, amplifier
> +and deep sleep control. The second one used by newer systems deals primarily
> +with thermal, overclocking, and GPIO control.
> +
> +It is suspected that the latter is used by Alienware Command Center (AWCC) to
> +manage manufacturer predefined thermal profiles. The alienware-wmi driver
> +exposes Thermal_Information and Thermal_Control methods through the Platform
> +Profile API to mimic AWCC's behavior.
> +
> +This newer interface, named AWCCMethodFunction has been reverse engineered, as
> +Dell has not provided any official documentation. We will try to describe to the
> +best of our ability its discovered inner workings.
> +
> +.. note::
> +   The following method description may vary between models.
> +
> +WMI interface description
> +-------------------------
> +
> +The WMI interface description can be decoded from the embedded binary MOF (bmof)
> +data using the `bmfdec <https://github.com/pali/bmfdec>`_ utility:
> +
> +::
> +
> + [WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("WMI Function"), guid("{A70591CE-A997-11DA-B012-B622A1EF5492}")]
> + class AWCCWmiMethodFunction {
> +   [key, read] string InstanceName;
> +   [read] boolean Active;
> +
> +   [WmiMethodId(13), Implemented, read, write, Description("Return Overclocking Report.")] void Return_OverclockingReport([out] uint32 argr);
> +   [WmiMethodId(14), Implemented, read, write, Description("Set OCUIBIOS Control.")] void Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(15), Implemented, read, write, Description("Clear OC FailSafe Flag.")] void Clear_OCFailSafeFlag([out] uint32 argr);
> +   [WmiMethodId(19), Implemented, read, write, Description("Get Fan Sensors.")] void GetFanSensors([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(20), Implemented, read, write, Description("Thermal Information.")] void Thermal_Information([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(21), Implemented, read, write, Description("Thermal Control.")] void Thermal_Control([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(23), Implemented, read, write, Description("MemoryOCControl.")] void MemoryOCControl([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(26), Implemented, read, write, Description("System Information.")] void SystemInformation([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(28), Implemented, read, write, Description("Power Information.")] void PowerInformation([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(32), Implemented, read, write, Description("FW Update GPIO toggle.")] void FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(33), Implemented, read, write, Description("Read Total of GPIOs.")] void ReadTotalofGPIOs([out] uint32 argr);
> +   [WmiMethodId(34), Implemented, read, write, Description("Read GPIO pin Status.")] void ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(35), Implemented, read, write, Description("Read Chassis Color.")] void ReadChassisColor([out] uint32 argr);
> +   [WmiMethodId(36), Implemented, read, write, Description("Read Platform Properties.")] void ReadPlatformProperties([out] uint32 argr);
> +   [WmiMethodId(128), Implemented, read, write, Description("Caldera SW installation.")] void CalderaSWInstallation([out] uint32 argr);
> +   [WmiMethodId(129), Implemented, read, write, Description("Caldera SW is released.")] void CalderaSWReleased([out] uint32 argr);
> +   [WmiMethodId(130), Implemented, read, write, Description("Caldera Connection Status.")] void CalderaConnectionStatus([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(131), Implemented, read, write, Description("Surprise Unplugged Flag Status.")] void SurpriseUnpluggedFlagStatus([out] uint32 argr);
> +   [WmiMethodId(132), Implemented, read, write, Description("Clear Surprise Unplugged Flag.")] void ClearSurpriseUnpluggedFlag([out] uint32 argr);
> +   [WmiMethodId(133), Implemented, read, write, Description("Cancel Undock Request.")] void CancelUndockRequest([out] uint32 argr);
> +   [WmiMethodId(135), Implemented, read, write, Description("Devices in Caldera.")] void DevicesInCaldera([in] uint32 arg2, [out] uint32 argr);
> +   [WmiMethodId(136), Implemented, read, write, Description("Notify BIOS for SW ready to disconnect Caldera.")] void NotifyBIOSForSWReadyToDisconnectCaldera([out] uint32 argr);
> +   [WmiMethodId(160), Implemented, read, write, Description("Tobii SW installation.")] void TobiiSWinstallation([out] uint32 argr);
> +   [WmiMethodId(161), Implemented, read, write, Description("Tobii SW Released.")] void TobiiSWReleased([out] uint32 argr);
> +   [WmiMethodId(162), Implemented, read, write, Description("Tobii Camera Power Reset.")] void TobiiCameraPowerReset([out] uint32 argr);
> +   [WmiMethodId(163), Implemented, read, write, Description("Tobii Camera Power On.")] void TobiiCameraPowerOn([out] uint32 argr);
> +   [WmiMethodId(164), Implemented, read, write, Description("Tobii Camera Power Off.")] void TobiiCameraPowerOff([out] uint32 argr);
> + };
> +
> +Some of these methods get quite intricate so we will describe them using
> +pseudo-code that vaguely resembles the original ASL code.
> +
> +Argument Structure
> +------------------
> +
> +All input arguments have type **uint32** and their structure is very similar
> +between methods. Usually, the first byte corresponds to a specific *operation*
> +the method performs, and the subsequent bytes correspond to *arguments* passed
> +to this *operation*. For example, if an operation has code 0x01 and requires an
> +ID 0xA0, the argument you would pass to the method is 0xA001.
> +
> +
> +Thermal Methods
> +===============
> +
> +WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) == 0x01:
> +         argr = 1
> +
> + if BYTE_0(arg2) == 0x02:
> +         argr = UNKNOWN_CONSTANT
> +
> + if BYTE_0(arg2) == 0x03:
> +         if BYTE_1(arg2) == 0x00:
> +                 argr = FAN_ID_0
> +
> +         if BYTE_1(arg2) == 0x01:
> +                 argr = FAN_ID_1
> +
> +         if BYTE_1(arg2) == 0x02:
> +                 argr = FAN_ID_2
> +
> +         if BYTE_1(arg2) == 0x03:
> +                 argr = FAN_ID_3
> +
> +         if BYTE_1(arg2) == 0x04:
> +                 argr = SENSOR_ID_CPU | 0x0100
> +
> +         if BYTE_1(arg2) == 0x05:
> +                 argr = SENSOR_ID_GPU | 0x0100
> +
> +         if BYTE_1(arg2) == 0x06:
> +                 argr = THERMAL_MODE_QUIET_ID
> +
> +         if BYTE_1(arg2) == 0x07:
> +                 argr = THERMAL_MODE_BALANCED_ID
> +
> +         if BYTE_1(arg2) == 0x08:
> +                 argr = THERMAL_MODE_BALANCED_PERFORMANCE_ID
> +
> +         if BYTE_1(arg2) == 0x09:
> +                 argr = THERMAL_MODE_PERFORMANCE_ID
> +
> +         if BYTE_1(arg2) == 0x0A:
> +                 argr = THERMAL_MODE_LOW_POWER_ID
> +
> +         if BYTE_1(arg2) == 0x0B:
> +                 argr = THERMAL_MODE_GMODE_ID
> +
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> + if BYTE_0(arg2) == 0x04:
> +         if is_valid_sensor(BYTE_1(arg2)):
> +                 argr = SENSOR_TEMP_C
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> + if BYTE_0(arg2) == 0x05:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr = FAN_RPM()
> +
> + if BYTE_0(arg2) == 0x06:
> +         skip
> +
> + if BYTE_0(arg2) == 0x07:
> +         argr = 0
> +
> + If BYTE_0(arg2) == 0x08:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr = 0
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> + if BYTE_0(arg2) == 0x09:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr = FAN_UNKNOWN_STAT_0()
> +
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> + if BYTE_0(arg2) == 0x0A:
> +         argr = THERMAL_MODE_BALANCED_ID
> +
> + if BYTE_0(arg2) == 0x0B:
> +         argr = CURRENT_THERMAL_MODE()
> +
> + if BYTE_0(arg2) == 0x0C:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 argr = FAN_UNKNOWN_STAT_1()
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> +WMI method Thermal_Control([in] uint32 arg2, [out] uint32 argr)
> +---------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) == 0x01:
> +         if is_valid_thermal_profile(BYTE_1(arg2)):
> +                 SET_THERMAL_PROFILE(BYTE_1(arg2))
> +                 argr = 0
> +
> + if BYTE_0(arg2) == 0x02:
> +         if is_valid_fan(BYTE_1(arg2)):
> +                 SET_FAN_SPEED_MULTIPLIER(BYTE_2(arg2))
> +                 argr = 0
> +         else:
> +                 argr = 0xFFFFFFFF
> +
> +.. note::
> +   While you can manually change the fan speed multiplier with this method,
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
> +Usually if a model doesn't support the first four profiles they will support
> +the User Selectable Thermal Tables (USTT) profiles and vice-versa.
> +
> +GMODE replaces PERFORMANCE in G-Series laptops.
> +
> +WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) == 1:
> +        if is_valid_fan(BYTE_1(arg2)):
> +                argr = 1
> +        else:
> +                argr = 0
> +
> + if BYTE_0(arg2) == 2:
> +        if is_valid_fan(BYTE_1(arg2)):
> +                if BYTE_2(arg2) == 0:
> +                        argr == SENSOR_ID
> +                else
> +                        argr == 0xFFFFFFFF
> +        else:
> +                argr = 0
> +
> +Overclocking Methods
> +====================
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
> + argr = 0
> +
> +CSMI is an unknown operation.
> +
> +WMI method Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr = 0
> +
> +CSMI is an unknown operation

Missing ".".

> +
> +WMI method Clear_OCFailSafeFlag([out] uint32 argr)
> +--------------------------------------------------
> +
> +::
> +
> + CSMI (0xE3, 0x99)
> + argr = 0
> +
> +CSMI is an unknown operation

Missing ".".

> +
> +
> +WMI method MemoryOCControl([in] uint32 arg2, [out] uint32 argr)
> +---------------------------------------------------------------
> +
> +AWCC supports memory overclocking, but this method is very intricate and has
> +not been deciphered yet.
> +
> +GPIO methods
> +============
> +
> +These methods are probably related to some kind of firmware update system,
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
> + if BYTE_0(arg2) == 0:
> +         if BYTE_1(arg2) == 1:
> +                 SET_PIN_A_HIGH()
> +         else:
> +                 SET_PIN_A_LOW()
> +
> + if BYTE_0(arg2) == 1:
> +         if BYTE_1(arg2) == 1:
> +                 SET_PIN_B_HIGH()
> +
> +         else:
> +                 SET_PIN_B_LOW()
> +
> + else:
> +         argr = 1
> +
> +WMI method ReadTotalofGPIOs([out] uint32 argr)
> +----------------------------------------------
> +
> +::
> +
> + argr = 0x02
> +
> +WMI method ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr)
> +------------------------------------------------------------------
> +
> +::
> +
> + if BYTE_0(arg2) == 0:
> +         argr = PIN_A_STATUS
> +
> + if BYTE_0(arg2) == 1:
> +         argr = PIN_B_STATUS
> +
> +Other information Methods
> +=========================
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
> + argr = CHASSIS_COLOR_ID
> +
> +WMI method ReadPlatformProperties([out] uint32 argr)
> +----------------------------------------------------
> +
> +Returns unknown information.
> +
> +Acknowledgements
> +================
> +
> +Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for documenting
> +and testing avaliable thermal profile codes.

avaliable -> available.

Other than that this looks very good.

Thanks,
Armin Wolf

> +

