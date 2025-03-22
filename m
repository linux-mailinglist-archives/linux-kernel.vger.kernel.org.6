Return-Path: <linux-kernel+bounces-572454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D02A6CA7A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B1F16D16F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4622A1E1;
	Sat, 22 Mar 2025 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="QA9FhXh+"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69041B21AD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742652667; cv=none; b=SmLIJWqReWPr+Skwz3cGW71OPrKweemgoTSOkzuy7Av4JjJ0gIBw3nSgGTwMkshz7OTUyhSYw+6XvIyHKcDfjPj8Xw7s5Ghsd2lsh6GXBAted1HfvtZjZcxJe/nBCixzGwgSVw33lUNhsVk3rigo5Z5cYZ8NhXY3uXGNpXTDnSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742652667; c=relaxed/simple;
	bh=G1Z9UFHRMq3775bfxwMasta+Xz+dr7DnPOeYXAzGB4E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jz0c1U6Rs4AFlOWb5MUwOe0353cxNycteKoP5/CLvKiCum6O+aTDFA+7TB0rSQNV64Xa+vakfJuQBz5v4MN6n+r710Dm75F2Jd2DFociYy+ZoFM9no3KprWf+oBsfxLtaJ7SJt0vi/fvLInn8dGKY5w28+erQUjfzVpP679Luy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=QA9FhXh+; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dkqU/DbfmSzz4wjuxvy8BHU2ws4WmJo5/bVGqxFBkWc=;
  b=QA9FhXh+69sshlWIlRHeUVbEk7T0c7a28McpAUlLRqquQGzo4SHVV3lg
   JByHBJNngUfwkuroGY8OX1XqW+IdKGFGIGXErEAanSUXzGzrlA0h2hMrz
   nSUZX9kR9rp3N454+400/wjH/04eHDObWSUMv9fmjz5gzm4NFpfDHeLWW
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,267,1736809200"; 
   d="scan'208";a="112317675"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 15:11:03 +0100
Date: Sat, 22 Mar 2025 15:11:02 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
cc: outreachy@lists.linux.dev, julia.lawall@inria.fr, 
    gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: bcm2835-camera: Modify function call
 formatting
In-Reply-To: <Z97Bl9RyFRGZUXNM@HP-650>
Message-ID: <alpine.DEB.2.22.394.2503221510230.12345@hadrien>
References: <Z97Bl9RyFRGZUXNM@HP-650>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 22 Mar 2025, Abraham Samuel Adekunle wrote:

> The line is a function call which ends with an opening parenthesis
> thereby not adhering to the Linux kernel coding style.
>
> Modify the function call to include parameters on the same line as
> the opening parenthesis to improve readability and consistency while
> adhering to Linux coding styles.
>
> Reported by checkpatch:
>
> CHECK: Lines should not end with '('

Please check the get_maintainer script (see tutorial).  It looks like
there are some other people who should receive patches on this driver.

julia


>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> ---
>  .../vc04_services/bcm2835-camera/controls.c        | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> index 6bce45925bf1..e670226f1edf 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> @@ -533,17 +533,15 @@ static int ctrl_set_image_effect(struct bcm2835_mmal_dev *dev,
>
>  		control = &dev->component[COMP_CAMERA]->control;
>
> -		ret = vchiq_mmal_port_parameter_set(
> -				dev->instance, control,
> -				MMAL_PARAMETER_IMAGE_EFFECT_PARAMETERS,
> -				&imagefx, sizeof(imagefx));
> +		ret = vchiq_mmal_port_parameter_set(dev->instance, control,
> +						    MMAL_PARAMETER_IMAGE_EFFECT_PARAMETERS,
> +						    &imagefx, sizeof(imagefx));
>  		if (ret)
>  			goto exit;
>
> -		ret = vchiq_mmal_port_parameter_set(
> -				dev->instance, control,
> -				MMAL_PARAMETER_COLOUR_EFFECT,
> -				&dev->colourfx, sizeof(dev->colourfx));
> +		ret = vchiq_mmal_port_parameter_set(dev->instance, control,
> +						    MMAL_PARAMETER_COLOUR_EFFECT,
> +						    &dev->colourfx, sizeof(dev->colourfx));
>  	}
>
>  exit:
> --
> 2.34.1
>
>

