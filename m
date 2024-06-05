Return-Path: <linux-kernel+bounces-203119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5C8FD6B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452A5B2583B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73325152DE3;
	Wed,  5 Jun 2024 19:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q99Quntj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB414D449
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616666; cv=none; b=OVLdckULq35pHbX5dOzrSjHX86mmti4T9uhFIlHKL2LXiKJcGoddMKjuOCFs+3nbKzZkCRdbscwld0qduu4JDiu64tjxUHwBDU2uvLXfyweLQDnBJgd9RXftcHaJLQp0gflTet4DfUnU7IkfsWE3kSxIPq5+oCF21mzF55DvTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616666; c=relaxed/simple;
	bh=KCeniOHRFpzzTdyjs5MfcwvZY4RL5vqjprwOVtavYh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/uXkeFKWadInAFcfttcXswDXh00jgj+fMVjzrpZkqgSLaUH/thZCbSSyZMPBOIA+ocjBROw7gya5FYufZK15lg9ryss2kByDxy/xwxWDr9qJ6Mp4eV708Ja+ttiHzuEjP+nu4BnAbR+2HTAl5ktUypGk64ZqAJaw6Ha2iT5AxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q99Quntj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F8AC2BD11;
	Wed,  5 Jun 2024 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717616666;
	bh=KCeniOHRFpzzTdyjs5MfcwvZY4RL5vqjprwOVtavYh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q99QuntjdVygG3DhQZamPejzmR6f+mOuMZNvYp8uFdB6vyiHK3Uzycwz/kai+au5G
	 FneKlFLCF/YFhm48Vktvcyfb1LmkZj0Ik5BEA751K28ticZOMufwLBMnCl7m/+Yx5I
	 qehPbHDDiY84ljRwFMzplxPBFU96E0Vhm5V+WbbR8XZYf9Bl1Y7jA1j/HI7v/2zHgz
	 +/CFWreAfygAHhYyES+ZmLd32fGevD7QEv5bRrQvqSTiQdm6z7ENGSXKJtV78AjoHH
	 o3CdYIpBtWI8s8p9KBWz2zPDpSRl+A0HokZGeAWQ1ehLdM73hIG7dUDMD/rZvaMNgq
	 alXGzaJqC6awQ==
Received: by pali.im (Postfix)
	id D0085A2F; Wed,  5 Jun 2024 21:44:22 +0200 (CEST)
Date: Wed, 5 Jun 2024 21:44:22 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Benjamin Schneider <bschnei@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Benjamin Schneider <ben@bens.haus>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <20240605194422.klxtxgyljrrllkzy@pali>
References: <20240603012804.122215-1-ben@bens.haus>
 <20240603012804.122215-2-ben@bens.haus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240603012804.122215-2-ben@bens.haus>
User-Agent: NeoMutt/20180716

On Sunday 02 June 2024 18:26:38 Benjamin Schneider wrote:
> This frequency was disabled because of unresolved stability problems.
> However, based on several months of testing, the source of the
> stability problems seems to be the bootloader, not the kernel.
> Marvell has recently merged changes to their bootloader source that
> addresses the stability issues when frequency scaling is enabled at
> all frequencies including 1.2Ghz.
> 
> Signed-off-by: Benjamin Schneider <ben@bens.haus>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index bea41ccab..f28a4435f 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -102,11 +102,7 @@ struct armada_37xx_dvfs {
>  };
>  
>  static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
> -	/*
> -	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
> -	 * unstable because we do not know how to configure it properly.
> -	 */
> -	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} }, */
> +	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
>  	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
>  	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
>  	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },
> -- 
> 2.45.1

As without the updated firmware on 1.2 GHz variant of the SoC is kernel
already crashing, even with commented line for .cpu_freq_max = 1200,
this change makes sense.

There is no reason to have 1.2 GHz line disabled as it does not solve
any issue (as was originally thought) and just prevent people with
updated firmware to use non-performance governor on that SoC.
(When cpufreq driver is not loaded then CPU frequency of the SoC is
locked at the max speed, which has observed behavior same as performance
cpufreq governor).

So, go ahead with this change with my

Reviewed-by: Pali Rohár <pali@kernel.org>

