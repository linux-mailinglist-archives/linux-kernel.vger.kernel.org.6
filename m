Return-Path: <linux-kernel+bounces-288586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A86F953C14
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6D41F261C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310FE1537D9;
	Thu, 15 Aug 2024 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+ZkG/9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59C149C6F;
	Thu, 15 Aug 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754547; cv=none; b=pZF9dHw/XR89QQWTy9qkPJuGdOGb1lNpcpTcxHO0cqf/RVwv6Uf+qULRO51S6CvbFuTbvgwAXsQnG7scpHsJFQxFtW7Y71va+5DkKfDvkATDBrwD76Z2Kv8MNww9GqdYKaz/GCZ79N/zOl5QEE6mJX84F+jALNHjTK1inNPSPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754547; c=relaxed/simple;
	bh=g8ehn/PJBUinnXWgPe0QmVwYk1A8/HXAzwHp6W2rokg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/TM3Aiy3sPfodCjWB0t7sxbIPChiGuBhvp2wuHzlyTu8U3pFb5S7kZZ6SptonE9i/b7SAmJ4J0cwYuwsg6uizNkYBNn3Zcx+q88xrPgCZNtm/vZnbJqeTv+AtccEmopXdD74Bw5tq6Ks2cJGsYE7HsJ3FXLpH8biVHnn5KI6zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+ZkG/9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE46C32786;
	Thu, 15 Aug 2024 20:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754545;
	bh=g8ehn/PJBUinnXWgPe0QmVwYk1A8/HXAzwHp6W2rokg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+ZkG/9xzQDuWX4vOQ4JtBOVopR9yfHTcyI40zRvf1ybJUIun38Z5RuAg0wj538Rz
	 E29ykJe0Tsp8ZLOPFpd3qevLk6MCgT/9lid/dBF8lPSGRyjbQLXGoR/ycsbe+iPbg3
	 +d+yd183NdMaHDuo6RQmx0AeUfJDNp42YbuEdSvPLqvaC3/AL4qWh6zhiSzc/S7Upq
	 LsmZJD0ydnpftuZlGEkIpAadBDFGzRwwW90DNKTiNGFUgHwPke9xZc8/iAwgJ06Vsr
	 S8nGOPkQvFHAzM8KPdbTVjrhS9gNW17GAVtf2I9ReSurAFvMquQsscTcFoguKr8Xq7
	 7QDWNEKs2zZxw==
Date: Thu, 15 Aug 2024 21:42:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/11] dt-bindings: soc: microchip: document the two
 simple-mfd syscons on PolarFire SoC
Message-ID: <20240815-afloat-baton-77a6d4e47b18@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
 <20240815-pending-sacrifice-f2569ed756fe@spud>
 <20240815200003.GA2956351-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aUl07Qh2nQayq3NX"
Content-Disposition: inline
In-Reply-To: <20240815200003.GA2956351-robh@kernel.org>


--aUl07Qh2nQayq3NX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 02:00:03PM -0600, Rob Herring wrote:
> On Thu, Aug 15, 2024 at 03:01:09PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > There are two syscons on PolarFire SoC that provide various functionali=
ty of
> > use to the OS.
> >=20
> > The first of these is the "control-scb" region, that contains the "tvs"
> > temperature and voltage sensors and the control/status registers for the
> > system controller's mailbox. The mailbox has a dedicated node, so
> > there's no need for a child node describing it, looking the syscon up by
> > compatible is sufficient.
> >=20
> > The second, "mss-top-sysreg", contains clocks, pinctrl, resets, and
> > interrupt controller and more. For this RFC, only the reset controller
> > child is described as that's all that is described by the existing
> > bindings. The clock controller already has a dedicated node, and will
> > retain it as there are other clock regions, so like the mailbox,
> > a compatible-based lookup of the syscon is sufficient to keep the clock
> > driver working as before so no child is needed.
>=20
> I'm confused. The reset controller is reused from somewhere else?

There's already a driver for it on this device, but probed via the
auxiliary bus, and the #reset-cells property is in the clock controller
node. The only devices that use this driver are the various different
logic element SKUs (which all share a compatible, they're identical as
far as an OS is concerned) and an upcoming SoC that is effectively a
zero logic element SKU.

> I=20
> thought you didn't expect any reuse of the IP happening.

> If a child node=20
> makes it possible to enable the h/w without any s/w changes, then that=20
> is a compelling argument for having a child node.

No, in both cases there'd be software changes - they're just simpler
with a child node.

>=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > (I'll split this in two later, it's just easier when I have the same
> > questions about both...)
> >=20
> > Are these things entitled to have child nodes for the reset and sensor
> > nodes, or should the properties be in the parent and the OS probe the
> > drivers for the functions? That's something that, despite supposedly
> > being a maintainer, I do not understand the rules (of thumb?) for.
>=20
> Besides the is it an independent, reusable IP block test, my test=20
> generally is do the child nodes have their own DT resources? Say=20
> you have phy registers mixed in some syscon and clocks which only go to=
=20
> the phy. Then a child node with "clocks" makes sense. If your only=20
> property is #phy-cells, then a child node doesn't make sense. Of course=
=20
> you could reach different conclusions based on the completeness of the=20
> binding.

AFAIK, none of these things are consumers of resources like that, other
than the interrupt controller, which has an interrupts property. I think
that could justify a child node (and I think a dedicated binding,
because it is a confusing irq mux that that kernel doesn't appear to
have anything else similar to).

> > Secondly, is it okay to make the "pragmatic" decision to not have a
> > child clock node and keep routing the clocks via the existing & retained
> > clock node (and therefore not update the various clocks nodes in the
> > consumers)? Doing so would require a lot more hocus pocus with the clock
> > driver than this series does, as the same driver would no longer be
> > suitable for the before/after bindings.
>=20
> In the 2 cases here, I don't think you need child nodes. I would expect=
=20
> pinctrl to have one though if only as a container for all the pinctrl=20
> child nodes.

Good to know for when that gets written. Hopefully not by me, I have
enough messes to sort out as is!

Cheers,
Conor.

--aUl07Qh2nQayq3NX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr5oLgAKCRB4tDGHoIJi
0owVAQCRkSdo/hUd7wk0uN5NZW7djgJSquy18gbzGCqmTEZyXAEApoAV/aNJXcR+
xexMkf+YtA9tnksmeZ2e2OH6nf5WDwc=
=BIBj
-----END PGP SIGNATURE-----

--aUl07Qh2nQayq3NX--

