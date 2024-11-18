Return-Path: <linux-kernel+bounces-413044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC9F9D12AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFBD1F2334C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947219C54B;
	Mon, 18 Nov 2024 14:10:14 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2831990C1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939014; cv=none; b=hOyi/Mxxknc5kXSjvSqt9ukIk2R5etiXN+fDZsagrzbUAjUbcATAtTmRN8zwMIhNs3dTJaX539Nq83mTcAdzSq0DVZCWEdq5tTxb5rLsdC1dKjjChQZB/UgPuM+CxVrVEPD211sBRK1KrpyxA87XDhmy/PNX/ZMdJge6q6fdn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939014; c=relaxed/simple;
	bh=wGPBIuVj90SV4APkWaYMpfGIHmLJgRRMmrBDGbesP70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUg4zTrg5xRoBsbn1GhdWBUpOMg61aveZuBOTluY5c5R1+glwqCUhu5VVU/u/Ex7PdqyOrgyWtU62p5Tz8ZlWWaFL3JcvmO4Szzh7hBMG14WwkLZZtt2IYdOMfGQ5C5ywqeEUX4EJgiZfz6w/JAFy+TlceQiqyUl1Q+FtlZ21UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XsTzP6G54z9sPd;
	Mon, 18 Nov 2024 15:10:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KxloadAykXFK; Mon, 18 Nov 2024 15:10:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XsTzP56Lwz9rvV;
	Mon, 18 Nov 2024 15:10:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F0598B767;
	Mon, 18 Nov 2024 15:10:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hhDIJCCuUNsR; Mon, 18 Nov 2024 15:10:09 +0100 (CET)
Received: from [192.168.232.23] (PO27094.IDSI0.si.c-s.fr [192.168.232.23])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 413068B763;
	Mon, 18 Nov 2024 15:10:09 +0100 (CET)
Message-ID: <514964ea-0795-41d6-91d3-f3d4f193fc6d@csgroup.eu>
Date: Mon, 18 Nov 2024 15:10:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
> Remove legacy-of-mm-gpiochip.h header file. The above mentioned
> file provides an OF API that's deprecated. There is no agnostic
> alternatives to it and we have to open code the logic which was
> hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
> drivers are using their own labeling schemas and resource retrieval
> that only a few may gain of the code deduplication, so whenever
> alternative is appear we can move drivers again to use that one.
> 
> As a side effect this change fixes a potential memory leak on
> an error path, if of_mm_gpiochip_add_data() fails.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> v2: fixed build errors (Christophe), improved commit message (Christophe)
>   arch/powerpc/platforms/8xx/cpm1.c | 119 +++++++++++++++---------------
>   1 file changed, 60 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
> index b24d4102fbf6..1dc095ad48fc 100644
> --- a/arch/powerpc/platforms/8xx/cpm1.c
> +++ b/arch/powerpc/platforms/8xx/cpm1.c
> @@ -45,7 +45,7 @@
>   #include <sysdev/fsl_soc.h>
>   
>   #ifdef CONFIG_8xx_GPIO
> -#include <linux/gpio/legacy-of-mm-gpiochip.h>
> +#include <linux/gpio/driver.h>
>   #endif
>   
>   #define CPM_MAP_SIZE    (0x4000)
> @@ -376,7 +376,8 @@ int __init cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
>   #ifdef CONFIG_8xx_GPIO
>   
>   struct cpm1_gpio16_chip {
> -	struct of_mm_gpio_chip mm_gc;
> +	struct gpio_chip gc;
> +	void __iomem *regs;
>   	spinlock_t lock;
>   
>   	/* shadowed data register to clear/set bits safely */
> @@ -386,19 +387,17 @@ struct cpm1_gpio16_chip {
>   	int irq[16];
>   };
>   
> -static void cpm1_gpio16_save_regs(struct of_mm_gpio_chip *mm_gc)
> +static void cpm1_gpio16_save_regs(struct cpm1_gpio16_chip *cpm1_gc)
>   {
> -	struct cpm1_gpio16_chip *cpm1_gc =
> -		container_of(mm_gc, struct cpm1_gpio16_chip, mm_gc);
> -	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
> +	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
>   
>   	cpm1_gc->cpdata = in_be16(&iop->dat);
>   }
>   
>   static int cpm1_gpio16_get(struct gpio_chip *gc, unsigned int gpio)
>   {
> -	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> -	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
> +	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
> +	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
>   	u16 pin_mask;
>   
>   	pin_mask = 1 << (15 - gpio);
> @@ -406,11 +405,9 @@ static int cpm1_gpio16_get(struct gpio_chip *gc, unsigned int gpio)
>   	return !!(in_be16(&iop->dat) & pin_mask);
>   }
>   
> -static void __cpm1_gpio16_set(struct of_mm_gpio_chip *mm_gc, u16 pin_mask,
> -	int value)
> +static void __cpm1_gpio16_set(struct cpm1_gpio16_chip *cpm1_gc, u16 pin_mask, int value)
>   {
> -	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
> -	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
> +	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
>   
>   	if (value)
>   		cpm1_gc->cpdata |= pin_mask;
> @@ -422,38 +419,35 @@ static void __cpm1_gpio16_set(struct of_mm_gpio_chip *mm_gc, u16 pin_mask,
>   
>   static void cpm1_gpio16_set(struct gpio_chip *gc, unsigned int gpio, int value)
>   {
> -	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> -	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
> +	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
>   	unsigned long flags;
>   	u16 pin_mask = 1 << (15 - gpio);
>   
>   	spin_lock_irqsave(&cpm1_gc->lock, flags);
>   
> -	__cpm1_gpio16_set(mm_gc, pin_mask, value);
> +	__cpm1_gpio16_set(cpm1_gc, pin_mask, value);
>   
>   	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
>   }
>   
>   static int cpm1_gpio16_to_irq(struct gpio_chip *gc, unsigned int gpio)
>   {
> -	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> -	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
> +	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
>   
>   	return cpm1_gc->irq[gpio] ? : -ENXIO;
>   }
>   
>   static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>   {
> -	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> -	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
> -	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
> +	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
> +	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
>   	unsigned long flags;
>   	u16 pin_mask = 1 << (15 - gpio);
>   
>   	spin_lock_irqsave(&cpm1_gc->lock, flags);
>   
>   	setbits16(&iop->dir, pin_mask);
> -	__cpm1_gpio16_set(mm_gc, pin_mask, val);
> +	__cpm1_gpio16_set(cpm1_gc, pin_mask, val);
>   
>   	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
>   
> @@ -462,9 +456,8 @@ static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>   
>   static int cpm1_gpio16_dir_in(struct gpio_chip *gc, unsigned int gpio)
>   {
> -	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> -	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
> -	struct cpm_ioport16 __iomem *iop = mm_gc->regs;
> +	struct cpm1_gpio16_chip *cpm1_gc = gpiochip_get_data(gc);
> +	struct cpm_ioport16 __iomem *iop = cpm1_gc->regs;
>   	unsigned long flags;
>   	u16 pin_mask = 1 << (15 - gpio);
>   
> @@ -481,11 +474,10 @@ int cpm1_gpiochip_add16(struct device *dev)
>   {
>   	struct device_node *np = dev->of_node;
>   	struct cpm1_gpio16_chip *cpm1_gc;
> -	struct of_mm_gpio_chip *mm_gc;
>   	struct gpio_chip *gc;
>   	u16 mask;
>   
> -	cpm1_gc = kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
> +	cpm1_gc = devm_kzalloc(dev, sizeof(*cpm1_gc), GFP_KERNEL);
>   	if (!cpm1_gc)
>   		return -ENOMEM;
>   
> @@ -499,10 +491,8 @@ int cpm1_gpiochip_add16(struct device *dev)
>   				cpm1_gc->irq[i] = irq_of_parse_and_map(np, j++);
>   	}
>   
> -	mm_gc = &cpm1_gc->mm_gc;
> -	gc = &mm_gc->gc;
> -
> -	mm_gc->save_regs = cpm1_gpio16_save_regs;
> +	gc = &cpm1_gc->gc;
> +	gc->base = -1;
>   	gc->ngpio = 16;
>   	gc->direction_input = cpm1_gpio16_dir_in;
>   	gc->direction_output = cpm1_gpio16_dir_out;
> @@ -512,30 +502,39 @@ int cpm1_gpiochip_add16(struct device *dev)
>   	gc->parent = dev;
>   	gc->owner = THIS_MODULE;
>   
> -	return of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
> +	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
> +	if (!gc->label)
> +		return -ENOMEM;
> +
> +	cpm1_gc->regs = devm_of_iomap(dev, np, 0, NULL);
> +	if (IS_ERR(cpm1_gc->regs))
> +		return PTR_ERR(cpm1_gc->regs);
> +
> +	cpm1_gpio16_save_regs(cpm1_gc);
> +
> +	return devm_gpiochip_add_data(dev, gc, cpm1_gc);
>   }
>   
>   struct cpm1_gpio32_chip {
> -	struct of_mm_gpio_chip mm_gc;
> +	struct gpio_chip gc;
> +	void __iomem *regs;
>   	spinlock_t lock;
>   
>   	/* shadowed data register to clear/set bits safely */
>   	u32 cpdata;
>   };
>   
> -static void cpm1_gpio32_save_regs(struct of_mm_gpio_chip *mm_gc)
> +static void cpm1_gpio32_save_regs(struct cpm1_gpio32_chip *cpm1_gc)
>   {
> -	struct cpm1_gpio32_chip *cpm1_gc =
> -		container_of(mm_gc, struct cpm1_gpio32_chip, mm_gc);
> -	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
> +	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
>   
>   	cpm1_gc->cpdata = in_be32(&iop->dat);
>   }
>   
>   static int cpm1_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
>   {
> -	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> -	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
> +	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
> +	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
>   	u32 pin_mask;
>   
>   	pin_mask = 1 << (31 - gpio);
> @@ -543,11 +542,9 @@ static int cpm1_gpio32_get(struct gpio_chip *gc, unsigned int gpio)
>   	return !!(in_be32(&iop->dat) & pin_mask);
>   }
>   
> -static void __cpm1_gpio32_set(struct of_mm_gpio_chip *mm_gc, u32 pin_mask,
> -	int value)
> +static void __cpm1_gpio32_set(struct cpm1_gpio32_chip *cpm1_gc, u32 pin_mask, int value)
>   {
> -	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
> -	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
> +	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
>   
>   	if (value)
>   		cpm1_gc->cpdata |= pin_mask;
> @@ -559,30 +556,28 @@ static void __cpm1_gpio32_set(struct of_mm_gpio_chip *mm_gc, u32 pin_mask,
>   
>   static void cpm1_gpio32_set(struct gpio_chip *gc, unsigned int gpio, int value)
>   {
> -	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> -	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
> +	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
>   	unsigned long flags;
>   	u32 pin_mask = 1 << (31 - gpio);
>   
>   	spin_lock_irqsave(&cpm1_gc->lock, flags);
>   
> -	__cpm1_gpio32_set(mm_gc, pin_mask, value);
> +	__cpm1_gpio32_set(cpm1_gc, pin_mask, value);
>   
>   	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
>   }
>   
>   static int cpm1_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>   {
> -	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> -	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
> -	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
> +	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
> +	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
>   	unsigned long flags;
>   	u32 pin_mask = 1 << (31 - gpio);
>   
>   	spin_lock_irqsave(&cpm1_gc->lock, flags);
>   
>   	setbits32(&iop->dir, pin_mask);
> -	__cpm1_gpio32_set(mm_gc, pin_mask, val);
> +	__cpm1_gpio32_set(cpm1_gc, pin_mask, val);
>   
>   	spin_unlock_irqrestore(&cpm1_gc->lock, flags);
>   
> @@ -591,9 +586,8 @@ static int cpm1_gpio32_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>   
>   static int cpm1_gpio32_dir_in(struct gpio_chip *gc, unsigned int gpio)
>   {
> -	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> -	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(&mm_gc->gc);
> -	struct cpm_ioport32b __iomem *iop = mm_gc->regs;
> +	struct cpm1_gpio32_chip *cpm1_gc = gpiochip_get_data(gc);
> +	struct cpm_ioport32b __iomem *iop = cpm1_gc->regs;
>   	unsigned long flags;
>   	u32 pin_mask = 1 << (31 - gpio);
>   
> @@ -610,19 +604,16 @@ int cpm1_gpiochip_add32(struct device *dev)
>   {
>   	struct device_node *np = dev->of_node;
>   	struct cpm1_gpio32_chip *cpm1_gc;
> -	struct of_mm_gpio_chip *mm_gc;
>   	struct gpio_chip *gc;
>   
> -	cpm1_gc = kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
> +	cpm1_gc = devm_kzalloc(dev, sizeof(*cpm1_gc), GFP_KERNEL);
>   	if (!cpm1_gc)
>   		return -ENOMEM;
>   
>   	spin_lock_init(&cpm1_gc->lock);
>   
> -	mm_gc = &cpm1_gc->mm_gc;
> -	gc = &mm_gc->gc;
> -
> -	mm_gc->save_regs = cpm1_gpio32_save_regs;
> +	gc = &cpm1_gc->gc;
> +	gc->base = -1;
>   	gc->ngpio = 32;
>   	gc->direction_input = cpm1_gpio32_dir_in;
>   	gc->direction_output = cpm1_gpio32_dir_out;
> @@ -631,7 +622,17 @@ int cpm1_gpiochip_add32(struct device *dev)
>   	gc->parent = dev;
>   	gc->owner = THIS_MODULE;
>   
> -	return of_mm_gpiochip_add_data(np, mm_gc, cpm1_gc);
> +	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
> +	if (!gc->label)
> +		return -ENOMEM;
> +
> +	cpm1_gc->regs = devm_of_iomap(dev, np, 0, NULL);
> +	if (IS_ERR(cpm1_gc->regs))
> +		return PTR_ERR(cpm1_gc->regs);
> +
> +	cpm1_gpio32_save_regs(cpm1_gc);
> +
> +	return devm_gpiochip_add_data(dev, gc, cpm1_gc);
>   }
>   
>   #endif /* CONFIG_8xx_GPIO */

