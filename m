Return-Path: <linux-kernel+bounces-387020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5849B4AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9921C2295E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327E2206940;
	Tue, 29 Oct 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maPSauNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C05206071
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208048; cv=none; b=hJlg2H47KvsHqcTbuB/6lzuO1zdtOwXHmznCuIlf9S/Yd5v7WcuXsxa6ADbi3OWh8ZKYHazKs4//Ml17DkY9RDRr1hZQVi5tkeSjwgyvMkMSdONYanzfbzeDG5V/FBeeE089WUZIs4AhNAjvL9wZTJZNCxZuC76JBGuxWZpGae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208048; c=relaxed/simple;
	bh=atIdjrSoz8cQOo8Oh3x41BjnGBTqmvpWtHpYQOqBTIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEKyFMpXsJQBF5v+/IBNYYPM5tJkcOkLe0xYjtoG/hIo9ANjm7RxPnPEGqMUtkL/twaRzWd9oz0p23455l/4wTkENpif7tOqx32jwfryXfp6/0tZhJa+vwr67Jj6pQcYoMlTN0pAnvGteb49WUft99sWcW7AhqLp6mMjoxAqbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maPSauNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2F1C4CECD;
	Tue, 29 Oct 2024 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730208048;
	bh=atIdjrSoz8cQOo8Oh3x41BjnGBTqmvpWtHpYQOqBTIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=maPSauNb/CNnnievFOAFYOU7f38+08j7hlhokWmUHB9io3DNtx2BMgx4rZ0txddjB
	 GO8ZTV8Myxrx2wOfS6tluq1+dap7q3kdp9o7AzxslPu8PzWJnGuO7vErF09+/TEoo1
	 XM23aIbOHbl66pxZKZGD46phpT/55IPOE5AbfNddUd7sWMd1Vf13R04tg2TjkwE9Yb
	 X9nAvwaG0+niGCVERR8HS2UT9TMxZQLIL9oBm0k6cn4oKl8R0xerfhbm1u5/XPgjM2
	 yAhn/JrOghfLEPizGb6UQ28HL7Ssbje5uHGypz186z62YAeTi3zJocUTxeNxv8zoXe
	 Gah5N6nGQt5jg==
Date: Tue, 29 Oct 2024 13:20:43 +0000
From: Will Deacon <will@kernel.org>
To: huanglei <huanglei814@163.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>,
	arnd@arndb.de
Subject: Re: Re: [PATCH] arm64/Kconfig: introduce GENERIC_ISA_DMA
Message-ID: <20241029132042.GA4416@willie-the-truck>
References: <20241025011641.4858-1-huanglei814@163.com>
 <20241028150544.GA2445@willie-the-truck>
 <26ed8fbb.1809.192d5ef13e5.Coremail.huanglei814@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26ed8fbb.1809.192d5ef13e5.Coremail.huanglei814@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 29, 2024 at 09:41:08AM +0800, huanglei wrote:
>     Even if MAX_SMA_CANNELS is not defined, as long as GENETIC-SIA_DMA is
>     enabled， request_rma/free_rma  function will also be exported, and
>     other modules using these two interfaces will not encounter link
>     errors.
> 
>     I don't know why others haven't noticed, but I discovered it when
>     debugging pcie parallel port drivers.  And the arm/Kconfig  has been
>     around for a long time.

Please try to avoid top-posting in replies, as it makes the conversation
very hard to follow.

> At 2024-10-28 22:05:45, "Will Deacon" <will@kernel.org> wrote:
> >On Fri, Oct 25, 2024 at 09:16:41AM +0800, huanglei814 wrote:
> >> From: huanglei <huanglei@kylinos.cn>
> >> 
> >> Enable GENERIC_ISA_DMA feature on arm64 platform,
> >> thus, request_dma and free_dma interface can be export.
> >> and driver modules can use the this interfaces on arm64
> >> platform.
> >> 
> >> Currently, many pcie parallel port drivers still use these
> >> interfaces when ported to arm64 platform.
> >
> >Why has it taken so long for anybody to notice?
> >
> >> Signed-off-by: huanglei <huanglei@kylinos.cn>
> >> ---
> >>  arch/arm64/Kconfig | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index fd9df6dcc593..986eb251f68f 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -367,6 +367,9 @@ config GENERIC_CSUM
> >>  config GENERIC_CALIBRATE_DELAY
> >>  	def_bool y
> >>  
> >> +config GENERIC_ISA_DMA
> >> +	def_bool y
> >> +
> >
> > Does this actually do anything without MAX_DMA_CHANNELS defined?
>
>     Even if MAX_SMA_CANNELS is not defined, as long as GENETIC-SIA_DMA is
>     enabled， request_rma/free_rma  function will also be exported, and
>     other modules using these two interfaces will not encounter link
>     errors.

Do the drivers do anything useful after they've linked? Can you please
provide some in-tree examples of drivers that can be used on arm64 only
once GENERIC_ISA_DMA is selected? If they just need some stubs for
request_dma() and free_dma(), then it feels to me like that should be
the default implementation, rather than having to select something to
get them.

Will

