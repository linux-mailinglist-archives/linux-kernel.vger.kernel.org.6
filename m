Return-Path: <linux-kernel+bounces-373414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31D9A5666
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8871DB27225
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD7B196D9D;
	Sun, 20 Oct 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uAQxayBK"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B392B9A5;
	Sun, 20 Oct 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453426; cv=none; b=k5PTOJwYzzf2W4WESBLdbpQx1nXO2EFX7kdG1jtJ7/rGBUKSUesmpKLvwlj3O1nrg3ypIVWxAk4cNy3wNLYWTYmPlFfKYxzdiIT3KbJqNUHeWBzMGa1p/WkFWM/UHLJNsnv73+Mg5GL2WeTTP8OfhOzaSC8iGSkoOcW1cPyT5SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453426; c=relaxed/simple;
	bh=JaLFQBr3mBeZid15hpI5dREamA5UlAKkKP5ClmObnHg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a9DiLHl38KQSTn6nxZKtziGRGBLwQk2JsVIpAPZt2TE0QMXeV82MXGbNyMcpwaX/v09e5Ivy3KR1jj0FeGtfviybv/dSNZpHVIqXc0dPIs9aqLUQf4r1ZICLCcD72xsLT77ydhtQVpEEbjvdzBbaw3SMVvtyXeJT5yo6w4jDE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uAQxayBK; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729453367; x=1730058167; i=w_armin@gmx.de;
	bh=JaLFQBr3mBeZid15hpI5dREamA5UlAKkKP5ClmObnHg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uAQxayBKt1nvkVdE7Q0NlHbz425VSsW0DItvFhcFSl8hGZgdKrxmJkn9tq713a/B
	 iVowu3nWYNWU+t4EyWLB3sSzUbCGol/HiEmSobSMAtuIUUziQmW9u/5Affy/alg9W
	 ub2dbp3EakrMsaxNnNzaeVLUOEypLMVLiaeOt3c0eSKWnRqj9seEeSxkK0ADfyNeY
	 IUMQc4jndIl3uxLu9qxPlIPqYG874kH/TuTZj+aCWur2MXiZgGC4eea6gPHLmcmrI
	 YtmuEbY0AwBCm3cHYI1Q8Kh1jKiXBdfqBL96zuyJq5w/24tXs7DHimPZ2Y8vpeIdJ
	 zCEIWtXXFtmvpQG8yA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1tLE6c3h2y-00QrBp; Sun, 20
 Oct 2024 21:42:46 +0200
Message-ID: <8d70bb6a-c6fd-49de-a494-e97c093827e9@gmx.de>
Date: Sun, 20 Oct 2024 21:42:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
From: Armin Wolf <W_Armin@gmx.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Larabel <Michael@phoronix.com>,
 Casey Bowman <casey.g.bowman@intel.com>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
Content-Language: en-US
In-Reply-To: <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eP4wqlu4TlRrUjVruluy8M//Z1EX5kj2NIQL5gErrpLeE9QgCSj
 BvuaKfps0wTnhSGVwmgbOe8DL+riKQpdGFFjMFh7ZDUkK03yGleyvFoexgn+CKxV2V0bccb
 /z6dfBDewCvQQ5B0D53BCcBXm71o+Ohm1MALY2mKqgsV9nLqI+3G4rGF/1aFKkioOSvdYgg
 ynHGmaSVUWtfza3sQaPNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NsYoQE057PM=;Ip/YneLqlG1g8sM2QYuTE9V/+dg
 qTZAspjPXtydE1R1n1tp4oH0lH1+8GFIrfUZ2D/7CqjoLsW4j0Lj2I5OuWySc+Rg2/infTnak
 kXBEBofsP3swU9E1ZJlLRRiyAl5QEA5p///dtBWOLArDs+wQ+DF7oJt9yj5EYzIWrbwLdkdfg
 driCsRUvY9OCDAOGUEM33g3VksCfYstnomZidUVa34TjH/TfdCbUyHYpyYVatK3jSwSqp75bl
 zic2drheICOMgJR3A3iDlfgmy5m3WvJ3hrZy4KVCM2Hx/RqIHFOd7RDJFt1cJrmNPawFOPCgT
 vnxeEu+cQmdqPLQGmg+WLKLy1IdyNij/WnGVNumI9errqf8XofbLoSx9OBeyVZP24ZWYOclM5
 RgvfGN+GeRDqtLf3HRm19hqCLlIh7LYaxFG11T1sUmfoCoC+tnwZaqeC0NOI9kWV4PEZQjqIa
 Q0x0lJ2LUoji+ehvxe8C7cDKeGbrlrhDDzuEL4ikUeWGKY08bKWwbBJSK58qFFa518Naty3eh
 MxRgE24jAJzhF9+mY4y75ocwwwN32mbFv4M6q4iUdZdqRd8AT84rgORiXJ2XUrtFVeW8iq2G+
 le+NnyC2rzWsX5XVLwV0nqclpw2VMhhNx6COfH/xz6a7BkLS9S9kQmUJDP05wcc9tGsYjhUbr
 57X27LSTafv2VHO2vu9eiyOm+KU0xofWSR+MGWn7Y4KuRX1oRjbiyGOMUjl4nnjFnDwBzSx/l
 +KjQ1W8tYqm2wr67WYNI6zbwQjHhb0YERFSyK+qgtZjuMx4fRYUKlu3sjtEpobYqflALfs8TP
 X9oOunhCzn0FTIQHCVUFR9uu5uccRYWSueG74Pn8rd+eI=

Am 20.10.24 um 21:05 schrieb Armin Wolf:

> Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:
>
>> Some recent Asus laptops are supporting ASUS Intelligent Performance
>> Technology (AIPT). This solution allows users to have maximized CPU
>> performance in models with a chassis providing more thermal head room.
>> Refer to [1].
>>
>> There are major performance issues when Linux is installed on these
>> laptops compared to Windows install. One such report is published for
>> Graphics benchmarks on Asus ASUS Zenbook S 14 with Lunar Lake
>> processors [2].
>>
>> By default, these laptops are booting in "Whisper Mode" till OS power
>> management or tools change this to other AIPT mode. This "Whisper" mode
>> calls to set lower maximum and minimum RAPL (Running Average Power
>> Limit)
>> via thermal tables. On Linux this leads to lower performance even when
>> platform power profile is "balanced". This "Whisper" mode should
>> correspond to "quiet" mode.
>>
>> So, when AIPT is present change the default mode to "Standard" during
>> boot. Map the three platform power profile modes as follows:
>>
>> Power Profile Mode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AIPT mode
>> -----------------------------------
>> quiet=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Whisper
>> balanced=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Standard
>> performance=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Performance
>> ------------------------------------
>>
>> Here AIPT mode can be detected by checking presese of "FANL" method
>> under
>> PNP HID "PNP0C14" and UID "ATK". If AIPT mode is present, this takes
>> precedence over the existing VIVO thermal policy. These modes are set
>> using "FANL" method.
>>
>> Although this =E2=80=9CFANL=E2=80=9D method is not used in the Asus WMI=
 driver, users
>> have used this method from user space [3] to set AIPT modes. Used this
>> as a reference.
>>
>> Link:
>> https://www.asus.com/content/laptop-asus-intelligent-performance-techno=
logy-aipt/
>> # [1]
>> Reported-by: Michael Larabel <Michael@phoronix.com>
>> Closes: https://www.phoronix.com/review/lunar-lake-xe2/5 # [2]
>> Link: https://github.com/dominiksalvet/asus-fan-control/issues/151 # [3=
]
>> Tested-by: Casey Bowman <casey.g.bowman@intel.com>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
>> ---
>> =C2=A0 drivers/platform/x86/asus-wmi.c | 93 +++++++++++++++++++++++++++=
=2B+++--
>> =C2=A0 1 file changed, 89 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c
>> b/drivers/platform/x86/asus-wmi.c
>> index 7a48220b4f5a..06689d0f98c7 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -100,6 +100,11 @@ module_param(fnlock_default, bool, 0444);
>> =C2=A0 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO=C2=A0=C2=A0=C2=
=A0 1
>> =C2=A0 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO=C2=A0=C2=A0=
=C2=A0 2
>>
>> +#define AIPT_STANDARD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>> +#define AIPT_WHISPER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
>> +#define AIPT_PERFORMANCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 2
>> +#define AIPT_FULL_SPEED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>> +
>> =C2=A0 #define PLATFORM_PROFILE_MAX 2
>>
>> =C2=A0 #define USB_INTEL_XUSB2PR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0xD0
>> @@ -333,6 +338,9 @@ struct asus_wmi {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi_debug debug;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi_driver *driver;
>> +=C2=A0=C2=A0=C2=A0 acpi_handle acpi_mgmt_handle;
>> +=C2=A0=C2=A0=C2=A0 int asus_aipt_mode;
>> +=C2=A0=C2=A0=C2=A0 bool asus_aipt_present;
>> =C2=A0 };
>>
>> =C2=A0 /* WMI
>> ***********************************************************************=
*/
>> @@ -3804,6 +3812,19 @@ static ssize_t
>> throttle_thermal_policy_store(struct device *dev,
>> =C2=A0 static DEVICE_ATTR_RW(throttle_thermal_policy);
>>
>> =C2=A0 /* Platform profile
>> ***********************************************************/
>> +static int asus_wmi_write_aipt_mode(struct asus_wmi *asus, int
>> aipt_mode)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int status;
>> +
>> +=C2=A0=C2=A0=C2=A0 status =3D acpi_execute_simple_method(asus->acpi_mg=
mt_handle,
>> "FANL", aipt_mode);
>> +=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_handle_info(asus->acpi=
_mgmt_handle, "FANL execute
>> failed\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *as=
us,
>> int mode)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool vivo;
>> @@ -3844,6 +3865,26 @@ static int
>> asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus, int m
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mode;
>> =C2=A0 }
>>
>> +static int asus_wmi_aipt_platform_profile_get(struct asus_wmi *asus,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 enum platform_profile_option *profile)
>> +{
>> +=C2=A0=C2=A0=C2=A0 switch (asus->asus_aipt_mode) {
>> +=C2=A0=C2=A0=C2=A0 case AIPT_STANDARD:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PROFI=
LE_BALANCED;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case AIPT_PERFORMANCE:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PROFI=
LE_PERFORMANCE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case AIPT_WHISPER:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PROFI=
LE_QUIET;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 static int asus_wmi_platform_profile_get(struct
>> platform_profile_handler *pprof,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_pr=
ofile_option *profile)
>> =C2=A0 {
>> @@ -3851,6 +3892,10 @@ static int
>> asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tp;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus =3D container_of(pprof, struct asus=
_wmi,
>> platform_profile_handler);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (asus->asus_aipt_present)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return asus_wmi_aipt_platfo=
rm_profile_get(asus, profile);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D asus->throttle_thermal_policy_mod=
e;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (asus_wmi_platform_profile_mode_f=
rom_vivo(asus, tp)) {
>> @@ -3874,26 +3919,42 @@ static int
>> asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform_pr=
ofile_option profile)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi *asus;
>> -=C2=A0=C2=A0=C2=A0 int tp;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0, tp, aipt_mode;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus =3D container_of(pprof, struct asus=
_wmi,
>> platform_profile_handler);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (profile) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_PERFORMANCE:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D ASUS_THRO=
TTLE_THERMAL_POLICY_OVERBOOST;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D AIPT_PERFORMA=
NCE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_BALANCED:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D ASUS_THRO=
TTLE_THERMAL_POLICY_DEFAULT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D AIPT_STANDARD=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_QUIET:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D ASUS_THRO=
TTLE_THERMAL_POLICY_SILENT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D AIPT_WHISPER;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSU=
PP;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> -=C2=A0=C2=A0=C2=A0 asus->throttle_thermal_policy_mode =3D
>> asus_wmi_platform_profile_to_vivo(asus, tp);
>> -=C2=A0=C2=A0=C2=A0 return throttle_thermal_policy_write(asus);
>> +=C2=A0=C2=A0=C2=A0 if (asus->asus_aipt_present) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D asus_wmi_write_aipt=
_mode(asus, aipt_mode);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asu=
s->asus_aipt_mode =3D aipt_mode;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o skip_vivo;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (asus->throttle_thermal_policy_dev) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus->throttle_thermal_poli=
cy_mode =3D
>> asus_wmi_platform_profile_to_vivo(asus, tp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D throttle_thermal_po=
licy_write(asus);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +skip_vivo:
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>>
>> =C2=A0 static int platform_profile_setup(struct asus_wmi *asus)
>> @@ -3905,7 +3966,7 @@ static int platform_profile_setup(struct
>> asus_wmi *asus)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Not an error if a component plat=
form_profile relies on is
>> unavailable
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so early return, skipping the se=
tup of platform_profile.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 if (!asus->throttle_thermal_policy_dev)
>> +=C2=A0=C2=A0=C2=A0 if (!asus->throttle_thermal_policy_dev && !asus->as=
us_aipt_present)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "Using throttle_thermal_po=
licy for
>> platform_profile support\n");
>> @@ -4538,6 +4599,7 @@ static int asus_wmi_sysfs_init(struct
>> platform_device *device)
>> =C2=A0 static int asus_wmi_platform_init(struct asus_wmi *asus)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &asus->platform_d=
evice->dev;
>> +=C2=A0=C2=A0=C2=A0 struct acpi_device *adev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *wmi_uid;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rv;
>>
>> @@ -4593,6 +4655,29 @@ static int asus_wmi_platform_init(struct
>> asus_wmi *asus)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus_wmi_set_dev=
state(ASUS_WMI_DEVID_CWAP,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus=
->driver->quirks->wapf, NULL);
>>
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Check presence of Intelligent Performance T=
echnology (AIPT).
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If present store acpi handle and set asus_a=
ipt_present to true.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 adev =3D acpi_dev_get_first_match_dev("PNP0C14", "A=
TK", -1);
>
> Is there really no way of changing the AIPT mode through the WMI
> interface?
> I would prefer using the WMI interface if available, since the
> firmware might
> assume that FANL is only called through the WMI interface.
>
> Do you have a acpidump from a affected device?
>
> Thanks,
> Armin Wolf
>
I found a acpidump from a ASUS device with a matching FANL method. It seem=
s that this method
can indeed be called using the WMI interface using the DEVS() WMI method:

[WmiMethodId(1398162756), Implemented] void DEVS([in] uint32 Device_ID, [i=
n] uint32 Control_status, [out] uint32 result);

If Device_ID is 0x00110019, then Control_status is passed to the FANL ACPI=
 method.

It also seems that support for AIPT can be queried using the DSTS() WMI me=
thod:

[WmiMethodId(1398035268), Implemented] void DSTS([in] uint32 Device_ID, [o=
ut] uint32 device_status);

Using Device_ID 0x00110019, the returned device status seems to contain th=
e following information:

- 16-bit current AIPT mode
- 4-bit unknown value (possible values 2, 3 and 7, maybe number of support=
ed modes or some kind of bitmap?)
- 1-bit with is set when (GGIV (0x0907000C) =3D=3D One) is true

Maybe you can figure out the meaning of the 4-bit value so that the number=
 of supported states can be
detected automatically. For interacting with the DEVS() and DSTS() WMI met=
hod, please use the driver-provided
helper methods if suitable.

Thanks,
Armin Wolf

>> +=C2=A0=C2=A0=C2=A0 if (adev) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_handle handle =3D acpi=
_device_handle(adev);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_dev_put(adev);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!acpi_has_method(handle=
, "FANL"))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus->acpi_mgmt_handle =3D =
handle;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus->asus_aipt_present =3D=
 true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "ASUS Intelli=
gent Performance Technology
>> (AIPT) is present\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Set the mode corres=
ponding to default Linux platform power
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * profile Balanced
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus_wmi_write_aipt_mode(as=
us, AIPT_STANDARD);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>>
>

