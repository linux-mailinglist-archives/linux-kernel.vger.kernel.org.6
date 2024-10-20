Return-Path: <linux-kernel+bounces-373472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40619A5733
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 00:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600EA1F2201D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADE5198A0F;
	Sun, 20 Oct 2024 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GK/in/cd"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A936124;
	Sun, 20 Oct 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729462185; cv=none; b=bp2omJayCUCJy4gIkzITTwAh29Rc8aSq7ickRTKEO5XYEeDTlilqg4FzeS0T4Wj/ZwzvvCoL2aTfdCGMCR1bSSRpcBo8HYb5sp0KwS9JKbVLGncbmxjTIlKXtShTKUxs2mm8zv1L+tPKZcsSNMBnm0wrYqoC0o2wFiAsY7zK0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729462185; c=relaxed/simple;
	bh=nNKPcTp0JXv6DEGqV/f4fFfU3Xlj7YDvmHixgmxA7ow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=APudgg/RVXsMwZjw0VA/1Qr25cohYZkicdbbKtUS9XtWLPcyOghBn7CeQKWrJzeC+6ZIy9PC3N/lnlPnYgNc4cZ9CUDF4otVlXNJKnNJaR4ukIshKdDbnaWoNrAX5Zbmo6VRWnFHyY4awswgBxxr1uctt/+J2R+ZwFVcqKMZrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GK/in/cd; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729462175; x=1730066975; i=w_armin@gmx.de;
	bh=nNKPcTp0JXv6DEGqV/f4fFfU3Xlj7YDvmHixgmxA7ow=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GK/in/cdUCn3lUDDkN+gP6Ujsu8yYK4xiWCmaSsWCqctR+kBgJhdrqn7G05Jj70P
	 Vr3CNDKfMXFCUklUIIvsQ5mtDeYtxR8XepM9MFEv6Ae3MLC+Wj7vBk16t/4rPs2Q1
	 w9XfiXRGTMZhS1XtG3clRKUY5TSpWlW1Be+m3C+rP6Twqgq6+CZJIT8ds3DDYFbwg
	 LNgzKBncuu5D5ExwJlWjEolo7/n53TuTxo8LkU0gTqAgxsq4SMUwMYv8/MN2Hz8E1
	 id6L2778aA42psPEkROmQq/Fcqb4p0gIWIf6yuZlQVraC1IzmWN97hiEUgz3MYVUR
	 DYmB2m/RBRxpyaZPOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1tZks31a0G-00ntus; Mon, 21
 Oct 2024 00:09:35 +0200
Message-ID: <b1276fd9-6fc3-41fc-a67e-4a18f0139595@gmx.de>
Date: Mon, 21 Oct 2024 00:09:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] alienware-wmi: added autodetect_thermal_profile
 for devices with quirk_unknown
From: Armin Wolf <W_Armin@gmx.de>
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241017081211.126214-2-kuurtb@gmail.com>
 <20241017081631.127333-3-kuurtb@gmail.com>
 <9d30b2ce-68e4-4080-9068-d1c0b5a59284@gmx.de>
 <bd44d3ce-f34f-4b32-878a-0c9f8d1b131e@gmx.de>
Content-Language: en-US
In-Reply-To: <bd44d3ce-f34f-4b32-878a-0c9f8d1b131e@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KHoNZzzOGkmGA8WjWuC4zIo7q0DsegdOlf5L1P7Q2cEm3/U713b
 8GJxD744YujuumQJplRzr+O+1G/EI2GcVTm7xVEkSmMU2kX4FDiKfPIZOgzTmlJj/lzsRev
 02WTb36uL3Qfpz3vBD+HLKbjXZzlBDl/03HuYEGtFodTS1MmZ6nfoA4qlFJ9GQTp8RPKvqa
 Gn+ODheZOzQIdZX76Q/qQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J3Novxuj57Y=;MIpQsV3srXbOJpgKX6tY/KxpB8Y
 MZULUNx0Gi4h6FuovIOEj6JCnRWWkVQcV2vpBrkA+APfXJvB3ZgG+ywEiKSsEMzV21C28pR1k
 jHTUxG2mrSXr1/0bzQW59H9j8z/mWj9dr3nU/NWl0kFDqZ+xe4ILYSPDDDubXEtaeM/LrdaeY
 cqpgAOWodCiDDVws2dUG6Fr9BaAk8mjibOUjjS4cNOpzrlMfFq0exDfNWlC9NAARDwxWScaK6
 LLbNkrsrf8cKN2wzuFBIIaOtAgnJXRkAkPFCBxiGc0utY+uIHc0KTsjUFhJyuKClYsnwLYDCR
 uiy7K0G/ZPjyRXjU06r4N19wypPbEJBpoogVPWG4RhU4DURq0q7An/SKKy/5EbFBmArFdGr9d
 6PhnTDIohPLaExMJSVfMETGT10gRqiDZXL2aXnSJ8pyX8jbHJaNOFDUZbKQwrYgoW+2gm2J9X
 YjMu2Q+8KhhmnK4nfidwuzSqsVrJnyHWrFsTV8Wc4MX4FA9i1s+4Cqfw411+1VZqFxZmJbPPy
 2EThkE+FKyCIYzV57E2IgeebuvjmM9etVI6c77Eohhs/R8eyeU3DJA9qwiPDscEmqgRXDbv2V
 rz0y3P3EIiuCiDOo4IDb+YaaKO/61AyJ1tvVnCstGrhvnttnV6/0HCUZOL2To/Pq6Yhd9aV0o
 1YT8HLMbzqfSOb5DsSsxIIiF+O6Z8gQY9TMOslVItPamEJwBqTK2HPulL4Afj6q3QtrOGUWoX
 fSS4DwYYEO6/qI9AEGgBcn8UvN88WqEbIECSVPvQbPyESL12D2sE8KQ925/AmJpRg9cfujtsv
 uojRohn0uMMwK7FMzW7p/Ouw==

Am 20.10.24 um 22:40 schrieb Armin Wolf:

> Am 20.10.24 um 22:39 schrieb Armin Wolf:
>
>> Am 17.10.24 um 10:16 schrieb Kurt Borja:
>>
>>> Added autodetect_thermal_profile for devices with quirk_unknown.
>>> Autodetection is done through basic conditions most devices with WMAX'=
s
>>> thermal interface meet. Function exits returning 0 in case of errors.
>>>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
Oops, this should have been for patch 5. Please ignore this.

>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>>
>>> ---
>>> I apologize for the late inclusion. This feature can extend support to
>>> many devices without having to list them in alienware_quirks.
>>>
>>> The conditions for selecting the automatic thermal profile are based o=
n
>>> observations on a lot of *issues* in AWCC open source alternatives.
>>>
>>> I observed only Dell's G-Series laptops have WMAX_THERMAL_BALANCED
>>> avaliable and when it's present none of the other profiles are
>>> avaliable, except for GMODE. When a model has USTT profiles avaliable
>>> usually they have all USTT profiles avaliable, except for cool on
>>> mostly
>>> Alienware devices.
>>>
>>> I made another implementation of this function, brute-forcing operatio=
n
>>> 0x03 of Thermal_Information, which is the operation that varies the
>>> most
>>> across models. I found the implementation too cumbersome to include in
>>> this series, but it could potentially extend support of this driver to
>>> all posible devices with this interface automatically.
>>
>> I like this patch, automatic configuration is always a nice feature.
>>
>> Please add support for operation 0x03, this way the driver can work
>> automatically
>> without users having to submit patches adding quirks for their machines=
.
>>
>> Maybe you can use an array for storing the supported thermal mode ids,
>> like this:
>>
>> enum thermal_modes =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0THERMAL_MODE_QUIET,
>> =C2=A0=C2=A0=C2=A0=C2=A0...
>> =C2=A0=C2=A0=C2=A0=C2=A0THERMAL_MODE_LOW_POWER,
>> =C2=A0=C2=A0=C2=A0=C2=A0THERMAL_MODE_MAX
>> };
>>
>> const enumplatform_profile_option
>> thermal_mode_to_platform_profile[THERMAL_MODE_MAX] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0[THERMAL_MODE_QUIET] =3DPLATFORM_PROFILE_QUIET,=
 ...
>> };
>>
>> const enumthermal_modes
>> platform_profile_to_thermal_mode[PLATFORM_PROFILE_LAST] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0[PLATFORM_PROFILE_LOW_POWER] =3D THERMAL_MODE_L=
OW_POWER, ...
>> };
>>
>>
>> u8 thermal_modes[THERMAL_MODE_MAX] =3D {};
>>
>> for (int i =3D 0; i < THERMAL_MODE_MAX; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0thermal_modes[i] =3D call_operation_3(0x06 + i)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0// TODO: Error handling
>> =C2=A0=C2=A0=C2=A0=C2=A0if (thermal_modes[i] =3D=3D 0xFFFFFFFF)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0set_bit(supported_profiles, thermal_mode_to_pla=
tform_profile[i]);
>> }
>>
>> then you can use platform_profile_to_thermal_mode[] when setting the
>> platform profile
>> and thermal_mode_to_platform_profile[] when getting the platform
>> profile.
>> I will leave it up to you on how to handle the existence of GMode.
>>
>> This of course is only a rough idea, you can change anything you want
>> in the above pseudo-code.
>>
>> Thanks,
>> Armin Wolf
>>
>>>
>>> Another possibility is just including every device I observed into
>>> alienware_quirks, which I can do but I want to know your opinion first=
.
>>> ---
>>> =C2=A0 drivers/platform/x86/dell/alienware-wmi.c | 42
>>> +++++++++++++++++++++++
>>> =C2=A0 1 file changed, 42 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/dell/alienware-wmi.c
>>> b/drivers/platform/x86/dell/alienware-wmi.c
>>> index 37a898273..a11ff4851 100644
>>> --- a/drivers/platform/x86/dell/alienware-wmi.c
>>> +++ b/drivers/platform/x86/dell/alienware-wmi.c
>>> @@ -30,8 +30,11 @@
>>> =C2=A0 #define WMAX_METHOD_DEEP_SLEEP_STATUS=C2=A0=C2=A0=C2=A0 0x0C
>>> =C2=A0 #define WMAX_METHOD_THERMAL_INFORMATION=C2=A0=C2=A0=C2=A0 0x14
>>> =C2=A0 #define WMAX_METHOD_THERMAL_CONTROL=C2=A0=C2=A0=C2=A0 0x15
>>> +#define WMAX_METHOD_GMODE_STATUS=C2=A0=C2=A0=C2=A0 0x25
>>>
>>> +#define WMAX_ARG_GET_DEFAULT_PROF=C2=A0=C2=A0=C2=A0 0x0A
>>> =C2=A0 #define WMAX_ARG_GET_CURRENT_PROF=C2=A0=C2=A0=C2=A0 0x0B
>>> +#define WMAX_ARG_GET_GMODE_STATUS=C2=A0=C2=A0=C2=A0 0x02
>>>
>>> =C2=A0 #define WMAX_FAILURE_CODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0xFFFFFFFF
>>>
>>> @@ -968,6 +971,42 @@ static int thermal_profile_set_ustt(struct
>>> platform_profile_handler *pprof,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>>
>>> +static int autodetect_thermal_profile(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 acpi_status status;
>>> +=C2=A0=C2=A0=C2=A0 u32 in_args;
>>> +=C2=A0=C2=A0=C2=A0 u32 default_profile;
>>> +=C2=A0=C2=A0=C2=A0 u32 gmode;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 in_args =3D WMAX_ARG_GET_DEFAULT_PROF;
>>> +=C2=A0=C2=A0=C2=A0 status =3D alienware_wmax_command(&in_args, sizeof=
(in_args),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WMAX_METHOD_THERMAL_INFORMAT=
ION,
>>> &default_profile);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 in_args =3D WMAX_ARG_GET_GMODE_STATUS;
>>> +=C2=A0=C2=A0=C2=A0 status =3D alienware_wmax_command(&in_args, sizeof=
(in_args),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WMAX_METHOD_GMODE_STATUS, &g=
mode);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (default_profile =3D=3D WMAX_THERMAL_BALANCED &=
& gmode =3D=3D 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quirks->thermal =3D WMAX_T=
HERMAL_TABLE_SIMPLE;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quirks->gmode =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (default_profile =3D=3D WMAX_THERMAL_USTT_BALAN=
CED)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quirks->thermal =3D WMAX_T=
HERMAL_TABLE_USTT;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (gmode =3D=3D 0 || gmode =3D=3D 1)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quirks->gmode =3D 1;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> =C2=A0 static int create_thermal_profile(void)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pp_handler.profile_get =3D thermal_prof=
ile_get;
>>> @@ -1050,6 +1089,9 @@ static int __init alienware_wmi_init(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto fail_prep_deepsleep;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0 if (interface =3D=3D WMAX && quirks =3D=3D &quirk_=
unknown)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 autodetect_thermal_profile=
();
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (quirks->thermal > 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D create_=
thermal_profile();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>
>

