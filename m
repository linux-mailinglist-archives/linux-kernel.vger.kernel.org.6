Return-Path: <linux-kernel+bounces-373444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4C99A56B6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA8A1F21F81
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0AC197A92;
	Sun, 20 Oct 2024 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jfMxSeyO"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFEEBE;
	Sun, 20 Oct 2024 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729456836; cv=none; b=XcLYyM1j7vHOC4/4xGKLUl8BRfvTI5/XboXDqmOoI+A98QKJ0RY0tYLeVDQ1QUHrCUDGwu00nIcuxmz1GFnaOLNtDnId/EoRKdk4ascLliIIMJKpbf07TIBjaJdSLBjge4u7rZ1AxFWX0CqtXES5zJECyLf0ofWUyRZ2hVZydjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729456836; c=relaxed/simple;
	bh=5eOE/EXGs/m9GtZRrdxoan5N02m+StjZIDVZFK3Ddi0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=upbjbmwg57kY5Jq9L1My05RQCdlg0L5JTEnCHDd7VM/2M8inH4hLU5M8qRVD1zrFxxwvaRBAcL9Z7vhPcK0vngAAtWd9a7xBIEM4K9uwHfG5Em1mAmq5wgoPt/d/5Zv2KaGSOwmeWHyaDXc16itk83M/9TSdAqoqQIWT/tXl2zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jfMxSeyO; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729456826; x=1730061626; i=w_armin@gmx.de;
	bh=5eOE/EXGs/m9GtZRrdxoan5N02m+StjZIDVZFK3Ddi0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jfMxSeyOGogAylLvGjtknKw3aD2tWNLOK3rt/0aCwFxWCUUrI8ww+rz17JdG5lCB
	 0WcxBgZIJhJ8W2sPje9RTY3/mxmhqrPwawIdFkQuRedKlwKT/nCaOsKek0EhAXXeR
	 ryuFWndCoDGfXW4oN52PdeLnikMbF3nTw6z4IHDzALfEqXqd7ev4A8d1ZCL9BxchM
	 sRjTkg4kIPw9bjJnOkxwzrny79VTT62ZqbgmlmwIeDdFdr4iJPNEjpVUB4yn91/sb
	 EJzHHq37eVKKIhwtKosz8ZnXtS7wtFDCVssCkd1aEGnrVdGh4OsCC0X7uAlP8aPzl
	 LUdyWRy2A8gHK19Mjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MORAa-1tHPmO2Sre-00VpN0; Sun, 20
 Oct 2024 22:40:26 +0200
Message-ID: <bd44d3ce-f34f-4b32-878a-0c9f8d1b131e@gmx.de>
Date: Sun, 20 Oct 2024 22:40:25 +0200
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
Content-Language: en-US
In-Reply-To: <9d30b2ce-68e4-4080-9068-d1c0b5a59284@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XEu2LLUPuwGs0yuBkEQKuNLHhR7+Bfg+LCwy2P7mYnF0ZO/Igim
 8m44TqQV1QsromR+/AipBOH+HucbYvLAQPHb2O07A22XwJuXfHV/aw8gWymXGRNZAqIs7pp
 5b8p8FS+XLX268/0VRxRcMqND1YuI+ZBcO8S8TsEE2QSaC3BKGZoKCODpFI60q2Lz5JglUk
 GMSbWMK+QeLJqkzI+k9xA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:619/fuOb7jI=;eIiQu31TxmXos1br0+XOhik49/v
 xG63clZiErcCHLtHDrTIaBKxzzFO3JCWRIrvooFkfhTCmv2svDMsopdaqI8RAaiRtwTaeapow
 158kvLLDzwYyoYeo6vaMU1UZIVBFXQEpvNErAJ2alh/LL8i+WOOgzPd6CJCQKHMjoNn0LzJzq
 Z2dm9vatoyM4vaRtouQ4hZTCUK+IupugO86AKmrrcP3DgM1Vqty96f5F3sWVvmQu5i8zypQn3
 gwOQwFAK1z0gAFPP1TjxXLQbZ/tvBxSysjAeNzDd4TdsFk8qmwj1Jjbr05DqMD19hJuGKbzhB
 zGzwtO37A0kMIWXeO3pc6dW/EPzBtSeGb2gJw/92nBQkVl7vqi1Z/O4sQ9K0iCADR1ZFYXZnJ
 5pdE83rUe4gt6VlP0fCpE/nQ6aRtwGlWx185xP1VSM5MLN4pDP8oNGFTwzB4gssxTGXsI7xdp
 n5KIxgJbd6k7zCZYnorJDjmtsKSy+vRFnUSfKrsugvZj4gIv0r68K82frWk8PjY8tA4eP89ED
 Z8VsY/yUrUuwjS3D4y7fovxEfuKDQx2UAv5OhFx+bpJgx+XfDxo2sUYo0mPhnPDUqu/vLgvfW
 nycgYApKjX1tp+D1GeqaXqj4Rvjdclqq5XGmCtlj1rBEOk4+Xu8WnVQasLobFTxxtyYUCs7Wf
 sq34It1oAbi9OQCV+irV9XCubambphvVWG2Ltss2hRrvEKo81xRqx4Q0TWGBMBDSC04OjJcAK
 TPPVXqJLkm8ITqDTDDjywvzvSUfQT+ZW/vkF75AAqIH9ITAHzuC6+4WuQLCvKj6QYEGD+tUeV
 tgNcpzYWt4oUGDXzov1j+Zvw==

Am 20.10.24 um 22:39 schrieb Armin Wolf:

> Am 17.10.24 um 10:16 schrieb Kurt Borja:
>
>> Added autodetect_thermal_profile for devices with quirk_unknown.
>> Autodetection is done through basic conditions most devices with WMAX's
>> thermal interface meet. Function exits returning 0 in case of errors.
>>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>
>> ---
>> I apologize for the late inclusion. This feature can extend support to
>> many devices without having to list them in alienware_quirks.
>>
>> The conditions for selecting the automatic thermal profile are based on
>> observations on a lot of *issues* in AWCC open source alternatives.
>>
>> I observed only Dell's G-Series laptops have WMAX_THERMAL_BALANCED
>> avaliable and when it's present none of the other profiles are
>> avaliable, except for GMODE. When a model has USTT profiles avaliable
>> usually they have all USTT profiles avaliable, except for cool on mostl=
y
>> Alienware devices.
>>
>> I made another implementation of this function, brute-forcing operation
>> 0x03 of Thermal_Information, which is the operation that varies the mos=
t
>> across models. I found the implementation too cumbersome to include in
>> this series, but it could potentially extend support of this driver to
>> all posible devices with this interface automatically.
>
> I like this patch, automatic configuration is always a nice feature.
>
> Please add support for operation 0x03, this way the driver can work
> automatically
> without users having to submit patches adding quirks for their machines.
>
> Maybe you can use an array for storing the supported thermal mode ids,
> like this:
>
> enum thermal_modes =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0THERMAL_MODE_QUIET,
> =C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0THERMAL_MODE_LOW_POWER,
> =C2=A0=C2=A0=C2=A0=C2=A0THERMAL_MODE_MAX
> };
>
> const enumplatform_profile_option
> thermal_mode_to_platform_profile[THERMAL_MODE_MAX] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0[THERMAL_MODE_QUIET] =3DPLATFORM_PROFILE_QUIET, =
...
> };
>
> const enumthermal_modes
> platform_profile_to_thermal_mode[PLATFORM_PROFILE_LAST] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0[PLATFORM_PROFILE_LOW_POWER] =3D THERMAL_MODE_LO=
W_POWER, ...
> };
>
>
> u8 thermal_modes[THERMAL_MODE_MAX] =3D {};
>
> for (int i =3D 0; i < THERMAL_MODE_MAX; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0thermal_modes[i] =3D call_operation_3(0x06 + i);
> =C2=A0=C2=A0=C2=A0=C2=A0// TODO: Error handling
> =C2=A0=C2=A0=C2=A0=C2=A0if (thermal_modes[i] =3D=3D 0xFFFFFFFF)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>
> =C2=A0=C2=A0=C2=A0=C2=A0set_bit(supported_profiles, thermal_mode_to_plat=
form_profile[i]);
> }
>
> then you can use platform_profile_to_thermal_mode[] when setting the
> platform profile
> and thermal_mode_to_platform_profile[] when getting the platform profile=
.
> I will leave it up to you on how to handle the existence of GMode.
>
> This of course is only a rough idea, you can change anything you want
> in the above pseudo-code.
>
> Thanks,
> Armin Wolf
>
>>
>> Another possibility is just including every device I observed into
>> alienware_quirks, which I can do but I want to know your opinion first.
>> ---
>> =C2=A0 drivers/platform/x86/dell/alienware-wmi.c | 42 +++++++++++++++++=
++++++
>> =C2=A0 1 file changed, 42 insertions(+)
>>
>> diff --git a/drivers/platform/x86/dell/alienware-wmi.c
>> b/drivers/platform/x86/dell/alienware-wmi.c
>> index 37a898273..a11ff4851 100644
>> --- a/drivers/platform/x86/dell/alienware-wmi.c
>> +++ b/drivers/platform/x86/dell/alienware-wmi.c
>> @@ -30,8 +30,11 @@
>> =C2=A0 #define WMAX_METHOD_DEEP_SLEEP_STATUS=C2=A0=C2=A0=C2=A0 0x0C
>> =C2=A0 #define WMAX_METHOD_THERMAL_INFORMATION=C2=A0=C2=A0=C2=A0 0x14
>> =C2=A0 #define WMAX_METHOD_THERMAL_CONTROL=C2=A0=C2=A0=C2=A0 0x15
>> +#define WMAX_METHOD_GMODE_STATUS=C2=A0=C2=A0=C2=A0 0x25
>>
>> +#define WMAX_ARG_GET_DEFAULT_PROF=C2=A0=C2=A0=C2=A0 0x0A
>> =C2=A0 #define WMAX_ARG_GET_CURRENT_PROF=C2=A0=C2=A0=C2=A0 0x0B
>> +#define WMAX_ARG_GET_GMODE_STATUS=C2=A0=C2=A0=C2=A0 0x02
>>
>> =C2=A0 #define WMAX_FAILURE_CODE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0xFFFFFFFF
>>
>> @@ -968,6 +971,42 @@ static int thermal_profile_set_ustt(struct
>> platform_profile_handler *pprof,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>>
>> +static int autodetect_thermal_profile(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 acpi_status status;
>> +=C2=A0=C2=A0=C2=A0 u32 in_args;
>> +=C2=A0=C2=A0=C2=A0 u32 default_profile;
>> +=C2=A0=C2=A0=C2=A0 u32 gmode;
>> +
>> +=C2=A0=C2=A0=C2=A0 in_args =3D WMAX_ARG_GET_DEFAULT_PROF;
>> +=C2=A0=C2=A0=C2=A0 status =3D alienware_wmax_command(&in_args, sizeof(=
in_args),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WMAX_METHOD_THERMAL_INFORMAT=
ION, &default_profile);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 in_args =3D WMAX_ARG_GET_GMODE_STATUS;
>> +=C2=A0=C2=A0=C2=A0 status =3D alienware_wmax_command(&in_args, sizeof(=
in_args),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WMAX_METHOD_GMODE_STATUS, &g=
mode);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (default_profile =3D=3D WMAX_THERMAL_BALANCED &&=
 gmode =3D=3D 1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quirks->thermal =3D WMAX_TH=
ERMAL_TABLE_SIMPLE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quirks->gmode =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (default_profile =3D=3D WMAX_THERMAL_USTT_BALANC=
ED)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quirks->thermal =3D WMAX_TH=
ERMAL_TABLE_USTT;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (gmode =3D=3D 0 || gmode =3D=3D 1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 quirks->gmode =3D 1;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 static int create_thermal_profile(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pp_handler.profile_get =3D thermal_profi=
le_get;
>> @@ -1050,6 +1089,9 @@ static int __init alienware_wmi_init(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto fail_prep_deepsleep;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 if (interface =3D=3D WMAX && quirks =3D=3D &quirk_u=
nknown)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 autodetect_thermal_profile(=
);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (quirks->thermal > 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D create_t=
hermal_profile();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>

