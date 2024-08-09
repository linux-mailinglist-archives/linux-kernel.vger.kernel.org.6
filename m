Return-Path: <linux-kernel+bounces-281008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D7994D1D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16F91F23F3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BDC1946BA;
	Fri,  9 Aug 2024 14:09:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C551957FF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212595; cv=none; b=J+ZEMTtttxqaEzwtbGNa3w/V64/NFBoT/fHtYm54Elh02ai9r811ypfmdK8C490d+kgP7fynP0F0AsmgPc+vLPLKTxHXQDFzAw8/7B6t/BJXfKOCbdmiBPLdnnO1chCiv4AHgCkUcKQGTP4KbCowSlnkRTZ0/h3FkN5IczbmVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212595; c=relaxed/simple;
	bh=S1ohTV6sMFb5O/0bITkq8wljRJ1t90I6Jzr24PKSRVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E69Dao0t1buNwCNU+S9TzKkitnhTudww4tRH6ZX3CUrwTTmCjFlZb6swjdcYnn2TrPGQRf5mjbaEjfUjPjk54BkPePYScHesGkvKtdftpuhoMjOYZFtFZrMW5ShNlM3l6cgWpDzoyrlag2xcZnYO8Qv8PIFaAdGC9hVGcGJ/Ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: +mNGZPVNSna+i15R16eB1Q==
X-CSE-MsgGUID: 5A6sGIXZRBuCbp4ujO+uzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21361686"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21361686"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 07:09:54 -0700
X-CSE-ConnectionGUID: 0lz16Yf7Q/CB3HfRHJe13g==
X-CSE-MsgGUID: gFDJUJNDSGijAF9X4I2M6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62533160"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 07:09:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1scQJR-0000000DRCu-1d9j;
	Fri, 09 Aug 2024 17:09:49 +0300
Date: Fri, 9 Aug 2024 17:09:49 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Zhang Ning <zhangn1985@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID: <ZrYjLdPryElDubaM@smile.fi.intel.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 09, 2024 at 08:53:24PM +0800, Zhang Ning wrote:
> On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> > > Hi, Greg & Rafael
> > > 
> > > recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> > > for debian kernel[0]. I find tmu and typec failed to probe.
> > > 
> > > after check source code, I find irq for these two devices are 0, when
> > > use platform_get_irq, it will alway fail.
> > > 
> > > 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > 		return -EINVAL;
> > > 	return ret;
> > > 
> > > My workaround for debian is to hardcode irq to 0, instead to use api.
> > > 
> > > I don't know how to write a good solution, thus send an email to you.
> > 
> > Hold on, how the heck you got 0 in the first place?A
> 
> use tmu as an example
> 
> enum bxtwc_irqs_tmu {
>         BXTWC_TMU_IRQ = 0,
> };
> 
> static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
>         REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
> };
> 
> static const struct resource tmu_resources[] = {
>         DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
> };
> 
>         {
>                 .name = "bxt_wcove_tmu",
>                 .num_resources = ARRAY_SIZE(tmu_resources),
>                 .resources = tmu_resources,
>         },
> 
> this is why I got 0, and I don't do any hack.

Thanks for elaboration, I will look at this a bit later (may be next or one
after next week, just returned from vacations).

> > > [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs

-- 
With Best Regards,
Andy Shevchenko



