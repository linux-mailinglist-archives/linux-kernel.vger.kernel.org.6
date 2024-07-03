Return-Path: <linux-kernel+bounces-239345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE92925B64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA821C20F2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C44E18509C;
	Wed,  3 Jul 2024 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UBYGrw1B"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B72173348
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004137; cv=none; b=ZmmntEEHyEz9LFo4o19w76cPUxC+NdrHifSZxdWyi5pwjjEL/UdK1zoOUS1IOzcSMTD488ce4RmrRpzXKFWh6NBXI4NngZf/+UilMPSS7lKiWm64+D88knXqgJTdHDgBOOze++NLUBwNHvkidOEIIP6Dvdomt8DapvRasKejTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004137; c=relaxed/simple;
	bh=KZXdDsuzF69Blsa8jgtRkrogPbhEQ2Tn9c8T5iBeH/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyGQ5jvyI4phAYqMzKAaoFh7RtdD6wsTAZmk9ZTvi35o8YC71i82dQ65XCaFK32W3hofwZNvKRmqA49Fz/OOVEMjzDHe90YHGf+DKd17J4IPKDWdqoNNnPIkBYSADRdKtz0etAP5h3V47QSfcyUnSCrC6epexWMF98nzNR3iNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UBYGrw1B; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B645E0002;
	Wed,  3 Jul 2024 10:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720004127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bn2Cag/x6QwhxcuWMLlARpck1D5imG3lqhwCJXtBb98=;
	b=UBYGrw1BorDccFxJQqPhIZZgl2ydgiV3scqGR6xvB9f5euzieAsMksDTX7pCdxuY/gARP0
	2OWcvS5PIYeIvdDZdErWz3wmn0y4FstyDRsas83EH7Rae8UeGre5lvNQPRchk54ud3osH8
	x12cyfmGSPaCgqB7+O4ApEX5I1hdFFuBcMlT7TQUym9P59HISxWvKX/uMJqF9u4WiYy/GB
	DCVmQZD4RjoYp8kOyUqTdqOJ1oa0BAATQJasvAbWQqIZC81s6SAOoRr7r8+7XPFisc4JVI
	J1wnLze+kK3WhhC2ucId2rVsUG5am1mFefGL6hn427zaoTCVZlFrFFPMe8x4iQ==
Date: Wed, 3 Jul 2024 12:55:27 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: linux@armlinux.org.uk, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/27] ARM: at91: pm: add sam9x7 SoC init config
Message-ID: <20240703105527c859341b@mail.local>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102702.195564-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703102702.195564-1-varshini.rajendran@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 03/07/2024 15:57:02+0530, Varshini Rajendran wrote:
> Add SoC init config for sam9x7 family.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v5:
> - Removed unnecessary header file.
> - Added a space in the return type for clarity.
> ---
>  arch/arm/mach-at91/Makefile |  1 +
>  arch/arm/mach-at91/sam9x7.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 arch/arm/mach-at91/sam9x7.c
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 794bd12ab0a8..7d8a7bc44e65 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
>  obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
>  obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
> +obj-$(CONFIG_SOC_SAM9X7)	+= sam9x7.o
>  obj-$(CONFIG_SOC_SAMA5)		+= sama5.o sam_secure.o
>  obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
>  obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
> diff --git a/arch/arm/mach-at91/sam9x7.c b/arch/arm/mach-at91/sam9x7.c
> new file mode 100644
> index 000000000000..e1ff30b5b09b
> --- /dev/null
> +++ b/arch/arm/mach-at91/sam9x7.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Setup code for SAM9X7.
> + *
> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mach/arch.h>
> +
> +#include "generic.h"
> +
> +static void __init sam9x7_init(void)
> +{
> +	of_platform_default_populate(NULL, NULL, NULL);

Can you check whether this call is actually needed to boot the platform?

> +
> +	sam9x7_pm_init();
> +}
> +
> +static const char * const sam9x7_dt_board_compat[] __initconst = {
> +	"microchip,sam9x7",
> +	NULL
> +};
> +
> +DT_MACHINE_START(sam9x7_dt, "Microchip SAM9X7")
> +	/* Maintainer: Microchip */
> +	.init_machine	= sam9x7_init,
> +	.dt_compat	= sam9x7_dt_board_compat,
> +MACHINE_END
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

