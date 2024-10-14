Return-Path: <linux-kernel+bounces-364436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D081999D49D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F90287CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129161B4F0B;
	Mon, 14 Oct 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="i+CXAf+4"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8C28FC;
	Mon, 14 Oct 2024 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923217; cv=none; b=ZUvIqcN8r/Aw5WXZUh2TLLrmWGzPw3BeyIe9I8wE0vDdCoHqtwhPTdovNX9hhk/1hOwwYE84IJYJ3ZRxLs0Zdcla0J1p3jrNAxMPqh7gpEhPLP75N13rNJmz4jZcCFUJNIMWGC1dRiO/01zsGxW8kIRTdSchGiPJVAhGsk4U9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923217; c=relaxed/simple;
	bh=U30A7BPRrbdyRUqaxjptAW19OsPSGOMJiYV+YtVSQCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAhLDccXobehnYBSTEUrOoyGkcCBeQWbMMXuDHJHnTtSSB95Oh3P1nFFLfRJ3MjgPKY1FmlezUVakLcgc22jX7dN0madYGezetyU7/q7mlU40klzWpOlL6wF4Qyk73sjjyDyMA4ZPOjsnAZ7BUHDJiv5OBJxsADKWOdsVHQyAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=i+CXAf+4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728923206; x=1729528006; i=w_armin@gmx.de;
	bh=NGewo8lqX5cHCvf2WJySa3l6Ye+MnvpY5Dy5n+Z+GY0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i+CXAf+42eaUTdvC1UV9ajGhWRVFsSfq41gHFt1z3l+skfvNFXWCSyD9LRbYzpHd
	 fijSyN9jdm5NOj23Csw5sh1vWnQk2Fd6vYfWmsmtsoeo5z0ITPFtAmJxpMiVVmF/y
	 mXgJMjv0L74gTuHKiRI2EKqzydxQd9GL7U2Uj283PV+ddZTkoq+H8s9Av7Rtnqty3
	 lmLLfThsXIotEGxeN+GpO0Nlcn+RZaPv7lYVOGRe3TtDaSRFZL2bqGTVmQ8bfPV/c
	 5RifKCjdPX0B7jiIZzivPRGLHsMCM0smVFwD+wdOS293dQpQTxBsmJtR3iNMF5azH
	 5cx96KLLKmMaOuNSoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1u0MGD3EJf-015HdX; Mon, 14
 Oct 2024 18:26:46 +0200
Message-ID: <2d685783-aef8-4774-b67c-8a8736b5a477@gmx.de>
Date: Mon, 14 Oct 2024 18:26:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] alienware-wmi: fixed indentation and clean up
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241012015849.19036-3-kuurtb@gmail.com>
 <20241012020124.19444-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241012020124.19444-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CEW9GjiaopWCsE9NtCF6TATRM0exmFfmxrQ0qODseC4sc3B4NGQ
 7O3oOcagj0lP188n7vIPrXQ6+uP18LTQBZwmiKPCsn3wJjmoetNuC/rdmOwXRHXzj/Z9qCd
 4iopjNjBwpF3cU9BEHuZqvbPAUVjxGpK7kE5i+mB8vq3WENAITGP08djt1uJl7LdW01hjWB
 Adib85yBSvDUnQ5O/jlSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rH/mVFQuNjA=;vynIc65mjijJv/iqq5hgSql3mAK
 uopkBKLRlh5RfzsUYUY0/KqQGsR4WMv2DJnGbx1LalCdVSbd3zJ32x4YKeYNF/nE1M53iVSad
 XBt+iaJ5wz0YDIy6aqVTpPt4PBCa0wjF1RfRFOOxNf27fzO/k9K77XQkpJEVYrgJP/uGX4K0H
 27dUtvuLu54kD3v9mLx3Rs/pw1u4F60UjMCqS2uBtWD031pffGXJdYfQmrKANADiML+s3SlhC
 nWK9fYI6Y0vvPjEqUgraDQREc0Ju4E3lymr2hU9ixIZgkzFP6bXRxPF+qDoO4HTN5R2aDpV2t
 KTjIUZfaTDRZ9TNUfXDVNIth6pTvUxR0w6f9JDvbycDiZMKahJNsbL1mAJkr5fzTiMqele0Rl
 Ds4eIBXydYUdj+uSoJSVIilGgCy9i8hb/XlmlhP9XlXyLhEdZgvbY2ODbJYDj+XYyr4tK2IHK
 OOon6JwbFlCC7jw5fD7AZrAC6cLIVlZPfMLBcHKzLkZWyWxkhPrdaF9GUiZrqQAw3CcKXZRNd
 e/+YnQUtiAMaHHEmxMKFWxoc5YN8qhS09xVx9NePJkAteCNc4yr5JpNpWokPkHXP/NL3rKrIG
 jLql6W0qT28AXIrOQUCmygIQ0UIIM0aZ63DpnUAj9b9H7jpg9UuZy5H9m3ll1srj5UJfUco0K
 fFvV8gInCkb30bK03d0xR3RGUGrffx2n2nI3S+4VQIlwywaq+PJoP6gjs9rDTGOSA8zDKR+Sk
 tdnDbaTsvmlI+ovJnu/U30m8Qe7Y7LVApASUV4AqNESxGbxGPxJKHWdMV6S9FagMqPqabN2ht
 +HBSTZSCGR4dLx8Xgg9o3fkw==

Am 12.10.24 um 04:01 schrieb Kurt Borja:

> Fixed inconsistent indentation and removed unnecessary (acpi_size) and
> (u32 *) casts.

Reviewed-by: Armin Wolf <W_Armin@gmx.de

>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 134 +++++++++++-----------
>   1 file changed, 67 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index f5ee62ce1..16a3fe9ac 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -116,68 +116,68 @@ static int __init dmi_matched(const struct dmi_sys=
tem_id *dmi)
>
>   static const struct dmi_system_id alienware_quirks[] __initconst =3D {
>   	{
> -	 .callback =3D dmi_matched,
> -	 .ident =3D "Alienware X51 R3",
> -	 .matches =3D {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
> -		     },
> -	 .driver_data =3D &quirk_x51_r3,
> -	 },
> +		.callback =3D dmi_matched,
> +		.ident =3D "Alienware X51 R3",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
> +		},
> +		.driver_data =3D &quirk_x51_r3,
> +	},
>   	{
> -	 .callback =3D dmi_matched,
> -	 .ident =3D "Alienware X51 R2",
> -	 .matches =3D {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
> -		     },
> -	 .driver_data =3D &quirk_x51_r1_r2,
> -	 },
> +		.callback =3D dmi_matched,
> +		.ident =3D "Alienware X51 R2",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
> +		},
> +		.driver_data =3D &quirk_x51_r1_r2,
> +	},
>   	{
> -	 .callback =3D dmi_matched,
> -	 .ident =3D "Alienware X51 R1",
> -	 .matches =3D {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
> -		     },
> -	 .driver_data =3D &quirk_x51_r1_r2,
> -	 },
> +		.callback =3D dmi_matched,
> +		.ident =3D "Alienware X51 R1",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
> +		},
> +		.driver_data =3D &quirk_x51_r1_r2,
> +	},
>   	{
> -	 .callback =3D dmi_matched,
> -	 .ident =3D "Alienware ASM100",
> -	 .matches =3D {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
> -		     },
> -	 .driver_data =3D &quirk_asm100,
> -	 },
> +		.callback =3D dmi_matched,
> +		.ident =3D "Alienware ASM100",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
> +		},
> +		.driver_data =3D &quirk_asm100,
> +	},
>   	{
> -	 .callback =3D dmi_matched,
> -	 .ident =3D "Alienware ASM200",
> -	 .matches =3D {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
> -		     },
> -	 .driver_data =3D &quirk_asm200,
> -	 },
> +		.callback =3D dmi_matched,
> +		.ident =3D "Alienware ASM200",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
> +		},
> +		.driver_data =3D &quirk_asm200,
> +	},
>   	{
> -	 .callback =3D dmi_matched,
> -	 .ident =3D "Alienware ASM201",
> -	 .matches =3D {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
> -		     },
> -	 .driver_data =3D &quirk_asm201,
> -	 },
> -	 {
> -	 .callback =3D dmi_matched,
> -	 .ident =3D "Dell Inc. Inspiron 5675",
> -	 .matches =3D {
> -		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -		     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
> -		     },
> -	 .driver_data =3D &quirk_inspiron5675,
> -	 },
> +		.callback =3D dmi_matched,
> +		.ident =3D "Alienware ASM201",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
> +		},
> +		.driver_data =3D &quirk_asm201,
> +	},
> +	{
> +		.callback =3D dmi_matched,
> +		.ident =3D "Dell Inc. Inspiron 5675",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
> +		},
> +		.driver_data =3D &quirk_inspiron5675,
> +	},
>   	{}
>   };
>
> @@ -221,8 +221,8 @@ static struct platform_zone *zone_data;
>
>   static struct platform_driver platform_driver =3D {
>   	.driver =3D {
> -		   .name =3D "alienware-wmi",
> -		   }
> +		.name =3D "alienware-wmi",
> +	}
>   };
>
>   static struct attribute_group zone_attribute_group =3D {
> @@ -292,7 +292,7 @@ static int alienware_update_led(struct platform_zone=
 *zone)
>   		guid =3D WMAX_CONTROL_GUID;
>   		method_id =3D WMAX_METHOD_ZONE_CONTROL;
>
> -		input.length =3D (acpi_size) sizeof(wmax_basic_args);
> +		input.length =3D sizeof(wmax_basic_args);
>   		input.pointer =3D &wmax_basic_args;
>   	} else {
>   		legacy_args.colors =3D zone->colors;
> @@ -306,7 +306,7 @@ static int alienware_update_led(struct platform_zone=
 *zone)
>   			guid =3D LEGACY_CONTROL_GUID;
>   		method_id =3D zone->location + 1;
>
> -		input.length =3D (acpi_size) sizeof(legacy_args);
> +		input.length =3D sizeof(legacy_args);
>   		input.pointer =3D &legacy_args;
>   	}
>   	pr_debug("alienware-wmi: guid %s method %d\n", guid, method_id);
> @@ -358,7 +358,7 @@ static int wmax_brightness(int brightness)
>   		.led_mask =3D 0xFF,
>   		.percentage =3D brightness,
>   	};
> -	input.length =3D (acpi_size) sizeof(args);
> +	input.length =3D sizeof(args);
>   	input.pointer =3D &args;
>   	status =3D wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
>   				     WMAX_METHOD_BRIGHTNESS, &input, NULL);
> @@ -508,7 +508,7 @@ static acpi_status alienware_wmax_command(struct wma=
x_basic_args *in_args,
>   	struct acpi_buffer input;
>   	struct acpi_buffer output;
>
> -	input.length =3D (acpi_size) sizeof(*in_args);
> +	input.length =3D sizeof(*in_args);
>   	input.pointer =3D in_args;
>   	if (out_data) {
>   		output.length =3D ACPI_ALLOCATE_BUFFER;
> @@ -542,7 +542,7 @@ static ssize_t show_hdmi_cable(struct device *dev,
>   	};
>   	status =3D
>   	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> -				   (u32 *) &out_data);
> +				   &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -563,7 +563,7 @@ static ssize_t show_hdmi_source(struct device *dev,
>   	};
>   	status =3D
>   	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> -				   (u32 *) &out_data);
> +				   &out_data);
>
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 1)
> @@ -643,7 +643,7 @@ static ssize_t show_amplifier_status(struct device *=
dev,
>   	};
>   	status =3D
>   	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> -				   (u32 *) &out_data);
> +				   &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -695,7 +695,7 @@ static ssize_t show_deepsleep_status(struct device *=
dev,
>   		.arg =3D 0,
>   	};
>   	status =3D alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_ST=
ATUS,
> -					(u32 *) &out_data);
> +					&out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");

