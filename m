Return-Path: <linux-kernel+bounces-373432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA989A5697
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C5FB217A1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994C1974F4;
	Sun, 20 Oct 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="R7pM3YGG"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403F2F43;
	Sun, 20 Oct 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729454675; cv=none; b=nVxmtCRwdEgyFPS1iwJaXhhm7nLXoL7eMvWy6VdthfXj5fFhcUjONRNp8STz3O11T9dpJnFWqrW3pYrFsr9X7t2ONV6SP1lBbUV18tpLeagz6Ii01EwrmsfwNFDPEuE3hqOZVo2WXK9yPeuojoJYf8NijdYo/SVxnGD0n12mpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729454675; c=relaxed/simple;
	bh=1N26rAHYljR9BpDfAcv5q3OVLq1VsawmnGYQfIhnoFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGWxzjsZ1dqpK0GYuwXrSEOQ+UU3TAzt0nhFqeEq+Eq+kjA0Wgmf4NBRNgKUH7LaBfIuMKOTQX2AuJZRO81q7+UBT+Jc8kozyY4TTliaCTA4rGM7InXvAGCCzrDp3Hi3D/QzbaqdkDNilneMC8SW+bzlB7NzlrfQXByQSFEXOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=R7pM3YGG; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1729454665; x=1730059465; i=w_armin@gmx.de;
	bh=i+s2VTxyirokT7GgDMwrCV1hQecFIL1nnrV8yfcetio=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R7pM3YGGgBwpajxfQCMqRsaIDFQiSKoDIAgkYqMvYWh8FMN3jpSz2UEN0xTIZ7DT
	 1igwJRBUL+uASJcO6x7QCe7soGUhNxbHP8xt7+Y75HPq39rvW+qTiF1bHlq7bF/XY
	 HqiOhVuExtRJvCmUnT3U0N8uYkpS0f/kdP2XbNgoXYN7/2ayoVE83iGS8J0kcnYgs
	 iaFj6sk7Po5SINCjEes0EUF7Bd4OYYkPiygraqI8FpR3Ql9I1bs3GsEgePJmgM0Jf
	 ZXSAsuPegKvVhjn3vBtAixKDHLA45vAEpHTTJ4WWzoFjYEeXYYTyuf0G2ZtB9KxnV
	 1n2vn8XefI6excNV9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLQxN-1tKPzm1NWl-00MXEz; Sun, 20
 Oct 2024 22:04:25 +0200
Message-ID: <b1f370d8-79a1-4363-a0f9-3871696f43aa@gmx.de>
Date: Sun, 20 Oct 2024 22:04:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] alienware-wmi: fixed indentation and clean up
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241017081211.126214-2-kuurtb@gmail.com>
 <20241017081339.126564-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241017081339.126564-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aZA/rmAusXcL6xR5QoS9jUxNSp+Cuo05pXXavtOxRWMvb6+DlHS
 nKq3JMiZE+7o7ysGhpluTIkGeI1k0pPTxzOP/GuqqPwvDhXhyTmkoDs/RvHSbW3CdvUxf46
 8xqd6WrkukKlxvEXKqfvKC+06U+YngXAqmysWNg1Vj4uT5tKfV9SUry5zwQ0XKFKHauoCBr
 YmBcJdJXw4vUh0kIXaEHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8zWQyjKELV8=;nlL/8HRHdysdeJq5XEeNpz0TwvJ
 KdHn1IP4yQCwSgvzil2FBYvymUwzX+wdfZ60sV2R/TRntp2mQm7p1+ER/4eNzIl8xhyRKRXkQ
 yx0N9yYrW2J7UQkkqzJXqlMNWVrwQm8+f6PPuPTUplG8Us3f59ko7D4NuKd/anNQMEEo+i9UG
 0mAY7SsD1ZvnYTyVZfEj7CMXY9fztuGxTB3yyNrednCKaSfjIOOnN5qOKey30Tq/zjs/27jub
 Ix/fH4hLwEhV2coQSUnR9ADWRFpG7B6szwnScfoVDyQg3NmCiHhBSqcE/pQW4+mXOopQJZEjr
 p8993GWioyzlHd+INQH7eAzXU3MdnseH7sbS0z/2m4d4eNqQjbeBWgMk/qkYhAvMnAspV34NM
 h2KntAfIrzv2qFDYwhul9q/moDrwKgS8frhHZ1h3UFVjgo4F7yuBORgG754dBlS8KWXyCwt1n
 cp4u8M+nzWOV+aq9TQCcWSHb2LB/SvA2sLbLpLkypek6AL/ozKROYY3CQ0UQDrHx91NEdnYuy
 iZxd93niTA3xdXs/a80OGmIicmzMaH4kC0fm8Kyls3rsVACgxYvePv+EDS+LYTmO/r/Ij2Gux
 /YkOkLHGAicgrGbLfjSc1XX0vcAKHuxeHSsNPmuOyRegT5Oa8i7Hg6j1c421uFxU9CwHxIZ9L
 qXYZnooPPNZb7y62ZmKCQ6K/77zfciL5/QglEwkCC78g+zhOCUwlKDCbQJS/3t5DBF9LXKlsj
 9jkv6JgtkPGBFeWIpEFMHtmt2mHXtyLgFAdfnV/ogGPuu9oGupv2Luo/sx3Ia0JcEvqWgFqOw
 xykKo+DolkRBLeieTSQg+5zQ==

Am 17.10.24 um 10:13 schrieb Kurt Borja:

> Fixed inconsistent indentation and removed unnecessary (acpi_size) and
> (u32 *) casts.
>
Please remove any unnecessary empty lines inside the commit description.
Other than that:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>
> ---
> v6:
>   - Unchanged
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

