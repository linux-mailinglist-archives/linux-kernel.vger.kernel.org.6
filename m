Return-Path: <linux-kernel+bounces-436232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A529E82F2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 01:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F5E1657A0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 00:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F4D5258;
	Sun,  8 Dec 2024 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="imKfo0Ox"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE141E480;
	Sun,  8 Dec 2024 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733618033; cv=none; b=VPxNuvYA37bGOoXBPkMeCFmrm+x7FVmP4ULUZopSPRz3nehGSuXRe88umENbJxh5MRIBLD1CEcFHBiUl3lQzoLSL30wrBTXux/vLbB4YsZpnBYgr92jW4dido9YsQXOmraX3QI82NqC7qwOUKN/IMrnu2Q1EflHIxVto6OwAqcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733618033; c=relaxed/simple;
	bh=MGJ1aVj95g0SY59UATiAcOqoeUVWhnEEWQb4cCUeyJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrHovOZSk0WpdQLl3Fqr6wvhBFQwK31ArS3csY53D+I4OicgZjDyH1+gRtD0GYkW+2U8gt/dUl8AS5swn0/MIuSyWjhqfb+hg8rb2dPWqfmT5/tff6f3ZKDr3TbfVeyvLs6ejjPZAgqW4PPNUda0RTPtJMXK6U2W6lz8BdjV8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=imKfo0Ox; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733618018; x=1734222818; i=w_armin@gmx.de;
	bh=HL+IMuAiNiF8aM/8sH0ANomr/T5Z8We7VKoDmRJ/65s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=imKfo0Ox3y9n2Jt/7WWuhzFiC6eJ0SVX17GrEn3IPJARbo7vYdWvwigamcuCYwFc
	 NiWMa1Zyt0vNvIG1sNBS1Mc21WiK1f0gyRklPTEDMU/RaVcPo0CTAYWfisewjzinf
	 EdVu7vH3neICtk+e+sRWIkCEttq1eURWwOzrYHhf+/xdLS+cPkBpkcUc/ctIQRxL8
	 W+vGZvROiPbVYY3qtL2vEZj5xYPD8pesGOusCIpNazQagFTjWcZpNr6PUcJyk4/AO
	 MGsxXGL02jIBdrMCNdDiNgP37hmQB4TqZd3FUlCWmbyiUYqldVEY7DW0LgG3l39ID
	 2bBR51cwwsTP7pDD2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([91.14.230.110]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1t2Ppa1AsC-00RZm8; Sun, 08
 Dec 2024 01:33:38 +0100
Message-ID: <d5a57f5b-92cd-4b60-bd92-16db368f4486@gmx.de>
Date: Sun, 8 Dec 2024 01:33:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] alienware-wmi: Adds support to Alienware m16 R1
 AMD
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com, Dell.Client.Kernel@dell.com,
 hdegoede@redhat.com, linux-kernel@vger.kernel.org,
 Cihan Ozakca <cozakca@outlook.com>
References: <20241208002652.5885-4-kuurtb@gmail.com>
 <20241208003013.6490-3-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241208003013.6490-3-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5KCjUwNrWBT42fBP6HR5Er2Bii1XLf+XR2A4/4pEu0zbxOQlhae
 4y7WfMl3q6ryqMubcGte27vv+ZgPdXVi5i8dWHqQfe4snjQ79pylP+upSrAnS47jX86mvOa
 0hSf7CP0lS+jE3nd3j6ESWPx7JvO9j21B7HfpSibtDVBTeSH6sQp//p1GUY7WlVMNFOVEDf
 HA8MkiQn+uN8AVdH6312Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+cqpx8jzvXA=;+SvocsB3KZkDBkIgCJ72XfX2zEn
 iStFKC9CB/VIrqWrM6evT3r6pL4NLUR4NTn+JU1bUywjm8eu2/0CYv6c2zR460/eLwMqhZf3f
 1YF0NxE8PfyKRScrpQH2nhpbou/2mVYCXLR1EUT3JeadOXi19TvQuN9SZlRvGnHQfKjIMpk/3
 impiyZHwGikec+Gs6dg5nJik5t8Jb/u305FR550BifJm+RMyak9dbzc4l3XAN1qNpoBE4qweO
 M8gJoqHt3+/BMpvrwaOGBIdoOKkUoQCNRKxj6YHx4EHQZncxpZyZZa9pW6WEG4MqlVrAlt9yx
 RFNIUonRodyNro3GPzZEpVzI9qDnSn0X1zi49h4ViO4pnaAUr201M+bN1tUwz/O6dk2eqOQe7
 NS7XCFzakEs3sJ2Uu9eoOq0PNRagPORg1l5W0F/OJTChfI30Ztg8Da73TLHp0DFQ+j0rlRd8m
 iR58gnOOcI54E/rNRbTvd96enZUze8Jf97iD04I8rlzxo7CqNr9y9gUOlrBre31zBC4S0xm0y
 VWlH5YKSQs2Xpr4AGaEnrxR5a5p3yA0CskFRIC0CZevMUK/utzRrM8E1vUtEQHLZPN4zOm4M7
 Ltqr263dHPBA3xp/Bw87A4IBj4cjN6CG/aVjaG2qRi0RJ1wrB6IwReSSgkc4YGjjPSbGZRRvE
 FWDJraLPa6esOOq/nl90SxW4oGirdkq+esW3YsB38b6DZzihGcwZn+KKY3XWWykPIGxOLttlD
 5kTwh8sUJTkqM/ZxRD90HSxiCBjf+UokssZtuhnstPo0lFx1Ei+pN8W76JJ1Fo8RosCQqMNfb
 sZ5/EP97E/XkqcEabcGFCkYTEQYu3fAznr3n6E4mH8z/b/7OvaZYtX0doSPHrvmtYAEWEGyse
 IAfwcelmhikz5gQn96z/UcBwkUmf059PcyA+z5J+iRBidhnLDowOgmg3u67iYRMh0zeYR3Uou
 olX9SCR9JLrQWiVZMX8In6ncEA15iz+5Kp/6eyxG+JgkGwpqHsJf54Dut0M4lTgTC8CnI5LWA
 cfYv05vNPARBObn5jcHNc5M+U6Od84qRuBGVGPyqpnM3CkA1LF3AyyZYh+LUColUwGWEySKPa
 vVP0tnEc8OJ/J+HMI0hdDtMvZ7dcWY

Am 08.12.24 um 01:30 schrieb Kurt Borja:

> Adds support to Alienware m16 R1 AMD.
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Cihan Ozakca <cozakca@outlook.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> v2:
>   - Added this patch
> ---
>   drivers/platform/x86/dell/alienware-wmi.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> index e69bf9a7b6c8..341d01d3e3e4 100644
> --- a/drivers/platform/x86/dell/alienware-wmi.c
> +++ b/drivers/platform/x86/dell/alienware-wmi.c
> @@ -241,6 +241,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
>   		},
>   		.driver_data = &quirk_asm201,
>   	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "Alienware m16 R1 AMD",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1 AMD"),
> +		},
> +		.driver_data = &quirk_x_series,
> +	},
>   	{
>   		.callback = dmi_matched,
>   		.ident = "Alienware m17 R5",

