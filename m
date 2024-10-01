Return-Path: <linux-kernel+bounces-345092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6051898B1F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E9DB20ECC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACDF2B9D2;
	Tue,  1 Oct 2024 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ss1cQG4v"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8223129CF6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747592; cv=none; b=EHI5gAv9DublGQbrkgbhfjhtak4EIO5rK1d8klZstcufidXm6+QssdXwT3jaMVN2zLVA3k1l9An0HE29ttLIwlL6uwSE7flJ9ggzGWvH1gn1DrWcRjZ2FRxM+hBfx+FrcH8nzcVvBc9ufqlpJYR2GmnDSwdA7Ms/DRnPsT0KC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747592; c=relaxed/simple;
	bh=HSLFNcBwW9X8/XexZSb2uUsVHMp7iPaMi1f2s2c3VuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3YWa9HsZyoTMevfzNVJ9tErsTm9+dxHZhRAqO4v2MAKJ0e3atHSAm6K/LNO+l9OCcmQkePw/jXJlW6pNH4fjOpGytbrnL/M239EKzgEo1iolpSXa8saEX0YLsYQo7lgAX7/PG6N6LGDyRRR3LJ539vp7QkBvXNbyA9OqRQmbMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ss1cQG4v; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0CBUM69JBOO6lk+BAphqc4aBR26hQrDANhpRMBm6y2w=; b=Ss1cQG4vmYFnMJLr9PY/d2LRQY
	xJrbzAG92r03r1ONWkk8SNp09dqkpFc811rkVKJWTQT+YV0Ar1d/5uTJnqyZmkUHhNO78Sf/BUoej
	WD8X3i2lCZpxaBuUTkAgg3qT8xGsdwXOzkVqnO1lbZ7X6Gfk3nQdWt5viRs5gRpE4528=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svS4T-008gMT-71; Tue, 01 Oct 2024 03:53:01 +0200
Date: Tue, 1 Oct 2024 03:53:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: arm: kirkwood: support nvmem mac address
Message-ID: <e729da5b-3964-4cdc-bdf4-2352be5b093e@lunn.ch>
References: <20240930215934.349238-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930215934.349238-1-rosenp@gmail.com>

On Mon, Sep 30, 2024 at 02:59:34PM -0700, Rosen Penev wrote:
> of_get_ethdev_address gets called too early for nvmem. If EPROBE_DEFER
> gets called, skip so that the ethernet driver can adjust the MAC address
> through nvmem.

Is this from code analysis or do you have a board with real issues? Do
we want to add a Fixed: so it gets back ported in stable?

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  arch/arm/mach-mvebu/kirkwood.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
> index 73b2a86d6489..da347f66900b 100644
> --- a/arch/arm/mach-mvebu/kirkwood.c
> +++ b/arch/arm/mach-mvebu/kirkwood.c
> @@ -86,13 +86,18 @@ static void __init kirkwood_dt_eth_fixup(void)
>  		void __iomem *io;
>  		u8 *macaddr;
>  		u32 reg;
> +		int err;
>  
>  		if (!pnp)
>  			continue;
>  
> -		/* skip disabled nodes or nodes with valid MAC address*/
> -		if (!of_device_is_available(pnp) ||
> -		    !of_get_mac_address(np, tmpmac))
> +		/* skip disabled nodes */
> +		if (!of_device_is_available(pnp))
> +			goto eth_fixup_skip;
> +
> +		/* skip nodes with valid MAC address*/
> +		err = of_get_mac_address(np, tmpmac);
> +		if (err == -EPROBE_DEFER || !err)
>  			goto eth_fixup_skip;

I'm wondering about ordering here. What exactly does EPROBE_DEFER
mean? Does it mean we know there is a MAC address in nvmem, but the
nvmem has not probed yet? Or can it mean, the nvmem has not probed
yet, and maybe there is a MAC address in it, maybe not?

In the maybe not case, we should still be trying to read the MAC from
the hardware and storing it way safe for later use.

	Andrew

