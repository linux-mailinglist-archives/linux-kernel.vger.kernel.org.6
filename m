Return-Path: <linux-kernel+bounces-376272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712F9AA27B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2291F2360C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657BB19D89B;
	Tue, 22 Oct 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VhclUzgJ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEEA19AD94
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601441; cv=none; b=YHAYiiyugvKF29HkZC18pyD7du96BHCRlktFRbC0LuAcSFN5XFEwm4xh1JA3w03LOS7OmZFdtQXHWe2qMu3yzLfX8oFBNa2EWCC+PpB4FM65F22r0lZn28yK7rE+F+kkg7sM2SDxvKZ56h5OnnaUShda0V7iOPuapOrCsDhj+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601441; c=relaxed/simple;
	bh=tjXLfWzZO/QHP99Gy+N7Afd+5FefwgppKqM8luQx7C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V88eZfugUOfjCU84X/sA5Ljc/gKcvzOfBu7jDoIJtnePdj6FbYVRoiOSu4rn/J298k23Fpj5B2BjuGKXJRg5BONtuds3KbJPVX/xA0EqMdsnmyLTyhv4lWMC8u9XtmGiJgszB0c0pQ1r4jcm+49PcStHGWJ5U2hZLXbxORVNUig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VhclUzgJ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7DB6B49E;
	Tue, 22 Oct 2024 14:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729601331;
	bh=tjXLfWzZO/QHP99Gy+N7Afd+5FefwgppKqM8luQx7C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhclUzgJvfqVpAcz39HRf7svW+otNh7TmlUx2YwU8DApnMzVKTxEJCGWbsARfNLVr
	 qw8oCdSZsHOW1Fj758xYBFRcLdWh8JP803iWcrjh5WKia7Ugxj0lJ9ddI6UUKpkL7d
	 hRoPjsEzvN9x+5aI3bPhtAs8PUbJGiCpvrZ0VE2Y=
Date: Tue, 22 Oct 2024 15:50:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	Haibo Chen <haibo.chen@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] mfd: adp5585: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20241022125031.GA9497@pendragon.ideasonboard.com>
References: <20241022124745.5d8d3778@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022124745.5d8d3778@endymion.delvare>

Hi Jean,

Thank you for the patch.

On Tue, Oct 22, 2024 at 12:47:45PM +0200, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/mfd/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-6.12-rc4.orig/drivers/mfd/Kconfig
> +++ linux-6.12-rc4/drivers/mfd/Kconfig
> @@ -25,7 +25,7 @@ config MFD_ADP5585
>  	select MFD_CORE
>  	select REGMAP_I2C
>  	depends on I2C
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	help
>  	  Say yes here to add support for the Analog Devices ADP5585 GPIO
>  	  expander, PWM and keypad controller. This includes the I2C driver and

-- 
Regards,

Laurent Pinchart

