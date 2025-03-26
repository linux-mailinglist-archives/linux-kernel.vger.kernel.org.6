Return-Path: <linux-kernel+bounces-577226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCACA719FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92EC17A66F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A6914A614;
	Wed, 26 Mar 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcPsi9Eo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2413C8EA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002161; cv=none; b=aG90lGs5DCH5iiPgK+CeVerXxmWZNh8rGX0TqL2emHKo6DKhz7y1ALriv/uWtCFNf5ZZTfi44Q17cynCyR8J5EYfkEmBE+dVNl/lX2/Nk2ANudQEV2ARXc/LMoyIc7CeRpnrKWoAkVgh68Gbm0L1l6dhKjFlgzvNgWTxdZMimWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002161; c=relaxed/simple;
	bh=pRe/Us8yRQHDlKQLHSWJ7A5NovV1DYDJYNZQ7w5XL9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJe5FPZJrE2P6WodO/qLA5Yt4csjRtxScRMqL4n579p4LezedJ6/+AVlgENPO0AdhOXVEJ7QxFeILKs9kA2nPyR3WmSJIxbby8+zxpFx5t8OM/m5JSt1jKOxi+ejgeps19fQGB7+3wzGmE/NjRFCkDLLXYLSnrU/L12p4Ketslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcPsi9Eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F50C4CEE2;
	Wed, 26 Mar 2025 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743002161;
	bh=pRe/Us8yRQHDlKQLHSWJ7A5NovV1DYDJYNZQ7w5XL9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcPsi9EoySYtvkMWBZ/qmmyF65AfxE4JSnKRcZW1k92O3wWKAWwLjQVs/hudWmVou
	 P8g6FZRaaT9Y81y9LPQnEjTtJlnO4is8A/B+eFohIw/1+jshfMrX5RRIYDhEg0Ix4n
	 vPHedi3FUWM1L32RCVgXRYjoT39X08ALaQHahLDXaqSbcsxeS8bPEA/DF6NprCAxmq
	 Qfz+a2RAJGRKA8AQ26x4cIgo10iUZHSBo/vpytMh7Mj6jgp9LJJ8wiwaE2Fi7INwBh
	 /yuw4CKRvsg7pIBJrbbWW7n4Gj5+CyFrUI4TOxWCYbcurZESAcgBjyUwkOBG2nqB6k
	 7Il54AKH9liBA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1txSU7-000000007cw-16XN;
	Wed, 26 Mar 2025 16:16:03 +0100
Date: Wed, 26 Mar 2025 16:16:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: extend dma mask to 36 bits
Message-ID: <Z-QaMwB215vTKSTq@hovoldconsulting.com>
References: <20250321162331.19507-1-johan+linaro@kernel.org>
 <8edf77d9-1afd-402a-b966-d1b3e5b4ba1b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edf77d9-1afd-402a-b966-d1b3e5b4ba1b@oss.qualcomm.com>

On Wed, Mar 26, 2025 at 08:11:11AM -0700, Jeff Johnson wrote:
> On 3/21/2025 9:23 AM, Johan Hovold wrote:
> > Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
> > without an iommu (under OS control) similar to what was done for ath11k
> > in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
> > DMA").
> > 
> > This specifically avoids using bounce buffers on Qualcomm Snapdragon X
> > Elite machines like the Lenovo ThinkPad T14s when running at EL1.
> > 
> > Note that the mask could possibly be extended further but unresolved DMA
> > issues with 64 GiB X Elite machines currently prevents that from being
> > tested.
> > 
> > Also note that the driver is limited to 32 bits for coherent
> > allocations and that there is no need to check for errors when setting
> > masks larger than 32 bits.
> > 
> > Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> 
> Please make sure to include linux-wireless for all ath.git patches so that
> they are processed by patchwork.kernel.org

Ok, I'll try to remember that, but it seems you need to update
MAINTAINERS to include that list:

	$ scripts/get_maintainer.pl 0001-wifi-ath12k-extend-dma-mask-to-36-bits.patch 
	Jeff Johnson <jjohnson@kernel.org> (supporter:QUALCOMM ATH12K WIRELESS DRIVER)
	ath12k@lists.infradead.org (open list:QUALCOMM ATH12K WIRELESS DRIVER)
	linux-kernel@vger.kernel.org (open list)

Do you want me to resend?

Johan

