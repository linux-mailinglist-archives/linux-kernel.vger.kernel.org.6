Return-Path: <linux-kernel+bounces-213596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E190907765
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C11C21EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2A414A09F;
	Thu, 13 Jun 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT1KdjTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6912EBF5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293358; cv=none; b=lruFOiwe0YwkOiTLC7e85y69MLS3EPAFLaIrD7a/Hysha5b9TjADFFFV1txf3ZWkYYWw8fgL53WoMkCWMx9r/wBd55cDj9g8IxcoKz9TgoaHtbChR2tyUMaCQEFvmbfomLWAvtkNASeC1ThirGW5xeBZ0D9dmFx4UE4KF36Cm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293358; c=relaxed/simple;
	bh=+cNA8prMtq63BGxILXqlaVJYINbLjR3W4DBSMt5rMmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaNwQmaffb+WsBgYoi3wvFta3q3Urs0B92raFSOGU2sN9m6YouSXx6vsFi2bzr6E5PW2g0ForsXCVbz3g10r31/7uWNbzBLxomRiUgxHJT75VC6S/uw9Mk7AQwYb6KOBvFrWS3FUmzuR/LGyNwuii8clwO/1gX+b0EG1yqjtSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT1KdjTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA334C2BBFC;
	Thu, 13 Jun 2024 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293357;
	bh=+cNA8prMtq63BGxILXqlaVJYINbLjR3W4DBSMt5rMmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LT1KdjTgBnvTkbS9BZb6UBNRHlPqWcYlUWH0Fr0CdxP+qCBLxAgQUxopIhRWSiz1b
	 yv7RdZoAkLM47jsOCQcnKkJXZJda6TJJH/lIl7F7Yp8xsUZtrRe3AIVc6VV2coVVxd
	 hA8ipP5mazHRLISWL+Gqpp3dCt94X8Ziwk6OC6q3DbvX78XOeCsXYqTujnekPcWetL
	 VY4Xh8oXNIAAKoCdsNuYjo5WyCM1OViVKl+rEjRTtVU/9OvS13fusvla7U/Qcn52N7
	 /mEJENGNBOw7reiBFLsFBP6Vu3eMJYNdebmvOKsPWecZQby8sxucJqQIPRPgpIBSRM
	 CPv72iak1q9Jw==
Date: Thu, 13 Jun 2024 16:42:34 +0100
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com
Subject: Re: [PATCH 4/4] mfd: tqmx86: add I2C IRQ support
Message-ID: <20240613154234.GJ2561462@google.com>
References: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
 <18d0348f2f7b70329e44f7759bad7e6fe231dba0.1717499766.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18d0348f2f7b70329e44f7759bad7e6fe231dba0.1717499766.git.matthias.schiffer@ew.tq-group.com>

On Wed, 05 Jun 2024, Matthias Schiffer wrote:

> From: Gregor Herburger <gregor.herburger@tq-group.com>
> 
> The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
> Add module parameter to allow configuring the IRQ number, similar to the
> handling of the GPIO IRQ.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> index cf27497245322..b96af7091b6bc 100644
> --- a/drivers/mfd/tqmx86.c
> +++ b/drivers/mfd/tqmx86.c
> @@ -50,6 +50,7 @@
>  #define TQMX86_REG_IO_EXT_INT_9			2
>  #define TQMX86_REG_IO_EXT_INT_12		3
>  #define TQMX86_REG_IO_EXT_INT_MASK		0x3
> +#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
>  #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
>  #define TQMX86_REG_SAUC		0x17
>  
> @@ -60,7 +61,12 @@ static uint gpio_irq;
>  module_param(gpio_irq, uint, 0);
>  MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
>  
> -static const struct resource tqmx_i2c_soft_resources[] = {
> +static uint i2c_irq;
> +module_param(i2c_irq, uint, 0);
> +MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (7, 9, 12)");

Just one question; what is (7, 9, 12)?

And why is it the same as the GPIO one?  Copy/paste error?

> +static struct resource tqmx_i2c_soft_resources[] = {
> +	DEFINE_RES_IRQ(0),
>  	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
>  };
>  
> @@ -271,6 +277,18 @@ static int tqmx86_probe(struct platform_device *pdev)
>  	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
>  
>  	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
> +		if (i2c_irq) {
> +			err = tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
> +					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
> +			if (err)
> +				i2c_irq = 0;
> +		}
> +
> +		if (i2c_irq)
> +			tqmx_i2c_soft_resources[0].start = i2c_irq;
> +		else
> +			tqmx_i2c_soft_resources[0].flags = 0;
> +
>  		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>  					   tqmx86_i2c_soft_dev,
>  					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
> 

-- 
Lee Jones [李琼斯]

