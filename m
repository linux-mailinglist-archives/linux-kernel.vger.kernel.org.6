Return-Path: <linux-kernel+bounces-550041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31527A55A81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788BF3B45E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A22E3373;
	Thu,  6 Mar 2025 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="h8reqH5K"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA12054FD;
	Thu,  6 Mar 2025 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302186; cv=none; b=j0SHp2DXik9g2nKhn+C9xabTu3bkj4W6/S+Qg04qQIOPSe/lxAT4kgFlV0wuTOPO0NSNJ45JZTFWd6MFKLh3HDpxxs6Aqd+d0IPqiiCErIksgTYIlGaWBMqHhrhb5bPgg1JTS8mN8cVyVFdYf218rrtBRWgDxT18Mxs0m7wrU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302186; c=relaxed/simple;
	bh=7VSIG77okYWUi2hSj5c3ia0RQRgqqm4MS2Xv4fLemhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNXhjlFb7azedzM96QwCb6Ctem+HB5vBy9lu27TjEyJ9npazken2ihN1hEynYll3Ohu1S6HRGv3OXwxsWqsdOBHlN53Ysf3DVmlHN1hvlYIkKYsa4/va/JFwVmNMVsLadcTQjMwauwEXc8GmmV6MPk079DclqMuC0pWe2jLOL9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=h8reqH5K; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741302178; x=1741906978; i=w_armin@gmx.de;
	bh=RZ79fVnIqt6fcz2W4tjfLJx2mSHY4OR+ArWz6WxIMt0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h8reqH5KUseplCQdCZDkSsFXcSu6XPw21553ORt8upnU9mr5wcNx+9jb5CV22SQX
	 DQNaUVlI3NeOCub+WS8YKfgHw5Gx6tVyMWQMNO/XcxlJ4CZtANiCf7VO3Ivc6x5wD
	 J7nKX1z2V2LDnIQdOLpY9RI/Qe8JfB7eL7gTehg+QNGZiJ4bhUVdhsH7nQ83QgBc6
	 j4l8T0ETtkxxNSlkZcS9Z9DblLm7rKIgt91lm73XC2c1i+CfN8TFNTMoSxPJMrWpu
	 idt/NkjDxLgtdxvZnl8kufCqrvj/EkbUblzKrfdrWmSizAoDQBEYAwbwEDK2V4wKA
	 i+UQMFnjXdBVVtOgBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1tWrRz22x7-00IW4f; Fri, 07
 Mar 2025 00:02:58 +0100
Message-ID: <9d6507ac-0c84-4b33-bebb-7c6460dc72b7@gmx.de>
Date: Fri, 7 Mar 2025 00:02:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] Documentation: wmi: Improve and update
 alienware-wmi documentation
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
 <20250305-hwm-v3-10-395e7a1407e2@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250305-hwm-v3-10-395e7a1407e2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YcEYYduI8r6I2DhvSVS0GwcjKCD07CetNiAYIvDerMqCekyILGn
 QoYIG4BkVgcUbmQ1uH9/KfsqsPgaKE4LRzPaMP+cdXNvgXwAONqU2SiCfux07/HVrX/ghxM
 YSFXJasytXIX8qRxwYXdDSZzSft71930LXOckvLozLnirEtUX+mpDvkySs2Dd1QyWIr5bce
 Ie0YiscEcI2f8eESi7ziw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KEaU1xZwOIU=;Q+Np5DQ8Iuiqd77T4lx0om/wUYu
 4mPTDXQmLCWdONBGB9CFvmcHlpbs32zgbdUJoFlEgCKiMPVj0JDgDqREzGFXHu5FXMWKr++Xj
 COb9U4DdFSkTr6ZwtK4lsJF4OCzq0Lo9LvGdwIUUDRIvDhe7vXShQGRPrVvehJpZPYqROPUHB
 NA7QlnCPmU219EwpVoPXhSNtky1sa/4L2LsuVyyRBC0Hnp9DxUt6IYa62F/c+aGdSDvIyDP6m
 UEtW4tGalal+92yTfphD5f6w8hLSBUqPre6JifuTJW85TdEwledOYzBbr3XQhp5ko87AEag2x
 W3pgw1/DoK0jLKmu2WsLapiR/qXCa6KWAVk42tE07nhPz/U1K6ONuhpG6sLdR/46KKp4/SKAW
 GbRdV6hEDlkkMdw+5V3X/Fyc2KI33TFTjsOaXLSUkeitOW6fKcYSMbbhjBBSfpAboobhE48be
 4zorUfaoqHydGivWOH6jeoq3ZxmP+CabmhMxiEI+2mZ9YndcXHBW7hvvoJM1ZI+rZvGvFYhqs
 +rcqM5hBUc2i2bHS1A/1c2AikpCYXHo5Fx7jtuyhXAGaGPo/56+CRU+3xTYfGl71ahcE1Ocly
 Fbt4dREFysEXN96tC709nBH6k3R0Lr1GJD+iU8YabJ1ahxNKdtFYmenpN8/cliU994YcxalDx
 rjANRSdLrunk39HHid6K4dmZi5jegdmuExauss8Ivqp55REcQrwm9VRgEQAoyyVEQEsss7rKE
 oN8oVtk4LWMAh6oIhbPJw99FhN+pp7KQygbUws/AZJ/ejMVejeKWlCQJkHIIRALB9ylI8eBu3
 Ga5ukcJNKLQ+/ZZv1aa4fcJyTmrgiDpQ4K0UFITDm2qHjyHAJGsasVJiU7HsAsD4GK+0DD7E9
 2khX0e/SnAwpBhxouhj+63bLflBp9ndMB4uc/CDG2NVRJTdOAmkUCoJYacLaESxgWmnK4wVBZ
 bVv2vaFqXvz7QsVe6qo2KZSs/KyywqFPzXrB0wEY3vZIKcy75vEM6h4k6BbcmkB+QadSfEHzh
 HXpYkcNQjrCftTr91QWdkW076cD3kJ+ErNeb/xCZJvEEEZllBX2Gwi8KIgjQYyWyaaBdZ9Wh4
 4kv28VVjVOwQ2h/yZp8sqncoZ6a9dtC9H+GSxVw32ioz2RVjbAxtwzGWC91Jifmy/8ydFV6FF
 EjI4pWjVApOA1PKdnQXtU40XCdzP2TMabR+68PcuAPBh9zTgaii/MhVTpgyB0N28Jz8j2sEOt
 +w1JPD8a1T/6iihgg5oEsqF6IBkGoAaG5sdFvBAcLCS8qwfEIzifwY2qvSAQO5lkAO/y9mjdL
 fliFkOPWf7t8osbhsRrLPHYbGdft67YXxRsh/Xu6dYm6203RuAWLVIqHFqjliEB846kaEYqtd
 77qdA02wUoZssMECwKo7Mtf/xbnb2rv9FIWGEjlzZIK+aQ8Ki+EDDD2Hqzu2GoY8L5Yz6pypO
 +Gsw/GxXgZe081i7Km9G/j84SzDg=

Am 06.03.25 um 01:57 schrieb Kurt Borja:

> Use tables to describe method operations instead of using pseudo-code.
> Drop unknown method descriptions to avoid redundancy. Drop GPIO section
> as it is currently irrelevant to this driver. Update Thermal_Information
> method documentation. Add one more helpful developer to the kudos sectio=
n.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   Documentation/wmi/devices/alienware-wmi.rst | 383 +++++++++-----------=
--------
>   1 file changed, 117 insertions(+), 266 deletions(-)
>
> diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation=
/wmi/devices/alienware-wmi.rst
> index ddc5e561960e05fc7cffe700d7d278e32ff2e7b2..79238051b18bc5de9b502325=
017cd5c5fcf41748 100644
> --- a/Documentation/wmi/devices/alienware-wmi.rst
> +++ b/Documentation/wmi/devices/alienware-wmi.rst
> @@ -11,7 +11,7 @@ The WMI device WMAX has been implemented for many Alie=
nware and Dell's G-Series
>   models. Throughout these models, two implementations have been identif=
ied. The
>   first one, used by older systems, deals with HDMI, brightness, RGB, am=
plifier
>   and deep sleep control. The second one used by newer systems deals pri=
marily
> -with thermal, overclocking, and GPIO control.
> +with thermal control and overclocking.
>
>   It is suspected that the latter is used by Alienware Command Center (A=
WCC) to
>   manage manufacturer predefined thermal profiles. The alienware-wmi dri=
ver
> @@ -69,9 +69,6 @@ data using the `bmfdec <https://github.com/pali/bmfdec=
>`_ utility:
>      [WmiMethodId(164), Implemented, read, write, Description("Tobii Cam=
era Power Off.")] void TobiiCameraPowerOff([out] uint32 argr);
>    };
>
> -Some of these methods get quite intricate so we will describe them usin=
g
> -pseudo-code that vaguely resembles the original ASL code.
> -
>   Methods not described in the following document have unknown behavior.
>
>   Argument Structure
> @@ -87,175 +84,133 @@ ID 0xA0, the argument you would pass to the method=
 is 0xA001.
>   Thermal Methods
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------
> +
> ++--------------------+------------------------------------+------------=
--------+
> +| Operation (Byte 0) | Description                        | Arguments  =
        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> +| 0x01               | Get the number of temperature      | - Byte 1: F=
an ID   |
> +|                    | sensors related with a fan ID      |            =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x02               | Get the temperature sensor IDs     | - Byte 1: F=
an ID   |
> +|                    | related to a fan sensor ID         | - Byte 2: I=
ndex    |
> ++--------------------+------------------------------------+------------=
--------+
> +
>   WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
>   -------------------------------------------------------------------
>
> -::
> -
> - if BYTE_0(arg2) =3D=3D 0x01:
> -         argr =3D 1
> -
> - if BYTE_0(arg2) =3D=3D 0x02:
> -         argr =3D SYSTEM_DESCRIPTION
> -
> - if BYTE_0(arg2) =3D=3D 0x03:
> -         if BYTE_1(arg2) =3D=3D 0x00:
> -                 argr =3D FAN_ID_0
> -
> -         if BYTE_1(arg2) =3D=3D 0x01:
> -                 argr =3D FAN_ID_1
> -
> -         if BYTE_1(arg2) =3D=3D 0x02:
> -                 argr =3D FAN_ID_2
> -
> -         if BYTE_1(arg2) =3D=3D 0x03:
> -                 argr =3D FAN_ID_3
> -
> -         if BYTE_1(arg2) =3D=3D 0x04:
> -                 argr =3D SENSOR_ID_CPU | 0x0100
> -
> -         if BYTE_1(arg2) =3D=3D 0x05:
> -                 argr =3D SENSOR_ID_GPU | 0x0100
> -
> -         if BYTE_1(arg2) =3D=3D 0x06:
> -                 argr =3D THERMAL_MODE_QUIET_ID
> -
> -         if BYTE_1(arg2) =3D=3D 0x07:
> -                 argr =3D THERMAL_MODE_BALANCED_ID
> -
> -         if BYTE_1(arg2) =3D=3D 0x08:
> -                 argr =3D THERMAL_MODE_BALANCED_PERFORMANCE_ID
> -
> -         if BYTE_1(arg2) =3D=3D 0x09:
> -                 argr =3D THERMAL_MODE_PERFORMANCE_ID
> -
> -         if BYTE_1(arg2) =3D=3D 0x0A:
> -                 argr =3D THERMAL_MODE_LOW_POWER_ID
> -
> -         if BYTE_1(arg2) =3D=3D 0x0B:
> -                 argr =3D THERMAL_MODE_GMODE_ID
> -
> -         else:
> -                 argr =3D 0xFFFFFFFF
> -
> - if BYTE_0(arg2) =3D=3D 0x04:
> -         if is_valid_sensor(BYTE_1(arg2)):
> -                 argr =3D SENSOR_TEMP_C
> -         else:
> -                 argr =3D 0xFFFFFFFF
> -
> - if BYTE_0(arg2) =3D=3D 0x05:
> -         if is_valid_fan(BYTE_1(arg2)):
> -                 argr =3D FAN_RPM()
> -
> - if BYTE_0(arg2) =3D=3D 0x06:
> -         skip
> -
> - if BYTE_0(arg2) =3D=3D 0x07:
> -         argr =3D 0
> -
> - If BYTE_0(arg2) =3D=3D 0x08:
> -         if is_valid_fan(BYTE_1(arg2)):
> -                 argr =3D 0
> -         else:
> -                 argr =3D 0xFFFFFFFF
> -
> - if BYTE_0(arg2) =3D=3D 0x09:
> -         if is_valid_fan(BYTE_1(arg2)):
> -                 argr =3D FAN_UNKNOWN_STAT_0()
> -
> -         else:
> -                 argr =3D 0xFFFFFFFF
> -
> - if BYTE_0(arg2) =3D=3D 0x0A:
> -         argr =3D THERMAL_MODE_BALANCED_ID
> -
> - if BYTE_0(arg2) =3D=3D 0x0B:
> -         argr =3D CURRENT_THERMAL_MODE()
> -
> - if BYTE_0(arg2) =3D=3D 0x0C:
> -         if is_valid_fan(BYTE_1(arg2)):
> -                 argr =3D FAN_UNKNOWN_STAT_1()
> -         else:
> -                 argr =3D 0xFFFFFFFF
> -
> -Operation 0x02 returns a *system description* buffer with the following
> -structure:
> -
> -::
> -
> - out[0] -> Number of fans
> - out[1] -> Number of sensors
> - out[2] -> 0x00
> - out[3] -> Number of thermal modes
> -
> -Operation 0x03 list all available fan IDs, sensor IDs and thermal profi=
le
> -codes in order, but different models may have different number of fans =
and
> -thermal profiles. These are the known ranges:
> -
> -* Fan IDs: from 2 up to 4
> -* Sensor IDs: 2
> -* Thermal profile codes: from 1 up to 7
> -
> -In total BYTE_1(ARG2) may range from 0x5 up to 0xD depending on the mod=
el.
> ++--------------------+------------------------------------+------------=
--------+
> +| Operation (Byte 0) | Description                        | Arguments  =
        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> +| 0x01               | Unknown.                           | - None     =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x02               | Get system description number with | - None     =
        |
> +|                    | the following structure:           |            =
        |
> +|                    |                                    |            =
        |
> +|                    | - Byte 0: Number of fans           |            =
        |
> +|                    | - Byte 1: Number of temperature    |            =
        |
> +|                    |   sensors                          |            =
        |
> +|                    | - Byte 2: Unknown                  |            =
        |
> +|                    | - Byte 3: Number of thermal        |            =
        |
> +|                    |   profiles                         |            =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x03               | List an ID or resource at a given  | - Byte 1: I=
ndex    |
> +|                    | index. Fan IDs, temperature IDs,   |            =
        |
> +|                    | unknown IDs and thermal profile    |            =
        |
> +|                    | IDs are listed in that exact       |            =
        |
> +|                    | order.                             |            =
        |
> +|                    |                                    |            =
        |
> +|                    | Operation 0x02 is used to know     |            =
        |
> +|                    | which indexes map to which         |            =
        |
> +|                    | resources.                         |            =
        |
> +|                    |                                    |            =
        |
> +|                    | **Returns:** ID at a given index   |            =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x04               | Get the current temperature for a  | - Byte 1: S=
ensor   |
> +|                    | given temperature sensor.          |   ID       =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x05               | Get the current RPM for a given    | - Byte 1: F=
an ID   |
> +|                    | fan.                               |            =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x06               | Get fan speed percentage. (not     | - Byte 1: F=
an ID   |
> +|                    | implemented in every model)        |            =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x07               | Unknown.                           | - Unknown  =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x08               | Get minimum RPM for a given FAN    | - Byte 1: F=
an ID   |
> +|                    | ID.                                |            =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x09               | Get maximum RPM for a given FAN    | - Byte 1: F=
an ID   |
> +|                    | ID.                                |            =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x0A               | Get balanced thermal profile ID.   | - None     =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x0B               | Get current thermal profile ID.    | - None     =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x0C               | Get current `boost` value for a    | - Byte 1: F=
an ID   |
> +|                    | given fan ID.                      |            =
        |
> ++--------------------+------------------------------------+------------=
--------+
>
>   WMI method Thermal_Control([in] uint32 arg2, [out] uint32 argr)
>   ---------------------------------------------------------------
>
> -::
> -
> - if BYTE_0(arg2) =3D=3D 0x01:
> -         if is_valid_thermal_profile(BYTE_1(arg2)):
> -                 SET_THERMAL_PROFILE(BYTE_1(arg2))
> -                 argr =3D 0
> -
> - if BYTE_0(arg2) =3D=3D 0x02:
> -         if is_valid_fan(BYTE_1(arg2)):
> -                 SET_FAN_SPEED_MULTIPLIER(BYTE_2(arg2))
> -                 argr =3D 0
> -         else:
> -                 argr =3D 0xFFFFFFFF
> -
> -.. note::
> -   While you can manually change the fan speed multiplier with this met=
hod,
> -   Dell's BIOS tends to overwrite this changes anyway.
> ++--------------------+------------------------------------+------------=
--------+
> +| Operation (Byte 0) | Description                        | Arguments  =
        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> +| 0x01               | Activate a given thermal profile.  | - Byte 1: T=
hermal  |
> +|                    |                                    |   profile I=
D       |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x02               | Set a `boost` value for a given    | - Byte 1: F=
an ID   |
> +|                    | fan ID.                            | - Byte 2: B=
oost    |
> ++--------------------+------------------------------------+------------=
--------+
>
>   These are the known thermal profile codes:
>
> -::
> ++------------------------------+----------+------+
> +| Thermal Profile              | Type     | ID   |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D+
> +| Custom                       | Special  | 0x00 |
> ++------------------------------+----------+------+
> +| G-Mode                       | Special  | 0xAB |
> ++------------------------------+----------+------+
> +| Quiet                        | Legacy   | 0x96 |
> ++------------------------------+----------+------+
> +| Balanced                     | Legacy   | 0x97 |
> ++------------------------------+----------+------+
> +| Balanced Performance         | Legacy   | 0x98 |
> ++------------------------------+----------+------+
> +| Performance                  | Legacy   | 0x99 |
> ++------------------------------+----------+------+
> +| Balanced                     | USTT     | 0xA0 |
> ++------------------------------+----------+------+
> +| Balanced Performance         | USTT     | 0xA1 |
> ++------------------------------+----------+------+
> +| Cool                         | USTT     | 0xA2 |
> ++------------------------------+----------+------+
> +| Quiet                        | USTT     | 0xA3 |
> ++------------------------------+----------+------+
> +| Performance                  | USTT     | 0xA4 |
> ++------------------------------+----------+------+
> +| Low Power                    | USTT     | 0xA5 |
> ++------------------------------+----------+------+
>
> - CUSTOM                         0x00
> +If a model supports the User Selectable Thermal Tables (USTT) profiles,=
 it will
> +not support the Legacy profiles and vice-versa.
>
> - BALANCED_USTT                  0xA0
> - BALANCED_PERFORMANCE_USTT      0xA1
> - COOL_USTT                      0xA2
> - QUIET_USTT                     0xA3
> - PERFORMANCE_USTT               0xA4
> - LOW_POWER_USTT                 0xA5
> -
> - QUIET                          0x96
> - BALANCED                       0x97
> - BALANCED_PERFORMANCE           0x98
> - PERFORMANCE                    0x99
> -
> - GMODE                          0xAB
> -
> -Usually if a model doesn't support the first four profiles they will su=
pport
> -the User Selectable Thermal Tables (USTT) profiles and vice-versa.
> -
> -GMODE replaces PERFORMANCE in G-Series laptops.
> +Every model supports the CUSTOM (0x00) thermal profile. GMODE replaces
> +PERFORMANCE in G-Series laptops.
>
>   WMI method GameShiftStatus([in] uint32 arg2, [out] uint32 argr)
>   ---------------------------------------------------------------
>
> -::
> -
> - if BYTE_0(arg2) =3D=3D 0x1:
> -         TOGGLE_GAME_SHIFT()
> -         argr =3D GET_GAME_SHIFT_STATUS()
> -
> - if BYTE_0(arg2) =3D=3D 0x2:
> -         argr =3D GET_GAME_SHIFT_STATUS()
> ++--------------------+------------------------------------+------------=
--------+
> +| Operation (Byte 0) | Description                        | Arguments  =
        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> +| 0x01               | Toggle *Game Shift*.               | - None     =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x02               | Get *Game Shift* status.           | - None     =
        |
> ++--------------------+------------------------------------+------------=
--------+
>
>   Game Shift Status does not change the fan speed profile but it could b=
e some
>   sort of CPU/GPU power profile. Benchmarks have not been done.
> @@ -267,131 +222,27 @@ Thermal_Information does not list it.
>   G-key on Dell's G-Series laptops also changes Game Shift status, so bo=
th are
>   directly related.
>
> -WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
> --------------------------------------------------------------
> -
> -::
> -
> - if BYTE_0(arg2) =3D=3D 0x1:
> -        if is_valid_fan(BYTE_1(arg2)):
> -                argr =3D 1
> -        else:
> -                argr =3D 0
> -
> - if BYTE_0(arg2) =3D=3D 0x2:
> -        if is_valid_fan(BYTE_1(arg2)):
> -                if BYTE_2(arg2) =3D=3D 0:
> -                        argr =3D=3D SENSOR_ID
> -                else
> -                        argr =3D=3D 0xFFFFFFFF
> -        else:
> -                argr =3D 0
> -
>   Overclocking Methods
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -.. warning::
> -   These methods have not been tested and are only partially reverse
> -   engineered.
> -
> -WMI method Return_OverclockingReport([out] uint32 argr)
> --------------------------------------------------------
> -
> -::
> -
> - CSMI (0xE3, 0x99)
> - argr =3D 0
> -
> -CSMI is an unknown operation.
> -
> -WMI method Set_OCUIBIOSControl([in] uint32 arg2, [out] uint32 argr)
> --------------------------------------------------------------------
> -
> -::
> -
> - CSMI (0xE3, 0x99)
> - argr =3D 0
> -
> -CSMI is an unknown operation.
> -
> -WMI method Clear_OCFailSafeFlag([out] uint32 argr)
> ---------------------------------------------------
> -
> -::
> -
> - CSMI (0xE3, 0x99)
> - argr =3D 0
> -
> -CSMI is an unknown operation.
> -
> -
>   WMI method MemoryOCControl([in] uint32 arg2, [out] uint32 argr)
>   ---------------------------------------------------------------
>
>   AWCC supports memory overclocking, but this method is very intricate a=
nd has
>   not been deciphered yet.
>
> -GPIO methods
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -These methods are probably related to some kind of firmware update syst=
em,
> -through a GPIO device.
> -
> -.. warning::
> -   These methods have not been tested and are only partially reverse
> -   engineered.
> -
> -WMI method FWUpdateGPIOtoggle([in] uint32 arg2, [out] uint32 argr)
> -------------------------------------------------------------------
> -
> -::
> -
> - if BYTE_0(arg2) =3D=3D 0:
> -         if BYTE_1(arg2) =3D=3D 1:
> -                 SET_PIN_A_HIGH()
> -         else:
> -                 SET_PIN_A_LOW()
> -
> - if BYTE_0(arg2) =3D=3D 1:
> -         if BYTE_1(arg2) =3D=3D 1:
> -                 SET_PIN_B_HIGH()
> -
> -         else:
> -                 SET_PIN_B_LOW()
> -
> - else:
> -         argr =3D 1
> -
> -WMI method ReadTotalofGPIOs([out] uint32 argr)
> -----------------------------------------------
> -
> -::
> -
> - argr =3D 0x02
> -
> -WMI method ReadGPIOpPinStatus([in] uint32 arg2, [out] uint32 argr)
> -------------------------------------------------------------------
> -
> -::
> -
> - if BYTE_0(arg2) =3D=3D 0:
> -         argr =3D PIN_A_STATUS
> -
> - if BYTE_0(arg2) =3D=3D 1:
> -         argr =3D PIN_B_STATUS
> -
>   Other information Methods
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
>   WMI method ReadChassisColor([out] uint32 argr)
>   ----------------------------------------------
>
> -::
> -
> - argr =3D CHASSIS_COLOR_ID
> +Returns the chassis color internal ID.
>
>   Acknowledgements
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ for documentin=
g
> -and testing available thermal profile codes.
> +Kudos to `AlexIII <https://github.com/AlexIII/tcc-g15>`_ and
> +`T-Troll <https://github.com/T-Troll/alienfx-tools/>`_ for documenting =
and
> +testing some of this device's functionality, making it possible to gene=
ralize
> +this driver.
>

