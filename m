Return-Path: <linux-kernel+bounces-222245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C50790FEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA7E1F22C98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23E2198A3D;
	Thu, 20 Jun 2024 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="fsktYGwp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ltjhb45n"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917118EFEE;
	Thu, 20 Jun 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871979; cv=none; b=pabZYP0fgP1xaZiz/bIhBQOjgfBgT6WoUQsSnZiCse2UAALxz3BmDaoLCPWP9jdX79tPzLUbmQHtZHN0zy2CC4+8EpUw8FzrGTUerOb22qGzOIzig1PTjy9f513vdnq5lVwbZKo60KlBjhJBtQ2yamTpsfJmnGuURZZwfz4vZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871979; c=relaxed/simple;
	bh=ykx82u3dFRnQssCH+WPqTmGF9rPNEhJ9MfICw59yjuU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I3YHYtMpV/xkDnpzYoqZjJlcilFRsmQLTcXT/EaZMJEGly4h1jhdzhkg0ECYv/MwnEJvd72wqU/IfEpXHqXEA3vvXuW405604pZtcbE2yA9tm7sCqBBOXJRuq9BhHfwyxF0nbYzIrHFN00I7YaGvZANeSxY34usGVJqjEZv+H3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=fsktYGwp; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ltjhb45n reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718871975; x=1750407975;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fhOVTc8EwkQ97eTIibAFj6NhxNXrIp2CfJhA/VS9Po0=;
  b=fsktYGwpaANzFCTw3oK8xidvLCxulksFsfmNUYwDNEU7HDc1anuKU5gb
   8eMsGC8csT9llq6moFmBGDWc5qKrZIF8FOz8Xgse55t4el6rzj7jsqS2n
   MyDPeaSI/KUIEM6V98qVUdDwEn3JWMwxwWUmANSCeXVzcghk1gxMf6UO6
   HPIyDmYYOZWXDrQKjxcg8nO/85ywkkD3Y9mFz3USDtjcdnujjjbozKTHB
   p8S9FmNLGtItwUT9D1Q9RrV3erqGobWYvFg4yG+Ct/6PeBhOHixWoUb0j
   pYlSdkhYIcFbndBgwKNJ7Ly87E0oRI9FWQMfR315A9lbw5bZkmmDSJvBf
   A==;
X-CSE-ConnectionGUID: eDohtDWbQhm/sCQHt/ve+g==
X-CSE-MsgGUID: ur5SVpOwQFGYlcVGdk7nNg==
X-IronPort-AV: E=Sophos;i="6.08,251,1712613600"; 
   d="scan'208";a="37492741"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 20 Jun 2024 10:26:12 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48787161196;
	Thu, 20 Jun 2024 10:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718871968;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fhOVTc8EwkQ97eTIibAFj6NhxNXrIp2CfJhA/VS9Po0=;
	b=ltjhb45nnKhAozxXQPtArb5qMYrSIefFEh6/MeCJwAMqiKx/6v77A69YxU/WNYTFW33ViI
	ytsdcjw/H1tgbv574S3EKZe9JEqBqIHG8FwJ7i9LMXRNHQyaHeDZtdoJegolaaUG8Mh8kf
	E7j29BNSu5/sTvi2/eTKWu2rLt5OlBXJcOu3782QrUxNAZaChs8DHEVyqvX0vlLR9Xr6sC
	t2JCWRY4XPsvXWgVUTc0kFqD5ig0w/ptSbNfyQ6kPPc1Rwc65OLhwT0XdZbY5KuVNfTZt0
	LljBTN/pTsjdWlH2b+vmsEbIaF3+3h8g7f/THOHoV09/ERvwgaQSINLo4ZnI1A==
Message-ID: <99cc7afbb891de890ff051606f7a120f796e0fbc.camel@ew.tq-group.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: allow ethernet
 controller in ICSSG node
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Suman Anna
 <s-anna@ti.com>
Date: Thu, 20 Jun 2024 10:26:07 +0200
In-Reply-To: <89880cda-1140-4ed5-a67f-2201c2825447@kernel.org>
References: <20240619112406.106223-1-matthias.schiffer@ew.tq-group.com>
	 <89880cda-1140-4ed5-a67f-2201c2825447@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 2024-06-20 at 09:24 +0200, Krzysztof Kozlowski wrote:
> On 19/06/2024 13:24, Matthias Schiffer wrote:
> > While the current Device Trees for TI EVMs configure the PRUSS Ethernet
> > controller as a toplevel node with names like "icssg1-eth", allowing to
> > make it a subnode of the ICSSG has a number of advantages:
>=20
> What is ICSSG? The sram or ti,prus from the ethernet schema?

ICSSG (Industrial Communication Subsystem (Group?)) is the main device desc=
ribed by the
ti,pruss.yaml binding (ICSS and PRUSS are different variants of similar IP =
cores); it is the
container for the individual PRU, TXPRU and RTU cores which are referenced =
by the ti,prus
node of the Ethernet schema.

The entirety of PRU, TXPRU and RTU cores of one ICSSG, each with its own fi=
rmware, forms one
Ethernet controller, which is not quite a hardware device, but also not a f=
ully virtual software
device.

The Ethernet controller only exists through the various ICSS subcores, so i=
t doesn't have an MMIO
address of its own. As described, the existing Device Trees define it as a =
toplevel non-MMIO node;
we propose to allow it as a non-MMIO child node of the ICSSG container inst=
ead.

If you consider moving the ethernet node into the ICSSG node a bad approach=
, we will drop this patch
and try to find a different solution to our issue (the Ethernet device stay=
ing in deferred state
forever when the ICSSG node is disabled on Linux).

Best regards,
Matthias



>=20
> >=20
> > - It makes sense semantically - the Ethernet controller is running on
> >   the ICSSG/PRUSS
> > - Disabling or deleting the ICSSG node implicitly removes the Ethernet
> >   controller node when it is a child node. This can be relevant on SoCs
> >   like the AM64x which come in variants with and without ICSSG; e.g., o=
n
> >   the TQMa64xxL the ICSSG node will be disabled on variants without as =
a
> >   bootloader fixup.
> >   On Linux, this avoids leaving the Ethernet controller in deferred
> >   state forever while waiting for the ICSSG to become available
> >   (resulting in a warning on newer kernels)
> >=20
> > The node name "ethernet" is chosen as it nicely matches the regular
> > "ethernet@<reg>" format of many Ethernet controller nodes, and is also
> > what the prueth binding example (/schemas/net/ti,icssg-prueth.yaml) use=
s.
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/D=
ocumentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> > index c402cb2928e89..89dfcf5ce8434 100644
> > --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> > +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> > @@ -92,6 +92,13 @@ properties:
> >      description: |
> >        This property is as per sci-pm-domain.txt.
> > =20
> > +  ethernet:
> > +    description: |
>=20
> Do not need '|' unless you need to preserve formatting.
>=20
> > +      ICSSG PRUSS Ethernet. Configuration for an Ethernet controller r=
unning
> > +      on the PRU-ICSS.
> > +    $ref: /schemas/net/ti,icssg-prueth.yaml#
> > +    type: object
> > +
> >  patternProperties:
> > =20
> >    memories@[a-f0-9]+$:
>=20
> You are mixing MMIO and non-MMIO nodes. That's odd or even sloppy
> design. It immediately raises questions about your bindings.
>=20
> Best regards,
> Krzysztof
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

