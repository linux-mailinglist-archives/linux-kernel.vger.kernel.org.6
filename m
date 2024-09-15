Return-Path: <linux-kernel+bounces-329993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EF5979842
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBA71C21373
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039C1CB302;
	Sun, 15 Sep 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCob5PFn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704F1DFED;
	Sun, 15 Sep 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426139; cv=none; b=rG99Oix8nr3wIPqR5G4zzcgzp1OkoHNWe2fdlgxeVhOOKSk5yW4EpIkyLqWTuVbVH8AY1g4q0BUlWB3epUbN64hR70WWN1vOEsQFnQOz4YpJaYq4oOkNSo9ZnyQyNFTzUJZThnsM5GFYZKzwszfnNiz35g0sTb/5wG4R7+d9Bv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426139; c=relaxed/simple;
	bh=D9HxBLyvzyjMpUPZtpJQHBKYQ4KIWLM8X3qtCbLCPIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZCheZEDr9Ej/Vdg1jDH5KM+ROEKGbGz9zG9a8BmzGKEjo378ybYgEwQM0WMDya44TwgVx/thXo/mdnPAPaIY+gQ8LXRjMsgU1BIcxZA549X8JV01dv/4DKm/1aVOve8NLcxWOxZpG91wkT2+wIp8/2+MnrqCFQW8WuhH99USXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCob5PFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DB2C4CEC3;
	Sun, 15 Sep 2024 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726426138;
	bh=D9HxBLyvzyjMpUPZtpJQHBKYQ4KIWLM8X3qtCbLCPIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCob5PFncPnOltBCI34Wy++9Fid0gdw+N5sHe5Alkj15uVGTX+i6cg6xSon7z9l+T
	 ruVz4sXzK8wmCuFRFMsnUDNbTbyddweDvH1kNR3EC2x7RMkJgSZEoeXGu0TOn11x4c
	 ApeprHMWQanjFRVVs8Rdi1d9W0FjZLRmDoJXuz66UnweYYKYBiEubNeWzf7ypwuFYU
	 M0qkUy9s3H5I35tP3E/4yjmE+AnJynmhSM5hJ2UhCM3FY81CgJjOqRR178CmZSIYEr
	 qJOqk9Cjz56MgRFRcsN8ws0hGaY5RoHctCCOCxE80ocWJVgdJNQ/AqF38HxW2II9cN
	 UAtOJ4T2WRI4A==
Date: Sun, 15 Sep 2024 19:48:53 +0100
From: Simon Horman <horms@kernel.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] ethernet: chelsio: fix a typo
Message-ID: <20240915184853.GC167971@kernel.org>
References: <20240915132133.109268-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915132133.109268-1-algonell@gmail.com>

On Sun, Sep 15, 2024 at 04:21:32PM +0300, Andrew Kreimer wrote:
> Fix a typo in comments.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> Keep the layout intact.
> 
>  drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> index 4c883170683b..422e147f540b 100644
> --- a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> +++ b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> @@ -49,7 +49,7 @@
>  /******************************************************************************/
>  /** S/UNI-1x10GE-XP REGISTER ADDRESS MAP                                     **/
>  /******************************************************************************/
> -/* Refer to the Register Bit Masks bellow for the naming of each register and */
> +/* Refer to the Register Bit Masks below for the naming of each register and  */
>  /* to the S/UNI-1x10GE-XP Data Sheet for the signification of each bit        */
>  /******************************************************************************/

Hi,

net-next is currently closed, as the merge window is open.
Please repost once net-next opens, after v6.12-rc1 has been released,
which will be in in approximately two weeks.

Also, please explicitly target the patch at net-next.

	Subject: [PATCH net-next vN] ...

Link: https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: defer

