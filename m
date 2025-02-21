Return-Path: <linux-kernel+bounces-525479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F3A3F078
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25757A9900
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384EC2040B0;
	Fri, 21 Feb 2025 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="18EQsskM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2D202F8F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130566; cv=none; b=SpATQSjDNSSklCQ6Hta8lSDZGfStIn/NO0+zqNHF/RqAupvlu+GMxHF7hyaf1N5ma3KlpTmNGZMbAare5vpGkNvcrULTfa2VJLC56YzRwOKgwCbiv3iAYfPzKIXIDyccch4vi3ELLEMUq2AUqqEHj4tMuKcfxGh+1cWPYWS5JOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130566; c=relaxed/simple;
	bh=Ey25d9kgI7M6UcGM9VubfVyoNV2YgWP5EB2DILx7ytA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e18wL0Ld7O8H8E/ewmIFl1sw58KpPyIldooLcVjO5rodK9tnLnzXJnBsmuypzQ3rLkZPm0NqALOXe9d8Wv4Dij/sneTrNgYjMcTsXWnn3zWNXk7caf86hAc2EbzEZO3lLjXDYr3R/WgijAA0mT+oZjL3Xvz7vK4ZK95EX4lh6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=18EQsskM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F19EC4CED6;
	Fri, 21 Feb 2025 09:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740130566;
	bh=Ey25d9kgI7M6UcGM9VubfVyoNV2YgWP5EB2DILx7ytA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=18EQsskMOqNGI+GoKSD2oVvPakZxHL+IGD1ZtnXX+2Juf/jm5FOSePKnoAfzTh4zG
	 VqAluqu7KUAXvfVwiCA8k2U3xYGS+HaHjikcRDUdWMvdFM5oU4R/DZodVPIJYkBgs1
	 A3Qwdvdjov7gThtiHpokj9l0MuhykF3E8sVI8Yy8=
Date: Fri, 21 Feb 2025 10:36:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhang Lixu <lixu.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, andi.shyti@kernel.org,
	broonie@kernel.org, stanislaw.gruszka@linux.intel.com,
	zhifeng.wang@intel.com
Subject: Re: [PATCH] MAINTAINERS: Update Intel LJCA maintainer
Message-ID: <2025022134-storewide-greedy-8d4d@gregkh>
References: <20250221083713.25947-1-lixu.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221083713.25947-1-lixu.zhang@intel.com>

On Fri, Feb 21, 2025 at 04:37:12PM +0800, Zhang Lixu wrote:
> Wentong is no longer with Intel, I will take over as the maintainer of the
> Intel LJCA driver.
> 
> Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9fd56f205c0..da09f84a87b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11818,7 +11818,7 @@ F:	drivers/crypto/intel/keembay/ocs-hcu.c
>  F:	drivers/crypto/intel/keembay/ocs-hcu.h
>  
>  INTEL LA JOLLA COVE ADAPTER (LJCA) USB I/O EXPANDER DRIVERS
> -M:	Wentong Wu <wentong.wu@intel.com>
> +M:	Lixu Zhang <lixu.zhang@intel.com>

Wentong also needs to ack this, just because someone leaves a company
does not mean they automatically loose maintainership.

thanks,

greg k-h

