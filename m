Return-Path: <linux-kernel+bounces-272108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F5794571E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1322837F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926522C1A5;
	Fri,  2 Aug 2024 04:34:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613621B7F4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 04:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722573266; cv=none; b=bAooYZU2H9NY33Ip/tzczg5mVDt/TbHz9pNgGF26A04pudhBL8S4pQj2pTOOD3qj0BJ7hQOHF0gyd46oDt10bSlIENs+43ATHgt0cmSlyp6Cyzy7YEIvFl7ddGqhtcq3MggN1lv7Zq7Rttq09jk87Idbo0ZsU4wk89HzeK/dwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722573266; c=relaxed/simple;
	bh=Ia3GNH5t4DAVsAiEytxtQpi2Cvt24KTMWtuxBpX/z7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJndnwMZxRujBPnBkjsCsushE5oHrRT9SFxjTH50nw1ZXgz+IHOHuV23lSip4LhsQcC9/Pnppl3P91B1L3wxkjG+oF65kcQvPhel0544i6Ujijd7krI2vmXqDmJDtIoHpBAPA7zqwfkA6Gyu+WTt3cNjz3D1ZCBPA5OQCho2txU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sZjze-00039I-Me; Fri, 02 Aug 2024 06:34:18 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sZjzd-003vQ3-9T; Fri, 02 Aug 2024 06:34:17 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sZjzd-00EngG-0c;
	Fri, 02 Aug 2024 06:34:17 +0200
Date: Fri, 2 Aug 2024 06:34:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next] MAINTAINERS: Add ethtool pse-pd to PSE NETWORK
 DRIVER
Message-ID: <ZqxhyRiR1EPH4l6d@pengutronix.de>
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

