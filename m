Return-Path: <linux-kernel+bounces-221020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3389490EAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D236B1F246D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A313FD8D;
	Wed, 19 Jun 2024 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wU8YO6+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF314F9EF;
	Wed, 19 Jun 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799518; cv=none; b=sVzi0KfKv2Qtn+PH+CI80YJknhnSFq9JJBOBjOqCO4LwM/1VCvEBelhSCPmKNHwI8/9iwhMGjied093SY4UsP4/SmbEfEJBquwyEBwBzqoUecMOLGeRj/9yv4SuZa80U3RpI7QeVA/eTdt8jCDlCQiSg1H3eZxiivjnL2UA17QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799518; c=relaxed/simple;
	bh=oS16SDxq7LLevQ5fdL1wikBwb3na4x3KCVVA1PsNSXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blWecT5cIo4s9WixoQetSYz0Q4LDgtqkKTGKO4TKRFH8zsTuupAelbfK07Jko/aWFsSDQF4TOy2HFp3SHBCV8uQHmJZr4QC8lPmFa7RNYJJvrrcCtEoiR+4VEpghFu7xkwtD78iFO4oQiPqSzguGOu3x7Ll9sYT8tlWBGCmlyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wU8YO6+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522C2C32786;
	Wed, 19 Jun 2024 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718799517;
	bh=oS16SDxq7LLevQ5fdL1wikBwb3na4x3KCVVA1PsNSXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wU8YO6+yCaSsHwRSHnoxZ1Dof72Uie9MfShkbtQVORWO3BQlw8NkBARGtnDxhiWZZ
	 dmhSSgmYliQJvVyCrQGyTVu3NZLRaemMfE53nZItVHx/goomfKJ2NZBYJctxGtqFdW
	 ffVDkCs0N0WTsWyE1lLqgE6TELV6sTpgfsdadZak=
Date: Wed, 19 Jun 2024 14:18:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Lee Jones <lee@kernel.org>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 resend] MAINTAINERS: Fix 32-bit i.MX platform paths
Message-ID: <2024061920-hardwired-pry-bb81@gregkh>
References: <20240619115610.2045421-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619115610.2045421-1-alexander.stein@ew.tq-group.com>

On Wed, Jun 19, 2024 at 01:56:10PM +0200, Alexander Stein wrote:
> The original patch was created way before the .dts movement on arch/arm.
> But it was patch merged after the .dts reorganization. Fix the arch/arm
> paths accordingly.
> 
> Fixes: 7564efb37346a ("MAINTAINERS: Add entry for TQ-Systems device trees and drivers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c36d72143b995..762e97653aa3c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22930,9 +22930,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
>  L:	linux@ew.tq-group.com
>  S:	Supported
>  W:	https://www.tq-group.com/en/products/tq-embedded/
> -F:	arch/arm/boot/dts/imx*mba*.dts*
> -F:	arch/arm/boot/dts/imx*tqma*.dts*
> -F:	arch/arm/boot/dts/mba*.dtsi
> +F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
> +F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
> +F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
>  F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
>  F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
>  F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
> -- 
> 2.34.1
> 
> 

Why is a MAINTAINERS change needed for stable kernels?

