Return-Path: <linux-kernel+bounces-313242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317C196A23B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E218B289F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D5418FDCD;
	Tue,  3 Sep 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHH7k3x1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6E9188913;
	Tue,  3 Sep 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376889; cv=none; b=GYeGJn+QGJV45ze8857CHfJS7pHvBO+QeB9KDVIL2VGU/zr7HL3jead2apcB71x8ACEQwzMMEs0CpY1CX2LF+MZCacyezHA6cwSB3nleKAgbAR3nI6IjD+YdUEnpBo8pIGsAoNE5NwIogIqO8oh8JSlaevRmknUyKGL44Lt6ZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376889; c=relaxed/simple;
	bh=hhi6tY4jGP/k2j+XpnMsQIByasv4clyAzpjN213Fvik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkNn1ZzGfaiYetw1d1sZo70HYejHdcol9QUAewWXORXMCD5uSL6AIKt6dLTELx7J3Autd4prV/dvX7H8Tod1iXyvxyoNOTNjfRKQgR++jKrxJ1cRzifM+QTqTjlIN7Csj8rEnlmWgRN6bM43IN6xae6iT4ZuLDkhlJ6xWD/oklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHH7k3x1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54E7C4CEC4;
	Tue,  3 Sep 2024 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725376888;
	bh=hhi6tY4jGP/k2j+XpnMsQIByasv4clyAzpjN213Fvik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHH7k3x12V3ImUXVXMjO55WdFyHvHOP3SveyGZL8b1OzTDvrFofYo+mU5GKEb6Rad
	 yqrtffFo7aoPjQvXYDjhnPjxns8r2GbYg2uMdfn4vUgyr0OSUFVuVuTc1x2NneIHAT
	 3D+RAVRp+rR6Hg0oqbcWkV88IoCoTp000RarUJ2RUVZX1/hvWw/JIOtVGuffpBOPH9
	 yyPdQx5vUMss/TsitC5jSKUlnqtV5rLSxI8YLrfovmxYeBGhvDxp7cgro1BFJqrJBO
	 z2RMuLYP1hCSwgTiHpNDl5ZiDIeVcKB8EaFgqPBYHQ4lnUzJ/0VyFk+gQdGhclfAHC
	 kg66KdtYKYqRg==
Date: Tue, 3 Sep 2024 16:21:25 +0100
From: Simon Horman <horms@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ptp: ptp_idt82p33: Convert comma to semicolon
Message-ID: <20240903152125.GA4792@kernel.org>
References: <20240903030303.494089-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903030303.494089-1-nichen@iscas.ac.cn>

On Tue, Sep 03, 2024 at 11:03:02AM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.

Thanks,

It might be nice to add a bit more text here.
Describing the motivation for the change and how the problem was found.

E.g.

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/ptp/ptp_idt82p33.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ptp_idt82p33.c
> index 92bb42c43fb2..d5732490ed9d 100644
> --- a/drivers/ptp/ptp_idt82p33.c
> +++ b/drivers/ptp/ptp_idt82p33.c
> @@ -1171,10 +1171,10 @@ static void idt82p33_caps_init(u32 index, struct ptp_clock_info *caps,
>  	caps->owner = THIS_MODULE;
>  	caps->max_adj = DCO_MAX_PPB;
>  	caps->n_per_out = MAX_PER_OUT;
> -	caps->n_ext_ts = MAX_PHC_PLL,
> -	caps->n_pins = max_pins,
> -	caps->adjphase = idt82p33_adjwritephase,
> -	caps->getmaxphase = idt82p33_getmaxphase,
> +	caps->n_ext_ts = MAX_PHC_PLL;
> +	caps->n_pins = max_pins;
> +	caps->adjphase = idt82p33_adjwritephase;
> +	caps->getmaxphase = idt82p33_getmaxphase;
>  	caps->adjfine = idt82p33_adjfine;
>  	caps->adjtime = idt82p33_adjtime;
>  	caps->gettime64 = idt82p33_gettime;
> -- 
> 2.25.1
> 
> 

