Return-Path: <linux-kernel+bounces-244585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576EE92A67F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E041F21A9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2BA1474C3;
	Mon,  8 Jul 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="kRJkI7N5"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95A1474A2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454081; cv=none; b=mqwL5zlAWGnNvzqQUBfZCMmiLkb4/s2CpKLoy/1tV+i0xEIxl9JgDjUDmloe6MRBcnp13Xep+MZaIckh6QyDb/1kwMf2WNmz5bcpNLj0F2zTQj31Oo7Ok5v6FcdZ/+mg/u8Wyem1b4bkT9chKj0wP8rgS5ulmdFeM9T+Wtlg/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454081; c=relaxed/simple;
	bh=Kt5KUWdxd+J5SzA+sJLjT1CTq0d6T7GN684Xz0uIAtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuSE63rpn2hU0oX9itxedJpjrCmLWhVZgLXsgnYUdZXqjSA6lhebDqLUERBOaEf1mPjcJQMbfs48de3/Cpevsb4XgujXx07EI1F83g3D/gc6Dx3sLqyJBJnO5f0Z4MOF3ncH/y8D5YSnEaPHL4Q1qVnjWt3et44aWRWeX1C2CFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=kRJkI7N5; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720454065; x=1721058865; i=wahrenst@gmx.net;
	bh=Ub6J2Z53f3wUO+xk78tLgojAcxeSDWJYJRW9UqqTXuU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kRJkI7N5Y5kwc2auIa/1TDvEI+sDMNgZ97XaMnH9duurji6mq9RSsZbl9WBCDeIy
	 +Df6n3PiB0BDLDfPYavI6TxaVul1QDpW1VwN4uC6fAUn0fk58aoOQ9FbnJ6lJWzbn
	 Xl4yD9ZPEWZ7hns2Leyx/r697OEOtNCmmT3PDBRvul9xwJEJH83EpFDwa+PEmcpxX
	 j+1KJF6088qELty6kLKsv5DCM1AIhKpL8Xk17008MxQxhJ5U5+jrd4GBvh3S+Ed39
	 hwQQxLjN1U9HAnbsP+XTu3l+YdvfVl+iVcf/zOxNDsItDFqWg9xHHtMU98W8P6wNe
	 GsEVeWg1R1UcXdN8BQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1sdpFG3JKh-00DhVy; Mon, 08
 Jul 2024 17:54:25 +0200
Message-ID: <a5c69147-c0fe-4cda-8996-e46698c5e9e8@gmx.net>
Date: Mon, 8 Jul 2024 17:54:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: bcm2835_defconfig: Enable SMP support
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Russell King <linux@armlinux.org.uk>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240707-raspi-config-v1-0-3e122f2122e9@gmx.net>
 <20240707-raspi-config-v1-2-3e122f2122e9@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240707-raspi-config-v1-2-3e122f2122e9@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dwXQtn/8x3viNcyK+GebOAFG6pbReHTLNl/d7R07Vf/unMTjnLj
 mcjo0bhnR0mkq9SfP4cO5zu6iyEwNXwqgxXk6aaEOM443I65G5hs82sNK41InPQyTZ7bh8i
 U/UEv70ZzFqkvLLNHXW9of4aE2nQyJDZpYdJyc5st+f5e8zcJD9bhYNcbXf3P1u/ZkbXvgG
 0K3xNRl/4+2mX3KMnjsdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vj6fKrjzQ6s=;wQoKj+lLp8+q55CJrsYQWZWBxxh
 /HNuQtmM3he53oXLIdv0ycxXIuGqNygYA6WsU+QaTrdwA0K6/CWfk7G5d0JX84NDQDbDR6vvn
 f4GH4DyH6bWJXZ7gi6eg+VCsHOvTN878MGg4X2jiUFcG8ZTZlUYMglAWd8yID0zKNONGrB47j
 JouaPSI0iigOZvJEthUHBZKLxK1TAGZi+6PwUaZyzOLI462LEIq2h21cMfW3TlOH96qP+HW66
 EsQFdch+ojtultor7H5InF/7BPzk4FJq/zEsotd92EOI2tEimW/ysTv3WTXaAgYXiKcx8cqrE
 MbadPNR45D0C6ASMrgeu9kZ8af7iNUvMTAmxRNfkS0IRaXCteWKY2lpyQ498txOoUQhGph4AT
 mm8wcV/4ct7k0Dr4TVuy3pWOxVbyPTFrv4ylvUdUPj7RzlwA+js77IycfYMCD2g8jMhDZSw9J
 5VwrTt140W9gGOgs0KB2CsA77jfbXDhyXND8tDqAxfCq95BbqE9OE0YaM36MAAttLZM5WY3O1
 I1qNkDJK5R7dLYetpfwwP9JY/7wsarw73k7UUFGcGREuaEzImacwHslmQ1OD95v2SnbnBecKZ
 Ez23GF4XzDuqEP0UrQYfpsD1AetTCnxovDEfNBLDhMHdwjYjbyNA13j8ou3BzsRr7U+h7F305
 NmoXEvMt5djOJhy2Cp1zZfexWSKHSGzq335JGj8+FTyizKdeVMV2MG+N9LKOOj2waUPS4A2hE
 8yzlhV1T/ugOzFuK1gL1IUvoyxqOLFCS+kA9FqmlvGStoogHQvpZUQq5gAjVrS0OcsuMdg3Rc
 Ljy2O+EkvWr0DgMA7GA1sL0da7PVeu9x3MJ1+FYtAF8Os=

Hi Jonathan,

Am 07.07.24 um 23:48 schrieb Jonathan Neusch=C3=A4fer:
> Since there is only one Raspberry Pi related defconfig in the mainline
> kernel, it's useful to have to work well on all 32-bit Raspberry Pis.
this wasn't intention of bcm2835_defconfig. It's more focused on BCM2835
SOC and kernel-ci (both non-SMP). If you want to use the BCM2836 &
BCM2837 (incl. SMP), please use multi_v7_defconfig instead. Applying
this change would decrease the test coverage.
> To that end, this patch enables CONFIG_SMP and CONFIG_SMP_ON_UP, which
> allows the kernel to run well on multi- and single-CPU systems.
>
> PM and suspend support is necessary in order to keep KEXEC enabled.
In this case the subject contains only half of the truth.

Regards
> - Raspberry Pi 2 Model B V1.1 (BCM2836, SMP)
> - Raspberry Pi Model B (BCM2835, UP)
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>   arch/arm/configs/bcm2835_defconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm28=
35_defconfig
> index da49dcfd359050..d505058715b66f 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -24,6 +24,7 @@ CONFIG_KEXEC=3Dy
>   CONFIG_ARCH_MULTI_V6=3Dy
>   CONFIG_ARCH_BCM=3Dy
>   CONFIG_ARCH_BCM2835=3Dy
> +CONFIG_SMP=3Dy
>   CONFIG_CPU_FREQ=3Dy
>   CONFIG_CPU_FREQ_STAT=3Dy
>   CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=3Dy
> @@ -33,8 +34,6 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
>   CONFIG_CPUFREQ_DT=3Dy
>   CONFIG_ARM_RASPBERRYPI_CPUFREQ=3Dy
>   CONFIG_VFP=3Dy
> -# CONFIG_SUSPEND is not set
> -CONFIG_PM=3Dy
>   CONFIG_JUMP_LABEL=3Dy
>   CONFIG_MODULES=3Dy
>   CONFIG_MODULE_UNLOAD=3Dy
> @@ -175,6 +174,7 @@ CONFIG_DEBUG_FS=3Dy
>   CONFIG_KGDB=3Dy
>   CONFIG_KGDB_KDB=3Dy
>   CONFIG_DEBUG_MEMORY_INIT=3Dy
> +# CONFIG_RCU_TRACE is not set
>   CONFIG_FUNCTION_PROFILER=3Dy
>   CONFIG_STACK_TRACER=3Dy
>   CONFIG_SCHED_TRACER=3Dy
>
> --
> 2.43.0
>
>


