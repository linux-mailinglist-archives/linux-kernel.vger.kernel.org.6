Return-Path: <linux-kernel+bounces-286524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E18951C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0391F25E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375761B143E;
	Wed, 14 Aug 2024 13:41:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5D1AE031
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642878; cv=none; b=ZxjyNVnnSIWzAPc2XJW1dfal5qbhRYg03bZkpiCNq57+Owj8qYHR34jXXuQJdASdFfpb0ZHlYbEy1GN0UZjAmv62MLsROodDBrdOVQf6QiV4wO4G9r7Ak7pIQMCLOncErPK1//KQGq0xx4rc1Jlw91cN/tahHSah1a+Q47stGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642878; c=relaxed/simple;
	bh=zOjk6hGGDth6yc75Nnd1oYyWL8+rID/sW43+5mDPxXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7ajguN/sqAiL1Q46br8G0IaAFmtUD6UVfkYo+FtyNU6BOYG2d7Ut0KzWCssim8GdSGdZCueAOes3clEvYtzqk2AKclW3GsybGA8uNj6iNs32WGsxcMHg5MqhEfWq/OOnUWX0Yk4i6ipDP35yqv8gyEbUm7aQpiU9G6d9iCFVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1seEFL-00064z-Vs; Wed, 14 Aug 2024 15:41:04 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1seEFL-000N7l-8p; Wed, 14 Aug 2024 15:41:03 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1seEFL-002ZXT-0V;
	Wed, 14 Aug 2024 15:41:03 +0200
Date: Wed, 14 Aug 2024 15:41:03 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: usb: microchip,usb2514: add support for
 port vbus-supply
Message-ID: <20240814134103.esnt6niyu36adtgp@pengutronix.de>
References: <20240807-b4-v6-10-topic-usb-onboard-dev-v1-0-f33ce21353c9@pengutronix.de>
 <20240807-b4-v6-10-topic-usb-onboard-dev-v1-2-f33ce21353c9@pengutronix.de>
 <20240813185752.GA1423091-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813185752.GA1423091-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Rob,

On 24-08-13, Rob Herring wrote:
> On Wed, Aug 07, 2024 at 04:36:52PM +0200, Marco Felsch wrote:
> > Some PCB designs don't connect the USB hub port power control GPIO and
> > instead make use of an host controllable regulator. Add support for this
> > use-case by introducing an portX-vbus-supply property.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> > index 783c27591e56..51d02c4b8f2d 100644
> > --- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> > +++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> > @@ -35,6 +35,13 @@ required:
> >    - compatible
> >    - reg
> >  
> > +patternProperties:
> > +  "^port[1-7]-vbus-supply$"
> > +    type: object
> > +    description:
> > +      Regulator controlling the USB VBUS on portX. Only required if the host
> > +      controls the portX VBUS.
> 
> This is completely external to the Microchip part, right?
> 
> I think each port node should have a 'vbus-supply' property instead.

This was my first approach but the problem is that we currently don't
support such use-case:

	parent-node {
		/* Parent controlling the supply of the child node */

		child-node {
			vbus-supply = <&reg>;
		};
	};

at least I didn't found such use-case. I'm happy for pointers if you
know more :) At the moment *-supply properties and device-nodes are
bound together:
	
	parent-node {
		vbus-supply = <&reg>;
	};

Regards,
  Marco

> 
> Rob
> 

