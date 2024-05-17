Return-Path: <linux-kernel+bounces-181659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 764438C7F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323C928390F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F663A5F;
	Fri, 17 May 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCYkYbWW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616107E2;
	Fri, 17 May 2024 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715906348; cv=none; b=Ir7MkpLVcP6LDpfX9nCtmxGg/v4J0yQ4fmBDfpf470+mIXt3Aj01ip8dtXRLLjRc1aYmamhzuxVf4JG6NeR8xb0IO12lH9bhegqD/5hke1/B3LYmSmy/zDGdgWRmuzqs/1YnOj6vJBW9O9CQdPSbG3iARAOxqGia3UN2Uj44eGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715906348; c=relaxed/simple;
	bh=gG0rBTgAalNSQOb8EKbB7cQc3gWTqoJxB0I5m2D5WKk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=IYTf7xa1Zegm0miC4TEcHJA6xwEGVOIYSbxtV2gjp7c+RgwAWsEIPv1qIpUlz4z6dXRMYkuDYNeig+u1INkjK/x8zbPpTBlPe1VMadh4E4Q6kGP9xkCSkuaNLALRsZuObmyIaZcWRt0Kd+Tqieth+AAibTCeLzrASatc4b0IEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCYkYbWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5AEC113CC;
	Fri, 17 May 2024 00:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715906347;
	bh=gG0rBTgAalNSQOb8EKbB7cQc3gWTqoJxB0I5m2D5WKk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=oCYkYbWWJrT/g+j+licSCJUG9wbvqC7HbhZH4ZCD25oWKeU6B3cbmxH7gN6bi/f2h
	 89cpqVIVSUYYxUP9IH3kJnVkdlp6vxXBRdTNEom3nAFWkHcFUBmxEkRIOo7lXt+Ff0
	 uz+Umd7NWSQW2hEkiQvCTUyp7c1ln0z32zQQE5MggQogEzO352UV4PfKavAYt6cB6Q
	 82b2T1oHS19T0HvxE1ZAY0ov6haZRAmmpbznRCdJoCeTDNBrIL+wAJ73WKygsA6wrm
	 kKt+iOqhmnSV0tp1UBWqqs5YJJzIfFJ4SaDf2jo3lU6G1CViMIC+bUpAe1tbDrkUkj
	 HKDX9N/V9sYIA==
Message-ID: <b91dbdad0beb145a0797459c4ba9a98b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com> <1715679210-9588-4-git-send-email-shengjiu.wang@nxp.com> <20240514-campus-sibling-21cdf4c78366@spud> <b86c83a520f0c45a60249468fa92b1de.sboyd@kernel.org> <CAA+D8ANTdvQJVtniyMtqjnJdT4qX+LDGjVuFO6H0RSO+GDw+ng@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: clock: imx8mp: Add reset-controller sub-node
From: Stephen Boyd <sboyd@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 16 May 2024 17:39:05 -0700
User-Agent: alot/0.10

Quoting Shengjiu Wang (2024-05-14 19:47:57)
> On Wed, May 15, 2024 at 5:09=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> w=
rote:
> >
> > Quoting Conor Dooley (2024-05-14 11:06:14)
> > > On Tue, May 14, 2024 at 05:33:27PM +0800, Shengjiu Wang wrote:
> > > > diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomi=
x.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > index 0a6dc1a6e122..a403ace4d11f 100644
> > > > --- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > +++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
> > > > @@ -15,7 +15,10 @@ description: |
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    const: fsl,imx8mp-audio-blk-ctrl
> > > > +    items:
> > > > +      - const: fsl,imx8mp-audio-blk-ctrl
> > > > +      - const: syscon
> > > > +      - const: simple-mfd
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -44,6 +47,11 @@ properties:
> > > >        ID in its "clocks" phandle cell. See include/dt-bindings/clo=
ck/imx8mp-clock.h
> > > >        for the full list of i.MX8MP IMX8MP_CLK_AUDIOMIX_ clock IDs.
> > > >
> > > > +  reset-controller:
> > > > +    type: object
> > > > +    $ref: /schemas/reset/fsl,imx8mp-audiomix-reset.yaml#
> > > > +    description: The child reset devices of AudioMIX Block Control.
> > >
> > > Why not just set #reset-cells =3D <1> in the existing node? IIRC it w=
as
> > > already suggested to you to do that and use auxdev to set up the reset
> > > driver.
> >
> > Yes, do that.
>=20
> Can I know why sub nodes can't be used? the relationship of parent and
> child devices looks better with sub nodes.

Don't make nodes for drivers. Only make nodes for devices. This device
is multi-function, but is still only a single device.

