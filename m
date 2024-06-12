Return-Path: <linux-kernel+bounces-211018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB1F904C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06F61C225EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA3416C448;
	Wed, 12 Jun 2024 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="icYHwowA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485D16C434;
	Wed, 12 Jun 2024 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175440; cv=none; b=OMbueUohZGsX3FaJlpV5wnH7Ph3GshKjfWrWk7+GjXl1UzUU9MPFZZnALEsb4u9grkD5nhxiXAGA79079Sj6A402l3/oElH9oHSrrioREpcl6vBj2VxWYyvK7hWipk4Ru3Qh6RgCP2lZWj5W/aRbsXKFazyj6xhuBpFH+y621w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175440; c=relaxed/simple;
	bh=8Z3l3Of9FpQAmG0oeNwXwxLpixI9OgoDOg2PS9Qq8p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YInk7PFvzVdOLhGO0r9NMTKWt/30c4FxhoaRvx6xmFPPt2qy/GVxlEZoZB3iu/eKVCl2o4apKSGxvP4DeWonJHdiXb/rV+THE2JsJx/0dOvetWYc6C6sbfIhpCKw1s+/VibYZuABbbevfEA3sYty2Qm6JydxuP3IGbroY0h1Ylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=icYHwowA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375F0C3277B;
	Wed, 12 Jun 2024 06:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718175439;
	bh=8Z3l3Of9FpQAmG0oeNwXwxLpixI9OgoDOg2PS9Qq8p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icYHwowAi96pGgeE5tFwnZSFIoGxzEyC/hEwobaYnjJ41eKRkl6dSXz0PBOzuRS8X
	 NPZimc/qGJJ6eH5WK/qyLdDlfxIPd7cKsvxugsucVywOCZFIeOHzUUKDKmEZROzeCQ
	 gVxj6SnOD8S5rSgDHbontu/dD+KjKRD5pYshszB8=
Date: Wed, 12 Jun 2024 08:57:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Teddy Engel <engel.teddy@gmail.com>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Fix checkpatch unnecessary parentheses
Message-ID: <2024061235-zoning-recite-dd20@gregkh>
References: <20240611152256.24563-1-engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611152256.24563-1-engel.teddy@gmail.com>

On Tue, Jun 11, 2024 at 04:22:56PM +0100, Teddy Engel wrote:
> Remove unnecessary parentheses - according to checkpatch.pl strict
> 
> Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
> ---
>  drivers/staging/vt6656/TODO       | 2 +-
>  drivers/staging/vt6656/baseband.c | 8 ++++----
>  drivers/staging/vt6656/main_usb.c | 4 ++--
>  drivers/staging/vt6656/usbpipe.c  | 8 ++++----
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/TODO b/drivers/staging/vt6656/TODO
> index e154b2f3b247..507b7aec9f14 100644
> --- a/drivers/staging/vt6656/TODO
> +++ b/drivers/staging/vt6656/TODO
> @@ -11,7 +11,7 @@ TODO:
>  - switch to use LIB80211
>  - switch to use MAC80211
>  - use kernel coding style
> -- checkpatch.pl fixes
> +- checkpatch.pl fixes -- done

When fixing something, you can just remove the line.

>  - sparse fixes
>  - integrate with drivers/net/wireless
>  
> diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
> index ad7b963f0d98..c981fc75a030 100644
> --- a/drivers/staging/vt6656/baseband.c
> +++ b/drivers/staging/vt6656/baseband.c
> @@ -230,8 +230,8 @@ int vnt_vt3184_init(struct vnt_private *priv)
>  
>  	dev_dbg(&priv->usb->dev, "RF Type %d\n", priv->rf_type);
>  
> -	if ((priv->rf_type == RF_AL2230) ||
> -	    (priv->rf_type == RF_AL2230S)) {
> +	if (priv->rf_type == RF_AL2230 ||
> +	    priv->rf_type == RF_AL2230S) {

Sorry, but no, please see the mailing list archives as to why I keep
rejecting these kinds of patches. checkpatch is wrong here.

greg k-h

