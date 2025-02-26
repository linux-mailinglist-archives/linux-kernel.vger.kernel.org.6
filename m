Return-Path: <linux-kernel+bounces-533247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6DBA45747
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2FB17536F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F2B26F455;
	Wed, 26 Feb 2025 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="nnXAqJwm"
Received: from smtpdh17-1.aruba.it (smtpdh17-1.aruba.it [62.149.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94DD23815C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556272; cv=none; b=Z1eJBUA+O+jiSR0zOTdhT1yHlQwwZSMkLz+0L8uBRpGMlUgUvVhsNbPvrIepHYiNYjguimVPgO1P9dTwIobPBIxNCa9nZVWa3SvqbRd4OJTaPMote8hyGqvV7JX0BcwPIoeSaGqCdR0Aq3uXNzUxbEx65AR9lY5+SsrMTOocc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556272; c=relaxed/simple;
	bh=uX21Co84btEE4Hx3pPLgcYdUN6dmLmD4vl6Qfswnwi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHDOOilumAblgh3sf4isyxNbUbJ8gL022XjcT8wvMMJaztQXxgs0kjti7sTm+hDcgtQVeiDqm30EgUPM/fqitv1uvW7ZT7VtCnidbRZymBrZAsNBJxObdXY2Ssj5/aQvIV8l9Vc1esN6hWWAz4oylLH4OrzOrqwqumVWMTCjGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=nnXAqJwm; arc=none smtp.client-ip=62.149.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id nCCDtOXD9fFewnCCDtIqjj; Wed, 26 Feb 2025 08:51:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1740556269; bh=uX21Co84btEE4Hx3pPLgcYdUN6dmLmD4vl6Qfswnwi0=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=nnXAqJwmNS1At0VmEWQd6dCJX+8nXJpwPgCLHJ+ol88iymhn6RP7DKmcj9MufRm1H
	 mcSgN5H2cmHqqCWarRsPz52lNuwth9NFPL9OIFdPbq8VxZDzz6k67gwR6Fm/SKGDMB
	 5XnQZWrSMgJ/Cqxy9hb738BXAC2h3HBPkN/dEyw1gkTSRMe3sLcxSDwhDHbloluKDO
	 995x871s9RvvzIqU844JPuPr/y8AekYzGJ8QZI1IKpnkVfe3Cd81Z1aLLbPH2vahPP
	 UMzZSIKejz3eFsln9ltr8dzAujM3/BiXaujPWwhl0rcVrHYzdrre96P6OrSlTjjWne
	 vC055To5E5EUQ==
Message-ID: <c52718b2-138d-48ec-9b79-e8e07549a069@enneenne.com>
Date: Wed, 26 Feb 2025 08:51:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] pps: generators: tio: Introduce Intel Elkhart Lake
 PSE TIO
Content-Language: en-US
To: Raag Jadav <raag.jadav@intel.com>, lee@kernel.org,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 raymond.tan@intel.com
Cc: linux-kernel@vger.kernel.org
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-4-raag.jadav@intel.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20250226061527.3031250-4-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBUAKTSBSrFfJX576nO/ixJu10qk/6NM6AoUn/58VSQCgX2ZajGniu9UfqXyjJsxbJ/siRCnH3J0Xhtdu4UOGGhgdeAFf7wHA6I+LRCO8rO7Vho1vrxu
 3gYE+cn3Q/130kVIbHO5caO+65vdTfdnUVjd2+jhbIHJBR96x8UCU4TLRIjT8/WpLuXPVwWEGg2GqukqlR9EbErnKpdq5KmhalgFzkIJUJPvAuSucYmm344s
 pJ8clEMj1mBSLo6EE7xjH91q259Mcf+2YMSQh5g5UUdxmNvzA7wsVQFnAz3MmoqTmdsEuq+6f2LTh7ebiXXiykz4D1uarRiQBm8XdIjeHNBR6aUCiexIfSCU
 DIx/iq0TW2KLXbpw+Fs69ZVfC7Zt4A==

On 26/02/25 07:15, Raag Jadav wrote:
> Add initial support for Intel Elkhart Lake PSE TIO controller.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   drivers/pps/generators/pps_gen_tio.c | 17 ++++++++++++++++-
>   drivers/pps/generators/pps_gen_tio.h |  5 +++++
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
> index 89b08301d21e..8339d8c8f8bb 100644
> --- a/drivers/pps/generators/pps_gen_tio.c
> +++ b/drivers/pps/generators/pps_gen_tio.c
> @@ -22,6 +22,14 @@
>   
>   #include "pps_gen_tio.h"
>   
> +static const struct pps_tio_data ehl_pse_data = {
> +	.regs = {
> +		.ctl = TIOCTL_PSE,
> +		.compv = TIOCOMPV_PSE,
> +		.ec = TIOEC_PSE,
> +	},
> +};
> +
>   static const struct pps_tio_data pmc_data = {
>   	.regs = {
>   		.ctl = TIOCTL_PMC,
> @@ -240,9 +248,16 @@ static const struct acpi_device_id intel_pmc_tio_acpi_match[] = {
>   };
>   MODULE_DEVICE_TABLE(acpi, intel_pmc_tio_acpi_match);
>   
> +static const struct platform_device_id pps_gen_tio_ids[] = {
> +	{ "pps-gen-tio", (kernel_ulong_t)&ehl_pse_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, pps_gen_tio_ids);
> +
>   static struct platform_driver pps_gen_tio_driver = {
>   	.probe          = pps_gen_tio_probe,
>   	.remove         = pps_gen_tio_remove,
> +	.id_table	= pps_gen_tio_ids,
>   	.driver         = {
>   		.name                   = "intel-pps-gen-tio",
>   		.acpi_match_table       = intel_pmc_tio_acpi_match,
> @@ -255,5 +270,5 @@ MODULE_AUTHOR("Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>");
>   MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
>   MODULE_AUTHOR("Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>");
>   MODULE_AUTHOR("Subramanian Mohan <subramanian.mohan@intel.com>");
> -MODULE_DESCRIPTION("Intel PMC Time-Aware IO Generator Driver");
> +MODULE_DESCRIPTION("Intel Time-Aware IO Generator Driver");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/pps/generators/pps_gen_tio.h b/drivers/pps/generators/pps_gen_tio.h
> index e652f976e455..bbf5b994e7ff 100644
> --- a/drivers/pps/generators/pps_gen_tio.h
> +++ b/drivers/pps/generators/pps_gen_tio.h
> @@ -14,6 +14,11 @@
>   #include <linux/pps_gen_kernel.h>
>   #include <linux/spinlock_types.h>
>   
> +/* EHL PSE Registers */
> +#define TIOCTL_PSE			0x00
> +#define TIOCOMPV_PSE			0x04
> +#define TIOEC_PSE			0x24
> +
>   /* PMC Registers */
>   #define TIOCTL_PMC			0x00
>   #define TIOCOMPV_PMC			0x10

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


