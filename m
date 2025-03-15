Return-Path: <linux-kernel+bounces-562508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E4A62A07
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BA77A679F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035E31F4E37;
	Sat, 15 Mar 2025 09:26:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844A1F4CBA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742030769; cv=none; b=MvTV/UP1KJgL3UzPuz8uf+wh8Hg7hLm8Lkul2WDf6wPMdXqgN6VDCfDdjKQQxh02WE0xOH692IHS42KlZO3ri4UnKVFIw4nBDO+TY6Qa6TB/cFk3DPXdYHZEdhk3oS1OSiQ/FF0rj5kDFnh823fonWplij8sxApbqHYNedmd7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742030769; c=relaxed/simple;
	bh=7dP1gemwU1OOl+2ffb6QpZFJ60y5VCO/omQBJL5t6Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT34IlpdZPm+ix1kFoZjmcqJw7UyCysm5oB4u44WFd0VsWgImtGSA/vrLtOxVcfwd0oWUOtl49wxuZEMvzOEThSVVXRXQWTYWb1es0P7O/4kYH63gMG1J7fa+1sq1GPW7vuZCs4wh+Z2Zqqf2t+Y0EU2QaiDziumMHqIpim2Jj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ttNm1-00047n-9c; Sat, 15 Mar 2025 10:25:41 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ttNm0-005qTX-1t;
	Sat, 15 Mar 2025 10:25:40 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ttNm0-00EwMG-1T;
	Sat, 15 Mar 2025 10:25:40 +0100
Date: Sat, 15 Mar 2025 10:25:40 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: =?utf-8?Q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Julien Boibessot <julien.boibessot@armadeus.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: opos6ul: add ksz8081 phy properties
Message-ID: <Z9VHlE-5lvtoYFYb@pengutronix.de>
References: <20250314-opos6ul-fix-ethernet-v1-1-1c0172949b40@armadeus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314-opos6ul-fix-ethernet-v1-1-1c0172949b40@armadeus.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Mar 14, 2025 at 05:20:38PM +0100, Sébastien Szymanski wrote:
> Commit c7e73b5051d6 ("ARM: imx: mach-imx6ul: remove 14x14 EVK specific
> PHY fixup") removed a PHY fixup that setted the clock mode and the LED
> mode.
> Make the Ethernet interface work again by doing as advised in the
> commit's log, set clock mode and the LED mode in the device tree.
> 
> Fixes: c7e73b5051d6 ("ARM: imx: mach-imx6ul: remove 14x14 EVK specific PHY fixup")
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Looks good to me. Thank you!
Reviewed by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

