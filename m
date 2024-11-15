Return-Path: <linux-kernel+bounces-411103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88B9CF2FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDDD1F2306B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D324F1D63D1;
	Fri, 15 Nov 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ME/5oqI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294615383D;
	Fri, 15 Nov 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692023; cv=none; b=ZPKqLJlbzP3yf6MIrMTyCiAjAbBZswi9A8zova7Qe/2xOQGHQAv/tvQ4Qxrj2cQuEmzmdTM7VmxvA2qJlV6W5cqIVdpC1gFJux1idfnxAWvKPODnv/7Gon0mwNI4qt0/RbmfcaO4IrV7MY7jbXcob5VE+Yf7cF9s4RW81eMbMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692023; c=relaxed/simple;
	bh=KAyTU2wbJPNWq+AnPPIg5jRJD0fH1t6QufJ8G6BdE+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4JN/F/FHOiVuvx5x2V1SC2cBU+m/7MZOrBp0ZTJ4G1pTM36S5UhMrQU7+R5ATlsOoB2TgC80o8WItNzkUizdsFnR8t/itLIMW0cONhWX7iO+q0McEnhRK7KKs5OZIqethgtBTl7swu6RWR/te3KrDWgL2Y0jVLF5MBMfH8RaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ME/5oqI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B938C4CECF;
	Fri, 15 Nov 2024 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731692022;
	bh=KAyTU2wbJPNWq+AnPPIg5jRJD0fH1t6QufJ8G6BdE+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME/5oqI+9A5m65Ks+FI//A2msRKaoqyZsf8e+ZghTz6L0qiyWlGJI6zbxAO4SjmJ7
	 QTv6C9Js0yK/mIY90hePo9stLZfjatvVg5Osg7PVkMKaHT0MvI1wZrW3oSKUVrrsx/
	 fGfxx9566+orfgW9/TF5/rWaUCIRJL1j60bX5O6M6XeVlZoojkhxIif/G6voPR++Ep
	 VrwdwVo20M6h4e7coL8dKdFziZGDy/mJCEbWTJJrM4FiEFlyZUz2TeibmpDAKmTOCJ
	 vQ7UCDJDzVsyXx8f8wbgt5GNWmZmeMiG+4/ghCKaLIrFD+MIHxbiGK4Uf5Pn5KYe17
	 QzfRUhDaCSGow==
Date: Fri, 15 Nov 2024 11:33:40 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ASoC: dt-bindings: add common binding for NXP CPUs
Message-ID: <20241115173340.GA3436142-robh@kernel.org>
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
 <20241113195240.3699-2-laurentiumihalcea111@gmail.com>
 <ZzUF+iFeKSqKGcpX@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzUF+iFeKSqKGcpX@lizhi-Precision-Tower-5810>

On Wed, Nov 13, 2024 at 03:03:06PM -0500, Frank Li wrote:
> On Wed, Nov 13, 2024 at 02:52:36PM -0500, Laurentiu Mihalcea wrote:
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >
> > Add common binding for NXP CPUs sharing the same programming
> > model (i.e: audio processing with SOF).
> 
> Add binding for NXP audio processor with Sound Open Firmware (SOF) support.
> 
> >
> > Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > ---
> >  .../bindings/sound/fsl,sof-cpu.yaml           | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
> > new file mode 100644
> > index 000000000000..6d63fcd71154
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/fsl,sof-cpu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP audio CPU common properties
> 
> audio processor?
> 
> > +
> > +maintainers:
> > +  - Daniel Baluta <daniel.baluta@nxp.com>
> > +
> > +properties:
> > +  reg:
> > +    maxItems: 1
> > +
> > +  mboxes:
> > +    maxItems: 4
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: txdb0
> > +      - const: txdb1
> > +      - const: rxdb0
> > +      - const: rxdb1
> > +
> > +  memory-region:
> > +    maxItems: 1
> > +
> > +required:
> > +  - reg
> > +  - mboxes
> > +  - mbox-names
> > +  - memory-region
> > +
> > +additionalProperties: true
> 
> example ?

Common bindings generally don't have one.

Rob

