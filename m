Return-Path: <linux-kernel+bounces-306125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50520963980
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4461F249CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B0114885B;
	Thu, 29 Aug 2024 04:49:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B113211F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724906966; cv=none; b=WoRKRVshv9I8tJfdOkAcnKcNKbw/uJH1LTN5Xy1xze6iSYK8//oFjeRQtulk+uHO5M0G0Fi8KL3eC0u/PhCOWYhzt02dyEo/PWblbGULtIc+yLWnvVE6L5djRjmrR9wSYIgfTkxk1CX8hYsZcASCOQ0o3p7EMLd4R5F0xG3twNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724906966; c=relaxed/simple;
	bh=ou8ZCm+VJy/tS7kxDoHDiefAOh7OWpgBZy0Ym/EoRD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWdhM6YNHvrYm84awgab6W1gJPdP7vRlZct9DlmZnvGlxK7wsg1fMAYlxq+FKXHu/xSV3wITWCdW+VevL/nnsUt3Cl5oOTkBRhQkVK7fbXBby9MobGHn2+GSUP0iVbmbUMWvxVgUyCIoOeYGB9ZW9H1jEX0nXxXmKE+YcIZMgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjX5t-0002Fg-Tf; Thu, 29 Aug 2024 06:49:13 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjX5t-003per-7t; Thu, 29 Aug 2024 06:49:13 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjX5t-00CYPt-0P;
	Thu, 29 Aug 2024 06:49:13 +0200
Date: Thu, 29 Aug 2024 06:49:13 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCHv4 net-next] net: ag71xx: get reset control using devm api
Message-ID: <Zs_9yVMp8moxGfpE@pengutronix.de>
References: <20240826192904.100181-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826192904.100181-1-rosenp@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2024 at 12:28:45PM -0700, Rosen Penev wrote:
> Currently, the of variant is missing reset_control_put in error paths.
> The devm variant does not require it.
> 
> Allows removing mdio_reset from the struct as it is not used outside the
> function.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

You forgot to include my Reviewed-by tags from v3

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

