Return-Path: <linux-kernel+bounces-373370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4A9A55EE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A9B282094
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09197194ADB;
	Sun, 20 Oct 2024 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="evsydLJN"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BFB64A;
	Sun, 20 Oct 2024 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451193; cv=none; b=iZhENuhvacuCYyTRP8p+NmZ5dXkKcBMV1c6IGC+ZZN5HbzeR2oBT1zfgaOtQq0HdABRnD+V1TdqjE4S0Mz836fX21Lhtj39k4uV3xLRXvhdXwZYgkZI+6YVHHi0uzETb3Pyy3ZI3sOF/BzUcqO+JxZRorCbd1k3PhM249axLY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451193; c=relaxed/simple;
	bh=8Ux9dJ6YyCgOQ50X/PU+iJbNtImshBBRTHYhUaFeHQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqzeZS4oG13hAhwxxAm5dsOBz8bCA0QwlVVwSwkmWA08pHRzTfritWY7l+7ojNTYcvj2ukl09MiKjyYWfazgmlmDogTB9Hu79bZNh9Jf1ksVZ9IM6YJ6kOBOTATysEqfSnR3M+m+GiJ+9rxMeWnGA9984fgdz0w+fElKjGSxJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=evsydLJN; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729451133; x=1730055933; i=w_armin@gmx.de;
	bh=Pib642+IXEUJvHrvqgv0jEmYTeeYvF7kLZZ65J9ca3o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=evsydLJNCgwDmCCSYDsiey7qt5a4oe9g88prh8z3Zn5020dTELLhZgFNly9Sqhhy
	 uH6e5rU1N2GwiptouypoXwcTkaakG1UmazbW6ebHxUmVY32dr/S698gK97AOc0lVc
	 g1z2CthJNfYTiIUBL2y8Xs+YNPafgcHV2MgBnWxwZ64dsGxeZ169W8hTmky6DdURl
	 o3j+d0rs1/XDao/G84f0PSmj7ezzwA7NNp/chHeDpZqmswvZpbDfkCC/TEsIaiM/9
	 iDFkQJDyrQmOH0jeJittZ4fctenqOhvCokDo92HEjkWw/Oh70Nf/SqkdzzSZg5eDA
	 a6OXqWTTl7cD7mseNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1tAbiU1buB-00Ek7h; Sun, 20
 Oct 2024 21:05:33 +0200
Message-ID: <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
Date: Sun, 20 Oct 2024 21:05:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Larabel <Michael@phoronix.com>,
 Casey Bowman <casey.g.bowman@intel.com>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vx2VPf+PY56Yt/5JFdzgUAOsgEV5gdzv8GQ2DvBwDVo4Gt576bY
 qPvpdEnoixuFKidRQMXC6YM2/G0uLrFmhv37vGosYMMhkkR81vOVe/+/N1zh58Gv3ZxZEns
 18dqOY3YSViSE+iFeCb6wmbL1VB8HHfpCp74T12pp6CzBwAOw2gxhcrXoJvw3fy382+LV1B
 257jfjxBgJpLgBZKbPE3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KFqcC3WtjZg=;UdL4xmHZKoEq755Xc/9nyP22gqG
 QdoSKExPQ8WlYDgaLLVfSN3wthDVrs2RV3QHsFF3T2DlV2/WM/owFXhSr1cz9piTl0muWIHmE
 SJTbXitcnD8MxXm+LoHT8KIF9CZWmoIC8+i6N6Rs7oC2Ps6WPvn3UdeBktBmSS6KNSdyi2qtr
 5F+WfHBrDVaSqp9vm007qv4O0cvJTh1EqnKpNh983LPnNqWPf9sjmJ88L04pKS0t3Ek1RMJKx
 kGMECrSvKYkjKs30tgb5Q5XJy9HyMh/RMrzoBuBIlFEMC3OqnNGNejZNGk0ligjpSCzHoAFY7
 2XvNnTpDG74yu2ihGLjc1bopAVSOK1LpuxEiHjyi+JG4Y9OMCxN6B4V4l/D7IgvMNHUfpHtw8
 OwTn5/mQQlYH8RLDPFPp8iFEw2sjFNr3FV9VOMPXxIA/h5EjrHDN0nJe97KKav5nsfhcFIGwq
 5GQC2jjP3FnfPjVr7Xbw/40qWEc07keVRgNkDvSSFY6aqHQrBwgf20XSrEx+FL8vaHYGIwkZN
 RtajnPydY7I2sK27l1UjNU+2KPzXg4pJUqZ3CATqEG8+o16nUrTtU3/cgA3EYMpyoDnt+PydO
 GsyxXfaSW0j7Y+OLF7NiQipb8DplNcuYewMSf6gLOMEdbFh1EAc46CVD7hpNLs5wvzXkbPDer
 Mt4zYKH6zmja18gWCmLaTzX2YfqzZ6+xUfzTs+uOSAj8r7yeJ8ELWDxekf1MyXYB4Rha17hAM
 HlDsfmo392wEfOUH5rDxjcwSwo6e827zmWIIR5QTp6vby/YDQ9ZQ867uSeHgBXvF5NAeKserh
 krqQ/B9HhnkONmjLg9HczNjwcLdoXNpOnfQntQRq+x0i4=

Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:

> Some recent Asus laptops are supporting ASUS Intelligent Performance
> Technology (AIPT). This solution allows users to have maximized CPU
> performance in models with a chassis providing more thermal head room.
> Refer to [1].
>
> There are major performance issues when Linux is installed on these
> laptops compared to Windows install. One such report is published for
> Graphics benchmarks on Asus ASUS Zenbook S 14 with Lunar Lake
> processors [2].
>
> By default, these laptops are booting in "Whisper Mode" till OS power
> management or tools change this to other AIPT mode. This "Whisper" mode
> calls to set lower maximum and minimum RAPL (Running Average Power Limit=
)
> via thermal tables. On Linux this leads to lower performance even when
> platform power profile is "balanced". This "Whisper" mode should
> correspond to "quiet" mode.
>
> So, when AIPT is present change the default mode to "Standard" during
> boot. Map the three platform power profile modes as follows:
>
> Power Profile Mode      AIPT mode
> -----------------------------------
> quiet			Whisper
> balanced		Standard
> performance		Performance
> ------------------------------------
>
> Here AIPT mode can be detected by checking presese of "FANL" method unde=
r
> PNP HID "PNP0C14" and UID "ATK". If AIPT mode is present, this takes
> precedence over the existing VIVO thermal policy. These modes are set
> using "FANL" method.
>
> Although this =E2=80=9CFANL=E2=80=9D method is not used in the Asus WMI =
driver, users
> have used this method from user space [3] to set AIPT modes. Used this
> as a reference.
>
> Link: https://www.asus.com/content/laptop-asus-intelligent-performance-t=
echnology-aipt/ # [1]
> Reported-by: Michael Larabel <Michael@phoronix.com>
> Closes: https://www.phoronix.com/review/lunar-lake-xe2/5 # [2]
> Link: https://github.com/dominiksalvet/asus-fan-control/issues/151 # [3]
> Tested-by: Casey Bowman <casey.g.bowman@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/platform/x86/asus-wmi.c | 93 +++++++++++++++++++++++++++++++--
>   1 file changed, 89 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus=
-wmi.c
> index 7a48220b4f5a..06689d0f98c7 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -100,6 +100,11 @@ module_param(fnlock_default, bool, 0444);
>   #define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO	1
>   #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
>
> +#define AIPT_STANDARD				0
> +#define AIPT_WHISPER				1
> +#define AIPT_PERFORMANCE			2
> +#define AIPT_FULL_SPEED				3
> +
>   #define PLATFORM_PROFILE_MAX 2
>
>   #define USB_INTEL_XUSB2PR		0xD0
> @@ -333,6 +338,9 @@ struct asus_wmi {
>   	struct asus_wmi_debug debug;
>
>   	struct asus_wmi_driver *driver;
> +	acpi_handle acpi_mgmt_handle;
> +	int asus_aipt_mode;
> +	bool asus_aipt_present;
>   };
>
>   /* WMI ***************************************************************=
*********/
> @@ -3804,6 +3812,19 @@ static ssize_t throttle_thermal_policy_store(stru=
ct device *dev,
>   static DEVICE_ATTR_RW(throttle_thermal_policy);
>
>   /* Platform profile **************************************************=
*********/
> +static int asus_wmi_write_aipt_mode(struct asus_wmi *asus, int aipt_mod=
e)
> +{
> +	int status;
> +
> +	status =3D acpi_execute_simple_method(asus->acpi_mgmt_handle, "FANL", =
aipt_mode);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_handle_info(asus->acpi_mgmt_handle, "FANL execute failed\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
>   static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus, in=
t mode)
>   {
>   	bool vivo;
> @@ -3844,6 +3865,26 @@ static int asus_wmi_platform_profile_mode_from_vi=
vo(struct asus_wmi *asus, int m
>   	return mode;
>   }
>
> +static int asus_wmi_aipt_platform_profile_get(struct asus_wmi *asus,
> +					      enum platform_profile_option *profile)
> +{
> +	switch (asus->asus_aipt_mode) {
> +	case AIPT_STANDARD:
> +		*profile =3D PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case AIPT_PERFORMANCE:
> +		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case AIPT_WHISPER:
> +		*profile =3D PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int asus_wmi_platform_profile_get(struct platform_profile_handl=
er *pprof,
>   					enum platform_profile_option *profile)
>   {
> @@ -3851,6 +3892,10 @@ static int asus_wmi_platform_profile_get(struct p=
latform_profile_handler *pprof,
>   	int tp;
>
>   	asus =3D container_of(pprof, struct asus_wmi, platform_profile_handle=
r);
> +
> +	if (asus->asus_aipt_present)
> +		return asus_wmi_aipt_platform_profile_get(asus, profile);
> +
>   	tp =3D asus->throttle_thermal_policy_mode;
>
>   	switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
> @@ -3874,26 +3919,42 @@ static int asus_wmi_platform_profile_set(struct =
platform_profile_handler *pprof,
>   					enum platform_profile_option profile)
>   {
>   	struct asus_wmi *asus;
> -	int tp;
> +	int ret =3D 0, tp, aipt_mode;
>
>   	asus =3D container_of(pprof, struct asus_wmi, platform_profile_handle=
r);
>
>   	switch (profile) {
>   	case PLATFORM_PROFILE_PERFORMANCE:
>   		tp =3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> +		aipt_mode =3D AIPT_PERFORMANCE;
>   		break;
>   	case PLATFORM_PROFILE_BALANCED:
>   		tp =3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> +		aipt_mode =3D AIPT_STANDARD;
>   		break;
>   	case PLATFORM_PROFILE_QUIET:
>   		tp =3D ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> +		aipt_mode =3D AIPT_WHISPER;
>   		break;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
>
> -	asus->throttle_thermal_policy_mode =3D asus_wmi_platform_profile_to_vi=
vo(asus, tp);
> -	return throttle_thermal_policy_write(asus);
> +	if (asus->asus_aipt_present) {
> +		ret =3D asus_wmi_write_aipt_mode(asus, aipt_mode);
> +		if (!ret) {
> +			asus->asus_aipt_mode =3D aipt_mode;
> +			goto skip_vivo;
> +		}
> +	}
> +
> +	if (asus->throttle_thermal_policy_dev) {
> +		asus->throttle_thermal_policy_mode =3D asus_wmi_platform_profile_to_v=
ivo(asus, tp);
> +		ret =3D throttle_thermal_policy_write(asus);
> +	}
> +
> +skip_vivo:
> +	return ret;
>   }
>
>   static int platform_profile_setup(struct asus_wmi *asus)
> @@ -3905,7 +3966,7 @@ static int platform_profile_setup(struct asus_wmi =
*asus)
>   	 * Not an error if a component platform_profile relies on is unavaila=
ble
>   	 * so early return, skipping the setup of platform_profile.
>   	 */
> -	if (!asus->throttle_thermal_policy_dev)
> +	if (!asus->throttle_thermal_policy_dev && !asus->asus_aipt_present)
>   		return 0;
>
>   	dev_info(dev, "Using throttle_thermal_policy for platform_profile sup=
port\n");
> @@ -4538,6 +4599,7 @@ static int asus_wmi_sysfs_init(struct platform_dev=
ice *device)
>   static int asus_wmi_platform_init(struct asus_wmi *asus)
>   {
>   	struct device *dev =3D &asus->platform_device->dev;
> +	struct acpi_device *adev;
>   	char *wmi_uid;
>   	int rv;
>
> @@ -4593,6 +4655,29 @@ static int asus_wmi_platform_init(struct asus_wmi=
 *asus)
>   		asus_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
>   				      asus->driver->quirks->wapf, NULL);
>
> +	/*
> +	 * Check presence of Intelligent Performance Technology (AIPT).
> +	 * If present store acpi handle and set asus_aipt_present to true.
> +	 */
> +	adev =3D acpi_dev_get_first_match_dev("PNP0C14", "ATK", -1);

Is there really no way of changing the AIPT mode through the WMI interface=
?
I would prefer using the WMI interface if available, since the firmware mi=
ght
assume that FANL is only called through the WMI interface.

Do you have a acpidump from a affected device?

Thanks,
Armin Wolf

> +	if (adev) {
> +		acpi_handle handle =3D acpi_device_handle(adev);
> +
> +		acpi_dev_put(adev);
> +
> +		if (!acpi_has_method(handle, "FANL"))
> +			return 0;
> +
> +		asus->acpi_mgmt_handle =3D handle;
> +		asus->asus_aipt_present =3D true;
> +		dev_info(dev, "ASUS Intelligent Performance Technology (AIPT) is pres=
ent\n");
> +		/*
> +		 * Set the mode corresponding to default Linux platform power
> +		 * profile Balanced
> +		 */
> +		asus_wmi_write_aipt_mode(asus, AIPT_STANDARD);
> +	}
> +
>   	return 0;
>   }
>

