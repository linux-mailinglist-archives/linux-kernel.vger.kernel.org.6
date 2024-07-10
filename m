Return-Path: <linux-kernel+bounces-247021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2E92CA04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 06:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D180A28174F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854B040862;
	Wed, 10 Jul 2024 04:49:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C429AB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586968; cv=none; b=XsafOa3h662oEj4BvLGX2uKOSjMaHPbL7385XPvYgygyukYFOrXEXLMiOVWNe0iuiahF/FvPh8nRUaHlPOMWbKD9zAHPZtcx8004Kz/6knjjsuZRM9evR4AkUuu8VWAMMBwJ+uNh1JJSZNqpe2efREyn8Geeq9T3CDyhoXU3McM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586968; c=relaxed/simple;
	bh=xSchiPNrxhR9nMUskf+Vua7v4cO6bQOX+zcwSb5XdbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tieKTAtsHLwbizzNKE+scnO94Q2vCNbDEO9/OoLZ4gVeW1pGyBobFmDPLXFNhWY8pOY/blaX00VfoNfU4+6nbGasT9eCVEw35rFVginpntt0HOHcy5qJdKxaSOx0BlMMgL/4tqwRZx9RUmjeVCMxU77jbbUG9FZS0YoNynmhWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sRPGb-0006vq-Cu; Wed, 10 Jul 2024 06:49:21 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sRPGa-008RAB-0j; Wed, 10 Jul 2024 06:49:20 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sRPGZ-008Ks4-30;
	Wed, 10 Jul 2024 06:49:19 +0200
Date: Wed, 10 Jul 2024 06:49:19 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next] MAINTAINERS: Add ethtool pse-pd to PSE NETWORK
 DRIVER
Message-ID: <Zo4Sz-EitiDPxh8V@pengutronix.de>
References: <20240709130637.163991-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240709130637.163991-1-kory.maincent@bootlin.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2024 at 03:06:36PM +0200, Kory Maincent wrote:
> Add net/ethtool/pse-pd.c to PSE NETWORK DRIVER to receive emails concerning
> modifications to the ethtool part.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0f28278e504..b8312a8ba808 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18050,6 +18050,7 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/pse-pd/
>  F:	drivers/net/pse-pd/
> +F:	net/ethtool/pse-pd.c
>  
>  PSTORE FILESYSTEM
>  M:	Kees Cook <kees@kernel.org>
> -- 
> 2.34.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

