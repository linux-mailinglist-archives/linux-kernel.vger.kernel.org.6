Return-Path: <linux-kernel+bounces-200381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6DB8FAF2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A30C1C20906
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336BF1442F7;
	Tue,  4 Jun 2024 09:46:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857713B58A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494384; cv=none; b=aWz7h3VHv2Go3FSgk6V3E0FDu58lJU/QBK/0B5oBq/P6F1ebOwVdijjncAudOIm8YjYnWPZx0AWwoLk6d6zZwEEd8WB4nWY5htO6H7BwTdSx3ol+ASb7z2u5KhkLRI/oTCXkF48wo8PMa9pjlkok5AW3QlSZiLoG4LkvNWtA+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494384; c=relaxed/simple;
	bh=/zpny/ZM3LBzpHP+P5Rl8ivFh/8aquswNIcUNFLBxoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4QAI3JFg/Xfe5iDlfXzyMIGhjaevqjAwsm6Y12IIB8aeRFAz9u2tWGNyiavW9psrK2bGinGTWc8tGBdh1w1yh9m/Naeml3Z9qHfPO5Hf21G5SAPRKZPejPVTi3KMTQGyMXA1f8+Jvb1y312u/ZjliIvla0merusjbcAxDqukQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 995E71042;
	Tue,  4 Jun 2024 02:46:46 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EC6B3F762;
	Tue,  4 Jun 2024 02:46:21 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:46:19 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: ARM_MHU_V3 should depend on ARM64
Message-ID: <Zl7ia0t2O2xS8PXU@pluto>
References: <e00498fccf6dcbcf63bd24a137bfc7abd1b98345.1716967720.git.geert+renesas@glider.be>
 <Zlb_txl4CqCfxWZz@pluto>
 <CAMuHMdUyW_RxfUaxnyWVzPsdXQWqCQbgZ+avHskinXkrSFqhtw@mail.gmail.com>
 <Zl3HiBX8ih6Sret6@bogus>
 <CAMuHMdVkeKbUa45okF8qGOVVLRcOOtq=54yett+4dbyktCHxeg@mail.gmail.com>
 <20240604070718.ypymfv6j2smvxldr@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604070718.ypymfv6j2smvxldr@bogus>

On Tue, Jun 04, 2024 at 08:07:18AM +0100, Sudeep Holla wrote:
> On Mon, Jun 03, 2024 at 07:52:56PM +0200, Geert Uytterhoeven wrote:
> > Hi Sudeep,
> >
> > On Mon, Jun 3, 2024 at 3:39 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > On Wed, May 29, 2024 at 01:36:42PM +0200, Geert Uytterhoeven wrote:
> > > > On Wed, May 29, 2024 at 12:13 PM Cristian Marussi
> > > > <cristian.marussi@arm.com> wrote:
> > > > > On Wed, May 29, 2024 at 09:30:45AM +0200, Geert Uytterhoeven wrote:
> > > > > > The ARM MHUv3 controller is only present on ARM64 SoCs.  Hence add a
> > > > > > dependency on ARM64, to prevent asking the user about this driver when
> > > > > > configuring a kernel for a different architecture than ARM64.
> > > > >
> > > > > the ARM64 dependency was dropped on purpose after a few iterations of
> > > > > this series since, despite this being an ARM IP, it has really no technical
> > > > > dependency on ARM arch, not even the usual one on ARM AMBA bus, being this a
> > > > > platform driver, so it seemed an uneeded artificial restriction to impose...
> > > > > ...having said that, surely my live testing were performed only on arm64 models
> > > > > as of now.
> > > >
> > > > For that, we have COMPILE_TEST=y.
> > > >
> > > > > So, I am not saying that I am against this proposed fix but what is the
> > > > > issue that is trying to solve, have you seen any compilation error ? or
> > > > > is it just to avoid the user-prompting ?
> > > >
> > > > I did not see a compile error (I didn't enable it on any non-ARM
> > > > platform).
> > > >
> > > > But it is rather futile to ask the user about (thousands of) drivers
> > > > for hardware that cannot possibly be present on the system he is
> > > > configuring a kernel for.
> > >
> > > I am fine with this fix but I have seen quite opposite argument. That is
> > > not to add dependency if it is not strictly required.
> >
> > Can you please point me to that reference?
> >
> 
> I don't have one handy, I need to dig but I have been asked to remove
> in the past.
> 
> > > Also since you state that the fix is to avoid users of other archs being
> > > posed with the question that they may get annoyed or can't answer, I
> > > wonder if the right approach is to make this driver default "n" instead.
> >
> > The driver already defaults to "n" (which is the default default ;-)
> 
> Ah Cristian mentioned the same in private. I may have misunderstood
> then, for some reason I thought explicit default "n" would avoid getting
> the prompt.
> 

I just tried this trick, it does not seem to work: an explict default-n will
anyway trigger a prompt.

> As I said I am fine with the proposed change, just took this discussion
> as a way to learn little more about Kconfig.
> 

Can this be at least

	depends on ARM || ARM64 || COMPILE_TEST

Thanks,
Cristian


