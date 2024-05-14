Return-Path: <linux-kernel+bounces-179171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F297C8C5CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975EF1F22627
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FBD181B9E;
	Tue, 14 May 2024 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geFwaALR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F921DFD1;
	Tue, 14 May 2024 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720952; cv=none; b=LCS0GAuzUihOAZ21vH/2cwzUxA9ZhZTUTMfSqyUAap0c/ioZLES+k7wo8rG5eQRNW4Bmgky5AjGnj2npC51iYqGQmY/aIqZzvtHReK7y5eIj+n4LR4QbR2mknjkdCmB4GQKrW/6FjAoVAK8HYkm5a+3lPWIlcBhtixFRa6TgAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720952; c=relaxed/simple;
	bh=iBQGtyPRNxJ3b5eCicElCWKrOiKS02iKAvulYWm1oUU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JIlrkKL/LaRQewntYGEyDj/vEoSY0eWpHAfAdR8aYhGNSlne5wvfYdHT/mZdiZNuFMIULhlRL739AIh6r4roi/R+1PyzmOgkuaXMBRaHoBYxMYx98IbFLd3UVuHxJw1JZXndXtGUDYc/EjkLFP+r6QufWF8sUTW3j1QnzHCi03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geFwaALR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE4BC2BD10;
	Tue, 14 May 2024 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715720951;
	bh=iBQGtyPRNxJ3b5eCicElCWKrOiKS02iKAvulYWm1oUU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=geFwaALR6vbhzVKzofNk1wS80bfk5LIQWAfWAgkQV6OL0DagMP9T+RwSQa2s0bz6N
	 89LSgb4bi7I0aAtPTZMwye1uz3OMNaZja+SJaf+dki+W1UZC14FmzFuPbXRwBeHAFG
	 sVZUuKIeSNTU0FmHftWNp50QfMXnv/CQBXommIolqyx3czSfcJnEWMDPQOPJd9y+t2
	 jWVLHciqhkaiCdBtCoB1eLVOd3zfS4vvukwhXYTvw0ziGkgbrCEUNNefdofDyJTt54
	 NkoEzS6VTHACXS/ONZ3OZf/+4dIjsVc00Pj7AMJx3dbXGU85MJlLT5zzdH0Q8Mh/Bx
	 DkXZ1i3E8sX4Q==
Message-ID: <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240514-campus-sibling-21cdf4c78366@spud>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com> <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com> <20240514-campus-sibling-21cdf4c78366@spud>
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller sub-node
From: Stephen Boyd <sboyd@kernel.org>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, shengjiu.wang@gmail.com
To: Conor Dooley <conor@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Tue, 14 May 2024 14:09:09 -0700
User-Agent: alot/0.10

Quoting Conor Dooley (2024-05-14 11:06:14)
> On Tue, May 14, 2024 at 05:33:27PM +0800, Shengjiu Wang wrote:
> > diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.ya=
ml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > index 0a6dc1a6e122..a403ace4d11f 100644
> > --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > @@ -15,7 +15,10 @@ description: |
> > =20
> >  properties:
> >    compatible:
> > -    const: fsl,imx8mp-audio-blk-ctrl
> > +    items:
> > +      - const: fsl,imx8mp-audio-blk-ctrl
> > +      - const: syscon
> > +      - const: simple-mfd
> > =20
> >    reg:
> >      maxItems: 1
> > @@ -44,6 +47,11 @@ properties:
> >        ID in its "clocks" phandle cell. See include/dt-bindings/clock/i=
mx8mp-clock.h
> >        for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
> > =20
> > +  reset-controller:
> > +    type: object
> > +    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
> > +    description: The child reset devices of AudioMIX Block Control.
>=20
> Why not just set #reset-cells =3D <1> in the existing node? IIRC it was
> already suggested to you to do that and use auxdev to set up the reset
> driver.

Yes, do that.

