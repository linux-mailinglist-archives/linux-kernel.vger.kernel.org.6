Return-Path: <linux-kernel+bounces-306137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E319639C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F612831D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FF149011;
	Thu, 29 Aug 2024 05:13:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29EE136357
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908390; cv=none; b=p+B+ymLPS2xoMZUV0K0Fjl+5JxXsho28sOx7ZQKdIqavhZAy4LG6GHrKeeAhyVNiQfLhb0x8alAy/BR20kj+w6tuHDBLVp3W5CixXUVyjGveWBpTjSN2Q6K6/b0V9wrqJvTSYoS4lq0/Y2zgLdITXVbuTk+Pxbr9zUupdhiEArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908390; c=relaxed/simple;
	bh=TuQ5kAmSd+2FQcnqsC0UV+48aeMHqzr2qLJASNIOn+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjyKj1PgF9NoIEhymFAXPbDkaZdxdX5UH0zIQuIWJxaAHYDLc7uZFBZcPMiFDM1afGTw7xoKHMMioro3iNxPrWR8tbFxHjEGXj5TdZYXBolppQfL3w1N3b+aLU786uUMpaoDeNDSWEA8zlti1ikFsQ/7HZh6lSkJ/rI5E39CSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjXSq-0002IP-Mc; Thu, 29 Aug 2024 07:12:56 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjXSp-003pxg-91; Thu, 29 Aug 2024 07:12:55 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjXSp-00CYpL-0X;
	Thu, 29 Aug 2024 07:12:55 +0200
Date: Thu, 29 Aug 2024 07:12:55 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] arm: dts: st: stm32mp151a-prtt1l: Fix QSPI
 configuration
Message-ID: <ZtADV2hHgbF9HI08@pengutronix.de>
References: <20240806120517.406714-1-o.rempel@pengutronix.de>
 <20dc2cd4-7684-4894-9db3-23c3f4abd661@pengutronix.de>
 <8a13fd32-4bc4-4711-bf6b-7e0ce2e938ec@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a13fd32-4bc4-4711-bf6b-7e0ce2e938ec@foss.st.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Alexandre,

On Tue, Aug 27, 2024 at 10:07:10AM +0200, Alexandre TORGUE wrote:
> Hi
> 
> On 8/7/24 11:38, Ahmad Fatoum wrote:
> > Hello Oleksij,
> > 
> > On 06.08.24 14:05, Oleksij Rempel wrote:
> > > Rename 'pins1' to 'pins' in the qspi_bk1_pins_a node to correct the
> > > subnode name. The previous name caused the configuration to be
> > > applied to the wrong subnode, resulting in QSPI not working properly.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >   arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
> > > index 3938d357e198f..4db684478c320 100644
> > > --- a/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
> > > +++ b/arch/arm/boot/dts/st/stm32mp151a-prtt1l.dtsi
> > > @@ -123,7 +123,7 @@ flash@0 {
> > >   };
> > >   &qspi_bk1_pins_a {
> > > -	pins1 {
> > > +	pins {
> > 
> > As you have seen such device tree overriding is error prone and would
> > be entirely avoidable if specifying full board-specific pinctrl groups
> > was allowed for the stm32 platforms instead of override-and-pray.
> 
> You can create your own pin group in stm32mp15-pinctlr.dtsi. What is the
> issue ? Do I miss something ? It will avoid to overwrite an existing
> configuration

There are mostly one one properly change (pull up), not really worth adding a
new sub node.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

