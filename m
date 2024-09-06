Return-Path: <linux-kernel+bounces-319153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F266496F8A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15C1281F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C31D319F;
	Fri,  6 Sep 2024 15:51:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A072374F1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637872; cv=none; b=rPBNFeOV398WBBkIwLkrnOKdNq6ukpgG6QwGoMavLPQyUJjpLVR8Yn8nhQwyoipakazfa4/J7tDt9JY2M+I7Qy/nlLmQQodoDlokJsh7o2VR16EgZ80LT4O6qBj6r3Vkv37XrGfqDaNosmOs2BQ1Z403G6YT6clNCAElXRtruqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637872; c=relaxed/simple;
	bh=qo8O1h2lAqqv1CX/RzBNtMvvKqsJQzhgLJn7r2wlNX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2NhwKhOQm9CntEu7vo03SptXjkQYC53yi9jC89yYMdQjqO3oYYftueWpXkWMXSLGIgfvHBigRmhC75PZ0Z6kqlMgSFEEDQAgQf8LRfXsxd4kauzvcFdwd5+pUTP45Ph2si09r52hVaUoLch4faid3CyetLU+yv1I1Al3SA5tBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1smbEb-0007zn-CX; Fri, 06 Sep 2024 17:50:53 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1smbEZ-005ysl-Jh; Fri, 06 Sep 2024 17:50:51 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1smbEZ-00A9vb-1b;
	Fri, 06 Sep 2024 17:50:51 +0200
Date: Fri, 6 Sep 2024 17:50:51 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: net: ethernet-phy: Add
 forced-master/slave properties for SPE PHYs
Message-ID: <Ztsk23X_0p57KGSS@pengutronix.de>
References: <20240906144905.591508-1-o.rempel@pengutronix.de>
 <c08ac9b7-08e1-4cde-979c-ed66d4a252f1@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c08ac9b7-08e1-4cde-979c-ed66d4a252f1@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2024 at 05:11:54PM +0200, Andrew Lunn wrote:
> On Fri, Sep 06, 2024 at 04:49:05PM +0200, Oleksij Rempel wrote:
> > Add two new properties, `forced-master` and `forced-slave`, to the
> > ethernet-phy binding. These properties are intended for Single Pair
> > Ethernet (1000/100/10Base-T1) PHYs, where each PHY and product may have
> > a predefined link role (master or slave). Typically, these roles are set
> > by hardware strap pins, but in some cases, device tree configuration is
> > necessary.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  .../devicetree/bindings/net/ethernet-phy.yaml | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > index d9b62741a2259..af7a1eb6ceff6 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
> > @@ -158,6 +158,28 @@ properties:
> >        Mark the corresponding energy efficient ethernet mode as
> >        broken and request the ethernet to stop advertising it.
> > 
> > +  forced-master:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      If set, forces the PHY to operate as a master. This is used in Single Pair
> > +      Ethernet (1000/100/10Base-T1) where each PHY and product has a predefined
> > +      link role (master or slave). This property is board-specific, as the role
> > +      is usually configured by strap pins but can be set through the device tree
> > +      if needed.
> > +      This property is mutually exclusive with 'forced-slave'; only one of them
> > +      should be used.
> 
> DT reviewers tend to complain about such mutually exclusive
> properties.

Yes, at this point i was uncertain.

> What you are effectively adding is support for the ethtool:
> 
> ethtool -s [master-slave preferred-master|preferred-slave|forced-master|forced-slave]

ack

> 10Base-T1 often does not have autoneg, so preferred-master &
> preferred-slave make non sense in this context, but i wounder if
> somebody will want these later. An Ethernet switch is generally
> preferred-master for example, but the client is preferred-slave.

Good point.

> Maybe make the property a string with supported values 'forced-master'
> and 'forced-slave', leaving it open for the other two to be added
> later.
> 
> I've not seen the implementation yet, but i don't think there is much
> driver specific here. We already have phydev->master_slave_set, it
> just needs to be set from this property. Can it be done in phylib core
> somewhere?

Yes, this is the idea.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

