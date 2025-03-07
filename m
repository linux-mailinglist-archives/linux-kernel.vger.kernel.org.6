Return-Path: <linux-kernel+bounces-551707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D14A56FB8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143F116F545
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2242E24418E;
	Fri,  7 Mar 2025 17:53:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9151224336D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370011; cv=none; b=UeGjkqXgZcOf8Sx7j2qvCc2Wig7ccd4DrQWHCR3AfudEmn5shBjAF5kOyo86yLITBn/CLlGZ/4oTowutsGQSot/Bzsli8SNljjqT/RPFWVpnMaZux0TJjOYjaI8jQ3n0aDNpny/sxA5pAmyg9kyM3dJjM9+bYgTvp4lpGv9k0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370011; c=relaxed/simple;
	bh=uGp2XOYaAoeUpb/9b5BbIParJDTxLmqRE1Kf/2le0gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMe1GEjRD6IHo31BMvJrWUQQu6vdeKb1elX7IiGUaMGYBhbGNPqaNgRUEhQw4wHBCsKALFpJPabmSTgUmUCLvOczvVGATA+M8ne8PSXO8D1yABdtUJZc7VoiQgb7ici9k9e+XE8qzsc976Ntp+rvKDywFH0W1sJX28qQ3g1LA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tqbsk-0007Ns-8T; Fri, 07 Mar 2025 18:53:10 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tqbsj-004Wj2-1G;
	Fri, 07 Mar 2025 18:53:09 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tqbsj-000Zmp-0n;
	Fri, 07 Mar 2025 18:53:09 +0100
Date: Fri, 7 Mar 2025 18:53:09 +0100
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
Message-ID: <20250307175309.od3grjzr63dxp6ec@pengutronix.de>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-2-laurentiumihalcea111@gmail.com>
 <20250212093610.x4ixrackmn3u2xrf@pengutronix.de>
 <CAEnQRZBeQdnC+K92+Udb5awTmom10YHHNt7Ld-pYK4A1i8sr3Q@mail.gmail.com>
 <d66996eb-f49b-448b-9743-d19a3c3eba52@sirena.org.uk>
 <e45411df-1b8b-4f21-878d-d52e1112e62d@gmail.com>
 <20250213064724.kbmxsk5szpxwclj6@pengutronix.de>
 <88584d8f-e1cd-4b56-8906-461e1e6d9cc9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88584d8f-e1cd-4b56-8906-461e1e6d9cc9@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-03-04, Laurentiu Mihalcea wrote:
> On 2/13/2025 8:47 AM, Marco Felsch wrote:
> > Hi Laurentiu, Daniel,
> >
> > On 25-02-12, Laurentiu Mihalcea wrote:
> >> On 2/12/2025 2:38 PM, Mark Brown wrote:
> >>> On Wed, Feb 12, 2025 at 12:11:49PM +0200, Daniel Baluta wrote:
> >>>> On Wed, Feb 12, 2025 at 11:38 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >>>>> On 25-02-11, Laurentiu Mihalcea wrote:
> >>>>>> +    const: fsl,imx95-cm7-sof
> >>>>> Albeit Krzysztof already add his Reviewed-by, can I ask why we need to
> >>>>> add the -sof suffix instead of -audio or so? SOF is a software project
> >>>>> but you can clearly run different software on the audio-copro as well.
> >>>> Sure you can run a different software project on the audio DSP but
> >>>> you will need a way to distinguish between the different projects.
> >>>> There might be different mailbox, memory configurations. So you will  need
> >>>> to invent another suffix specific to the new project.
> >>>> We can make  const: fsl,imx95-cm7-audio as the one used with SOF
> >>>> and think about a different name later for when another project will
> >>>> want to use the DSP.
> >>> I think the point here was that the DT should stay the same even if the
> >>> DSP firwmare changes, just as how changing the main OS shouldn't affect
> >>> the DT.
> >> It's rather unfortunate but based on the experience from the 8 series
> >> (imx8qm, imx8qxp, imx8mp), the programming model can differ quite
> >> a bit (e.g: remoteproc vs SOF) even if the core is the same (i.e: DSP core).
> >>
> >> The different programming models also required different DT configurations
> >> (e.g: dif. mboxes as Daniel mentioned, some extra properties (i.e: reg-names), etc...)
> >>
> >> The "-sof" suffix was chosen here instead of the more generic "-audio" (or whatever else
> >> alternative) because the DT configuration is specific to SOF's programming model. Other
> >> audio applications running on the same core may have dif. configurations (e.g: use
> >> DTCM/ITCM for memory instead of DDR, dif. mbox count, etc...). I suppose this kind of thing
> >> is bound to happen to some degree since the DT node doesn't just describe the CM7 core
> >> (but, rather, it also encompasses information on the memory, mboxes, etc. used)
> >> but perhaps I'm wrong?
> > Time will tell if there will be any other user except for SOF for the
> > DSP but and this is what I wanted to point out: the DTS should abstract
> > the HW. IMHO The CM7-Audio node should contain all properties required
> > to turn power and reset the core (e.g. clocks, reset, pm-domains). I get
> > your point regarding different configs but please have a look at
> > mt8183-kukui.dtsi. Here the rpmsg config is a subnode of the actual
> > system-control-proc. This makes much more sense to me since the HW part
> > is part of the generic core-node and all the software config goes into a
> > separate subnode.
> >
> > Regards,
> >   Marco
> 
> I understand your point but we're dealing with 2 different programming
> models here: SOF and remoteproc as opposed to just remoteproc as it's
> the case for Mediatek.

The idea is exactly to decouple the CM7 HW config from the
software/firmware running on it and this is what MediaTek did.

Of course they are only interested in teh RPMsg part but this approach
could be used to decouple the HW and the FW part which is your use-case
(different FWs running on the CM7).

> Going for a similar approach would also mean quite a bit of software
> changes as we'd need to factor out the common bits (most importantly here:
> core operations like start/stop) and placing them in a common driver. 

Exactly but shouldn't be to hard to implement. Of course it is more work
than just adapting the compatible.

> This is not trivial and I'm not sure it's worth the effort right now
> given that:
> 
>     1) The current way we model the hardware inside the DT is not exactly inaccurate.
>     The core does physically use those memory regions, mailboxes, etc.
> 
>     2) Whatever we do, the information in the DT will still depend on the programming model.
>     It's just that you're placing it in a child node, instead of the parent, which is arguably not that
>     big of an improvement?

The benefit is to have different configs in place and a board can choose
between them, e.g.:

	sof_cpu: cm7-cpu@80000000 {
		compatible = "fsl,imx95-cm7";
		reg = <0x0 0x80000000 0x0 0x6100000>;
		reg-names = "sram";
		clocks = <...>;
		resets = <...>;
		access-controllers = <...>;

		firmware-name = "nxp/foo";
		firmware-config = <&cm7_sof>;

		cm7_sof: cm7-sof {
			compatible = "fsl,imx95-sof";
			memory-region = <&adma_res>;
			memory-region-names = "dma";
			mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
			mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";

			cpu: port {
				cpu_ep: endpoint {
					remote-endpoint = <&codec_ep>;
				};
			};
		};

		cm7_rpmsg: cm7-rpmsg {
			compatible = "fsl,imx95-rpmsg";
		};

		cm7_foo: cm7-foo {
			compatible = "fsl,imx95-foo";
		};
	};

I get your point and I'm not against your patchset. Just IMHO the above
example would make more sense to me since the CM7 hardware handling
(en-/disable/access/reset/clock) can be done by a common driver and must
not be done by each subsystem driver: sof, rpmsg, etc. Also the since
the driver would be common it could be reused by other CoProcessors
within the system as well since there are now more and more CoProcessors
on a SoC.

Regards,
  Marco

