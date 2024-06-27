Return-Path: <linux-kernel+bounces-232646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CCD91AC44
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948C11C24D96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C3199254;
	Thu, 27 Jun 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="Jc8xJC6t"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B7197A96
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504457; cv=none; b=KHzl1Lf34osVELzCqYBRHyj3iPvx9uK4M6Oe+9e2UW6QTt6lT7NJatmGjHiMLxA3sPyjSHx+P48JtopvU83FMtBVQFOcV+ceyBBG0hDN0zY2HVo00EhIrVMrHcdklBRZtrLJCAzIZZAFUIUbqHy+f6xVvAUMbVDVw81AxqKOIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504457; c=relaxed/simple;
	bh=xS9G9tJDc7QMILwH4JttXbese3wNuW1FSFSedENwspQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ot2z/wb53BzVFqHirL9YBxQG88z6Lk5fO3MhvrBIcXdMBPnc5Ai9TWoQZcmzvn/xLJL4VLvveVWwzlVlPhqxQgCSJM1QTEO+vj2OtBFeS5bQ4g7cO+WCm5/A0Qy5lALL/W0PmT/Y2Hz+j5WWCVfliczYsi4gRSENaY/WHwBxV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=Jc8xJC6t; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BEE9C000B;
	Thu, 27 Jun 2024 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1719504450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxlkZum+/SesrP8HyR5X9x/qLUUed+cowAzWPTkGNuc=;
	b=Jc8xJC6tHMstMbXdEhrC9wiM6D8ygNxtYlt7LDqjQBiDY3ZM1OCtG/tc496NSAKr0r3OS9
	iCxv270DFZnvkqWfNuQeqSA6AQxuTS1qFFhv6/j84JYVB5ocaImIVJW/pZirNtiGgjLdNs
	9mDDldaPYbO2XYpniB5FIF5YqpiEmYpxbhH4TseSfLGi0og1pi3VwFMdiEj6D+fM3y1A4H
	p5E151p55IgVAvNvnrbNpDWJNkFE0P8ChP65iXMygoCRoVucgDW8MoWJYHzwwdlsdWwu1d
	xhRhYefto/GnNMCUPFVdIIGTBR7wbwfQ7HYhFSQhJa7O+JIeiVP5pQb+/G2uQg==
Message-ID: <e7c4fade-f1c5-43bf-89fe-92349204171f@yoseli.org>
Date: Thu, 27 Jun 2024 18:07:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: Add support for M5441x NFC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Stefan Agner <stefan@agner.ch>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240620-upstream-nfc-mcf5441x-v1-1-69b64807d7a6@yoseli.org>
 <CAMuHMdV6z6OST=U3cvt3NRe3nj7DKCf+0O4v9s14ZV-j2v=qrA@mail.gmail.com>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <CAMuHMdV6z6OST=U3cvt3NRe3nj7DKCf+0O4v9s14ZV-j2v=qrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Geert,

On 27/06/2024 17:01, Geert Uytterhoeven wrote:
> Hi Jean-Michel,
> 
> On Thu, Jun 20, 2024 at 6:25 PM Jean-Michel Hautbois
> <jeanmichel.hautbois@yoseli.org> wrote:
>> The vf610_nfc driver is also the one which should be used for the
>> coldfire series. Sadly, these device don't support device-tree and so we
>> need to do a few modifications:
>> - Adapt the probe to use pdata if available
>> - Add a new variant as there is a small part to adapt in
>>    vf610_nfc_select_target()
>> - Add the corresponding missing register definitions
>>
>> Tested successfully on a 54418 custom board with a raw NAND:
>> [    2.640000] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
>> [    2.650000] nand: Micron MT29F4G08ABADAWP
>> [    2.650000] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
>>
>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> 
> Thanks for your patch!
> 
>> --- a/drivers/mtd/nand/raw/vf610_nfc.c
>> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
>> @@ -810,6 +840,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>>          struct vf610_nfc *nfc;
>>          struct mtd_info *mtd;
>>          struct nand_chip *chip;
>> +       struct nand_chip *pdata;
>>          struct device_node *child;
> 
> As reported by the robot, this is now unused.
> 
>>          int err;
>>          int irq;
>> @@ -820,30 +851,53 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>>
>>          nfc->dev = &pdev->dev;
>>          chip = &nfc->chip;
>> +       pdata = dev_get_platdata(&pdev->dev);
>> +       if (pdata)
>> +               *chip = *pdata;
>> +
>>          mtd = nand_to_mtd(chip);
>>
>>          mtd->owner = THIS_MODULE;
>>          mtd->dev.parent = nfc->dev;
>> -       mtd->name = DRV_NAME;
>> +
>> +       /*
>> +        * We keep the MTD name unchanged to avoid breaking platforms
>> +        * where the MTD cmdline parser is used and the bootloader
>> +        * has not been updated to use the new naming scheme.
>> +        */
>> +       if (!nfc->dev->of_node)
>> +               mtd->name = "NAND";
>> +       else
>> +               mtd->name = DRV_NAME;
>>
>>          irq = platform_get_irq(pdev, 0);
>>          if (irq < 0)
>>                  return irq;
>>
>>          nfc->regs = devm_platform_ioremap_resource(pdev, 0);
>> -       if (IS_ERR(nfc->regs))
>> +       if (IS_ERR(nfc->regs)) {
>> +               dev_err(nfc->dev, "Unable to map registers!\n");
>>                  return PTR_ERR(nfc->regs);
>> +       }
>>
>> +#ifdef CONFIG_OF
> 
> Do you need all the #ifdeffery?

Indeed I removed those ! Thanks.

> 
>>          nfc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> 
> Perhaps replace by devm_clk_get_optional_enabled() instead?
> 
>>          if (IS_ERR(nfc->clk)) {
>>                  dev_err(nfc->dev, "Unable to get and enable clock!\n");
>>                  return PTR_ERR(nfc->clk);
>>          }
>>
>> -       nfc->variant = (enum vf610_nfc_variant)device_get_match_data(&pdev->dev);
>> -       if (!nfc->variant)
>> -               return -ENODEV;
>> +       const void *data = device_get_match_data(&pdev->dev);
>>
>> +       nfc->variant = (enum vf610_nfc_variant)data;
>> +       if (!nfc->variant) {
>> +               dev_err(nfc->dev, "No variant data found!\n");
>> +               return -ENODEV;
>> +       }
>> +#else
>> +       nfc->variant = (enum vf610_nfc_variant)platform_get_device_id(pdev)->driver_data;
>> +#endif
>> +#ifdef CONFIG_OF
>>          for_each_available_child_of_node(nfc->dev->of_node, child) {
> 
> for_each_available_child_of_node_scoped(...), so the child variable
> no longer needs to be declared at the top.
> 
>>                  if (of_device_is_compatible(child, "fsl,vf610-nfc-nandcs")) {
>>
>> @@ -862,6 +916,10 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>>                  dev_err(nfc->dev, "NAND chip sub-node missing!\n");
>>                  return -ENODEV;
>>          }
>> +#else
>> +       nfc->clk = NULL;
>> +       mtd->dev.parent = &pdev->dev;
>> +#endif
>>
>>          chip->options |= NAND_NO_SUBPAGE_WRITE;

New version sent with your suggestions.
Greg, I also created a dedicated patch for the
arch/m68k/include/asm/m5441xsim.h file.

Thanks !
JM

>>
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

