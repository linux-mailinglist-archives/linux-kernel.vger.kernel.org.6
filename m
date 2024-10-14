Return-Path: <linux-kernel+bounces-364440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC599D4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80911C24E62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427861A76DE;
	Mon, 14 Oct 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hg+tPGH8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22B2595;
	Mon, 14 Oct 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923432; cv=none; b=cC9/pDMOUj1ztDRqcyyuIQQb9KCrX+oX5p9ATQIT4iIOxZZWAuTHkBGa2Ehmj8XEuQtyWtchxgJy8QD65gqu+d/oDB8wW1pnED7IaWVUnbUh9yiO9unEMHLOa2lvceaswf2KXVrLl/8c+VtmpN5aQeiFYypI6xVlHz22C2UPFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923432; c=relaxed/simple;
	bh=e8/3uxk2MTpVSNgKUiAWycXneXmQ7a/GiQDrcIGVaG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwibnxlUeou5I3A4pb7HKOSGl9ZQkqZ6xNpC5QMfBSoDBP8V25HTESIEXrKwFKPOgOxWdgXH0Mg/F8LlmivmLdFLuIAjpknvDutmxmgvIO614I3fJacceFnAwNerJnsqiSZwOkJOzDvnzkYncMmYAJKRNAbhmd8YEVfLzBB48tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hg+tPGH8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728923422; x=1729528222; i=w_armin@gmx.de;
	bh=xPK992Gl04Ko7oieqDNyzfneYG2qaqjxZZEtGBl0bAY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hg+tPGH8A+HgAQyirk6RsvJwrHvvjCJ5ScKbkeqCUuCtV+JErFVaX5BzrZ6xG/Tm
	 oxvISrRwcQb4OZGyK2yKqbBQNpnrBqbsMcc1oUU/OksGuMbxkt8Ub3NT06Yd9egMS
	 OZdt0aL4w4lzSwRyMcVy4mOO7KqN/uTZrTGAwqOTWK8hbNrzHo7ktHPQP4AcWMgE2
	 E0s8BujkhK6DVlc/h33hp0KLKg7D7K9rP6SVYQpjdq8PUHCV10lENQJu4c31qF89i
	 mrJvI4L6TnBRse4/3nKQ2DBWd+mkQTtnZ4rG1GfvfKS9L0yRBJkNfAh+48CuTIDHu
	 KoXbyabjCKP0B5CmVw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1swoWR2n5Z-008QJg; Mon, 14
 Oct 2024 18:30:22 +0200
Message-ID: <3fe7c4e0-c24a-4205-a870-0fcc6e76f1af@gmx.de>
Date: Mon, 14 Oct 2024 18:30:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] alienware-wmi: alienware_wmax_command() is now
 input size agnostic
To: Kurt Borja <kuurtb@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20241012015849.19036-3-kuurtb@gmail.com>
 <20241012020149.19700-3-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241012020149.19700-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hHWQ/FrJsNANXRgCw69KUAB7/JPXlrBoC/XB+drzswf8DQ3mrws
 2iBTtUgQbP+IP/C/2aplqfDn6YFdgSmFI2mdKyfYpOnRaDwEI0IzINudfLVVOGE69zbl7cC
 pMCThraOgrMRK2s56kvaumKtGbmrDIvs7c6BZeabLF5mbRFVApCTfKwTXA37o21E0B09Y59
 SguWcrn/G5VbkFgaUe8fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WMhy5ylRckg=;JWV9YaEWK+fcE1+H2gepZ1lceZJ
 xFVviZdmknWmQIMXvcN30SOxQFcD3rThQQZ3Wk0wUktrUOINRWqxgZBGWRJCkQlUK2mfknpBu
 MdI6SeF3ngAZkCjBkVuwgWbHTAlelrCe9EbxUKqUk8m/8yhchKD0CAyvOMfsy2CZ28yE9A/pI
 2mRSE23EsoZKd8Fr0ZspZ54NKKmYCYxMf0aS42pJhbT2oyM2dce7EY/otdePfD5odb0bUA/+R
 n3dxhwIvkFDhKY8JjmEHPheK9RuF3ZYFkB0GfPmZHzylHTBhYLdLYcVVvBVRn+8bItB5wavgh
 bHwqWJFQQU/3xC1B8Beg4IASXnAZNqHuaqMhhwZGxq+bWyqc4+3ZD4fyoLa5SqSYUrXGSTK9d
 QrkLUjWmOn3s/9p9YGEiGWCkObPzguemwLu+ytFZU/nM4N2wHKMcmCuy2gn32nkrz8i5fo7ra
 3LLN58SSuUhtO21kkgsCxmQevc1Y2LtfuXxHVDsbrCkGkXON2pQ7YysTeu2mVTDfXIGCAIJU4
 i2P5/BPtNf5mp2kbXKAILRZ2jerbaS3JScJtB2MW0fWGt4GsgDB4w1zC0LIDxMDS/7ogNVmu1
 nCWhTNrD7olKkxWow0PETLskytsmD9FJ4fLlMjJP/rDu820e2kGSwLV7w1mlHW+OqL/DJD99p
 BNBXgJVA7jebh2uALIIMzgthzIlpD86tuzq1X8vRPF2ooIkX16UFKD7ly1EIU8jACLr7nRCfO
 zmLXmeXAxxu8TLpP8ouXy4F0lcTrGyjthVgMW5T/zzGDUmXey1ZMC8zbPaEKov4dk46e6Gkvj
 KZd92g+ILNVtRIMhuxl4nHBw==

Am 12.10.24 um 04:01 schrieb Kurt Borja:

> alienware_wmax_command() now takes void * and size_t instead of struct
> wmax_basic_args to extend support to new WMAX methods. Also int *out_dat=
a
> was changed to u32 *out_data, because new interface specifies u32 as out=
put
> parameter and all previous callers would pass u32 * regardless.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 29 ++++++++++++-----------
>   1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platfor=
m/x86/dell/alienware-wmi.c
> index 16a3fe9ac..b27f3b64c 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -500,15 +500,15 @@ static void alienware_zone_exit(struct platform_de=
vice *dev)
>   	kfree(zone_attrs);
>   }
>
> -static acpi_status alienware_wmax_command(struct wmax_basic_args *in_ar=
gs,
> -					  u32 command, int *out_data)
> +static acpi_status alienware_wmax_command(void *in_args, size_t in_size=
,
> +					  u32 command, u32 *out_data)
>   {
>   	acpi_status status;
>   	union acpi_object *obj;
>   	struct acpi_buffer input;
>   	struct acpi_buffer output;
>
> -	input.length =3D sizeof(*in_args);
> +	input.length =3D in_size;
>   	input.pointer =3D in_args;
>   	if (out_data) {
>   		output.length =3D ACPI_ALLOCATE_BUFFER;
> @@ -541,8 +541,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
>   		.arg =3D 0,
>   	};
>   	status =3D
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
> -				   &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_CABLE, &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -562,8 +562,8 @@ static ssize_t show_hdmi_source(struct device *dev,
>   		.arg =3D 0,
>   	};
>   	status =3D
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
> -				   &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_HDMI_STATUS, &out_data);
>
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 1)
> @@ -589,7 +589,8 @@ static ssize_t toggle_hdmi_source(struct device *dev=
,
>   		args.arg =3D 3;
>   	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
>
> -	status =3D alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL=
);
> +	status =3D alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_HDMI_SOURCE, NULL);
>
>   	if (ACPI_FAILURE(status))
>   		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
> @@ -642,8 +643,8 @@ static ssize_t show_amplifier_status(struct device *=
dev,
>   		.arg =3D 0,
>   	};
>   	status =3D
> -	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
> -				   &out_data);
> +	    alienware_wmax_command(&in_args, sizeof(in_args),
> +				   WMAX_METHOD_AMPLIFIER_CABLE, &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[unconnected] connected unknown\n");
> @@ -694,8 +695,8 @@ static ssize_t show_deepsleep_status(struct device *=
dev,
>   	struct wmax_basic_args in_args =3D {
>   		.arg =3D 0,
>   	};
> -	status =3D alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STA=
TUS,
> -					&out_data);
> +	status =3D alienware_wmax_command(&in_args, sizeof(in_args),
> +					WMAX_METHOD_DEEP_SLEEP_STATUS, &out_data);
>   	if (ACPI_SUCCESS(status)) {
>   		if (out_data =3D=3D 0)
>   			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
> @@ -723,8 +724,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
>   		args.arg =3D 2;
>   	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, bu=
f);
>
> -	status =3D alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTRO=
L,
> -					NULL);
> +	status =3D alienware_wmax_command(&args, sizeof(args),
> +					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
>
>   	if (ACPI_FAILURE(status))
>   		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",

