Return-Path: <linux-kernel+bounces-516465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A65A3721F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 06:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15EE1886EE4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 05:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1A149C6F;
	Sun, 16 Feb 2025 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="QcJ1dXVV"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7B7290F;
	Sun, 16 Feb 2025 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739684429; cv=none; b=X7ceTVcbOIzjgoC/ech0svOrdg2IWrB/RU6NORXPgkNcfD0u/2ANNveCIKj+rFzsdOuKgqVQY7DbsahUacg0B3pd5AEi1IB5KVmxg44VJL90TAOH+AQW4st3IlY9BgndKQB4WLFMIdarIjYcTZz19sNiJt233+V09Eng8LqUAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739684429; c=relaxed/simple;
	bh=dthwI+5s++ur547uQviTWNRNUqZVJLq91QsxHDLuDTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJzhRu63QLzbJgf4IHFJcErCPqeQxlwDhzhPJ7D2ax0Ngfn5b2zm53m58Pem4iDfOrzw7d+nSmM3vYmOQ+Bzmk2e8B5MvdRm4LIUZ1QswtmASC99fbUzJCsPrG/qaWsbjPcSNelYxuaigWr/4wv9bD3YpT9yim/aYkf3D8E4qx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=QcJ1dXVV; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739684418; x=1740289218; i=w_armin@gmx.de;
	bh=ASPJLLBf1TAeTMn1mIyRs4eYimlXUqosk+J+ExxgxS4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QcJ1dXVVhgFocFGgaJU+REm5FXYHe3uNwlEuE4nhPsjq5f51Q21yZ8mbq7kbIHim
	 zWKgTy6FXtfv3ANysFf3CuezcBC0tjc5BzGlwilM8oVxJ83M3lByfaY5qC/BhYp3i
	 deoM4r74YowSJqTQfhZ+6D5NMW2ajIAGhrlFnT/RvHw4bmH0C87LuQjt2XOsfc2QO
	 IFNOutuvshbQ+tYO9Fe7TRsdVj2JfzUAJ8+GBV7lAezkCTzc954LzO9y5ilYI4HVM
	 DleU54T+1V2G8xp1/eeN3b+S7q//Tw8gScRZvjotl/3lE3+Dxzn3p0Pan+fPhCbYp
	 vfH5hSIyHJGkygA6Cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYv3-1tUTNa3w43-00zDbR; Sun, 16
 Feb 2025 06:40:18 +0100
Message-ID: <dd35f587-20fd-4ff0-8876-f1ea83346e1f@gmx.de>
Date: Sun, 16 Feb 2025 06:40:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] platform/x86: alienware-wmi-wmax: Rename thermal
 related symbols
To: Kurt Borja <kuurtb@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org
References: <20250208051614.10644-1-kuurtb@gmail.com>
 <20250208051614.10644-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250208051614.10644-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oceYzuGORcYmHsOvmtDh+sLENCYXLswLfwISKvBlUEjSIRg9wHk
 9M2FHAb9B3OXcggG01GgO6AjJ8Cd7+AA8uKwUSsS/RCohQxVVNZSec+xMuFRXj83d6p7TyI
 FPREKS+3U8akuCuachOhDzubIqtNZlY7m8qZqe2GV2cikl3Mewy8cPyPQQc8XxpErpW9dhy
 T5X3xyp2HhLVA0CedMWkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W+GO38cbN+E=;EZqGtS3oaOH8z5WHkFHSlmY9Jyw
 ruTxLSmYoB5aSSLT1nxuo3WHsSjDmiC/V8CgcALWnC79szW1RnvhftyFHkt2kGSR1xt/xTDWn
 F4CF6XDZ1btgtIXuDlKNiAXiOcA7QaIZHCSVm4Cw/MJVkudSvd+7XP+bYlRJ3eOSCYFul80P3
 tBOrUVK1m6yIy/ze0GMpzbxqDki5QEpB51bqQubqgAdhLvPFAZPyZ1TCG+ArhTe1OcC876xmW
 nVlDJg4vZzU1aOG70UrH3zyFkKmD9rKD9pGui72NXLrDACw84L6UcbWKm2Qa9NkocjDtPVxYM
 4g9Dlp6E2+rRmtJOz3tgBwPshqLTyBGVaVSFQ603joV5N45N+zrQk0WIPBVkt+E7VyHtYZEvs
 NK+kNSPcgQAP+pMOt0FKfZEPd6Mgux11K5FBt0uA1oO0X+wNJH92xcxPW5OYemBj9Mrco5G8K
 5USHXG+T3Td81n/QiqikE+YuPJ62w+nRe2W8imBf+XnkrFR/jwgHel/BPE/9mM2u2bq2DydtV
 +boJ/daqFXNfoBQM0yyGE/oUAxEc5nHb0+kuIom/s8i9IBuRscW0RP9FWgnR46DTWACJNDySa
 h0Tu1VbOHD5/khCce/fPmf/CVpVvxVaL/ZUEhgOnZdnZDM7NJ8aCqPsGMoyXoLKt5kLcuyzFU
 81VR1tLAOtIgCL+FAG6a+4EiVw9C+CcXJTLlaMaq0dibYmkgKIaUXi9uKg1REzkVihLaWyZmh
 k5gBAcMRTCwkaMXkqfBOWnRnCqzErwi8/elXqi/0A/rK1WffQg1ZNskT2NSLiSY9RWEu4puA0
 /ycRIcVlK0pgOtYEnWZcSHViAMhlWCpUsK6rkR+wgYethMt4DiyXzESFWBGkYFG9ts83iKQ4I
 rD3pWeYyXQTElQxNlHWDdB8iDYTBswYj3tCBpGXvLZnG4ci+Q/rKx/K9mGuqmNYCkVE9fEaTL
 m0S9q27/pyfaPJzdGBsyaRNylyhhF8DD5QNEX6hLM5jP7QQcBhFGWA/VU7xDMSVrcA5ScFsnL
 Beb89nm46hx1QON2Vav/RhfuUg/36ORuAeffEdizzdxhxvbsMDLRyntuh+DXf6eZTZ7HeBMNE
 HqW35h/NQZW1Wm+0NACfg9P/WZlRc68bK8ABOZ+E1xKvuqrEKKQ9bL6pmjsv/UwmMmOalS+t5
 N76GUgaAg0UDp7Sb8zrp+qncKxI5mEZdRAeymZC/ut4JQ0//zswOkx36GCsWnf/Gvs2hryoXH
 XvJDxt+5FLzmbJ9qPWMp+Gj6Eut+71dB3K5vjrfviZygp6LCgwFyRZJnRIUnyprzEHZj2dzQ+
 XCg7IBciJTT/Rchv3UNnpD4JlhGf17x/I5tlfxenrjsaVIdl9psW5QXKAogmAXj5fI8ezt5CK
 KmAJaJjQU3XFiEubQdH4CqqctGNC3NvvS7b+bwS7TMvtda9GBwDks55J0W

Am 08.02.25 um 06:16 schrieb Kurt Borja:

> The "thermal" features of the WMAX WMI device are only present on the
> host device if the ACPI _UID is "AWCC". Replace WMAX prefixes with
> "AWCC" to reflect this relationship.
>
> Thermal profiles with WMAX_PROFILE_BASIC prefix are also renamed to
> WMAX_PROFILE_LEGACY because they are only supported in older versions
> of this WMI device.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   .../platform/x86/dell/alienware-wmi-wmax.c    | 173 +++++++++---------
>   1 file changed, 87 insertions(+), 86 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/pl=
atform/x86/dell/alienware-wmi-wmax.c
> index 3d3014b5adf0..ed70e12d73d7 100644
> --- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
> +++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
> @@ -24,16 +24,17 @@
>   #define WMAX_METHOD_DEEP_SLEEP_STATUS		0x0C
>   #define WMAX_METHOD_BRIGHTNESS			0x3
>   #define WMAX_METHOD_ZONE_CONTROL		0x4
> -#define WMAX_METHOD_THERMAL_INFORMATION		0x14
> -#define WMAX_METHOD_THERMAL_CONTROL		0x15
> -#define WMAX_METHOD_GAME_SHIFT_STATUS		0x25
>
> -#define WMAX_THERMAL_MODE_GMODE			0xAB
> +#define AWCC_METHOD_THERMAL_INFORMATION		0x14
> +#define AWCC_METHOD_THERMAL_CONTROL		0x15
> +#define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
>
> -#define WMAX_FAILURE_CODE			0xFFFFFFFF
> -#define WMAX_THERMAL_TABLE_MASK			GENMASK(7, 4)
> -#define WMAX_THERMAL_MODE_MASK			GENMASK(3, 0)
> -#define WMAX_SENSOR_ID_MASK			BIT(8)
> +#define AWCC_THERMAL_MODE_GMODE			0xAB
> +
> +#define AWCC_FAILURE_CODE			0xFFFFFFFF
> +#define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
> +#define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
> +#define AWCC_SENSOR_ID_MASK			BIT(8)
>
>   static bool force_platform_profile;
>   module_param_unsafe(force_platform_profile, bool, 0);
> @@ -151,38 +152,38 @@ static const struct dmi_system_id awcc_dmi_table[]=
 __initconst =3D {
>   	},
>   };
>
> -enum WMAX_THERMAL_INFORMATION_OPERATIONS {
> -	WMAX_OPERATION_SYS_DESCRIPTION		=3D 0x02,
> -	WMAX_OPERATION_LIST_IDS			=3D 0x03,
> -	WMAX_OPERATION_CURRENT_PROFILE		=3D 0x0B,
> +enum AWCC_THERMAL_INFORMATION_OPERATIONS {
> +	AWCC_OP_GET_SYSTEM_DESCRIPTION		=3D 0x02,
> +	AWCC_OP_GET_RESOURCE_ID			=3D 0x03,
> +	AWCC_OP_GET_CURRENT_PROFILE		=3D 0x0B,
>   };
>
> -enum WMAX_THERMAL_CONTROL_OPERATIONS {
> -	WMAX_OPERATION_ACTIVATE_PROFILE		=3D 0x01,
> +enum AWCC_THERMAL_CONTROL_OPERATIONS {
> +	AWCC_OP_ACTIVATE_PROFILE		=3D 0x01,
>   };
>
> -enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
> -	WMAX_OPERATION_TOGGLE_GAME_SHIFT	=3D 0x01,
> -	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	=3D 0x02,
> +enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
> +	AWCC_OP_TOGGLE_GAME_SHIFT		=3D 0x01,
> +	AWCC_OP_GET_GAME_SHIFT_STATUS		=3D 0x02,
>   };
>
> -enum WMAX_THERMAL_TABLES {
> -	WMAX_THERMAL_TABLE_BASIC		=3D 0x90,
> -	WMAX_THERMAL_TABLE_USTT			=3D 0xA0,
> +enum AWCC_THERMAL_TABLES {
> +	AWCC_THERMAL_TABLE_LEGACY		=3D 0x90,
> +	AWCC_THERMAL_TABLE_USTT			=3D 0xA0,
>   };
>
> -enum wmax_thermal_mode {
> -	THERMAL_MODE_USTT_BALANCED,
> -	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
> -	THERMAL_MODE_USTT_COOL,
> -	THERMAL_MODE_USTT_QUIET,
> -	THERMAL_MODE_USTT_PERFORMANCE,
> -	THERMAL_MODE_USTT_LOW_POWER,
> -	THERMAL_MODE_BASIC_QUIET,
> -	THERMAL_MODE_BASIC_BALANCED,
> -	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
> -	THERMAL_MODE_BASIC_PERFORMANCE,
> -	THERMAL_MODE_LAST,
> +enum awcc_thermal_profile {
> +	AWCC_PROFILE_USTT_BALANCED,
> +	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
> +	AWCC_PROFILE_USTT_COOL,
> +	AWCC_PROFILE_USTT_QUIET,
> +	AWCC_PROFILE_USTT_PERFORMANCE,
> +	AWCC_PROFILE_USTT_LOW_POWER,
> +	AWCC_PROFILE_LEGACY_QUIET,
> +	AWCC_PROFILE_LEGACY_BALANCED,
> +	AWCC_PROFILE_LEGACY_BALANCED_PERFORMANCE,
> +	AWCC_PROFILE_LEGACY_PERFORMANCE,
> +	AWCC_PROFILE_LAST,
>   };
>
>   struct wmax_led_args {
> @@ -210,20 +211,20 @@ struct wmax_u32_args {
>   struct awcc_priv {
>   	struct wmi_device *wdev;
>   	struct device *ppdev;
> -	enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAS=
T];
> +	enum awcc_thermal_profile supported_thermal_profiles[PLATFORM_PROFILE_=
LAST];
>   };
>
> -static const enum platform_profile_option wmax_mode_to_platform_profile=
[THERMAL_MODE_LAST] =3D {
> -	[THERMAL_MODE_USTT_BALANCED]			=3D PLATFORM_PROFILE_BALANCED,
> -	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	=3D PLATFORM_PROFILE_BALANCED=
_PERFORMANCE,
> -	[THERMAL_MODE_USTT_COOL]			=3D PLATFORM_PROFILE_COOL,
> -	[THERMAL_MODE_USTT_QUIET]			=3D PLATFORM_PROFILE_QUIET,
> -	[THERMAL_MODE_USTT_PERFORMANCE]			=3D PLATFORM_PROFILE_PERFORMANCE,
> -	[THERMAL_MODE_USTT_LOW_POWER]			=3D PLATFORM_PROFILE_LOW_POWER,
> -	[THERMAL_MODE_BASIC_QUIET]			=3D PLATFORM_PROFILE_QUIET,
> -	[THERMAL_MODE_BASIC_BALANCED]			=3D PLATFORM_PROFILE_BALANCED,
> -	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	=3D PLATFORM_PROFILE_BALANCE=
D_PERFORMANCE,
> -	[THERMAL_MODE_BASIC_PERFORMANCE]		=3D PLATFORM_PROFILE_PERFORMANCE,
> +static const enum platform_profile_option awcc_mode_to_platform_profile=
[AWCC_PROFILE_LAST] =3D {
> +	[AWCC_PROFILE_USTT_BALANCED]			=3D PLATFORM_PROFILE_BALANCED,
> +	[AWCC_PROFILE_USTT_BALANCED_PERFORMANCE]	=3D PLATFORM_PROFILE_BALANCED=
_PERFORMANCE,
> +	[AWCC_PROFILE_USTT_COOL]			=3D PLATFORM_PROFILE_COOL,
> +	[AWCC_PROFILE_USTT_QUIET]			=3D PLATFORM_PROFILE_QUIET,
> +	[AWCC_PROFILE_USTT_PERFORMANCE]			=3D PLATFORM_PROFILE_PERFORMANCE,
> +	[AWCC_PROFILE_USTT_LOW_POWER]			=3D PLATFORM_PROFILE_LOW_POWER,
> +	[AWCC_PROFILE_LEGACY_QUIET]			=3D PLATFORM_PROFILE_QUIET,
> +	[AWCC_PROFILE_LEGACY_BALANCED]			=3D PLATFORM_PROFILE_BALANCED,
> +	[AWCC_PROFILE_LEGACY_BALANCED_PERFORMANCE]	=3D PLATFORM_PROFILE_BALANC=
ED_PERFORMANCE,
> +	[AWCC_PROFILE_LEGACY_PERFORMANCE]		=3D PLATFORM_PROFILE_PERFORMANCE,
>   };
>
>   static struct awcc_quirks *awcc;
> @@ -444,26 +445,26 @@ const struct attribute_group wmax_deepsleep_attrib=
ute_group =3D {
>    * Thermal Profile control
>    *  - Provides thermal profile control through the Platform Profile AP=
I
>    */
> -static bool is_wmax_thermal_code(u32 code)
> +static bool is_awcc_thermal_mode(u32 code)
>   {
> -	if (code & WMAX_SENSOR_ID_MASK)
> +	if (code & AWCC_SENSOR_ID_MASK)
>   		return false;
>
> -	if ((code & WMAX_THERMAL_MODE_MASK) >=3D THERMAL_MODE_LAST)
> +	if ((code & AWCC_THERMAL_MODE_MASK) >=3D AWCC_PROFILE_LAST)
>   		return false;
>
> -	if ((code & WMAX_THERMAL_TABLE_MASK) =3D=3D WMAX_THERMAL_TABLE_BASIC &=
&
> -	    (code & WMAX_THERMAL_MODE_MASK) >=3D THERMAL_MODE_BASIC_QUIET)
> +	if ((code & AWCC_THERMAL_TABLE_MASK) =3D=3D AWCC_THERMAL_TABLE_LEGACY =
&&
> +	    (code & AWCC_THERMAL_MODE_MASK) >=3D AWCC_PROFILE_LEGACY_QUIET)
>   		return true;
>
> -	if ((code & WMAX_THERMAL_TABLE_MASK) =3D=3D WMAX_THERMAL_TABLE_USTT &&
> -	    (code & WMAX_THERMAL_MODE_MASK) <=3D THERMAL_MODE_USTT_LOW_POWER)
> +	if ((code & AWCC_THERMAL_TABLE_MASK) =3D=3D AWCC_THERMAL_TABLE_USTT &&
> +	    (code & AWCC_THERMAL_MODE_MASK) <=3D AWCC_PROFILE_USTT_LOW_POWER)
>   		return true;
>
>   	return false;
>   }
>
> -static int wmax_thermal_information(struct wmi_device *wdev, u8 operati=
on,
> +static int awcc_thermal_information(struct wmi_device *wdev, u8 operati=
on,
>   				    u8 arg, u32 *out_data)
>   {
>   	struct wmax_u32_args in_args =3D {
> @@ -474,21 +475,21 @@ static int wmax_thermal_information(struct wmi_dev=
ice *wdev, u8 operation,
>   	};
>   	int ret;
>
> -	ret =3D alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_INFORMATION,
> +	ret =3D alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION,
>   				    &in_args, sizeof(in_args), out_data);
>   	if (ret < 0)
>   		return ret;
>
> -	if (*out_data =3D=3D WMAX_FAILURE_CODE)
> +	if (*out_data =3D=3D AWCC_FAILURE_CODE)
>   		return -EBADRQC;
>
>   	return 0;
>   }
>
> -static int wmax_thermal_control(struct wmi_device *wdev, u8 profile)
> +static int awcc_thermal_control(struct wmi_device *wdev, u8 profile)
>   {
>   	struct wmax_u32_args in_args =3D {
> -		.operation =3D WMAX_OPERATION_ACTIVATE_PROFILE,
> +		.operation =3D AWCC_OP_ACTIVATE_PROFILE,
>   		.arg1 =3D profile,
>   		.arg2 =3D 0,
>   		.arg3 =3D 0,
> @@ -496,18 +497,18 @@ static int wmax_thermal_control(struct wmi_device =
*wdev, u8 profile)
>   	u32 out_data;
>   	int ret;
>
> -	ret =3D alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_CONTROL,
> +	ret =3D alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL,
>   				    &in_args, sizeof(in_args), &out_data);
>   	if (ret)
>   		return ret;
>
> -	if (out_data =3D=3D WMAX_FAILURE_CODE)
> +	if (out_data =3D=3D AWCC_FAILURE_CODE)
>   		return -EBADRQC;
>
>   	return 0;
>   }
>
> -static int wmax_game_shift_status(struct wmi_device *wdev, u8 operation=
,
> +static int awcc_game_shift_status(struct wmi_device *wdev, u8 operation=
,
>   				  u32 *out_data)
>   {
>   	struct wmax_u32_args in_args =3D {
> @@ -518,46 +519,46 @@ static int wmax_game_shift_status(struct wmi_devic=
e *wdev, u8 operation,
>   	};
>   	int ret;
>
> -	ret =3D alienware_wmi_command(wdev, WMAX_METHOD_GAME_SHIFT_STATUS,
> +	ret =3D alienware_wmi_command(wdev, AWCC_METHOD_GAME_SHIFT_STATUS,
>   				    &in_args, sizeof(in_args), out_data);
>   	if (ret < 0)
>   		return ret;
>
> -	if (*out_data =3D=3D WMAX_FAILURE_CODE)
> +	if (*out_data =3D=3D AWCC_FAILURE_CODE)
>   		return -EOPNOTSUPP;
>
>   	return 0;
>   }
>
> -static int thermal_profile_get(struct device *dev,
> -			       enum platform_profile_option *profile)
> +static int awcc_platform_profile_get(struct device *dev,
> +				     enum platform_profile_option *profile)
>   {
>   	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>   	u32 out_data;
>   	int ret;
>
> -	ret =3D wmax_thermal_information(priv->wdev, WMAX_OPERATION_CURRENT_PR=
OFILE,
> +	ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_CURRENT_PROFI=
LE,
>   				       0, &out_data);
>
>   	if (ret < 0)
>   		return ret;
>
> -	if (out_data =3D=3D WMAX_THERMAL_MODE_GMODE) {
> +	if (out_data =3D=3D AWCC_THERMAL_MODE_GMODE) {
>   		*profile =3D PLATFORM_PROFILE_PERFORMANCE;
>   		return 0;
>   	}
>
> -	if (!is_wmax_thermal_code(out_data))
> +	if (!is_awcc_thermal_mode(out_data))
>   		return -ENODATA;
>
> -	out_data &=3D WMAX_THERMAL_MODE_MASK;
> -	*profile =3D wmax_mode_to_platform_profile[out_data];
> +	out_data &=3D AWCC_THERMAL_MODE_MASK;
> +	*profile =3D awcc_mode_to_platform_profile[out_data];
>
>   	return 0;
>   }
>
> -static int thermal_profile_set(struct device *dev,
> -			       enum platform_profile_option profile)
> +static int awcc_platform_profile_set(struct device *dev,
> +				     enum platform_profile_option profile)
>   {
>   	struct awcc_priv *priv =3D dev_get_drvdata(dev);
>
> @@ -565,8 +566,8 @@ static int thermal_profile_set(struct device *dev,
>   		u32 gmode_status;
>   		int ret;
>
> -		ret =3D wmax_game_shift_status(priv->wdev,
> -					     WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
> +		ret =3D awcc_game_shift_status(priv->wdev,
> +					     AWCC_OP_GET_GAME_SHIFT_STATUS,
>   					     &gmode_status);
>
>   		if (ret < 0)
> @@ -574,8 +575,8 @@ static int thermal_profile_set(struct device *dev,
>
>   		if ((profile =3D=3D PLATFORM_PROFILE_PERFORMANCE && !gmode_status) |=
|
>   		    (profile !=3D PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
> -			ret =3D wmax_game_shift_status(priv->wdev,
> -						     WMAX_OPERATION_TOGGLE_GAME_SHIFT,
> +			ret =3D awcc_game_shift_status(priv->wdev,
> +						     AWCC_OP_TOGGLE_GAME_SHIFT,
>   						     &gmode_status);
>
>   			if (ret < 0)
> @@ -583,21 +584,21 @@ static int thermal_profile_set(struct device *dev,
>   		}
>   	}
>
> -	return wmax_thermal_control(priv->wdev,
> +	return awcc_thermal_control(priv->wdev,
>   				    priv->supported_thermal_profiles[profile]);
>   }
>
> -static int thermal_profile_probe(void *drvdata, unsigned long *choices)
> +static int awcc_platform_profile_probe(void *drvdata, unsigned long *ch=
oices)
>   {
>   	enum platform_profile_option profile;
>   	struct awcc_priv *priv =3D drvdata;
> -	enum wmax_thermal_mode mode;
> +	enum awcc_thermal_profile mode;
>   	u8 sys_desc[4];
>   	u32 first_mode;
>   	u32 out_data;
>   	int ret;
>
> -	ret =3D wmax_thermal_information(priv->wdev, WMAX_OPERATION_SYS_DESCRI=
PTION,
> +	ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRI=
PTION,
>   				       0, (u32 *) &sys_desc);
>   	if (ret < 0)
>   		return ret;
> @@ -605,7 +606,7 @@ static int thermal_profile_probe(void *drvdata, unsi=
gned long *choices)
>   	first_mode =3D sys_desc[0] + sys_desc[1];
>
>   	for (u32 i =3D 0; i < sys_desc[3]; i++) {
> -		ret =3D wmax_thermal_information(priv->wdev, WMAX_OPERATION_LIST_IDS,
> +		ret =3D awcc_thermal_information(priv->wdev, AWCC_OP_GET_RESOURCE_ID,
>   					       i + first_mode, &out_data);
>
>   		if (ret =3D=3D -EIO)
> @@ -614,11 +615,11 @@ static int thermal_profile_probe(void *drvdata, un=
signed long *choices)
>   		if (ret =3D=3D -EBADRQC)
>   			break;
>
> -		if (!is_wmax_thermal_code(out_data))
> +		if (!is_awcc_thermal_mode(out_data))
>   			continue;
>
> -		mode =3D out_data & WMAX_THERMAL_MODE_MASK;
> -		profile =3D wmax_mode_to_platform_profile[mode];
> +		mode =3D out_data & AWCC_THERMAL_MODE_MASK;
> +		profile =3D awcc_mode_to_platform_profile[mode];
>   		priv->supported_thermal_profiles[profile] =3D out_data;
>
>   		set_bit(profile, choices);
> @@ -629,7 +630,7 @@ static int thermal_profile_probe(void *drvdata, unsi=
gned long *choices)
>
>   	if (awcc->gmode) {
>   		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =3D
> -			WMAX_THERMAL_MODE_GMODE;
> +			AWCC_THERMAL_MODE_GMODE;
>
>   		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
>   	}
> @@ -638,9 +639,9 @@ static int thermal_profile_probe(void *drvdata, unsi=
gned long *choices)
>   }
>
>   static const struct platform_profile_ops awcc_platform_profile_ops =3D=
 {
> -	.probe =3D thermal_profile_probe,
> -	.profile_get =3D thermal_profile_get,
> -	.profile_set =3D thermal_profile_set,
> +	.probe =3D awcc_platform_profile_probe,
> +	.profile_get =3D awcc_platform_profile_get,
> +	.profile_set =3D awcc_platform_profile_set,
>   };
>
>   static int awcc_platform_profile_init(struct wmi_device *wdev)

