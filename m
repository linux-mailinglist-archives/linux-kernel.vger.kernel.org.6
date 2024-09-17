Return-Path: <linux-kernel+bounces-331524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2CD97ADE4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BB91F226F5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA1115B0F2;
	Tue, 17 Sep 2024 09:29:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6E15A853
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565388; cv=none; b=dJFDzwQR//T8jzKwU18ngsmivMRI10zdpbTFjnY62LfvuPgXsXhAdetG/buR2s8b6Q4fZxtV2AE2qlaLWko5P06V3HbjDHOzkDC9dQLCbwEe+EFJTPUnoiY64p0P1qfPy2qidcCtiwDDCkE9jrYAJ0j71ULxNKV2ge8zn5MfnfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565388; c=relaxed/simple;
	bh=6z3ylPcsDoxYnF3RvsW/5CW6s7kXk7w3W/c+LA7gHfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw/pXdFsgYQ2A/5Icv89devDqSmoxr7DXwJGaOHquHWCbeS0eN6htOWfeYQfUcssTTN9LDmKQAJ6zTaki/Jz2oiwEAO4yPRW9lKVqWAKcG7gAAcWnuRnNQR0NlqQSqInbX1gaAGGHBUUQEC4cA7HTS5ti3G9+PUqvUWHoh4rV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sqUW5-00028y-I5; Tue, 17 Sep 2024 11:29:01 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sqUW3-008XC0-Rd; Tue, 17 Sep 2024 11:28:59 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sqUW3-00DCdr-2P;
	Tue, 17 Sep 2024 11:28:59 +0200
Date: Tue, 17 Sep 2024 11:28:59 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: ethernet-phy: Add
 timing-role role property for ethernet PHYs
Message-ID: <ZulL2w0s6m7BnqV6@pengutronix.de>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
 <20240913084022.3343903-2-o.rempel@pengutronix.de>
 <ZulHp9IBvptenuRa@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZulHp9IBvptenuRa@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2024 at 10:11:03AM +0100, Russell King (Oracle) wrote:
> On Fri, Sep 13, 2024 at 10:40:21AM +0200, Oleksij Rempel wrote:
> > This patch introduces a new `timing-role` property in the device tree
> > bindings for configuring the master/slave role of PHYs. This is
> > essential for scenarios where hardware strap pins are unavailable or
> > incorrectly configured.
> > 
> > The `timing-role` property supports the following values:
> > - `force-master`: Forces the PHY to operate as a master (clock source).
> > - `force-slave`: Forces the PHY to operate as a slave (clock receiver).
> > - `prefer-master`: Prefers the PHY to be master but allows negotiation.
> > - `prefer-slave`: Prefers the PHY to be slave but allows negotiation.
> > 
> > The terms "master" and "slave" are retained in this context to align
> > with the IEEE 802.3 standards, where they are used to describe the roles
> > of PHY devices in managing clock signals for data transmission. In
> > particular, the terms are used in specifications for 1000Base-T and
> > MultiGBASE-T PHYs, among others. Although there is an effort to adopt
> > more inclusive terminology, replacing these terms could create
> > discrepancies between the Linux kernel and the established standards,
> > documentation, and existing hardware interfaces.
> 
> Does this provide the boot-time default that userspace is subsequently
> allowed to change through ethtool, or does it provide a fixed
> configuration?

It provides the boot-time default.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

