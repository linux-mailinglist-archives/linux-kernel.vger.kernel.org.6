Return-Path: <linux-kernel+bounces-365560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A099E464
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF139B22900
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6E11E4110;
	Tue, 15 Oct 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vtOJWA/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42944683
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989025; cv=none; b=iROKug8qsYnD3Ayei3wYDqNdKebaxjWpl0UeTVyafBut5l1EuhwaGSsnunjHBSPcjtyaT8XNzJ3DnoCuZbrsm8mbcclSGnoIi70Hr98K3hJpwsSQRoUM3T0kdFEa/UNvRKFIRqKT0VGiiG/BQlfv8lPg3tCW5tPGB//XuOBE0HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989025; c=relaxed/simple;
	bh=c7G5sAQyubxgmbQhX09iwpiBcYl22G4olGhAxMgWzX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5xPOOv0k+MG5PZtO71AurFM71kX7IN1zlX+fuWQqQ/GBKZRMUwxjRvUmGKDxEVKnvsJwxR7j/ZhBB+em7y301o+lG9GqrkIiy0ejcdg28A1iX3gqUGHo7zuCCY/DRv/gyilg08vBkrJ8uEkIsDl+og+DHU6aGRL31ywrkcupO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vtOJWA/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DF2C4CECF;
	Tue, 15 Oct 2024 10:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728989024;
	bh=c7G5sAQyubxgmbQhX09iwpiBcYl22G4olGhAxMgWzX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vtOJWA/yh+LgU3EFdXJjXF2UQGXymzNTqmL98DHrfCvWJrJPsjA482hjaPsuUwCzJ
	 Nd6m0YeOxQIvxb8vLSCvs5RhV6zXqUGgMjggbIhatFZEKs3tBiL/3/sxy9SubnZleY
	 CxsqRZsmEmtNIsygSqtYWMtM0YQSoxF4nrp08UnY=
Date: Tue, 15 Oct 2024 12:43:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhinav Srivastava <atg271@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet: Improve formatting of conditional statements
Message-ID: <2024101509-overheat-dole-54e4@gregkh>
References: <20241015044507.1177265-1-atg271@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015044507.1177265-1-atg271@gmail.com>

On Mon, Oct 14, 2024 at 09:45:07PM -0700, Abhinav Srivastava wrote:
> Improve readability of conditional statements in the Octeon ethernet
> driver by removing unnecessary parentheses and adjusting line breaks.
> This change focuses on three functions:
> 
> - cvm_oct_common_change_mtu()
> - cvm_oct_common_set_multicast_list()
> - cvm_oct_set_mac_filter()
> 
> The modifications make the code more consistent with the Linux kernel
> coding style guidelines, specifically in regards to the formatting of
> multi-line conditional statements. No functional changes are made.
> 
> Signed-off-by: Abhinav Srivastava <atg271@gmail.com>

Your subject line looks odd for things that touch this file:

>  drivers/staging/octeon/ethernet.c | 15 ++++++---------

	$ git log --oneline drivers/staging/octeon/ethernet.c | head -n 10
	00d066a4d4ed netdev_features: convert NETIF_F_LLTX to dev->lltx
	c46d4073ec68 staging: octeon: ethernet: Convert to platform remove callback returning void
	5cd4dc44b8a0 Merge tag 'staging-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
	8b6ce9b02672 staging: use of_get_ethdev_address()
	524b09ea34a4 staging: use eth_hw_addr_set() in orphan drivers
	a76053707dbf dev_ioctl: split out ndo_eth_ioctl
	9d31d2338950 Merge tag 'net-next-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
	c295d3007ff6 staging: octeon: Use 'for_each_child_of_node'
	83216e3988cd of: net: pass the dst buffer to of_get_mac_address()
	179f5dc36b0a staging: octeon: repair "fixed-link" support

>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> index a5e99cc78a45..77044b7b40da 100644
> --- a/drivers/staging/octeon/ethernet.c
> +++ b/drivers/staging/octeon/ethernet.c
> @@ -248,9 +248,8 @@ static int cvm_oct_common_change_mtu(struct net_device *dev, int new_mtu)
>  
>  	dev->mtu = new_mtu;
>  
> -	if ((interface < 2) &&
> -	    (cvmx_helper_interface_get_mode(interface) !=
> -		CVMX_HELPER_INTERFACE_MODE_SPI)) {
> +	if (interface < 2 && cvmx_helper_interface_get_mode(interface) !=
> +	CVMX_HELPER_INTERFACE_MODE_SPI){

Surely that can't be right?  Did you run checkpatch.pl after you made
your change?  Please always do so.

Also use scripts/get_maintainer.pl to determine what mailing lists to
send stuff too.

thanks,

greg k-h

