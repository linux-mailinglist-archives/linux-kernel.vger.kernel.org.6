Return-Path: <linux-kernel+bounces-299875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61AA95DB86
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 06:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D399B21492
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB014B08E;
	Sat, 24 Aug 2024 04:48:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931A5339F
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724474903; cv=none; b=RDRbq7WQbRPMyPAEQjzLMFWBW3Z85D9KLJS58BwChgIBYPw8czX5aHLLNteO+aqzqFV67qUafMkpJvlYEmYZbFuw5qRGBKkhQY2USGz8I4YAZkl+hIjBj/Y9AgJ9JHwyRYhQgHdfPFmcwyGO9ID4YdbSXDsDpR6sSmi24+vMI/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724474903; c=relaxed/simple;
	bh=rk9D33q8kn84aYQ2vFDuhi6NuE8Y6FGmVkjAvkU8XN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqUSHIr1kzCbB45VQ6UcIw7q6LyBTcAfPhWsx1J33upgkY5hLpX+tUn9XsK/sZYSErlKc/X1thmQPMDgKQdnw0QBfJNaN38lUYYD8MmtBeMTqgvdusYGi2m/ItNqZAjDdEracE5urAhEfGma/sfa6Q7hqOENTWTkKdRewNwOj5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1shih6-0001ly-Oj; Sat, 24 Aug 2024 06:48:08 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1shih5-002dp5-SW; Sat, 24 Aug 2024 06:48:07 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1shih5-003MVH-2U;
	Sat, 24 Aug 2024 06:48:07 +0200
Date: Sat, 24 Aug 2024 06:48:07 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net-next] net: ag71xx: add missing reset_control_put
Message-ID: <ZslmB8RZo7z-uZQl@pengutronix.de>
References: <20240823200433.7542-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823200433.7542-1-rosenp@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Rosen,

On Fri, Aug 23, 2024 at 01:04:18PM -0700, Rosen Penev wrote:
> The original downstream driver used devm instead of of. The latter
> requires reset_control_put to be called in all return paths.

At the moment of upstreaming this code, the original driver used
of_reset_control_get_exclusive() and was fixed by f92bbdcc93 ("ath79:
ag71xx-mdio: get reset control using devm api")

Why not port the original fix?
 
Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

