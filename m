Return-Path: <linux-kernel+bounces-308055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A66965698
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BF91C228DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C64114C587;
	Fri, 30 Aug 2024 04:55:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF6142624
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724993716; cv=none; b=FyWLaIKhFPZv8kPiUru7YQVQzX9jaOaK9pEakOYtetqEIBWLradYej0E4x4EYw++3XqMtrLTUPGEg9l5tn18aHWIiNCirSfbuFczbr4zwXfMzltUKpjTPn8oY0Wp+gHE6ftBt1Xc5OI1bFBdnbNlNDaU1m9NEa6sm2BnD1lvtrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724993716; c=relaxed/simple;
	bh=4ebZuVSVPECGZb7x2I4i77gmMDYt9jsjdzMTsqir6vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/nNl6BxiLAbdNcTG1/EQeASYDge1NwCXCDG3XtVNEBDGYS5qA5mnEKKyezU9s7yaGq8lIedEXGnaKu3LnFXJ1VkHS4eQKaXUqDKdzDerIkSqcc0E5LziktoVY/0v89MynbAVbnQRCVAN76w1isE1ZH/XmnB8CQ88CxfOjeqr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjtek-0007qo-Ii; Fri, 30 Aug 2024 06:54:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjtei-0044W3-WF; Fri, 30 Aug 2024 06:54:41 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjtei-00EP15-2r;
	Fri, 30 Aug 2024 06:54:40 +0200
Date: Fri, 30 Aug 2024 06:54:40 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH net-next 2/6] net: ag71xx: update FIFO bits and
 descriptions
Message-ID: <ZtFQkM2vsg6-z-ML@pengutronix.de>
References: <20240829214838.2235031-1-rosenp@gmail.com>
 <20240829214838.2235031-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829214838.2235031-3-rosenp@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2024 at 02:48:21PM -0700, Rosen Penev wrote:
> Taken from QCA SDK. No functional difference as same bits get applied.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

This values can be confirmed by AR9341 documentation
8.19.20 ETH Configuration 4
8.19.21 ETH Configuration 5

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

