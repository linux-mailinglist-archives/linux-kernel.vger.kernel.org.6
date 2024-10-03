Return-Path: <linux-kernel+bounces-349635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3748798F951
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D49AB20D95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15EA1C245F;
	Thu,  3 Oct 2024 21:57:48 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F46A33F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992668; cv=none; b=SGBV8+v+E5/kN7rdo177G8gaJwCSnlmBHNP3ESREDdabzyFn2Vog3MYdOX9jk5hrdvY/SG+FcVnv8Mz2DJsmpG/vBtorHItMXtxWl+kHOtZPYK+TAn23tD5rLFU0By0+JSUe3a0yzQ9qwc9Dl0nG3FIoItHVEQieWucou6XXYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992668; c=relaxed/simple;
	bh=TTY6zomx2ZQSoj491llg50Y3v88NzS5jt9eldSGnkHY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRZS4umUhnk4dnY/XB5WvuiY5Uwu4zb0SrnLcNU+HbjNzAIPY3Kbxyid6zXWUMrvbpIqQAtEc1rHmGZVG+t93RbHq8O6cwFDjysKftrnNmewD1AhWdcfTVmjgegc3ncjVpd4AAbVN10SMQTEcfB6kprhvK38Dkx63eTJMlBG50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 808c90d5-81d2-11ef-995b-005056bd6ce9;
	Fri, 04 Oct 2024 00:57:37 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 4 Oct 2024 00:57:34 +0300
To: Zhang Ning <zhangn1985@outlook.com>
Cc: Andy Shevchenko <andy@kernel.org>, gregkh@linuxfoundation.org,
	rafael@kernel.org, linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID: <Zv8TTiFLNxWpWHZM@surfacebook.localdomain>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com>
 <TY2PR01MB33224CE088EF01D57DE1BABFCD9C2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR01MB33224CE088EF01D57DE1BABFCD9C2@TY2PR01MB3322.jpnprd01.prod.outlook.com>

Wed, Sep 04, 2024 at 10:29:03PM +0800, Zhang Ning kirjoitti:
> On Fri, Aug 09, 2024 at 05:09:49PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 09, 2024 at 08:53:24PM +0800, Zhang Ning wrote:
> > > On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:

...

> > > > > recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> > > > > for debian kernel[0]. I find tmu and typec failed to probe.
> > > > > 
> > > > > after check source code, I find irq for these two devices are 0, when
> > > > > use platform_get_irq, it will alway fail.
> > > > > 
> > > > > 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > > 		return -EINVAL;
> > > > > 	return ret;
> > > > > 
> > > > > My workaround for debian is to hardcode irq to 0, instead to use api.
> > > > > 
> > > > > I don't know how to write a good solution, thus send an email to you.
> > > > 
> > > > Hold on, how the heck you got 0 in the first place?A
> > > 
> > > use tmu as an example
> > > 
> > > enum bxtwc_irqs_tmu {
> > >         BXTWC_TMU_IRQ = 0,
> > > };
> > > 
> > > static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> > >         REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
> > > };
> > > 
> > > static const struct resource tmu_resources[] = {
> > >         DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
> > > };
> > > 
> > >         {
> > >                 .name = "bxt_wcove_tmu",
> > >                 .num_resources = ARRAY_SIZE(tmu_resources),
> > >                 .resources = tmu_resources,
> > >         },
> > > 
> > > this is why I got 0, and I don't do any hack.
> > 
> > Thanks for elaboration, I will look at this a bit later (may be next or one
> > after next week, just returned from vacations).
> 
>    could you share the patch link to the fix? then I could port it to
>    debian.

FWIW, the fix series is available here [1]. Please, test.

[1]: https://lore.kernel.org/platform-driver-x86/20241003174252.1190628-2-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko



