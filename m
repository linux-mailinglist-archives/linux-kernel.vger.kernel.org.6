Return-Path: <linux-kernel+bounces-411692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9819CFE50
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 11:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC16280CEA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27E196C9B;
	Sat, 16 Nov 2024 10:44:41 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AC194C8B
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731753881; cv=none; b=Ciko2uC5s0NoybFY/ED+0LiaHruYYl5NdFkLKfLEPXBAk/9v7YT6tpCU7JYz7n0lrkMcp5J6VaadPBkzgxVA94HCaZd9nd7AsojeHKUq/XtTZdjmWLdQj1fLYomQPbj9+pMmwCiusZcVJEfBHJyusAnGA0r4+733/tyfvGrZAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731753881; c=relaxed/simple;
	bh=RT334Um1Eqh+TvREoKzZMzj5j8G4vUSTm94Vn5B3XwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+D8b8S7wTREtpWeKjHsZvIBggMmFtYkYV8UHtq10RIwJ9LDIdNMQFEEzslhwyyMQ0XtbxcCakXxl87kL8g6JsfGzwpnh4NkNPqYihqV3monXYkQJFYQD1qzwLMWQIdIv7QnK2RjrRGxwVJKuablAgC6ESj5Ms3ZoQ8W++tGhFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Xr9W84fDjz9sSV;
	Sat, 16 Nov 2024 11:44:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yp4BJPltr9UO; Sat, 16 Nov 2024 11:44:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Xr9W83DqBz9sST;
	Sat, 16 Nov 2024 11:44:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 53FC48B7A0;
	Sat, 16 Nov 2024 11:44:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4zkTht-Dnt66; Sat, 16 Nov 2024 11:44:36 +0100 (CET)
Received: from [192.168.232.159] (POS169858.IDSI0.si.c-s.fr [192.168.232.159])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C77298B763;
	Sat, 16 Nov 2024 11:44:35 +0100 (CET)
Message-ID: <5b44abcc-f629-4250-9edf-7f173b78172c@csgroup.eu>
Date: Sat, 16 Nov 2024 11:44:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241115133802.3919003-1-andriy.shevchenko@linux.intel.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241115133802.3919003-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/11/2024 à 14:38, Andy Shevchenko a écrit :
> Remove legacy-of-mm-gpiochip.h header file, replace of_* functions
> and structs with appropriate alternatives.

Looks like you don't really have an alternative to 
of_mm_gpiochip_add_data(), you are replacing one single line by 11 new 
ones, and that is done twice (once for cpm1_gpiochip_add16(), once for 
cpm1_gpiochip_add32()).

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   arch/powerpc/platforms/8xx/cpm1.c | 119 +++++++++++++++---------------

Does not build:

   CC      arch/powerpc/platforms/8xx/cpm1.o
arch/powerpc/platforms/8xx/cpm1.c: In function 'cpm1_gpiochip_add16':
arch/powerpc/platforms/8xx/cpm1.c:505:2: error: 'g' undeclared (first 
use in this function); did you mean 'gc'?
   g->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
   ^
   gc
arch/powerpc/platforms/8xx/cpm1.c:505:2: note: each undeclared 
identifier is reported only once for each function it appears in
arch/powerpc/platforms/8xx/cpm1.c:509:18: error: too few arguments to 
function 'devm_of_iomap'
   cpm1_gc->regs = devm_of_iomap(dev, np, 0);
                   ^~~~~~~~~~~~~
In file included from ./include/linux/dma-mapping.h:8:0,
                  from arch/powerpc/platforms/8xx/cpm1.c:27:
./include/linux/device.h:372:15: note: declared here
  void __iomem *devm_of_iomap(struct device *dev,
                ^~~~~~~~~~~~~
arch/powerpc/platforms/8xx/cpm1.c: At top level:
arch/powerpc/platforms/8xx/cpm1.c:545:31: error: unknown type name 
'cpm1_gpio32_chip'
  static void __cpm1_gpio32_set(cpm1_gpio32_chip *cpm1_gc, u32 pin_mask, 
int value)
                                ^~~~~~~~~~~~~~~~
arch/powerpc/platforms/8xx/cpm1.c: In function 'cpm1_gpio32_set':
arch/powerpc/platforms/8xx/cpm1.c:565:2: error: implicit declaration of 
function '__cpm1_gpio32_set'; did you mean 'cpm1_gpio32_set'? 
[-Werror=implicit-function-declaration]
   __cpm1_gpio32_set(cpm1_gc, pin_mask, value);
   ^~~~~~~~~~~~~~~~~
   cpm1_gpio32_set
arch/powerpc/platforms/8xx/cpm1.c: In function 'cpm1_gpiochip_add32':
arch/powerpc/platforms/8xx/cpm1.c:625:2: error: 'g' undeclared (first 
use in this function); did you mean 'gc'?
   g->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
   ^
   gc
arch/powerpc/platforms/8xx/cpm1.c:629:18: error: too few arguments to 
function 'devm_of_iomap'
   cpm1_gc->regs = devm_of_iomap(dev, np, 0);
                   ^~~~~~~~~~~~~
In file included from ./include/linux/dma-mapping.h:8:0,
                  from arch/powerpc/platforms/8xx/cpm1.c:27:
./include/linux/device.h:372:15: note: declared here
  void __iomem *devm_of_iomap(struct device *dev,
                ^~~~~~~~~~~~~



>   1 file changed, 60 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
> index b24d4102fbf6..1262bff5ba2e 100644
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
> +	g->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
> +	if (!gc->label)
> +		return -ENOMEM;
> +
> +	cpm1_gc->regs = devm_of_iomap(dev, np, 0);
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
> +static void __cpm1_gpio32_set(cpm1_gpio32_chip *cpm1_gc, u32 pin_mask, int value)
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
> +	g->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
> +	if (!gc->label)
> +		return -ENOMEM;
> +
> +	cpm1_gc->regs = devm_of_iomap(dev, np, 0);
> +	if (IS_ERR(cpm1_gc->regs))
> +		return PTR_ERR(cpm1_gc->regs);
> +
> +	cpm1_gpio32_save_regs(cpm1_gc);
> +
> +	return devm_gpiochip_add_data(dev, gc, cpm1_gc);
>   }
>   
>   #endif /* CONFIG_8xx_GPIO */

