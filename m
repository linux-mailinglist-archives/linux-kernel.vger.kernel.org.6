Return-Path: <linux-kernel+bounces-378794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2EA9AD588
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB6F1F25B87
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B71DEFD8;
	Wed, 23 Oct 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QSprXnYX"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A95175809;
	Wed, 23 Oct 2024 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715613; cv=none; b=AOhvgVKHMI+AonTseT+cguqa2vz2xUnhLQBThY0eynHvB2tIvkYtaGBdUz26g7COi+2DsvSTf+2+45J5ye4C8EFvbTSYUdxkRu1h0xu+Zp5V+w+z4H5teYROdFjQl5A5TfeMykrqiZbCfdIpZ+jU+XjSNOK5/oibyB/ZJO9KAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715613; c=relaxed/simple;
	bh=wopiUkdLTouslW26pPUGeK4n4KV6zuTK9UTaMsQx2yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkl8PATNrTXAqth1mjuUaWrJkT30vmta237+UOgmsD6BvJBO4z1OroEcZ5h9o+qcFcCnNliCgIRmV4P6REboO1EX4qjr6l6OLwmJBdCcb7t3Zx7iWE9zSji1lPLp6leEYPYYqPtZlXPvfhK0KmFgPA7YZn/xkc37FW0iQoDJLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QSprXnYX; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729715551; x=1730320351; i=w_armin@gmx.de;
	bh=/+M4kueV6gotKkRQhoT1mDwSbiC5ZzTUGdKEL/j1LGk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QSprXnYXfKl2w8wmmBKV4geuQSGVFidptOH0dx1F4IZXUqwsvY6qGjIpuxeRW4xp
	 1ohuLlomzhEgQxQ5hoI7ywLmYazpN4SlwfUZ/9jIkvECD15CtJ+w7LP++M1EXmkik
	 BqwmfdqDddR23zkKO2g7UlwOPsvNTefJhEUCmzPjvLoxrV403qXp7OmXjh0op1h8V
	 Tj2LRz2hRsNJj2yZntH2UWCtAnabBkB4QDlaqouoPK+4m11tUef/lJWw/eQEn07z6
	 IVHt9QQ+bp2opehQtO2ha9N2YY44Yq1E6tE2wB6ReioaR4ZGxU24DKY4hgHPNBj4c
	 X6zrhwKw0yMPn0Gvdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXd2-1tHNG83kB8-00JXrK; Wed, 23
 Oct 2024 22:32:30 +0200
Message-ID: <01b95adb-3ae9-4619-9652-12a5ddafeb82@gmx.de>
Date: Wed, 23 Oct 2024 22:32:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Cc: corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Larabel <Michael@phoronix.com>,
 Casey Bowman <casey.g.bowman@intel.com>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
 <8d70bb6a-c6fd-49de-a494-e97c093827e9@gmx.de> <ZxkLz6QBahA7WAyh@laptop>
 <ab6cfea0-a091-4039-94ac-9a26f3df5da5@gmx.de> <Zxk5ZwG-61iVP3Qm@laptop>
 <8c4209a4-f6d4-4289-9c57-0ef0188149f3@gmx.de>
 <e1a3a8d980f2c2ff9ffe4f43b91ddffc81d85265.camel@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <e1a3a8d980f2c2ff9ffe4f43b91ddffc81d85265.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:At7UC6b54lEVkWqMKdov9lpcNf5MQZ4c05CwAJDtDxXNsXZw9Yg
 S0q1ph0Pxr4pBEw7tnkE2c8d0BqVdPOttcQ6QSUT7aUgP3tBAN2/M3CfzGCq8cLJ/ts7gPL
 rq2X2ldiGzBTmy1AkyfIik631wmd0IX9FTGT+u0V/cRHbFxAlB1yZuRj7Dq/4t/XmbbUt7q
 53+9meqDRx6ms1QUdL08g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rr4lymISYzE=;GUgGB83hhtfsWoqpF3seQPwGjc/
 bZ46ThVzz+O2NMbTm3E5JmhDC1hO26ZP7MPLtDpN+uaCdcF6Uim/w6d50jmGOUoiM9V1tYtRy
 JCK2FvOoEsR2QzAnScrRx+CUD3J8Mo5G1dwvaExFJvVKNextpAoNNzAvHD2JMWqOGxbXzoIxD
 izBf+IdKUFrZUOVkQ34/Cd7GwaGEt0Mcm3xej5klId8AL0xBrWc8V2nJRnQihGqubPjsPkNvj
 Di0ZXh/1QkYRWG8hRzYwqeIMvEap3Ln3ZBJtPH4kOwT7oEnqCly33TS3FtPsWW4wWXHMZT9SJ
 VSqKqOWOMGzSGF0VnBbmqwMxgAPRxWc1RIzFiWS5WsORUP9k3+vYVCPzR+XS6xFqo7KDMQViU
 ECb6i1tzxp8FJzTgw+u/yCc7N7NIfCdYnhPxgliEcMM2tCjOVc3vqDjYqz/xSeSmPE6w7zm35
 gLO00yZywPBLNZrm1dsQP9PevXXlMW7tIOviXBYcTjmekHEF9905SIMr0tXPGsESZ28L/kPVB
 47peAru6nt7XCeOdn7mKhgCEIzm8sIbwfo7srXWY2RSfebkmZ1eUMLPa+QY0Cr/l7tyZDISbZ
 ZjfFtoYizePzLxWAZp5NoDImBNpLQIjTaJB7ovRviABcgoRiM3qIzHGeahszNtcRpss+RcRhn
 FZ2fDWvtmu9YNiC6w8qam+TJInL0gxTFRuRo7BaPtW+rKjzpAB+rYRSYwc8t8jOnEGpEl4k5A
 J3FNjTMCECG8v+F50cOUvTFSPMxmBBOQUGT5pc1D3hi1vKS8hZ26ZQ+EmQsODucy4uu6RUtap
 eCUMHGXQFPBBTtsH5+d8DZUyGV8rM+cyCQzjS91gSRMpw=

Am 23.10.24 um 22:15 schrieb srinivas pandruvada:

> On Wed, 2024-10-23 at 20:57 +0200, Armin Wolf wrote:
>> Am 23.10.24 um 19:59 schrieb Mohamed Ghanmi:
>>
>>> On Wed, Oct 23, 2024 at 06:31:17PM +0200, Armin Wolf wrote:
>>>> Am 23.10.24 um 16:44 schrieb Mohamed Ghanmi:
>>>>
>>>>> Hello !
>>>>> On Sun, Oct 20, 2024 at 09:42:45PM +0200, Armin Wolf wrote:
>>>>>> Am 20.10.24 um 21:05 schrieb Armin Wolf:
>>>>>>
>>>>>>> Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:
>>>>>>>
>>>>>>>> Some recent Asus laptops are supporting ASUS Intelligent
>>>>>>>> Performance
>>>>>>>> Technology (AIPT). This solution allows users to have
>>>>>>>> maximized CPU
>>>>>>>> performance in models with a chassis providing more
>>>>>>>> thermal head room.
>>>>>>>> Refer to [1].
>>>>>>>>
>>>>>>>> There are major performance issues when Linux is
>>>>>>>> installed on these
>>>>>>>> laptops compared to Windows install. One such report is
>>>>>>>> published for
>>>>>>>> Graphics benchmarks on Asus ASUS Zenbook S 14 with Lunar
>>>>>>>> Lake
>>>>>>>> processors [2].
>>>>>>>>
>>>>>>>> By default, these laptops are booting in "Whisper Mode"
>>>>>>>> till OS power
>>>>>>>> management or tools change this to other AIPT mode. This
>>>>>>>> "Whisper" mode
>>>>>>>> calls to set lower maximum and minimum RAPL (Running
>>>>>>>> Average Power
>>>>>>>> Limit)
>>>>>>>> via thermal tables. On Linux this leads to lower
>>>>>>>> performance even when
>>>>>>>> platform power profile is "balanced". This "Whisper" mode
>>>>>>>> should
>>>>>>>> correspond to "quiet" mode.
>>>>>>>>
>>>>>>>> So, when AIPT is present change the default mode to
>>>>>>>> "Standard" during
>>>>>>>> boot. Map the three platform power profile modes as
>>>>>>>> follows:
>>>>>>>>
>>>>>>>> Power Profile Mode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AIPT mode
>>>>>>>> -----------------------------------
>>>>>>>> quiet=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Whisper
>>>>>>>> balanced=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Standard
>>>>>>>> performance=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Performance
>>>>>>>> ------------------------------------
>>>>>>>>
>>>>>>>> Here AIPT mode can be detected by checking presese of
>>>>>>>> "FANL" method
>>>>>>>> under
>>>>>>>> PNP HID "PNP0C14" and UID "ATK". If AIPT mode is present,
>>>>>>>> this takes
>>>>>>>> precedence over the existing VIVO thermal policy. These
>>>>>>>> modes are set
>>>>>>>> using "FANL" method.
>>>>>>>>
>>>>>>>> Although this =E2=80=9CFANL=E2=80=9D method is not used in the As=
us WMI
>>>>>>>> driver, users
>>>>>>>> have used this method from user space [3] to set AIPT
>>>>>>>> modes. Used this
>>>>>>>> as a reference.
>>>>>>>>
>>>>>>>> Link:
>>>>>>>> https://www.asus.com/content/laptop-asus-intelligent-performance-=
technology-aipt/
>>>>>>>> # [1]
>>>>>>>> Reported-by: Michael Larabel <Michael@phoronix.com>
>>>>>>>> Closes:
>>>>>>>> https://www.phoronix.com/review/lunar-lake-xe2/5=C2=A0# [2]
>>>>>>>> Link:
>>>>>>>> https://github.com/dominiksalvet/asus-fan-control/issues/151
>>>>>>>>  =C2=A0# [3]
>>>>>>>> Tested-by: Casey Bowman <casey.g.bowman@intel.com>
>>>>>>>> Signed-off-by: Srinivas Pandruvada
>>>>>>>> <srinivas.pandruvada@linux.intel.com>
>>>>>>>> ---
>>>>>>>>  =C2=A0 =C2=A0 drivers/platform/x86/asus-wmi.c | 93
>>>>>>>> +++++++++++++++++++++++++++++++--
>>>>>>>>  =C2=A0 =C2=A0 1 file changed, 89 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/platform/x86/asus-wmi.c
>>>>>>>> b/drivers/platform/x86/asus-wmi.c
>>>>>>>> index 7a48220b4f5a..06689d0f98c7 100644
>>>>>>>> --- a/drivers/platform/x86/asus-wmi.c
>>>>>>>> +++ b/drivers/platform/x86/asus-wmi.c
>>>>>>>> @@ -100,6 +100,11 @@ module_param(fnlock_default, bool,
>>>>>>>> 0444);
>>>>>>>>  =C2=A0 =C2=A0 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO=
=C2=A0=C2=A0=C2=A0 1
>>>>>>>>  =C2=A0 =C2=A0 #define
>>>>>>>> ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO=C2=A0=C2=A0=C2=A0 2
>>>>>>>>
>>>>>>>> +#define AIPT_STANDARD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>>>>> +#define AIPT_WHISPER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
>>>>>>>> +#define AIPT_PERFORMANCE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
>>>>>>>> +#define AIPT_FULL_SPEED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3
>>>>>>>> +
>>>>>>>>  =C2=A0 =C2=A0 #define PLATFORM_PROFILE_MAX 2
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0 #define USB_INTEL_XUSB2PR=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0xD0
>>>>>>>> @@ -333,6 +338,9 @@ struct asus_wmi {
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi_debug debu=
g;
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi_driver *dr=
iver;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 acpi_handle acpi_mgmt_handle;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 int asus_aipt_mode;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 bool asus_aipt_present;
>>>>>>>>  =C2=A0 =C2=A0 };
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0 /* WMI
>>>>>>>> *********************************************************
>>>>>>>> ***************/
>>>>>>>> @@ -3804,6 +3812,19 @@ static ssize_t
>>>>>>>> throttle_thermal_policy_store(struct device *dev,
>>>>>>>>  =C2=A0 =C2=A0 static DEVICE_ATTR_RW(throttle_thermal_policy);
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0 /* Platform profile
>>>>>>>> *********************************************************
>>>>>>>> **/
>>>>>>>> +static int asus_wmi_write_aipt_mode(struct asus_wmi
>>>>>>>> *asus, int
>>>>>>>> aipt_mode)
>>>>>>>> +{
>>>>>>>> +=C2=A0=C2=A0=C2=A0 int status;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 status =3D acpi_execute_simple_method(asus-
>>>>>>>>> acpi_mgmt_handle,
>>>>>>>> "FANL", aipt_mode);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status)) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_handle_info(asus=
->acpi_mgmt_handle, "FANL
>>>>>>>> execute
>>>>>>>> failed\n");
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  =C2=A0 =C2=A0 static int asus_wmi_platform_profile_to_vivo(struc=
t
>>>>>>>> asus_wmi *asus,
>>>>>>>> int mode)
>>>>>>>>  =C2=A0 =C2=A0 {
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool vivo;
>>>>>>>> @@ -3844,6 +3865,26 @@ static int
>>>>>>>> asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi
>>>>>>>> *asus, int m
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mode;
>>>>>>>>  =C2=A0 =C2=A0 }
>>>>>>>>
>>>>>>>> +static int asus_wmi_aipt_platform_profile_get(struct
>>>>>>>> asus_wmi *asus,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 enum platform_profile_option
>>>>>>>> *profile)
>>>>>>>> +{
>>>>>>>> +=C2=A0=C2=A0=C2=A0 switch (asus->asus_aipt_mode) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0 case AIPT_STANDARD:
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM=
_PROFILE_BALANCED;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 case AIPT_PERFORMANCE:
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM=
_PROFILE_PERFORMANCE;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 case AIPT_WHISPER:
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *profile =3D PLATFORM=
_PROFILE_QUIET;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  =C2=A0 =C2=A0 static int asus_wmi_platform_profile_get(struct
>>>>>>>> platform_profile_handler *pprof,
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum=
 platform_profile_option
>>>>>>>> *profile)
>>>>>>>>  =C2=A0 =C2=A0 {
>>>>>>>> @@ -3851,6 +3892,10 @@ static int
>>>>>>>> asus_wmi_platform_profile_get(struct
>>>>>>>> platform_profile_handler *pprof,
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int tp;
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus =3D container_of(ppro=
f, struct asus_wmi,
>>>>>>>> platform_profile_handler);
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (asus->asus_aipt_present)
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return asus_wmi_aipt_=
platform_profile_get(asus,
>>>>>>>> profile);
>>>>>>>> +
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp =3D asus->throttle_ther=
mal_policy_mode;
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch
>>>>>>>> (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
>>>>>>>> @@ -3874,26 +3919,42 @@ static int
>>>>>>>> asus_wmi_platform_profile_set(struct
>>>>>>>> platform_profile_handler *pprof,
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum=
 platform_profile_option
>>>>>>>> profile)
>>>>>>>>  =C2=A0 =C2=A0 {
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct asus_wmi *asus;
>>>>>>>> -=C2=A0=C2=A0=C2=A0 int tp;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0, tp, aipt_mode;
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus =3D container_of(ppro=
f, struct asus_wmi,
>>>>>>>> platform_profile_handler);
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (profile) {
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_PERF=
ORMANCE:
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp=
 =3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D AIPT_PE=
RFORMANCE;
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_BALA=
NCED:
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp=
 =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D AIPT_ST=
ANDARD;
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PLATFORM_PROFILE_QUIE=
T:
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp=
 =3D ASUS_THROTTLE_THERMAL_POLICY_SILENT;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aipt_mode =3D AIPT_WH=
ISPER;
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EOPNOTSUPP;
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>
>>>>>>>> -=C2=A0=C2=A0=C2=A0 asus->throttle_thermal_policy_mode =3D
>>>>>>>> asus_wmi_platform_profile_to_vivo(asus, tp);
>>>>>>>> -=C2=A0=C2=A0=C2=A0 return throttle_thermal_policy_write(asus);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (asus->asus_aipt_present) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D asus_wmi_writ=
e_aipt_mode(asus, aipt_mode);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 asus->asus_aipt_mode =3D aipt_mode;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto skip_vivo;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (asus->throttle_thermal_policy_dev) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asus->throttle_therma=
l_policy_mode =3D
>>>>>>>> asus_wmi_platform_profile_to_vivo(asus, tp);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D throttle_ther=
mal_policy_write(asus);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>> +
>>>>>>>> +skip_vivo:
>>>>>>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>>>  =C2=A0 =C2=A0 }
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0 static int platform_profile_setup(struct asus_wmi
>>>>>>>> *asus)
>>>>>>>> @@ -3905,7 +3966,7 @@ static int
>>>>>>>> platform_profile_setup(struct
>>>>>>>> asus_wmi *asus)
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Not an error if a =
component platform_profile
>>>>>>>> relies on is
>>>>>>>> unavailable
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so early return, s=
kipping the setup of
>>>>>>>> platform_profile.
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>> -=C2=A0=C2=A0=C2=A0 if (!asus->throttle_thermal_policy_dev)
>>>>>>>> +=C2=A0=C2=A0=C2=A0 if (!asus->throttle_thermal_policy_dev && !as=
us-
>>>>>>>>> asus_aipt_present)
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn 0;
>>>>>>>>
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "Using throt=
tle_thermal_policy for
>>>>>>>> platform_profile support\n");
>>>>>>>> @@ -4538,6 +4599,7 @@ static int
>>>>>>>> asus_wmi_sysfs_init(struct
>>>>>>>> platform_device *device)
>>>>>>>>  =C2=A0 =C2=A0 static int asus_wmi_platform_init(struct asus_wmi
>>>>>>>> *asus)
>>>>>>>>  =C2=A0 =C2=A0 {
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &as=
us->platform_device->dev;
>>>>>>>> +=C2=A0=C2=A0=C2=A0 struct acpi_device *adev;
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *wmi_uid;
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rv;
>>>>>>>>
>>>>>>>> @@ -4593,6 +4655,29 @@ static int
>>>>>>>> asus_wmi_platform_init(struct
>>>>>>>> asus_wmi *asus)
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as=
us_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
>>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 asus->driver->quirks->wapf,
>>>>>>>> NULL);
>>>>>>>>
>>>>>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Check presence of Intelligent Perform=
ance
>>>>>>>> Technology (AIPT).
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If present store acpi handle and set
>>>>>>>> asus_aipt_present to true.
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>> +=C2=A0=C2=A0=C2=A0 adev =3D acpi_dev_get_first_match_dev("PNP0C1=
4",
>>>>>>>> "ATK", -1);
>>>>>>> Is there really no way of changing the AIPT mode through
>>>>>>> the WMI
>>>>>>> interface?
>>>>>>> I would prefer using the WMI interface if available, since
>>>>>>> the
>>>>>>> firmware might
>>>>>>> assume that FANL is only called through the WMI interface.
>>>>>>>
>>>>>>> Do you have a acpidump from a affected device?
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Armin Wolf
>>>>>>>
>>>>>> I found a acpidump from a ASUS device with a matching FANL
>>>>>> method. It seems that this method
>>>>>> can indeed be called using the WMI interface using the DEVS()
>>>>>> WMI method:
>>>>>>
>>>>>> [WmiMethodId(1398162756), Implemented] void DEVS([in] uint32
>>>>>> Device_ID, [in] uint32 Control_status, [out] uint32 result);
>>>>>>
>>>>>> If Device_ID is 0x00110019, then Control_status is passed to
>>>>>> the FANL ACPI method.
>>>>>>
>>>>>> It also seems that support for AIPT can be queried using the
>>>>>> DSTS() WMI method:
>>>>>>
>>>>>> [WmiMethodId(1398035268), Implemented] void DSTS([in] uint32
>>>>>> Device_ID, [out] uint32 device_status);
>>>>>>
>>>>>> Using Device_ID 0x00110019, the returned device status seems
>>>>>> to contain the following information:
>>>>>>
>>>>>> - 16-bit current AIPT mode
>>>>>> - 4-bit unknown value (possible values 2, 3 and 7, maybe
>>>>>> number of supported modes or some kind of bitmap?)
>>>>>> - 1-bit with is set when (GGIV (0x0907000C) =3D=3D One) is true
>>>>> I just saw this conversation and i think that the behaviour
>>>>> this
>>>>> patch will implement in the driver was already implemented in
>>>>> this patch
>>>>> that got added to kernel v6.12-rc3:
>>>>> https://lore.kernel.org/platform-driver-x86/20240609144849.2532-2-mo=
hamed.ghanmi@supcom.tn/
>>>>>
>>>>> this patch introduced
>>>>> ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO
>>>>> 0x00110019 which is the device_id that changes the fan
>>>>> profiles. the
>>>>> naming is not clear because it was initially intended to add
>>>>> support for
>>>>> fan profiles for vivobook laptops but it ended up adding
>>>>> support
>>>>> for a lot of modern laptops.
>>>> Nice, you are absolutely right.
>>>>
>>>> So this patch series is effectively already upstream, very good.
>>>> I did some research and found out
>>>> that the status of this device id contains the following data:
>>>>
>>>> Status=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Sup=
ported Modes
>>>> -------------------------------
>>>> 0x00[1]300[xx]=C2=A0=C2=A00 1 2
>>>> 0x000700[xx]=C2=A0=C2=A0=C2=A0=C2=A00 1 2
>>>> 0x000200[xx]=C2=A0=C2=A0=C2=A0=C2=A0??? (ODV0)
>>>> 0x000700[xx]=C2=A0=C2=A0=C2=A0=C2=A00 1 2
>>>> 0x0a0700[xx]=C2=A0=C2=A0=C2=A0=C2=A0??? (ODV0)
>>>>
>>>> While i have no clue about the meaning of the remaining bits, i
>>>> can report that the first 8 Bits
>>>> contain the current thermal mode. Maybe adding support for this
>>>> would be nice, so the current
>>>> thermal mode can be read directly from the hardware.
>>>>
>>>> I also found out that on some models the thermal mode actually
>>>> modifies the ODV0 variable which
>>>> is consumed by int3400_thermal and exposed to the Intel Thermal
>>>> Daemon. So maybe the lackluster
>>>> performance also has something to do with it.
>>>>
>>>>> a point that Srinivas Pandruvada mentioned about RAPL (Running
>>>>> Average Power Limit)
>>>>> is valid for a lot of modern vivobook and zenbook laptops but i
>>>>> think
>>>>> it's unrelated to fan profiles.
>>>>>
>>>>> a lot of asus laptops that have intel cpus suffer from power
>>>>> throttling.
>>>>> for exemple in my case using windows, changing fan profiles
>>>>> will lead to max power
>>>>> changing to the values indicated in the table below (asus
>>>>> vivobook 16x
>>>>> pro k6604) which leads to higher performance than linux
>>>>>
>>>>> fan Profile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0power limit
>>>>> -----------------------------------
>>>>> Whisper=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A050watts
>>>>> Standard=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 120watts
>>>>> Performance=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0149watts
>>>>> ------------------------------------
>>>>>
>>>>> However in linux, even after changing to the appropriate fan
>>>>> profile,
>>>>> the power is still capped at 50watts and i found the reason why
>>>>>
>>>>> here is the results of using the powercap-info command:
>>>>>
>>>>> intel-rapl-mmio
>>>>>  =C2=A0=C2=A0=C2=A0 enabled: 1
>>>>>  =C2=A0=C2=A0=C2=A0 Zone 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: package-0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_range_uj: 262143328850
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: long_term
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw: 30000000
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us: 55967744
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: 55000000
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: short_term
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw: 55000000
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us: 2440
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: 0
>>>>> intel-rapl
>>>>>  =C2=A0=C2=A0=C2=A0 enabled: 1
>>>>>  =C2=A0=C2=A0=C2=A0 Zone 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: package-0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_range_uj: 262143328850
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: long_term
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw: 15700000=
0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us: 55967744
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: 55000000
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: short_term
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw: 15700000=
0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us: 2440
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 2
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: peak_power
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw: 20000000=
0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_power_uw: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Zone 0:0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: core
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_range_uj: 262=
143328850
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: long_t=
erm
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_=
uw: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_=
us: 976
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Zone 0:1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: uncore
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_range_uj: 262=
143328850
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: long_t=
erm
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_=
uw: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_=
us: 976
>>>>>  =C2=A0=C2=A0=C2=A0 Zone 1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: psys
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_energy_range_uj: 262143328850
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: long_term
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us: 27983872
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Constraint 1
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: short_term
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power_limit_uw: 0
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_window_us: 976
>>>>>
>>>>>
>>>>> as seen by the output of the command, the intel-rapl-mmio is
>>>>> causing the
>>>>> throttling as it sets power_limit_uw to 30 watts (readonly). so
>>>>> the current fix
>>>>> that i'm currently using is disabling the intel-rapl-mmio
>>>>> leaving only
>>>>> the intel-rapl which sets power_limit_uw to 157watts using this
>>>>> command: powercap-set -p intel-rapl-mmio -z 0 -e 0
>>>>>
>>>>> this will lead to the laptop being able to reach it's maximum
>>>>> power
>>>>> limit.
>>>>>
>>>>> after doing this, when i change the platform profile through
>>>>> sysfs the
>>>>> laptop will start behaving as described in the table above
>>>>> exactly like
>>>>> windows.
>>>>>
>>>>> in conclusion, the asus-wmi driver already has the platform
>>>>> profiles
>>>>> (a.k.a fan profiles)
>>>>> implemented and I think that the power throttling is caused by
>>>>> either
>>>>> intel Power Capping Framework or asus bios.
>>>> Or the Intel Thermal Daemon somehow does not properly support
>>>> intel-rapl-mmio
>>>> or is not installed.
>>> This was exactly it. the Intel Thermal Daemon wasn't installed. now
>>> everything is working as expected!
>>>
>>> Best regards,
>>> Mohamed G.
>> Interesting.
>>
>> Srinivas, can you verify that the Intel Thermal Daemon is installed
>> on the affected
>> Asus machines?
>>
>> I begin to wonder why this thermal daemon is a userspace component,
>> stuff like thermal
>> management should use the thermal subsystem inside the kernel.
> Thanks for detailed analysis here.
>
> Here the problem is not thermal daemon or INT340x (I am author of
> both).
>
> The ODVP variable is input into thermal tables. These thermal tables
> are defined by Asus via DTT tables. This results in matching certain
> max and min power limits and also various temperature limits.
>
> By default the laptop in question will boot with max limit of 17W,
> which is limit for whisper mode match based on ODVP variables. There is
> a SEN1 limit of 50C, once the limit reaches to 50C, you need to
> throttle upto 12W as per thermal table.
>
> If you stop thermald, yes, you will stay in 17W, so you will not see
> throttle but your SEN1 (seems skin limit) limit will be violated.
> Also if you remove the rapl_mmio driver, that will also work as no
> means to set power limits.
>
> Windows will do exactly same. Meeting thermal limit is a requirement.
>
> But on Windows this ODVP variable will be set to 0 to match standard
> mode. This will result in matching rules which will set the max power
> to 22W and min to 17W also increase thermal limit to 55C. So
> essentially lost 5W of performance.
>
> Here WMI method as you correctly found out matching VIVO thermal
> policy. But it will not set ODVP variable unless you call a WMI method
> to set the mode via DEVS() on the same device ID. So although platform
> power policy will say "balanced" it is actually "Whisper" for thermal
> policy. On Windows when system boots the Asus service will set to
> standard and will set the ODVP variable to 0 and will match the correct
> table.
>
> After Luke's help, I can do a work around from user space to change the
> power policy to any other policy than balanced and then again set to
> balance. This will result in setting the policy to standard via DEVS()
> and also set the correct ODVP variable.
>
> This driver on unload change the vivo thermal policy to default. But
> doesn't change that to default on load time to match the default
> platform power policy. So rmmod and modprobe of driver should also fix.
>
> Thanks,
> Srinivas
>
Good point, so basically throttle_thermal_policy_set_default() need to be =
called during
initialization of the thermal profile. Maybe you can send another patch wh=
ich implements this?

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>

