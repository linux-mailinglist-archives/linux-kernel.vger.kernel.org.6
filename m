Return-Path: <linux-kernel+bounces-233015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F2A91B11E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB9B1C23FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8FE19F469;
	Thu, 27 Jun 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwHZsHEU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FDB14D6EB;
	Thu, 27 Jun 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521936; cv=none; b=gYM9BcaFYZkZb8kCJXqjwkbVp9eRZUYOgy0NzP72cDO3e/TYx9zpCd7e3AAIqgvkhdsOoN6klFbioHiD8NGZ0QohK8c8522s1BQiNz1Q16MmhoeZVXh/AK4J98peGG2x+Dg12WdP5tYFiBhN5TYh0qAqvN4YGQLgINTtplkSDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521936; c=relaxed/simple;
	bh=09WhEq5r3XGQO4dhtl+2n781sC7j21j+wT5LnkW7syo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo7gtAjAaSmeCTUAUdBMurOvy5p5+A77hNsDERS5hhI6oW6h0G7llUEqeS3xWOzxQX3PVMQgPmGHX1j664t97/qC17gCqpdCciZCjHao/X0dVNjbGHFEsRkMbNsUMmSer4i5clzR3Gh3mNpRBLE9o6D760ha0PZvdvKCpnCivxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwHZsHEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8F4C2BBFC;
	Thu, 27 Jun 2024 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719521935;
	bh=09WhEq5r3XGQO4dhtl+2n781sC7j21j+wT5LnkW7syo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwHZsHEU0LBEPFP8V7twQLd5G9kEPs5zqsYN12u2t3VDr91wDlRWlhyb5/4t+AuQB
	 /Xm8aL3W0R/4YWx9z1iD5RnOG7in9GoIZwzLTjnGlAegoWibC7wnbd6yMPEOf5m49a
	 VJCiozsORs2fto2A3lZ6hSJL67oVsqb19xz5JVH9DY5rOo+kxF8fVHpWNL2qfnyYU1
	 ocp4qSxDm6V0SxJV0Re6gy61gQAcWOaWOBCyFUsrU+Epvw4/fhTs8jVBvYlLSbJAdO
	 TOijowy4xrn0G5gH26e6CDayPMkTcmYGcAPZEf/TgdCOoUUABRJLDwXdy5MFyJrOq6
	 tc+HtDo8OkBsQ==
Date: Thu, 27 Jun 2024 14:58:54 -0600
From: Rob Herring <robh@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: kernel test robot <lkp@intel.com>, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com, oe-kbuild-all@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v25 1/3] dt-bindings: reset: npcm: add clock properties
Message-ID: <20240627205854.GA501440-robh@kernel.org>
References: <20240618185819.2155595-2-tmaimon77@gmail.com>
 <202406191439.3NcnExKM-lkp@intel.com>
 <CAP6Zq1h2Sk6H2V-i+PAk_fCy9xdywcYw=w9wT_xcJ2WrqyWbAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP6Zq1h2Sk6H2V-i+PAk_fCy9xdywcYw=w9wT_xcJ2WrqyWbAg@mail.gmail.com>

On Thu, Jun 20, 2024 at 10:32:26AM +0300, Tomer Maimon wrote:
> Hi Rob and Krzysztof,
> 
> Could you please review this patch?

I would hope by v25 you'd know you just need to look at DT patchwork to 
see where you are in the queue. Pinging does nothing to help.

Furthermore, you waited a whole 2 days which isn't much.

> 
> Thanks,
> 
> Tomer
> 
> On Wed, 19 Jun 2024 at 09:20, kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Tomer,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on clk/clk-next]
> > [also build test WARNING on linus/master pza/reset/next v6.10-rc4 next-20240618]
> > [cannot apply to pza/imx-drm/next]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/dt-bindings-reset-npcm-add-clock-properties/20240619-093532
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> > patch link:    https://lore.kernel.org/r/20240618185819.2155595-2-tmaimon77%40gmail.com
> > patch subject: [PATCH v25 1/3] dt-bindings: reset: npcm: add clock properties
> > config: arm64-randconfig-051-20240619 (https://download.01.org/0day-ci/archive/20240619/202406191439.3NcnExKM-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 13.2.0
> > dtschema version: 2024.6.dev1+g833054f
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406191439.3NcnExKM-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202406191439.3NcnExKM-lkp@intel.com/
> >
> > dtcheck warnings: (new ones prefixed by >>)
> >    arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi:63.7-177.5: Warning (simple_bus_reg): /ahb/apb: simple-bus unit address format error, expected "f0000000"
> >    arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi:50.35-55.5: Warning (unique_unit_address_if_enabled): /ahb/reset-controller@f0801000: duplicate unit-address (also used in node /ahb/clock-controller@f0801000)
> >    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: /: memory@0: 'device_type' is a required property
> >         from schema $id: http://devicetree.org/schemas/memory.yaml#
> >    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: system-controller@f0800000: compatible: ['nuvoton,npcm845-gcr', 'syscon'] is too short
> >         from schema $id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-gcr.yaml#
> >    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: interrupt-controller@dfff9000: 'ppi-partitions' does not match any of the regexes: '^v2m@[0-9a-f]+$', 'pinctrl-[0-9]+'
> >         from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,gic.yaml#
> >    arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: ahb: apb:ranges: [[0, 0, 4026531840, 3145728], [4293918720, 0, 4293918720, 90112]] is not of type 'boolean'
> >         from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
> > >> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: reset-controller@f0801000: '#clock-cells' is a required property
> >         from schema $id: http://devicetree.org/schemas/reset/nuvoton,npcm750-reset.yaml#
> > >> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dtb: reset-controller@f0801000: 'clocks' is a required property
> >         from schema $id: http://devicetree.org/schemas/reset/nuvoton,npcm750-reset.yaml#

While I think things are too noisy for these 0-day reports, this one 
rightfully shows the ABI break you are causing. You can't add new 
required properties.

Rob

