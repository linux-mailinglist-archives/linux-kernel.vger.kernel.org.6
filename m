Return-Path: <linux-kernel+bounces-516478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB528A37247
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 07:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15427A2FB8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D65514D2BB;
	Sun, 16 Feb 2025 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="RC471Vhl"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B486344;
	Sun, 16 Feb 2025 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739686970; cv=none; b=Ku1d3+/v/t7jS8lzUaUcquGyVTo7sSMDHOhxOlNjF99XrvhHiQK6YVRNpR/xuOa+3osZAdveK+vRxlaw/t9THl946oxfwR4sz9W4MKwhUGHm4xYnxW5HorQ5ARVIXLIBl8yKjHJ4d12pBiXjS1OgxPNOL5aq3X4+qb1JOUQVGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739686970; c=relaxed/simple;
	bh=WOU/nIoQOZRokrfbkinDVyck6ARf8XJ0g25+zTy39lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7nedgbCxXOjw1epaLes+ZJ1JL/a89jzIDN1WjICcdjb1MwcscxEx/9BnkzgxpGMb6W0JhkgIN+rtPNc54/RK3gr6WjRwcUkdF7ZGBjiT+AEV0L/IovvuhZHidwvhUxA8dYDejQMP6/iBFYUcw8hmmI3Oi9qDFZRr+ENItItsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=RC471Vhl; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739686956; x=1740291756; i=w_armin@gmx.de;
	bh=f2VfAQc/X3awpEWdGvpOmSfPZtxt5IxKbTaicqbm5BE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RC471Vhl4SfhaEjQniNSO2rmT320ytm8GrEQFiEM6q9JJrc5PLw53IZ0TsdUsewH
	 HwHO2HlnHOnnDwLR4Z6j/zoy+0nN8RCUcjb9KYBGA+Gfs919ttI/zbQSZ1I0D3e2X
	 MxGASQ+l0rXUxXTp0LKLd1WNVq/K4t5Z94nAQTYoqAJgO6PLMyTJR5txm6ALC/fvF
	 E+1V8XESckOsoNAED4+jAQTnkipJBkTrxNpixKH5AbIUJmUkUASv5/GC7RgsMuU50
	 RUPNXEqe8JB+n4OX5POvkT8pRSfkq7rDs5d/m5KGwdUM/soqfVYBDFmAGCEklzadx
	 yXd3eWVxW4wbAONyGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1u08au1gyq-00K7qa; Sun, 16
 Feb 2025 07:22:36 +0100
Message-ID: <b65ffe38-78a3-4d37-b1d1-366bc6870665@gmx.de>
Date: Sun, 16 Feb 2025 07:22:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] platform/x86: alienware-wmi: Improve and update
 documentation
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-11-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250208051614.10644-11-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ue3JR2/GTY4zxdomKfu1BKey4nUbweEI1ZaNi6iFnNh41XfdClr
 dYlUN4k+logL0t9+MJRYnAITnSJeOF8Of9kROAqRmBTbGARflxWN148SZMJRh3KQ/FJCv53
 pUqLdYbrfQYhcYOvaJcr+QiVmISTFT5wdw5RrczIRFO0qypL5VaF//kTYcPSeIZtPADUG/u
 EqkwODL+UE6sP3G0a4iJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ltCTqu1jXZQ=;Tz/hWeJwRN9rz0CVVDAEmafdGVl
 THAwT4CDw89FAX9/3Tv0hEEjA3qXh6zQZfK5xL6dfY3qRxeYjTL/GLx2Rw2mf4gvrxxSl1kLU
 hC3pciwNEPFJyJQMCtuIFwui/1uBfnvaTsAYMJkhbUst7ou1PzwdOwUFPRehm6NMp2pzGtjUi
 Ka8+1dUXW4X2E+xY1jyBuwdxwLDenIUN3muAgsJdkfxhBZJOKvK87YdGwcGcbnt3cZF4V337v
 MxJyM9P5i+fGQMgHeubbNSXh5A8AvXlO/9RvJ4VlKdXZ4k9yAn3OrY98sqyzphyEl7YEsse9c
 rk3MzsiDkmYoJHceq5b2HVrU+jMSWDx804HHuyD+v1FkLfFqrQiGZKEOyykXvb0dSUZnBYxCv
 WIVYfAfV7KB6koH3EUz1nC7hMhcPG6yLKaYLVJNtHiXOJTSsaNw1ZsJ9p8DByXn/JzH5uhXgN
 JwKiIL7DMbICw7Dq1h/50i77RG5NCjyHPm/WHt4Bh3fwXcG+vBNxnSk45FFU8ErQ5NUdoQ8IF
 ktRfJc9lq3ZLaG9WXqCX3k9x8MrE0Rdxmb9dckcT1jkROJAcspCYUgXcjODrrHNLneQro9p6u
 1zimmhPMR9i/N465zyyzhxuRomv5igTn5IYomq/MvplwQcAvYyOEtGvi6m0b1ZycV7ZYQyZSc
 vXMhmvq2fWLnGcWYjSKsKRM7d6/xLs1VUVLi3cGkcG9/vSei8heN9E4XJ2yLgE3TWvn9+cBzl
 zoNQqffxD7XnblKh9YP+FJCfLCeJi3nBa39gQZWgt92oT6SVVNk9NQf5tGwEF3OiGN6KtQLXg
 gQhON+W5wQFwQNxxZ9hVhusB2ljIFiTLQMh+mjbwiKMc4ZDsiULsmrz6tFjg7DhkAGNV+LBcS
 YCJ/nq3V1WtAmvSXYp61uj9PfivfhvvjZuVQR5W32P0zuA9MTYnj5fflW+O8p60grBlWgUrdX
 22B4jQbci6KX4vSZXI/VjU4iaGtA8Oz952SOILBP56sY3WZitjnBu7/toCRc/fM9OAUpV+snu
 WTHZbk0g8CnAYtUdQJT8xMqLkPubaIgmaqEh8h663fm2EFMvasDjBc6BWFaZCFuX29rF9LMti
 QXqyPYrchqvYt1zbj4j/qmZ3WEM3umJb/CBaeagRXVVwe9eQOGZpmDL1BnJZc56dGNk/M43av
 04yWHYBCg/lu2JxIti0a/bWh3c3cCDwdr4qU7yeVZTj7WA44N6A3DUmgE+ULzI9COUDYaXCB3
 CbtTqxVsnZGNIkOQuFQYcN0QWfsYZQNBImO8J5Cm4Gds+QpJVGv8ZNJW+44RcQQkJJqslMUHU
 P2+TM40I0iz3VJgAqkU2qbFeY3ZQvHF0SsMXtHjMXrBvGvmjE8vDDsA08yuUmV9mSZxUlBg/o
 QdOy0GSRE+N7r0xY+7vM6UwK9CsWVjwP/sXD4Bws5TGPoBYghx9Lts5Hzp/fIY+SVYZgaqXgv
 YnhIko1NabrRcT3ccAVrVuTawAO8=

Am 08.02.25 um 06:16 schrieb Kurt Borja:

> Use tables to describe method operations instead of using pseudo-code.
> Drop unknown method descriptions to avoid redundancy. Drop GPIO section
> as it is currently irrelevant to this driver. Update Thermal_Information
> method documentation. Add one more helpful developer to the kudos sectio=
n.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   Documentation/wmi/devices/alienware-wmi.rst | 390 ++++++--------------
>   1 file changed, 122 insertions(+), 268 deletions(-)
>
> diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation=
/wmi/devices/alienware-wmi.rst
> index ddc5e561960e..2bb3abfd9cd7 100644
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
> @@ -87,175 +84,136 @@ ID 0xA0, the argument you would pass to the method=
 is 0xA001.
>   Thermal Methods
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
> --------------------------------------------------------------------
> -
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
> +WMI method GetFanSensors([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------
>
> -Operation 0x03 list all available fan IDs, sensor IDs and thermal profi=
le
> -codes in order, but different models may have different number of fans =
and
> -thermal profiles. These are the known ranges:
> ++--------------------+------------------------------------+------------=
--------+
> +| Operation (Byte 0) | Description                        | Arguments  =
        |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+
> +| 0x01               | Get the number of fans for a given | - Byte 1: F=
an ID   |
> +|                    | fan ID.                            |            =
        |
> ++--------------------+------------------------------------+------------=
--------+
> +| 0x02               | Get the temperature sensor ID      | - Byte 1: F=
an ID   |
> +|                    | related to a fan sensor ID         |            =
        |
> ++--------------------+------------------------------------+------------=
--------+

After looking at a acpidump from a alienware machine i discovered that ope=
ration 0x02
takes a second argument which acts like an index.

Could it be that operation 0x01 actually returns the number of temperature=
 sensors
associated with a given fan which can then be queried using operation 0x02=
?

>
> -* Fan IDs: from 2 up to 4
> -* Sensor IDs: 2
> -* Thermal profile codes: from 1 up to 7
> +WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
> +-------------------------------------------------------------------
>
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
> +| 0x09               | Get maximum RPM for a given FAN    | - Byte 1: F=
an ID   |
> +|                    | ID.                                |            =
        |
> ++--------------------+------------------------------------+------------=
--------+

Duplicated entry here.

Other than that the new documentation looks quite good.

Thanks,
Armin Wolf

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
> -
> - CUSTOM                         0x00
> -
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
> +
> +If a model supports the User Selectable Thermal Tables (USTT) profiles,=
 it will
> +not support the Legacy profiles and vice-versa.
> +
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
> @@ -267,131 +225,27 @@ Thermal_Information does not list it.
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

