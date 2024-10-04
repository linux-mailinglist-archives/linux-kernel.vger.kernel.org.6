Return-Path: <linux-kernel+bounces-350246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4432099020C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AB1283634
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A916157492;
	Fri,  4 Oct 2024 11:28:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E7137903
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728041330; cv=none; b=VY6knPJ21NpA6KZcbyJB5lrZ2/+t8pnZauFb+Y4ksncWMVGhs0fK/Kb+uduVrUVRAqAnPyQYz33rpnY3HsSYF1Vd2LoesCHDFrgFIdNCGd93bSGm/rL4ZaccbdeilV/CkzrTNJcwlPsQzb8jFyNN+3ZkjolIQAuiRc7mvEaOU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728041330; c=relaxed/simple;
	bh=TMCTua+WSh+xta2fTLxp7TAvOG3Qg5iX+WemrbYBX/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHHjlH4Dj+qxIudr39ICzLuSUKFsWjCSH7Vsf2fx/OtTpFNdau4V5FpqMUSCTOFNjJ/vdqN+cr0KbhRXnk/veyx3k3xsc4xQgD3DYmHRnl878VIZH0q1Odp8fr0c/ttMBgt7hhZ1Zw3OyITMvz+WRrYFih2G3uwSMzRByVts7uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1swgU2-0005Pf-UB; Fri, 04 Oct 2024 13:28:30 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1swgU0-003YgO-WE; Fri, 04 Oct 2024 13:28:29 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1swgU0-00Ag87-2r;
	Fri, 04 Oct 2024 13:28:28 +0200
Date: Fri, 4 Oct 2024 13:28:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Divya.Koppera@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, f.fainelli@gmail.com,
	maxime.chevallier@bootlin.com, kory.maincent@bootlin.com,
	lukma@denx.de, corbet@lwn.net, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux@armlinux.org.uk
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: add Twisted
 Pair Ethernet diagnostics at OSI Layer 1
Message-ID: <Zv_RXMRn83Tshf0H@pengutronix.de>
References: <20241003060602.1008593-1-o.rempel@pengutronix.de>
 <CO1PR11MB477100FB112A842674009A1AE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CO1PR11MB477100FB112A842674009A1AE2712@CO1PR11MB4771.namprd11.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Divya,

On Thu, Oct 03, 2024 at 10:00:21AM +0000, Divya.Koppera@microchip.com wrote:
> Hi @Oleksij Rempel<mailto:o.rempel@pengutronix.de>,
> 
> 
....
> 
> > +  - **Advertised auto-negotiation**:
> 
> > +
> 
> > +    - For **SPE** links (except **10BaseT1L**), this will be **No**.
> 
> 
> 
> May be to generalize statement for T1 phys, I would suggest it should be referred as "Yes" in case of auto-negotiation is enabled, "No" if auto-negotiation is disabled.
> 
> 
> 
> We are submitting patches for lan887x(100/1000BaseT1) and soon we will add support for auto-negotiation as well.

Ah, I see. Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

