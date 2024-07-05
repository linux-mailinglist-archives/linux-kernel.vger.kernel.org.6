Return-Path: <linux-kernel+bounces-241975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81135928214
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3586E1F25F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DD213F42D;
	Fri,  5 Jul 2024 06:29:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128396E611
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160979; cv=none; b=BKJKfRtHM6UHjc8ujmuxtbx1J5uYwKsbk4ffbHkDUYvlsvHOwqJXvYEd88/RJHS4mYkFq6DyXIwE8YJsALtZuwnPB2Uv3T7sFFhaqWqxHfysxp8ywmTA18l6ZvwETWH/Ip5GyQGzdgSeodQRK80QuemRsLC598LHDpnWZ38ttwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160979; c=relaxed/simple;
	bh=5Ef4WJT1iwgXPMJStNYXCB+2Hk6u8dYrVg+1AB1g10A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnXLyyG8H5YK65Ryiaq2QCfwFvCPeXKRnf7D7Yk9AVBF4m4Jpzg5HSn2ut93UZTN36kN/rIIPIgwjFhe1HiZRmz1BAK6Dpd4PoSAw7bGrVYB0NprFAyEJL/Y+wP73J+zJJNqNkg2iHmG9bj6SlAk2FVbIFS2TILegBUr/K/SLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPcRS-0004x3-8p; Fri, 05 Jul 2024 08:29:10 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPcRQ-007GQD-70; Fri, 05 Jul 2024 08:29:08 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPcRQ-00GM3S-0N;
	Fri, 05 Jul 2024 08:29:08 +0200
Date: Fri, 5 Jul 2024 08:29:08 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung.Huh@microchip.com
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	Arun.Ramadoss@microchip.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Yuiko.Oshino@microchip.com,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Message-ID: <ZoeStBG6aGu9WmHu@pengutronix.de>
References: <20240704135850.3939342-1-o.rempel@pengutronix.de>
 <BL0PR11MB29132F1C667E478728BCE4ECE7DE2@BL0PR11MB2913.namprd11.prod.outlook.com>
 <ZobyTGbbzXlhTBbz@pengutronix.de>
 <BL0PR11MB2913A0855BCD3EFF290F8018E7DE2@BL0PR11MB2913.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL0PR11MB2913A0855BCD3EFF290F8018E7DE2@BL0PR11MB2913.namprd11.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2024 at 08:02:00PM +0000, Woojung.Huh@microchip.com wrote:
> Hi Oleksij,
> 
> phy/microchip.c would be a file for this 100Base-TX PHY of LAN937x.

Thx!

Are there any diagnostic features in this? I was not able to find
anything in the register manual, MDIX status, no cable testing or
counters. Do I hold it wrong? How about the T1 PHY? Are there anything
beside cable testing and SQI?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

