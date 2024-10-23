Return-Path: <linux-kernel+bounces-378467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB8C9AD107
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6AC1F22E34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFA1CACE4;
	Wed, 23 Oct 2024 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OlmaEvOV"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A7DDAB;
	Wed, 23 Oct 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701164; cv=none; b=jzQ1ajlOLWjG2232xS2MFYDEO6FjvcgbbLgdwvpeKkXal7rcsuY7WCxEyjFcEb1ByEgnnDZTZGRolp9xiGRxQotQ61k1Ah0xl/xViX0w8Mku7Q78a8ZE82IhNggFSUwuaBFD9fJ0oK/EtElmQWVOjGAclzbQFTyKbO7M4r8Ao/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701164; c=relaxed/simple;
	bh=H/pIma+BMPbtGnvRXpE/ISgUkA1yNUv/16VHLUrNNJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cp6FkB+7QQzoaVJzzWdeGJUeavyVYEhIipEns+WPHEX+wFtF+h22R55UIVnV3u4jETbtoyatTRpELGWZyP6c/jfv6rO/JJa+DXWE4auyvRNTYg4De5wuoDovXBd0eOnhkQnneBkCoqC4OEEoSBPUg867poDDCI2h82K0W0g7o6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OlmaEvOV; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729701081; x=1730305881; i=w_armin@gmx.de;
	bh=KzQd+vS9bku6Si7UfoAVG0uoBW8hPzsbCGyq8p+964s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OlmaEvOVKejtPiY3TfjH2y9y1Lmhtc6cVLc43GxY+PNmF2NDEnV37UNEJZD/2W0i
	 w00/1G7RWLcA9AmgXZVbDrDf8jClo8k5TAqYVjxKB26wvdyHjEEuEGdY3l3knp+S0
	 zzOBLf/3691ycMPROZFL7L8wbQw0lO3gj3A0MStcxMLOxH5G8qBvWSK5YNZK74B3T
	 it1niGFFnMW2DnKHeyzozUfJTPnXxG/Slw9Vn6U2pvAbD7Go+Ij5F7YtScPDYyTfj
	 mFIYr7aShi/7Jme6TcK0RiwxmPhSZsQKzPtUchcEO++i1PAOzoVmZUQtxgztmNJD4
	 1nrJXN7O/JNt+d814A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1syzYv3tHl-00Dmsp; Wed, 23
 Oct 2024 18:31:21 +0200
Message-ID: <ab6cfea0-a091-4039-94ac-9a26f3df5da5@gmx.de>
Date: Wed, 23 Oct 2024 18:31:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
To: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Larabel <Michael@phoronix.com>,
 Casey Bowman <casey.g.bowman@intel.com>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
 <8d70bb6a-c6fd-49de-a494-e97c093827e9@gmx.de> <ZxkLz6QBahA7WAyh@laptop>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <ZxkLz6QBahA7WAyh@laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lJpdygShTlp2WCihZyZQ8dSCMbED9gt8draH7DgPVYLIUVThKYI
 cTNRPg8PGfneiQ+P1PVFn/uvyIGsDPa935hd4A5DhdHXs+obB/zRN6soZiRY0BqwXrmauQi
 OACf0joGjKCY59UiG01+Ct6lnBDJv/wnSfpZRPzFHiScSY6rfgNtDAOUfxwOw+VMXv+bfis
 8bvQgpaPllIJMfsMYm9UA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rIz11cNzmP8=;H928jzfyDydpW0HQHGO7a2i7qh5
 6i+dyOIEXFVd+UtvnlLwDCVAVjPuLEptrep5k2qUECcxgb5Nj/xZd9c6n41Rl60FNbfX61Hwz
 0iYs40cCsKfSZCWYRlO3iagmOKYkuG9qh8LheYGynKBjw2exg7VoPYRmQNuJhHcbVltjpTqWI
 /UcljWyNOHXHokNqszsqQkzZjHUySF2eE5XKqYsCXsDME23kpULMnHPkaW/kgarGOwtoUmc8f
 r9wO+5RST3jhDXnuq/Yq1N5wUV/vMEVjRUlosYQqWL67VembdlS5KO5LIaaTZVDVf6znJ8NaH
 fwro+ozFG+vI5TdAJIQ9bGs9k5Xqj22idRUQgYjpaWJPxk8q8O0ERJ7bHT7HXuLyDiYJJJTqb
 BM2LUKKXFNm9/IuvzRcwWEl1yYJBrpom/YOsrt2Kem56Hrsxr0jM/XDQCWbuHkVN7z0xVJh1a
 865mdpWNt8leiKU/z0EVvDvqlvfMG6iVAEbd57F98BALXUj46YPcwKQNdMOujJYUiMixnJVsO
 oO8luISuR93EgzbarSR6LpBr4ybGx2k+lMxCcieprMONkybDZ/0EOUmHJ4Ns6/xNhVCe+daaG
 QUBunQAIk4oWW6b3piVz6Fv3ZuR2eibzSYV7/yxASdf7GmrGSjS3b0UIx/BgbQoCLAqpBeWC4
 DL4H8655xXfm+zD8DQ0oYDcj6CqoGgle8VURmYhJwsnVfcdaq5E5fQLcB6mnesLSN+j9CcVkL
 T6biFtOKvHo71xyL4eJtcmXxsWwHN3/w0q+HE8f2HZ5DMWlpjxSl/VNppjDRmn2qyYU1KBkVo
 4MyR2VnjinYIvSwP9gFsHTzgYRiAiZ7oqnX/v0Fb+ow1A=

Am 23.10.24 um 16:44 schrieb Mohamed Ghanmi:

> Hello !
> On Sun, Oct 20, 2024 at 09:42:45PM +0200, Armin Wolf wrote:
>> Am 20.10.24 um 21:05 schrieb Armin Wolf:
>>
>>> Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:
>>>
>>>> Some recent Asus laptops are supporting ASUS Intelligent Performance
>>>> Technology (AIPT). This solution allows users to have maximized CPU
>>>> performance in models with a chassis providing more thermal head room=
.
>>>> Refer to [1].
>>>>
>>>> There are major performance issues when Linux is installed on these
>>>> laptops compared to Windows install. One such report is published for
>>>> Graphics benchmarks on Asus ASUS Zenbook S 14 with Lunar Lake
>>>> processors [2].
>>>>
>>>> By default, these laptops are booting in "Whisper Mode" till OS power
>>>> management or tools change this to other AIPT mode. This "Whisper" mo=
de
>>>> calls to set lower maximum and minimum RAPL (Running Average Power
>>>> Limit)
>>>> via thermal tables. On Linux this leads to lower performance even whe=
n
>>>> platform power profile is "balanced". This "Whisper" mode should
>>>> correspond to "quiet" mode.
>>>>
>>>> So, when AIPT is present change the default mode to "Standard" during
>>>> boot. Map the three platform power profile modes as follows:
>>>>
>>>> Power Profile Mode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AIPT mode
>>>> -----------------------------------
>>>> quiet=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Whisper
>>>> balanced=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Standard
>>>> performance=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Performance
>>>> ------------------------------------
>>>>
>>>> Here AIPT mode can be detected by checking presese of "FANL" method
>>>> under
>>>> PNP HID "PNP0C14" and UID "ATK". If AIPT mode is present, this takes
>>>> precedence over the existing VIVO thermal policy. These modes are set
>>>> using "FANL" method.
>>>>
>>>> Although this =E2=80=9CFANL=E2=80=9D method is not used in the Asus W=
MI driver, users
>>>> have used this method from user space [3] to set AIPT modes. Used thi=
s
>>>> as a reference.
>>>>
>>>> Link:
>>>> https://www.asus.com/content/laptop-asus-intelligent-performance-tech=
nology-aipt/
>>>> # [1]
>>>> Reported-by: Michael Larabel <Michael@phoronix.com>
>>>> Closes: https://www.phoronix.com/review/lunar-lake-xe2/5 # [2]
>>>> Link: https://github.com/dominiksalvet/asus-fan-control/issues/151 # =
[3]
>>>> Tested-by: Casey Bowman <casey.g.bowman@intel.com>
>>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.c=
om>
>>>> ---
>>>>  =C2=A0 drivers/platform/x86/asus-wmi.c | 93 ++++++++++++++++++++++++=
+++++++--
>>>>  =C2=A0 1 file changed, 89 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/platform/x86/asus-wmi.c
>>>> b/drivers/platform/x86/asus-wmi.c
>>>> index 7a48220b4f5a..06689d0f98c7 100644
>>>> --- a/drivers/platform/x86/asus-wmi.c
>>>> +++ b/drivers/platform/x86/asus-wmi.c
>>>> @@ -100,6 +100,11 @@ module_param(fnlock_default, bool, 0444);
>>>>  =C2=A0 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO=C2=A0=C2=A0=
=C2=A0 1
>>>>  =C2=A0 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO=C2=A0=C2=
=A0=C2=A0 2
>>>>
>>>> +#define AIPT_STANDARD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>> +#define AIPT_WHISPER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
>>>> +#define AIPT_PERFORMANCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2
>>>> +#define AIPT_FULL_SPEED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>>>> +
>>>>  =C2=A0 #define PLATFORM_PROFILE_MAX 2
>>>>
>>>>  =C2=A0 #define USB_INTEL_XUSB2PR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0xD0
>>>> @@ -333,6 +338,9 @@ struct asus_wmi {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi_debug debug;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi_driver *driver;
>>>> +=C2=A0=C2=A0=C2=A0 acpi_handle acpi_mgmt_handle;
>>>> +=C2=A0=C2=A0=C2=A0 int asus_aipt_mode;
>>>> +=C2=A0=C2=A0=C2=A0 bool asus_aipt_present;
>>>>  =C2=A0 };
>>>>
>>>>  =C2=A0 /* WMI
>>>> *********************************************************************=
***/
>>>> @@ -3804,6 +3812,19 @@ static ssize_t
>>>> throttle_thermal_policy_store(struct device *dev,
>>>>  =C2=A0 static DEVICE_ATTR_RW(throttle_thermal_policy);
>>>>
>>>>  =C2=A0 /* Platform profile
>>>> ***********************************************************/
>>>> +static int asus_wmi_write_aipt_mode(struct asus_wmi *asus, int
>>>> aipt_mode)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 int status;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 status =3D acpi_execute_simple_method(asus->acpi_=
mgmt_handle,
>>>> "FANL", aipt_mode);
>>>> +=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_handle_info(asus->ac=
pi_mgmt_handle, "FANL execute
>>>> failed\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>>  =C2=A0 static int asus_wmi_platform_profile_to_vivo(struct asus_wmi =
*asus,
>>>> int mode)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool vivo;
>>>> @@ -3844,6 +3865,26 @@ static int
>>>> asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus, int m
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mode;
>>>>  =C2=A0 }
>>>>
>>>> +static int asus_wmi_aipt_platform_profile_get(struct asus_wmi *asus,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 enum platform_profile_option *profile)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 switch (asus->asus_aipt_mode) {
>>>> +=C2=A0=C2=A0=C2=A0 case AIPT_STANDARD:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PRO=
FILE_BALANCED;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0 case AIPT_PERFORMANCE:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PRO=
FILE_PERFORMANCE;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0 case AIPT_WHISPER:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM_PRO=
FILE_QUIET;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>>  =C2=A0 static int asus_wmi_platform_profile_get(struct
>>>> platform_profile_handler *pprof,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform=
_profile_option *profile)
>>>>  =C2=A0 {
>>>> @@ -3851,6 +3892,10 @@ static int
>>>> asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tp;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus =3D container_of(pprof, struct a=
sus_wmi,
>>>> platform_profile_handler);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (asus->asus_aipt_present)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return asus_wmi_aipt_plat=
form_profile_get(asus, profile);
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D asus->throttle_thermal_policy_=
mode;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (asus_wmi_platform_profile_mod=
e_from_vivo(asus, tp)) {
>>>> @@ -3874,26 +3919,42 @@ static int
>>>> asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum platform=
_profile_option profile)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi *asus;
>>>> -=C2=A0=C2=A0=C2=A0 int tp;
>>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0, tp, aipt_mode;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus =3D container_of(pprof, struct a=
sus_wmi,
>>>> platform_profile_handler);
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (profile) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_PERFORMANCE:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D ASUS_T=
HROTTLE_THERMAL_POLICY_OVERBOOST;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D AIPT_PERFOR=
MANCE;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_BALANCED:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D ASUS_T=
HROTTLE_THERMAL_POLICY_DEFAULT;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D AIPT_STANDA=
RD;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_QUIET:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D ASUS_T=
HROTTLE_THERMAL_POLICY_SILENT;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D AIPT_WHISPE=
R;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNO=
TSUPP;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> -=C2=A0=C2=A0=C2=A0 asus->throttle_thermal_policy_mode =3D
>>>> asus_wmi_platform_profile_to_vivo(asus, tp);
>>>> -=C2=A0=C2=A0=C2=A0 return throttle_thermal_policy_write(asus);
>>>> +=C2=A0=C2=A0=C2=A0 if (asus->asus_aipt_present) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D asus_wmi_write_ai=
pt_mode(asus, aipt_mode);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
sus->asus_aipt_mode =3D aipt_mode;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto skip_vivo;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (asus->throttle_thermal_policy_dev) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus->throttle_thermal_po=
licy_mode =3D
>>>> asus_wmi_platform_profile_to_vivo(asus, tp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D throttle_thermal_=
policy_write(asus);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +skip_vivo:
>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0 }
>>>>
>>>>  =C2=A0 static int platform_profile_setup(struct asus_wmi *asus)
>>>> @@ -3905,7 +3966,7 @@ static int platform_profile_setup(struct
>>>> asus_wmi *asus)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Not an error if a component p=
latform_profile relies on is
>>>> unavailable
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so early return, skipping the=
 setup of platform_profile.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0 if (!asus->throttle_thermal_policy_dev)
>>>> +=C2=A0=C2=A0=C2=A0 if (!asus->throttle_thermal_policy_dev && !asus->=
asus_aipt_present)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "Using throttle_thermal=
_policy for
>>>> platform_profile support\n");
>>>> @@ -4538,6 +4599,7 @@ static int asus_wmi_sysfs_init(struct
>>>> platform_device *device)
>>>>  =C2=A0 static int asus_wmi_platform_init(struct asus_wmi *asus)
>>>>  =C2=A0 {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &asus->platfor=
m_device->dev;
>>>> +=C2=A0=C2=A0=C2=A0 struct acpi_device *adev;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *wmi_uid;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rv;
>>>>
>>>> @@ -4593,6 +4655,29 @@ static int asus_wmi_platform_init(struct
>>>> asus_wmi *asus)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus_wmi_set_=
devstate(ASUS_WMI_DEVID_CWAP,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
sus->driver->quirks->wapf, NULL);
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Check presence of Intelligent Performance=
 Technology (AIPT).
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If present store acpi handle and set asus=
_aipt_present to true.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 adev =3D acpi_dev_get_first_match_dev("PNP0C14", =
"ATK", -1);
>>> Is there really no way of changing the AIPT mode through the WMI
>>> interface?
>>> I would prefer using the WMI interface if available, since the
>>> firmware might
>>> assume that FANL is only called through the WMI interface.
>>>
>>> Do you have a acpidump from a affected device?
>>>
>>> Thanks,
>>> Armin Wolf
>>>
>> I found a acpidump from a ASUS device with a matching FANL method. It s=
eems that this method
>> can indeed be called using the WMI interface using the DEVS() WMI metho=
d:
>>
>> [WmiMethodId(1398162756), Implemented] void DEVS([in] uint32 Device_ID,=
 [in] uint32 Control_status, [out] uint32 result);
>>
>> If Device_ID is 0x00110019, then Control_status is passed to the FANL A=
CPI method.
>>
>> It also seems that support for AIPT can be queried using the DSTS() WMI=
 method:
>>
>> [WmiMethodId(1398035268), Implemented] void DSTS([in] uint32 Device_ID,=
 [out] uint32 device_status);
>>
>> Using Device_ID 0x00110019, the returned device status seems to contain=
 the following information:
>>
>> - 16-bit current AIPT mode
>> - 4-bit unknown value (possible values 2, 3 and 7, maybe number of supp=
orted modes or some kind of bitmap?)
>> - 1-bit with is set when (GGIV (0x0907000C) =3D=3D One) is true
> I just saw this conversation and i think that the behaviour this
> patch will implement in the driver was already implemented in this patch
> that got added to kernel v6.12-rc3:
> https://lore.kernel.org/platform-driver-x86/20240609144849.2532-2-mohame=
d.ghanmi@supcom.tn/
>
> this patch introduced ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO
> 0x00110019 which is the device_id that changes the fan profiles. the
> naming is not clear because it was initially intended to add support for
> fan profiles for vivobook laptops but it ended up adding support
> for a lot of modern laptops.

Nice, you are absolutely right.

So this patch series is effectively already upstream, very good. I did som=
e research and found out
that the status of this device id contains the following data:

Status		Supported Modes
=2D------------------------------
0x00[1]300[xx]	0 1 2
0x000700[xx]	0 1 2
0x000200[xx]	??? (ODV0)
0x000700[xx]	0 1 2
0x0a0700[xx]	??? (ODV0)

While i have no clue about the meaning of the remaining bits, i can report=
 that the first 8 Bits
contain the current thermal mode. Maybe adding support for this would be n=
ice, so the current
thermal mode can be read directly from the hardware.

I also found out that on some models the thermal mode actually modifies th=
e ODV0 variable which
is consumed by int3400_thermal and exposed to the Intel Thermal Daemon. So=
 maybe the lackluster
performance also has something to do with it.

> a point that Srinivas Pandruvada mentioned about RAPL (Running Average P=
ower Limit)
> is valid for a lot of modern vivobook and zenbook laptops but i think
> it's unrelated to fan profiles.
>
> a lot of asus laptops that have intel cpus suffer from power throttling.
> for exemple in my case using windows, changing fan profiles will lead to=
 max power
> changing to the values indicated in the table below (asus vivobook 16x
> pro k6604) which leads to higher performance than linux
>
> fan Profile		power limit
> -----------------------------------
> Whisper			50watts
> Standard                120watts
> Performance		149watts
> ------------------------------------
>
> However in linux, even after changing to the appropriate fan profile,
> the power is still capped at 50watts and i found the reason why
>
> here is the results of using the powercap-info command:
>
> intel-rapl-mmio
>    enabled: 1
>    Zone 0
>      name: package-0
>      enabled: 1
>      max_energy_range_uj: 262143328850
>      Constraint 0
>        name: long_term
>        power_limit_uw: 30000000
>        time_window_us: 55967744
>        max_power_uw: 55000000
>      Constraint 1
>        name: short_term
>        power_limit_uw: 55000000
>        time_window_us: 2440
>        max_power_uw: 0
> intel-rapl
>    enabled: 1
>    Zone 0
>      name: package-0
>      enabled: 1
>      max_energy_range_uj: 262143328850
>      Constraint 0
>        name: long_term
>        power_limit_uw: 157000000
>        time_window_us: 55967744
>        max_power_uw: 55000000
>      Constraint 1
>        name: short_term
>        power_limit_uw: 157000000
>        time_window_us: 2440
>        max_power_uw: 0
>      Constraint 2
>        name: peak_power
>        power_limit_uw: 200000000
>        max_power_uw: 0
>      Zone 0:0
>        name: core
>        enabled: 0
>        max_energy_range_uj: 262143328850
>        Constraint 0
>          name: long_term
>          power_limit_uw: 0
>          time_window_us: 976
>      Zone 0:1
>        name: uncore
>        enabled: 0
>        max_energy_range_uj: 262143328850
>        Constraint 0
>          name: long_term
>          power_limit_uw: 0
>          time_window_us: 976
>    Zone 1
>      name: psys
>      enabled: 0
>      max_energy_range_uj: 262143328850
>      Constraint 0
>        name: long_term
>        power_limit_uw: 0
>        time_window_us: 27983872
>      Constraint 1
>        name: short_term
>        power_limit_uw: 0
>        time_window_us: 976
>
>
> as seen by the output of the command, the intel-rapl-mmio is causing the
> throttling as it sets power_limit_uw to 30 watts (readonly). so the curr=
ent fix
> that i'm currently using is disabling the intel-rapl-mmio leaving only
> the intel-rapl which sets power_limit_uw to 157watts using this
> command: powercap-set -p intel-rapl-mmio -z 0 -e 0
>
> this will lead to the laptop being able to reach it's maximum power
> limit.
>
> after doing this, when i change the platform profile through sysfs the
> laptop will start behaving as described in the table above exactly like
> windows.
>
> in conclusion, the asus-wmi driver already has the platform profiles
> (a.k.a fan profiles)
> implemented and I think that the power throttling is caused by either
> intel Power Capping Framework or asus bios.

Or the Intel Thermal Daemon somehow does not properly support intel-rapl-m=
mio
or is not installed.

Thanks,
Armin Wolf

>
> I also think that redoing the above benchmarks linked by Srinivas after
> using a kernel version higher than v6.12-rc3 and disabling the
> intel-rapl-mmio would be a great idea
>
> Best Regards,

