Return-Path: <linux-kernel+bounces-317049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B353F96D89C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FAE2815F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767219AD8B;
	Thu,  5 Sep 2024 12:33:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4281A83CC1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539601; cv=none; b=Z3ypqgVz5cL/pNHcLymgOPgrI5FEw8V3DQVaZMJPQ0+rLE93QJMpkJvUwTzsT+tD8cuijivSP+gG+6ClofZCGFIz5u6u/gcoLJquQa8PL2l7jYLdMB45RERUaXiFxEApCseuAeGAO2nRQ+srBI9Z+gn/e3rh+5/JCPc+NnTnoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539601; c=relaxed/simple;
	bh=MecRGAENHhyfGFAz7r3MsJFRR01iHi9sdLn/98a3Ttk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8OjanUotoz++m/78Y5yAEclc9XEBvZ+QwPBoTUHIkT2n2Qhf5gUgcjA91mdV72dx0lt1Ga/oDdPDwdqUXCLheKXYZ0aQmwCeJ+hSdNWfQLwaXJjsfz9J08wUwsne50qYXowlrLCKvNlHLQExlnQ6UwUUI5uyudz/3oP4z5Gfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: VO34fhYkRSeTbGMzg5Jisw==
X-CSE-MsgGUID: njtI/mOrTW6PfeRpqaAnBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34918004"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34918004"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:33:19 -0700
X-CSE-ConnectionGUID: i1USyyJERJOLLlav3CIv2Q==
X-CSE-MsgGUID: UxMegDvnRjq/rqUFRsCnag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65299117"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:33:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1smBfm-00000005OQg-3VFI;
	Thu, 05 Sep 2024 15:33:14 +0300
Date: Thu, 5 Sep 2024 15:33:14 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Zhang Ning <zhangn1985@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID: <ZtmlCh4NScc25tS2@smile.fi.intel.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com>
 <TY2PR01MB33224CE088EF01D57DE1BABFCD9C2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <CAHp75VeMp9C04iDW5_c9owq3HP=5wvccoOuHwrSQ5SFeV+SRVA@mail.gmail.com>
 <TY2PR01MB3322699682DBE2F13F919F80CD9D2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PR01MB3322699682DBE2F13F919F80CD9D2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 07:27:25PM +0800, Zhang Ning wrote:
> On Wed, Sep 04, 2024 at 05:36:35PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 4, 2024 at 5:29 PM Zhang Ning <zhangn1985@outlook.com> wrote:
> > > On Fri, Aug 09, 2024 at 05:09:49PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Aug 09, 2024 at 08:53:24PM +0800, Zhang Ning wrote:
> > > > > On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> > > > > > On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> > > > > > > Hi, Greg & Rafael
> > > > > > >
> > > > > > > recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> > > > > > > for debian kernel[0]. I find tmu and typec failed to probe.
> > > > > > >
> > > > > > > after check source code, I find irq for these two devices are 0, when
> > > > > > > use platform_get_irq, it will alway fail.
> > > > > > >
> > > > > > >         if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > > > >                 return -EINVAL;
> > > > > > >         return ret;
> > > > > > >
> > > > > > > My workaround for debian is to hardcode irq to 0, instead to use api.
> > > > > > >
> > > > > > > I don't know how to write a good solution, thus send an email to you.
> > > > > >
> > > > > > Hold on, how the heck you got 0 in the first place?A
> > > > >
> > > > > use tmu as an example
> > > > >
> > > > > enum bxtwc_irqs_tmu {
> > > > >         BXTWC_TMU_IRQ = 0,
> > > > > };
> > > > >
> > > > > static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> > > > >         REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
> > > > > };
> > > > >
> > > > > static const struct resource tmu_resources[] = {
> > > > >         DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
> > > > > };
> > > > >
> > > > >         {
> > > > >                 .name = "bxt_wcove_tmu",
> > > > >                 .num_resources = ARRAY_SIZE(tmu_resources),
> > > > >                 .resources = tmu_resources,
> > > > >         },
> > > > >
> > > > > this is why I got 0, and I don't do any hack.
> > > >
> > > > Thanks for elaboration, I will look at this a bit later (may be next or one
> > > > after next week, just returned from vacations).
> > 
> > >    could you share the patch link to the fix? then I could port it to
> > >    debian.
> > 
> > Sorry I was busy with other stuff (as well), I am still in the middle
> > of debugging that.
> > The issue is that the leaf drivers for some reason do not request
> > proper vIRQ (that should come from the secondary IRQ chip). OTOH there
> > is only one _similar_ design in the kernel besides this one. And when
> > I tried to test the version where all this appears, I couldn't boot
> > (yeah, I spent some time on bisecting things) the board I have (One of
> > pre-production variants of Intel Joule SoM).
> 
> Yes, me too. I'm trying to enable Joule on Debian. thus found this
> issue. you can use debian sid with linux 6.11 to debug this issue.
> 
> and another issue is Joule HDA pci id is removed from Linux kernel, thus
> no sound, but I don't plan to submit an issue.
> 
> > Do you have any (most recent) kernel version that works as expected?
> I don't try any old kernel, but from git log, I think bad commit is:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57129044f5044dcd73c22d91491906104bd331fd`

No, it does the right thing from architectural point of view. It might be that
it was never tested or it was a regression somewhere. That's why I wanted to find
the newest possible kernel that works on that machine.

> > > > > > > [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs

-- 
With Best Regards,
Andy Shevchenko



