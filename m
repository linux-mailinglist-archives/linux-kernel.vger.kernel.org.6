Return-Path: <linux-kernel+bounces-189284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 547198CEDEE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 07:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517E6B216A5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 05:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A58B644;
	Sat, 25 May 2024 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlCMP2mz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF52913;
	Sat, 25 May 2024 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716613319; cv=none; b=TWaQ72MIUfEJ8UcINTrncfaIwxWMFBVaPkgZN8NtBPgI69v9EYMYIZ80mAvKr1tGVR8sf0/3u8CjwRgGBKtghcm6DmZWg2TYj0tIbdke1poz1GBFthaFxQLJR2wHhBkS7srUpnBo2aPHBpzKkoUZAOABQBZwkOswpTG+Kk4wCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716613319; c=relaxed/simple;
	bh=J9LYVGzOxQPYwrVOWTVSxCqfC+l4YKyMKpoA0Q5Tdn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snLyYoRUrRNe61ZxwOkqlt5miYEfOx5+XK9tf8KkzjNHf50UTAZGEkrjNB7zRBWruqcwtjp8KhQOgyq3sTdVlk19vZCss6inAxjXHnCYxwO71LibdUeR05YaZOs9hUaScWxkPbb1ojF6M/a4LMdsfNeoZ5N6qOyxW8a+vEEovPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlCMP2mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEB1C32782;
	Sat, 25 May 2024 05:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716613318;
	bh=J9LYVGzOxQPYwrVOWTVSxCqfC+l4YKyMKpoA0Q5Tdn0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SlCMP2mzmlwCDrUejywY+td+Chdr7OCXYJTVD2IALDS/cmpxakEF3fAzG3mASfOwC
	 fe9SHGvL1juyc0/cAerYXrAeSJyEUCd/1a632X2KFEFIl0C/LyqVMDd4BMvh2IKbGo
	 U2111VpOjKPTD678A6oECG4lIxYfxz6aPG/KUmXr+JNKQsY7poYYfS+/PiZa0XbiD7
	 WWT3dNC4+wlwwM1NUpro2n5A09muPd/IROybC2bWVKXEFeaQEqqFJhCY8t1Jbibtt2
	 s5OA5QaOC+qyCf1MtKTcOOYVKO4BdOvd4VRfaOFzEvKNyAlivFZzOTKx1lEyjo+jxg
	 Hz2CNH9jsoWiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1D012CE2A84; Fri, 24 May 2024 22:01:58 -0700 (PDT)
Date: Fri, 24 May 2024 22:01:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] locktorture: add MODULE_DESCRIPTION()
Message-ID: <b05ea477-cecc-4745-9c74-e78b21e7a37b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240524-md-locktorture-v1-1-f84c5d07b1ab@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-md-locktorture-v1-1-f84c5d07b1ab@quicinc.com>

On Fri, May 24, 2024 at 05:17:24PM -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/locktorture.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Queued for the v6.11 merge window, thank you!

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 415d81e6ce70..de95ec07e477 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -30,6 +30,7 @@
>  #include <linux/torture.h>
>  #include <linux/reboot.h>
>  
> +MODULE_DESCRIPTION("torture test facility for locking");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
>  
> 
> ---
> base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
> change-id: 20240524-md-locktorture-6d431f82aa24
> 

