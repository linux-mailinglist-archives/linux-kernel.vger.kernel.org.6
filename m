Return-Path: <linux-kernel+bounces-218635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C4F90C2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 883B0B2121E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479961804F;
	Tue, 18 Jun 2024 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAZqtMEo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E4134AC;
	Tue, 18 Jun 2024 04:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718686388; cv=none; b=gfrLgu6nmGB9K5EopBav4Ndfd3EcNEJC9mQqWij2Xpimik7TGbMkluFXROVF7+nEiE0BNlMPsHpqJUCWwwZO0pL71vERuWJXLXXUhPWhHCHSJy2loGSezEH0kcM5Kh0iQyaDPX5MH8Bc2EgGxVknY3sdTo3Nzy4cZx6slwCFeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718686388; c=relaxed/simple;
	bh=nQG2ozuXtUOSTdqSimyv9RBGDU0XpREHXYREIy934Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evnmqcZmBkY/DnP/6oa6mCHgrbxOyvNiWkyKvFL+Mt+PXG+dayIg+ng7VHq3cMaMLlpniKFS5OoIHZ7yOz5RZrhzKvYV4cx6fhHpLJCUEIkP7AH10mh3SYi88JNjsg/Ly08d7Qs4QpYEkLB10fbqTrfzp7ZnrTRdXHxtlBen3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAZqtMEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D13C4AF1D;
	Tue, 18 Jun 2024 04:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718686388;
	bh=nQG2ozuXtUOSTdqSimyv9RBGDU0XpREHXYREIy934Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAZqtMEo/sxEOB9MdPzkbnTvxBvBj0ED1AWxDTDTLtkU8ntdbvWYnSm0weVWZarhw
	 xFjasAxhVqTZGI49eA1mb08R48nbYnbEjuMkIQiLXZhghvqLxYsFQXeJvWRsxzYHKi
	 9n/eKdoLVoMayqZo7Iiv593iikHKn7fdmMESxdduTFH1GrdaC7P4pm/mSCy570Ny3w
	 oi6usvZZmhHFOmVDcT1yxS2Iwj8CpKY8qk8SSnNKe9kz9uj6tzhB8zNwX9Kag5Us6K
	 WRLfGdf2XcwZaXogN6HDD/lGSdDoNuaatD0pJCHN1tVww6VMwkCS72fIextCNPpsxd
	 cXubB6VFol2sQ==
Date: Tue, 18 Jun 2024 12:39:10 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Conor Dooley <conor@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jesse Taube <jesse@rivosinc.com>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Message-ID: <ZnEPbtbLhwZIHUJI@xhacker>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar>
 <ZnBEBQjTQtFs-fXt@xhacker>
 <20240617-synapse-carmaker-0a59c7c6edb7@spud>
 <tencent_26E7381EE1F6C5188428359AF3F908CA680A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_26E7381EE1F6C5188428359AF3F908CA680A@qq.com>

On Tue, Jun 18, 2024 at 12:39:30AM +0800, Yangyu Chen wrote:
> 
> 
> > On Jun 17, 2024, at 23:32, Conor Dooley <conor@kernel.org> wrote:
> > 
> > On Mon, Jun 17, 2024 at 10:11:17PM +0800, Jisheng Zhang wrote:
> >> On Sun, Jun 16, 2024 at 10:48:11PM +0000, Yixun Lan wrote:
> >>> Hi Conor
> >>> Thanks for bringing this up
> >>> 
> >>> On 19:35 Sun 16 Jun     , Conor Dooley wrote:
> >>>> On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
> >>>> 
> >>>> No MAINTAINERS update, so I figure that means you don't want to maintain
> >>>> it going forwards? If there's someone out that that does care about the
> >>>> spacemit k1 (Jesse maybe?), then I'd be more than happy to have them
> >>>> look after it.
> >>> Yangyu kind of has limited time, too many stuff for him..
> >>> 
> >>> I'd volunteered to help on this if it can fill the gap
> >>> Also I'd be more than happy if anyone willing step forward to co-maintain..
> >> 
> >> Does maintainership work like this? Is willing to do enough?
> >> FWICT, maintainership involves active patch contributing, reviewing and
> >> maintaining the whole SoC. It is better to take over the maintainership
> >> after showing enough patch contributions and understanding of the SoC.
> > 
> > I was going to reply to your other patch about providing more complete
> > "basic" support for the SoC, but I guess I'll reply here and address
> > both points. After the k230 and th1520, which were both merged with very
> > basic support and have made very little progress towards being a useful
> > platform, I'm pretty reluctant to merge another platform in a super
> > basic state. I was going to make this point before you brought it up,
> > but it's good to know I am not the only one with that view. To be clear,
> > I'm not pointing blame for those platforms, I'd just like to avoid a
> > repeat. If Yangyu doesn't have time to do any development work on the
> > platform, I'd like to see someone else (and as I mentioned Jesse is
> > interested) take on getting some of the basic driver patches written and
> > merge only when those are accepted. Having no in-tree clock and pinctrl
> > drivers is definitely a hindrance to other people doing parallel
> > development of drivers and I'd like to avoid that.
> > 
> 
> That's also my concern for the first time when I submitted initial
> support for K230. However, for SpacemiT K1, things went differently
> for its UART, and the vendor patched OpenSBI with their NOC-based
> HSM. They didn't use CLINT-MSWI as SBI HSM driver.
> 
> The vendor uses a special intel pxa uart driver, marked deprecated
> in the kernel and incompatible with ns16550. If we use ns16550 in
> the dt, the behavior of uart is like the uart has no interrupt and
> stops working permanently when fifo overruns, making many developers
> not know how to start unless they use the SBI HVC console, which
> needs to turn on CONFIG_NONPORTABLE.
> 
> For the OpenSBI, the vendor does not provide enough ISA string,
> which their chip might support, such as Zicboz. Thus, the OpenSBI
> does not correctly set up the corresponding M-Mode CSR, making the
> kernel panic when the ISA string contains this extension.
> 
> These two things takes me about one week to get the initial mainline
> kernel with full ISA extension and UART to work. Providing this
> information in the commit message helps attract more developers to
> start developing quickly.
> 
> I don't mind whether this series patch will be merged or not. The
> meaning of this series is just providing these informations. However,
> I think some details about bringing up a very basic kernel are
> essential to attract more developers. If a platform has already
> attracted some developer's attention. Providing initial support
> with the commit message to show how to bring it up is not bad.
> 
> The point is that if a developer like me has already done this but
> does not have much time to do further development, should the
> developer become the maintainer? If not, should a developer submit
> patches like this to the mailing list to provide this information
> in the commit message and make it easier for other developers to
> do further development?

This patch series is valueable, especially for the person who
has passion, time to expand the series to get pinctrl, reset and clk
ready so that the SoC is properly modeled even in the initial stage.

> 
> > Getting back to your point in this mail, whoever gets the platform to
> > that state is well suited to looking after it going forwards. Some other
> > interested parties could also join as reviewers. I don't want to see
> > people joining as maintainers that are not going to have an interest
> > in the platform going forward, as that'll just end up with me as the
> > defacto maintainer.
> > 
> 
> I agree. I also have no confidence in joining as a maintainer.
> That's why I didn't change the MAINTAINERS for the first time.
> 
> Thanks,
> Yangyu Chen
> 

