Return-Path: <linux-kernel+bounces-175534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94868C20FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55AE1C215E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9E5161B6A;
	Fri, 10 May 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KMPebKyZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07110A3E;
	Fri, 10 May 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333651; cv=none; b=jYtwqJ+2H/9CiMdLs49Tr9dsLioKcjVvvOD6qdLcaEYnc0YegMIqJRpafwPSaD1ZGhOQhETuRXKKCcGixRZX6VzJjNKIJqDJBrGAbSUauoUAw47JObQcV3Yl28s8wJzlmUYniQGrfQI6Sjs9aRoehz42310m1xm1aNMDIjKTfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333651; c=relaxed/simple;
	bh=PYfpJSicKdob+Dew7EMxzG7V511iTL5iPZFXkg2MC4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoyaFpUbkyKhxCwOGch36XlAIJGr8b3dKmP5MiCdDoIXasCKWHa8Kd4zge+oRsC4W8DfFUwGMixvHqQId3jOR4j0mt/dzLce+hF8wCE58VE6ql0361NryIJFlof7Nc3qqgJL03yZwcWZjrA+zq8wH7POWqySqaL4JJxdQST9+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KMPebKyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4C5C113CC;
	Fri, 10 May 2024 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715333649;
	bh=PYfpJSicKdob+Dew7EMxzG7V511iTL5iPZFXkg2MC4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMPebKyZhF1VD73UY+H2xHl6Zyc+b7YnTd7D8dBxwGZCuJd7OpAKc08BoXT/YsLib
	 sWps0/rY8WjX2EDnbGL2iytunNZWmMOxQnq8C6eBUs9kjbj2k3KAXSUKpzlleIAjSP
	 sy2hTvwoYMq3law1uLj5ug2lL+Jgqoq1TsIk7uF4=
Date: Fri, 10 May 2024 10:34:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] usb: fotg210: Add missing kernel doc description
Message-ID: <2024051047-scrabble-variable-6e29@gregkh>
References: <20240508150335.1378629-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508150335.1378629-1-andriy.shevchenko@linux.intel.com>

On Wed, May 08, 2024 at 06:03:35PM +0300, Andy Shevchenko wrote:
> kernel-doc validator is not happy:
> 
>   warning: Function parameter or struct member 'fotg' not described in 'fotg210_vbus'
> 
> Add missing description.
> 
> Fixes: 3e679bde529e ("usb: fotg210-udc: Implement VBUS session")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/usb/fotg210/fotg210-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
> index 958fc40eae86..00483da40f04 100644
> --- a/drivers/usb/fotg210/fotg210-core.c
> +++ b/drivers/usb/fotg210/fotg210-core.c
> @@ -95,6 +95,7 @@ static int fotg210_gemini_init(struct fotg210 *fotg, struct resource *res,
>  
>  /**
>   * fotg210_vbus() - Called by gadget driver to enable/disable VBUS
> + * @fotg210: pointer to a private fotg210 object
>   * @enable: true to enable VBUS, false to disable VBUS
>   */
>  void fotg210_vbus(struct fotg210 *fotg, bool enable)

I don't think you actually built the documentation after this patch :(

