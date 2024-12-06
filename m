Return-Path: <linux-kernel+bounces-434461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E5E9E6733
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC8A168661
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7F1D89EC;
	Fri,  6 Dec 2024 06:13:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0161D8DE8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733465610; cv=none; b=RFm8plUJmoBam1s+luulMS6yx5P5VraYNFjEwRPrLWe34SrULpkJ+0TItp8ae9fSuhUk6sWyBQEmy1WXVa4eRi0zy5C3P36aiD5knbeSxRLzK1xrtmsyJp+J3r2Cu/6NHaxR3fFDWhOQ0KUDU/tsMVNkdVG+JIm9hGbYh+zI2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733465610; c=relaxed/simple;
	bh=fhnoOtvLjyYbgDKK1hKbkCmQdtfhsc5b6UTarguiEqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkwNhVNSufM//8tpsW39D8GDf9Gp7Z/RQ6dqzWDfGAn8Csj5ZRmHhm1h1teRjd69INerYNwoqvttxQA03PdWaoVmntqupwmI9bDGhlENaNelKnvdOaWyM2THLYwvixhdKY725+1fMCDzeta2fMXCJQuBqxQ2q8o8TnnflrTuxUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tJRaR-0005UF-LC; Fri, 06 Dec 2024 07:13:11 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJRaO-001wrV-1O;
	Fri, 06 Dec 2024 07:13:09 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJRaP-000huU-0I;
	Fri, 06 Dec 2024 07:13:09 +0100
Date: Fri, 6 Dec 2024 07:13:09 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v1 2/5] dt-bindings: vendor-prefixes: Add prefix for Priva
Message-ID: <Z1KV9bCW0iafJ2hF@pengutronix.de>
References: <20241205125640.1253996-1-o.rempel@pengutronix.de>
 <20241205125640.1253996-3-o.rempel@pengutronix.de>
 <20241205-hamstring-mantis-b8b3a25210ef@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205-hamstring-mantis-b8b3a25210ef@spud>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2024 at 05:16:14PM +0000, Conor Dooley wrote:
> On Thu, Dec 05, 2024 at 01:56:37PM +0100, Oleksij Rempel wrote:
> > Introduce the 'pri' vendor prefix for Priva, a company specializing in
> > sustainable solutions for building automation, energy, and climate
> > control.  More information about Priva can be found at
> > https://www.priva.com
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index da01616802c7..9a9ac3adc5ef 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -1198,6 +1198,8 @@ patternProperties:
> >      description: Primux Trading, S.L.
> >    "^probox2,.*":
> >      description: PROBOX2 (by W2COMP Co., Ltd.)
> > +  "^pri,.*":
> > +    description: Priva
> 
> Why not "priva"? Saving two chars doesn't seem worth less info.

This is typical prefix which is used by this vendor, if it is possible
i would prefer not to change it. But, last decision is on your side :)

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

