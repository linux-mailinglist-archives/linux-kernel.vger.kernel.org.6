Return-Path: <linux-kernel+bounces-300324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B68395E261
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C86BB21395
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EED65E093;
	Sun, 25 Aug 2024 07:23:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B11B4A07
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724570626; cv=none; b=W7Zsotph6TvlERGNUm6BEiKwAySoAnU8IEIbkzyzhTZ16/NZdAXciQLv0XagaQzfwwiboFMRrzFxdgpw0cpRg1ZsVLC18+0aVrKoxzAJM916590udsR9K5SEEyKwr+4ZZo7LwsYTL77m6JHIclYxED13cViSGlkmAfUcaRkdZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724570626; c=relaxed/simple;
	bh=ez/J/WQv1YTW5i/up15opC2jNgAa92z+qoZdR7sPpSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv2iEVGr5blOLrpX6C01YIkt+FrpIVhL+562t56Zfx4+dOiX1lwaN3kxvWLPUZhVgLLsfEYDuUYmHntQISe2cFdj0IYD8zxJrfief7pXkZw0MenAX/DRok1IuA+vgZ3Xg99xCw6io84jZQCyIMm6bMCC7IEVssXMX3OSVpfdIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1si7ak-0002oM-V4; Sun, 25 Aug 2024 09:23:14 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1si7ai-002tiR-OT; Sun, 25 Aug 2024 09:23:12 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1si7ai-005AmU-1t;
	Sun, 25 Aug 2024 09:23:12 +0200
Date: Sun, 25 Aug 2024 09:23:12 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net-next] net: ag71xx: get reset control using devm api
Message-ID: <Zsrb4K0XQ2DaotcA@pengutronix.de>
References: <20240824181908.122369-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240824181908.122369-1-rosenp@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2024 at 11:18:56AM -0700, Rosen Penev wrote:
> Currently, the of variant is missing reset_control_put in error paths.
> The devm variant does not require it.
> 
> Allows removing mdio_reset from the struct as it is not used outside the
> function.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
 
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

