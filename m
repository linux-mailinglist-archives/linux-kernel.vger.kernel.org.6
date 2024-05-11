Return-Path: <linux-kernel+bounces-176413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FE8C2F84
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 06:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE0D8B22C67
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89945BF1;
	Sat, 11 May 2024 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyZudwWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF828689;
	Sat, 11 May 2024 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715401918; cv=none; b=IUFARE9snkzPDvJIVmPcNluKUDS0WicDFxtk1vlEhdDiAJZIBdcSJov64B6W/tDLGZR6jN3cR9ScLwAxnc+ADKBCQkW+K9L+va4inJiILsN9GEa44ev+4siQo9qfRsjrgXu0UwoIwbcAKZVloHr4imVvTejjd1BIF/tGsxvH+u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715401918; c=relaxed/simple;
	bh=pOHd2qw5bf9nP0s8s0oQXvG+Jy9rv8Fsa9Dig9FNGJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVGAzUo5afYwL1xX4rOFMWMQhgTwmv11/sOZXK4a+/97fipLpyEVA367s/QA0HOoDn1bhw8hVh7589VlCJo1BV4tbolLlqH++P6ewx333zFJwQYwVQjmHNAhe7UBKK7/xc1gjRmjukTFQ0Ku5vFFuExdGzYze+xTtX1TcJL0r8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyZudwWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CCBC2BD10;
	Sat, 11 May 2024 04:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715401918;
	bh=pOHd2qw5bf9nP0s8s0oQXvG+Jy9rv8Fsa9Dig9FNGJ0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kyZudwWWrULxP1VkiwQ47rlUiQTtFT+LQbY6yxz3H8XUhL5qC3/ZZN5M1UG/97SB5
	 F06sypVkvR9aL+O6FmfWicTnB3ePyNfCecj/hVa5DNkuzKGZ2R8uJK4p25BwIM8vEd
	 muAq17+/2mXjMgayZWTnAvGe1X7kevbw7200KChyR/93EOwpQCFSrInXkeTgepsXFS
	 PZ8hGr6ghumgXO2/k2a8J2ZMrw+aLyFrFz074hhLE482XiOc3hZ7bQU+Cxm55c7wPr
	 Iy08VkCMV6SHq7f2Gsrpv9dVs1WHFyEHmjCQp296tYN/0IbsM5ZUuu8O8H3PyoUUxH
	 g7sdTsbNhHr6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6839CE094C; Fri, 10 May 2024 21:31:57 -0700 (PDT)
Date: Fri, 10 May 2024 21:31:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	David Riley <davidriley@chromium.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] time: add MODULE_DESCRIPTION() to time test modules
Message-ID: <779507fe-8794-47f8-9c9c-9dbd5cbe899f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240510-time-md-v1-1-44a8a36ac4b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-time-md-v1-1-44a8a36ac4b0@quicinc.com>

On Fri, May 10, 2024 at 05:24:25PM -0700, Jeff Johnson wrote:
> Fix the make W=1 warnings:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/clocksource-wdtest.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/test_udelay.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/time/time_test.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

From a clocksource-watchdog-test perspective:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/time/clocksource-wdtest.c | 1 +
>  kernel/time/test_udelay.c        | 1 +
>  kernel/time/time_test.c          | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
> index d06185e054ea..62e73444ffe4 100644
> --- a/kernel/time/clocksource-wdtest.c
> +++ b/kernel/time/clocksource-wdtest.c
> @@ -22,6 +22,7 @@
>  #include "tick-internal.h"
>  
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Clocksource watchdog unit test");
>  MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
>  
>  static int holdoff = IS_BUILTIN(CONFIG_TEST_CLOCKSOURCE_WATCHDOG) ? 10 : 0;
> diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
> index 20d5df631570..783f2297111b 100644
> --- a/kernel/time/test_udelay.c
> +++ b/kernel/time/test_udelay.c
> @@ -155,5 +155,6 @@ static void __exit udelay_test_exit(void)
>  
>  module_exit(udelay_test_exit);
>  
> +MODULE_DESCRIPTION("udelay test module");
>  MODULE_AUTHOR("David Riley <davidriley@chromium.org>");
>  MODULE_LICENSE("GPL");
> diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
> index 3e5d422dd15c..2889763165e5 100644
> --- a/kernel/time/time_test.c
> +++ b/kernel/time/time_test.c
> @@ -96,4 +96,5 @@ static struct kunit_suite time_test_suite = {
>  };
>  
>  kunit_test_suite(time_test_suite);
> +MODULE_DESCRIPTION("time unit test suite");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
> change-id: 20240510-time-md-0f1514019230
> 

