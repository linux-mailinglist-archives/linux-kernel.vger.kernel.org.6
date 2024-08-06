Return-Path: <linux-kernel+bounces-276239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EF79490C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96CC1F26DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71D31D415F;
	Tue,  6 Aug 2024 13:16:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C21BE867
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950176; cv=none; b=jzU4vOJOxXonR73v/b12Dc13qtGIfYRLxz4tvRT3wY8h4JMcciuDJUooD7+fKYThKeyRmaR2nuKdmld+fvqawhXSqaQpDbaueE0YNWB+wJWq5tL7bhlOaJAOHNAJ05W3Ah9Ffxp1kXdDDR/PwImT7q7TjDo3l3vjAOM2BB+uxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950176; c=relaxed/simple;
	bh=WxVMOsooydwCvFTMcLilfNoUBQmZvwH9joUgNdC0h5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi5a/KwCmNMSCIrB2iVMP/TNAaz24XdYLivIghHDG9I+q69DB+M/ppOFeCY2/xsyh2KPcYQNQJMHxgfs7BkoyCgKId1JFkSHmZSUAAN8mEj3Jxf1FB3ADky/Dpc8eUbBu1JjoBXrDCCVY5rBd5pNrkeVuH5qETCMAaA/hhov/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sbK2d-0000GH-3S; Tue, 06 Aug 2024 15:15:55 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sbK2b-004xsB-NF; Tue, 06 Aug 2024 15:15:53 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sbK2b-0051Ir-1q;
	Tue, 06 Aug 2024 15:15:53 +0200
Date: Tue, 6 Aug 2024 15:15:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1] arm: dts: st: Add MECIO1 and MECT1S board variants
Message-ID: <ZrIiCX89nRDLvXtC@pengutronix.de>
References: <20240806120332.405064-1-o.rempel@pengutronix.de>
 <ae46118f-a692-4362-8e6b-4ef8c6369541@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae46118f-a692-4362-8e6b-4ef8c6369541@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2024 at 02:39:31PM +0200, Krzysztof Kozlowski wrote:
> On 06/08/2024 14:03, Oleksij Rempel wrote:
> > From: David Jander <david@protonic.nl>
> > 
> > Introduce device tree support for the MECIO1 and MECT1S board variants.
> > MECIO1 is an I/O and motor control board used in blood sample analysis
> > machines. MECT1S is a 1000Base-T1 switch for internal machine networks
> > of blood sample analysis machines.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  .../devicetree/bindings/arm/stm32/stm32.yaml  |   8 +
> >  arch/arm/boot/dts/st/Makefile                 |   3 +
> >  arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts |  48 ++
> >  arch/arm/boot/dts/st/stm32mp151c-mect1s.dts   | 297 ++++++++++
> >  arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts |  48 ++
> >  .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 533 ++++++++++++++++++
> >  6 files changed, 937 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
> >  create mode 100644 arch/arm/boot/dts/st/stm32mp151c-mect1s.dts
> >  create mode 100644 arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
> >  create mode 100644 arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> > index 58099949e8f3a..703d4b574398d 100644
> > --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> > +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.

Ack, I see. stm32.yaml should be in separate patch.

> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.

What should be done with "ethernet-phy-id2000.a284" appears
un-documente warnings? Should it be handled by
Documentation/devicetree/bindings/net/ethernet-phy.yaml?

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

