Return-Path: <linux-kernel+bounces-512366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436A0A33823
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C583A78C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F5207A27;
	Thu, 13 Feb 2025 06:47:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC342063E8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429262; cv=none; b=Fa85bddk+g4xcbmROQqslJUvoxkZUtJrhmRu3Hgc+dQRW6qgEshV5aXt1c67D4Pl2OyjI9NUrcj3FoYMN6B6KBtCAh7dmXDbnOOn4d5247b06oegeTHODxiyxNeeXNlNYp584SWx+ZUawVVWvKbV4bHzC6lg2iYQDkZeDGDOG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429262; c=relaxed/simple;
	bh=Ui9tV08ii4vDqsenJvS2hHYGvjrn1LMX+Edc6aM9628=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QATt5m/4Gk15EF4CmtcxmtkfLEjsyCoKbEyWKH688JdiziLPTws8xnzXgi7Jmu+0yUYPnjPvWXmONmssUeXYubOXJGqiBKyKjhEuWFsC3o1y28fzI35X01Wh1qdnnmaGa+UHYNjzH4MF5dmc+1C/+yz0VcHczOsIedivMKtuc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tiT0P-0007gj-8H; Thu, 13 Feb 2025 07:47:25 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tiT0O-000hzs-1x;
	Thu, 13 Feb 2025 07:47:24 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tiT0O-00CmQq-1c;
	Thu, 13 Feb 2025 07:47:24 +0100
Date: Thu, 13 Feb 2025 07:47:24 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] ASoC: dt-bindings: support imx95's CM7 core
Message-ID: <20250213064724.kbmxsk5szpxwclj6@pengutronix.de>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-2-laurentiumihalcea111@gmail.com>
 <20250212093610.x4ixrackmn3u2xrf@pengutronix.de>
 <CAEnQRZBeQdnC+K92+Udb5awTmom10YHHNt7Ld-pYK4A1i8sr3Q@mail.gmail.com>
 <d66996eb-f49b-448b-9743-d19a3c3eba52@sirena.org.uk>
 <e45411df-1b8b-4f21-878d-d52e1112e62d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e45411df-1b8b-4f21-878d-d52e1112e62d@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Laurentiu, Daniel,

On 25-02-12, Laurentiu Mihalcea wrote:
> 
> On 2/12/2025 2:38 PM, Mark Brown wrote:
> > On Wed, Feb 12, 2025 at 12:11:49PM +0200, Daniel Baluta wrote:
> >> On Wed, Feb 12, 2025 at 11:38 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >>> On 25-02-11, Laurentiu Mihalcea wrote:
> >>>> +    const: fsl,imx95-cm7-sof
> >>> Albeit Krzysztof already add his Reviewed-by, can I ask why we need to
> >>> add the -sof suffix instead of -audio or so? SOF is a software project
> >>> but you can clearly run different software on the audio-copro as well.
> >> Sure you can run a different software project on the audio DSP but
> >> you will need a way to distinguish between the different projects.
> >> There might be different mailbox, memory configurations. So you will  need
> >> to invent another suffix specific to the new project.
> >> We can make  const: fsl,imx95-cm7-audio as the one used with SOF
> >> and think about a different name later for when another project will
> >> want to use the DSP.
> > I think the point here was that the DT should stay the same even if the
> > DSP firwmare changes, just as how changing the main OS shouldn't affect
> > the DT.
> 
> It's rather unfortunate but based on the experience from the 8 series
> (imx8qm, imx8qxp, imx8mp), the programming model can differ quite
> a bit (e.g: remoteproc vs SOF) even if the core is the same (i.e: DSP core).
> 
> The different programming models also required different DT configurations
> (e.g: dif. mboxes as Daniel mentioned, some extra properties (i.e: reg-names), etc...)
> 
> The "-sof" suffix was chosen here instead of the more generic "-audio" (or whatever else
> alternative) because the DT configuration is specific to SOF's programming model. Other
> audio applications running on the same core may have dif. configurations (e.g: use
> DTCM/ITCM for memory instead of DDR, dif. mbox count, etc...). I suppose this kind of thing
> is bound to happen to some degree since the DT node doesn't just describe the CM7 core
> (but, rather, it also encompasses information on the memory, mboxes, etc. used)
> but perhaps I'm wrong?

Time will tell if there will be any other user except for SOF for the
DSP but and this is what I wanted to point out: the DTS should abstract
the HW. IMHO The CM7-Audio node should contain all properties required
to turn power and reset the core (e.g. clocks, reset, pm-domains). I get
your point regarding different configs but please have a look at
mt8183-kukui.dtsi. Here the rpmsg config is a subnode of the actual
system-control-proc. This makes much more sense to me since the HW part
is part of the generic core-node and all the software config goes into a
separate subnode.

Regards,
  Marco

