Return-Path: <linux-kernel+bounces-194736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918308D4136
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7E0284C18
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E216A375;
	Wed, 29 May 2024 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqrzuXnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE632837F;
	Wed, 29 May 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020975; cv=none; b=lyNbahqw6HaS0+qNKRaPF4QeqEWL2YpMsFL8gpISL2MuiE0r9AqO7DwK8y8A9CY5Vaqkza/+tVU8e3VOxlbGUVGVv19HgiDya9upopkoeXpU/+VxUghc/nRKsjkkcCmvKqvxl8k2gtbE6NuGWsPsULOBKbJNSqwVv5zzSUm2n7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020975; c=relaxed/simple;
	bh=zqXplLo3IUyebn6TUaamzkysme61Xk/+JDrVtVNmDRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryKycvVvCTx7VmcWoo/YftgY525kyrmMEvxFnSyOrTFtpF6sTQtvG4C4y/fisiD667Z9DiTv1PQJC3dRIrPrXMJ8x1HRaFUF6OgyjC4KY/w7w0DYF6ont9QeFSBAG8LWYAHDgBU9TAp1CL9KJOsIsLksjr29C+WfIhJ0P+xkOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqrzuXnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EECC113CC;
	Wed, 29 May 2024 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717020975;
	bh=zqXplLo3IUyebn6TUaamzkysme61Xk/+JDrVtVNmDRI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SqrzuXnSUwZZkHiF8SX74ogMREIZxNa/mUcmU/A4Oqgoa1IjGuYkMV8BO5KE0GZDd
	 sNp76eLfHWDL0bpFljmGZfJXNoVB51cFhMTBtmsTKRllQ6ww8RJpGF10E/Ma2XRg8T
	 NE5Fu1n0cgh6ufkfpyk2h+AMGIb0ZijFpOPrDgdL9hOMAyPeYYLHz8OjSS7AWPB0QW
	 drNJoN3uIX4Lhg+yfARq+/qTGu8MlcEX2Q4PBm1Lj3eyWmI+YhUnxx7x5LhfT5R0jR
	 UO+iH6notw5mS68L7p1kPysRo23eQxVuMgbcfInR70WcG3WIAyN9aMy4BH2p3yBa95
	 /ZvBUfPLF+cfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 99D53CE0EE0; Wed, 29 May 2024 15:16:13 -0700 (PDT)
Date: Wed, 29 May 2024 15:16:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scftorture: make torture_type static
Message-ID: <aa151486-2166-427a-a82f-3f5ed7e6b278@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240529-static-scftorture-v1-1-b0ceaeefebaa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-static-scftorture-v1-1-b0ceaeefebaa@quicinc.com>

On Wed, May 29, 2024 at 01:45:40PM -0700, Jeff Johnson wrote:
> Fix the 'make C=1' warning:
> kernel/scftorture.c:71:6: warning: symbol 'torture_type' was not declared. Should it be static?
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

I queued both this and the scftorture.c fix, thank you!!!

							Thanx, Paul

> ---
>  kernel/scftorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index 59032aaccd18..13ad348143ca 100644
> --- a/kernel/scftorture.c
> +++ b/kernel/scftorture.c
> @@ -67,7 +67,7 @@ torture_param(int, weight_many_wait, -1, "Testing weight for multi-CPU operation
>  torture_param(int, weight_all, -1, "Testing weight for all-CPU no-wait operations.");
>  torture_param(int, weight_all_wait, -1, "Testing weight for all-CPU operations.");
>  
> -char *torture_type = "";
> +static char *torture_type = "";
>  
>  #ifdef MODULE
>  # define SCFTORT_SHUTDOWN 0
> 
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240529-static-scftorture-c86eccd9e30e
> 

