Return-Path: <linux-kernel+bounces-216875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9290A7DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235D028148F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945118FDDA;
	Mon, 17 Jun 2024 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSq3AHCD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE218FC6E;
	Mon, 17 Jun 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610985; cv=none; b=JWN9Owf1qWoUrBms6ti5zlhyOdC07mNn1x2TlI2Zq3OqKYffLKixMTd82GTD02tybVhop+ynkH5VHyA+ry8EP/DM/8ihG2dwNOiN5xt1l0Ts/1FBTJ1OWqPUiRtdquRMPW1wgr0cbgmIJdjAQy9dp65rS8lcgoscQU883GmsdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610985; c=relaxed/simple;
	bh=i640sh2bxuwY+o/xxE+pY/dM5KklB45sLdW0TAwAVIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXtRNf5e3r3Bt+g0OATjAYL4p7AXY6ZTgoFQ87SXKSJEOdiIstP2DqbqTiqlCP5xF8qzvEDZIV5C9RcN6if9LdmZY8g4CvkRHBH3GVah4Br9j4BzBty/3f1PMOrkYgUSTZyQl+T0qdlNrPrFYlMSThjLcO6hsXybCUAOKwZqGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSq3AHCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FBBC2BD10;
	Mon, 17 Jun 2024 07:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718610985;
	bh=i640sh2bxuwY+o/xxE+pY/dM5KklB45sLdW0TAwAVIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSq3AHCDPBQM6l2EXP6Og0NDmAU3mWkhvlIkBPyKOlGxnE2w6dK5WHSUmD7VGURFk
	 drBgrGja4arl7Y46gCme63562c0hFx1h0+7OsjEd3OqplURzv3kjLI5PyieR5FIZtp
	 kdswdMhfc/tvgM/wsHouv+T80w3+Rita/3rXXljvpV2UK2UHxd8VhdDf+gkK+dFXpS
	 mJepuhpdR2NUOGwK3pgTZIKwV5XCam0336gTXL6Svcou+pf6s66dZoadA5/IHeXTso
	 mH9WcnWXaG3CK7l+pKUDxBWZCIBHAz5D5ajbjdN3PZZOwYTIFuRRZ7HJRRSpEbLbnb
	 xZGoqSutd1HOw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sJ7Dx-000000001tm-1pvl;
	Mon, 17 Jun 2024 09:56:22 +0200
Date: Mon, 17 Jun 2024 09:56:21 +0200
From: Johan Hovold <johan@kernel.org>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: disable UCSI on sc8280xp
Message-ID: <Zm_sJb3_xfMgLsnj@hovoldconsulting.com>
References: <20240608114529.23060-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608114529.23060-1-johan+linaro@kernel.org>

[ Trimming CC list ]

Hi Thorsten,

On Sat, Jun 08, 2024 at 01:45:29PM +0200, Johan Hovold wrote:
> Disconnecting an external display triggers a hypervisor reset on the
> Lenovo ThinkPad X13s since 6.10-rc1 which enabled UCSI. Disable it again
> until the regression has been fixed properly.
> 
> Fixes: 3f91a0bf4a0b ("soc: qcom: pmic_glink: reenable UCSI on sc8280xp")
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/soc/qcom/pmic_glink.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> 
> Dmitry reported off-list that his X13s was crashing when he disconnected
> an external display and I tracked it down to the enablement of UCSI in
> 6.10-rc1.
> 
> I have not had time to debug this further, but I'm flagging this as a
> regression and sending an effective so that we have a fall back in case
> this is not fixed in timely manner.
> 
> Note that this likely affects other Qualcomm SoCs as well.
> 
> Johan
> 
> 
> #regzbot introduced: 3f91a0bf4a0b

I noticed that this one did not make into the regression tracker. This
may be related to the fact that this is the second time I'm disabling
UCSI on sc8280xp and apparently I used the same patch Subject last time
so they end up in the same thread on lore:

	https://lore.kernel.org/lkml/20240608114529.23060-1-johan+linaro@kernel.org/

Bjorn has picked up this effective revert for 6.10 now, but I still
figured I'd mentioned this to you in case you want to add it to the
tracker and/or see what can be done to your scripts to avoid having
regressions like this fall through the cracks in the future.

Johan

[ Trying again: ]

#regzbot introduced: 3f91a0bf4a0b

