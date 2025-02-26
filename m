Return-Path: <linux-kernel+bounces-533246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5DA4575A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE25A189B43A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1027624E00A;
	Wed, 26 Feb 2025 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="bt0+g0s+"
Received: from smtpdh17-1.aruba.it (smtpdh17-1.aruba.it [62.149.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEA24DFEC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556249; cv=none; b=KNO7TYOVYFrsH4lUeZtZ1rRIgAlBAqwrSXBoxgWVdGm8awxWudxBanpofMMRwlF4rYoit2wKoAj1Xs9DRWiUz8qk4vWXceDLDZEfU8lAxekByR6jHGbmW4CZ9OKGIZwjIlwap6TVmsvzzjw/QJh0FpbfbxWNuhV6custeVouMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556249; c=relaxed/simple;
	bh=GcsaqDs7XXfUGXiuDdj8xhCvwLxA0He6mlrJrdvyky8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuUgXxQ+SYiyY/pL5yaGQSKTfiEG/w5ZpjuCkDz+DJBRLvQynXjsu08jNBDRic4t90yWnRY+xShi6S/z2oiImMkxvUvU4UHLJ88CZ+DtXJYKoQ3o07sVbZ9PyWUM1Jh6soRrpo8k6ssGTSHDi5ccrHAH18uVobHrpDF1UQ9SIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=bt0+g0s+; arc=none smtp.client-ip=62.149.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id nCBotOWShfFewnCBotIqQX; Wed, 26 Feb 2025 08:50:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1740556245; bh=GcsaqDs7XXfUGXiuDdj8xhCvwLxA0He6mlrJrdvyky8=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=bt0+g0s+xtVJ1co7WRU8EGUtO1s+ie7ekiBGUR1QDm2aqCtIc4JLbuoOWLZOcpQad
	 0R8UzrJ4w3bVupWVKvaaa1C23fXblFZq6nKSxmxQoNnCLPIoyim9grKUdLLVbQxhcQ
	 UZJKSuTs9O0aOdJ32hK9LR2Wd3oS4X4vRyOSKgrq6TioEsqVZkVvDsBA/a/6Vu1Dl1
	 CtdtEjIYQqC8GLXwU7yPPwF5ihgccwIlDJ8d6OutrDwDngP8kFEvtU5I4IB727pfJ3
	 kz1ckjkSuG5PipPlBtYLR0mmpthk31uOZgwXWMfdeswHc33VkXPylH68FpGiVw4ynn
	 kwvRmImQKtDSw==
Message-ID: <2c5bd165-d95e-4b66-a3ef-ad40f9b8e0ad@enneenne.com>
Date: Wed, 26 Feb 2025 08:50:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] pps: generators: tio: move to match_data() model
Content-Language: en-US
To: Raag Jadav <raag.jadav@intel.com>, lee@kernel.org,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 raymond.tan@intel.com
Cc: linux-kernel@vger.kernel.org
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-3-raag.jadav@intel.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20250226061527.3031250-3-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH6f/IaPEjWErBJ8wMlsTje4I+k3ggpk338mRxu1dtZR+umE6a7EKFw+Ny+R569X2Uznskm+xN7ZkcEWQOBwqndBcVj4PTW5XlVbD2rxKJ1FRt0Z0s8F
 e6+/J1WcR6UQ+bW4J7JYmYaVY0DfNU0V39lG6BTH6LFZNdZ4zQH9iklmcBF45MS6OGfZhQxetWfeEuLwmoSkn/i09pVDY6XdiqXmjNfFi0Y6bqXww6su6zzl
 a8YCgcqTnokLWANfxaYfksh7COItd2LDi0GppHBf3lVXD0sYzNHm3ZlfahmYI1oA6eCwfcdRMi2b2wLmxwC7CJaRgKZ7++VaaJ7iTezETGAR3kT0K2+BTP7i
 SyDL8vLAIYL5JiHb+MaDOi+paRrpTw==

On 26/02/25 07:15, Raag Jadav wrote:
> Use device_get_match_data() which allows configuring platform
> specific data like number of pins and MMIO registers for TIO.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   drivers/pps/generators/pps_gen_tio.c | 33 ++++++++++++++++++++--------
>   drivers/pps/generators/pps_gen_tio.h | 19 +++++++++++++---
>   2 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
> index 7f2aab1219af..89b08301d21e 100644
> --- a/drivers/pps/generators/pps_gen_tio.c
> +++ b/drivers/pps/generators/pps_gen_tio.c
> @@ -14,6 +14,7 @@
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/pps_gen_kernel.h>
> +#include <linux/property.h>
>   #include <linux/timekeeping.h>
>   #include <linux/types.h>
>   
> @@ -21,6 +22,14 @@
>   
>   #include "pps_gen_tio.h"
>   
> +static const struct pps_tio_data pmc_data = {
> +	.regs = {
> +		.ctl = TIOCTL_PMC,
> +		.compv = TIOCOMPV_PMC,
> +		.ec = TIOEC_PMC,
> +	},
> +};
> +
>   static inline u32 pps_tio_read(u32 offset, struct pps_tio *tio)
>   {
>   	return readl(tio->base + offset);
> @@ -28,7 +37,7 @@ static inline u32 pps_tio_read(u32 offset, struct pps_tio *tio)
>   
>   static inline void pps_ctl_write(u32 value, struct pps_tio *tio)
>   {
> -	writel(value, tio->base + TIOCTL);
> +	writel(value, tio->base + tio->regs.ctl);
>   }
>   
>   /*
> @@ -37,7 +46,7 @@ static inline void pps_ctl_write(u32 value, struct pps_tio *tio)
>    */
>   static inline void pps_compv_write(u64 value, struct pps_tio *tio)
>   {
> -	hi_lo_writeq(value, tio->base + TIOCOMPV);
> +	hi_lo_writeq(value, tio->base + tio->regs.compv);
>   }
>   
>   static inline ktime_t first_event(struct pps_tio *tio)
> @@ -49,7 +58,7 @@ static u32 pps_tio_disable(struct pps_tio *tio)
>   {
>   	u32 ctrl;
>   
> -	ctrl = pps_tio_read(TIOCTL, tio);
> +	ctrl = pps_tio_read(tio->regs.ctl, tio);
>   	pps_compv_write(0, tio);
>   
>   	ctrl &= ~TIOCTL_EN;
> @@ -63,7 +72,7 @@ static void pps_tio_enable(struct pps_tio *tio)
>   {
>   	u32 ctrl;
>   
> -	ctrl = pps_tio_read(TIOCTL, tio);
> +	ctrl = pps_tio_read(tio->regs.ctl, tio);
>   	ctrl |= TIOCTL_EN;
>   	pps_ctl_write(ctrl, tio);
>   	tio->pps_gen->enabled = true;
> @@ -112,7 +121,7 @@ static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
>   	 * Check if any event is missed.
>   	 * If an event is missed, TIO will be disabled.
>   	 */
> -	event_count = pps_tio_read(TIOEC, tio);
> +	event_count = pps_tio_read(tio->regs.ec, tio);
>   	if (tio->prev_count && tio->prev_count == event_count)
>   		goto err;
>   	tio->prev_count = event_count;
> @@ -172,6 +181,7 @@ static int pps_tio_get_time(struct pps_gen_device *pps_gen,
>   static int pps_gen_tio_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	const struct pps_tio_data *data;
>   	struct pps_tio *tio;
>   
>   	if (!(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ) &&
> @@ -184,6 +194,11 @@ static int pps_gen_tio_probe(struct platform_device *pdev)
>   	if (!tio)
>   		return -ENOMEM;
>   
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	tio->regs = data->regs;
>   	tio->gen_info.use_system_clock = true;
>   	tio->gen_info.enable = pps_tio_gen_enable;
>   	tio->gen_info.get_time = pps_tio_get_time;
> @@ -217,10 +232,10 @@ static void pps_gen_tio_remove(struct platform_device *pdev)
>   }
>   
>   static const struct acpi_device_id intel_pmc_tio_acpi_match[] = {
> -	{ "INTC1021" },
> -	{ "INTC1022" },
> -	{ "INTC1023" },
> -	{ "INTC1024" },
> +	{ "INTC1021", (kernel_ulong_t)&pmc_data },
> +	{ "INTC1022", (kernel_ulong_t)&pmc_data },
> +	{ "INTC1023", (kernel_ulong_t)&pmc_data },
> +	{ "INTC1024", (kernel_ulong_t)&pmc_data },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(acpi, intel_pmc_tio_acpi_match);
> diff --git a/drivers/pps/generators/pps_gen_tio.h b/drivers/pps/generators/pps_gen_tio.h
> index 78d4d7c25221..e652f976e455 100644
> --- a/drivers/pps/generators/pps_gen_tio.h
> +++ b/drivers/pps/generators/pps_gen_tio.h
> @@ -14,9 +14,10 @@
>   #include <linux/pps_gen_kernel.h>
>   #include <linux/spinlock_types.h>
>   
> -#define TIOCTL			0x00
> -#define TIOCOMPV		0x10
> -#define TIOEC			0x30
> +/* PMC Registers */
> +#define TIOCTL_PMC			0x00
> +#define TIOCOMPV_PMC			0x10
> +#define TIOEC_PMC			0x30
>   
>   /* Control Register */
>   #define TIOCTL_EN			BIT(0)
> @@ -32,9 +33,21 @@
>   #define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
>   #define ART_HW_DELAY_CYCLES		2
>   
> +struct pps_tio_regs {
> +	u32 ctl;
> +	u32 compv;
> +	u32 ec;
> +};
> +
> +struct pps_tio_data {
> +	struct pps_tio_regs regs;
> +	u32 num_pins;
> +};
> +
>   struct pps_tio {
>   	struct pps_gen_source_info gen_info;
>   	struct pps_gen_device *pps_gen;
> +	struct pps_tio_regs regs;
>   	struct hrtimer timer;
>   	void __iomem *base;
>   	u32 prev_count;

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


