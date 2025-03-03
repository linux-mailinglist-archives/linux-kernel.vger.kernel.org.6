Return-Path: <linux-kernel+bounces-542215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC2FA4C716
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF5C189C65B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CB7217F33;
	Mon,  3 Mar 2025 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcN+cLwm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76422D79E;
	Mon,  3 Mar 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019051; cv=none; b=FmG+0v7J2v8n5FZeM8WKken7e2FQnRsmVM950G4KFR7TJcrXXoFyACcKxOdm31ebPBiPX5vvCLApY2PVAvsE6TzN7pBQfnBkOb1jlHJyI8i1L63lQM4QhswvQOPWGyLvNCrBfC/QTS1yQnxwcRTwkJifGZPq0VBw+cz9PkY8rn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019051; c=relaxed/simple;
	bh=1yDqqVmCKFaOfepku4ibV9RAk9lyrZmb0xSVnZlX/L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex96cWwYG6x1Dp6k+qYI9JVCp6dWE1NfOuhu5itUde6s2hccu7D8GocUNOfI4Hk8Ze3TpTveU6stu7sbv+PwEEnZstisMgx/LxEfkP0ehT6mXMMxgN3baDG6Kv+xkothrXLYOqXIpbfnvDj+upMoXQ/8JjT67l540NsqhicbUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcN+cLwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7870EC4CED6;
	Mon,  3 Mar 2025 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019050;
	bh=1yDqqVmCKFaOfepku4ibV9RAk9lyrZmb0xSVnZlX/L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcN+cLwmkh4DIQ6sWSD/sU2ZBMbfcJAiWSiMZS3bojcipN2vLCUA4RmRuD+lb1gch
	 CooqYUk7Ll+ZuffNOvZZyvKaMzmbcZch6zQj26ow+RLtNOMZV+a63v45lBPJFplSSK
	 50C5rgEiMZStbW3mCVjFD0RxJcChTlErOzVxZ1DStMcP29Ig/OmI30jJ4VYZGDu1V+
	 6FSCShMeKGyxtqmQELiP2Qg1WThyQaxhTGHBglEP7nsCe6eN6T1cnuZ9rQyDnUA12i
	 bE7Pzvf7Oi3nsgSB12FgxCvDEpzBO4wlixmwbmsedLVdCySol8pL7lOd8vQYW5TnOW
	 PP05De7W0SY5A==
Date: Mon, 3 Mar 2025 16:24:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/4] dt-bindings: clock: thead: Add TH1520 VO clock
 controller
Message-ID: <20250303-navy-radish-dcd4e6a24c0e@spud>
References: <20250303143629.400583-1-m.wilczynski@samsung.com>
 <CGME20250303143635eucas1p1dbcd26d4906b962e07cbde7f5ef704bf@eucas1p1.samsung.com>
 <20250303143629.400583-2-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CALOE5J+d774HnuJ"
Content-Disposition: inline
In-Reply-To: <20250303143629.400583-2-m.wilczynski@samsung.com>


--CALOE5J+d774HnuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 03:36:26PM +0100, Michal Wilczynski wrote:
> Add device tree bindings for the TH1520 Video Output (VO) subsystem
> clock controller. The VO sub-system manages clock gates for multimedia
> components including HDMI, MIPI, and GPU.
>=20
> Document the VIDEO_PLL requirements for the VO clock controller, which
> receives its input from the AP clock controller. The VIDEO_PLL is a
> Silicon Creations Sigma-Delta (integer) PLL typically running at 792 MHz
> with maximum FOUTVCO of 2376 MHz.
>=20
> Add a mandatory reset property for the TH1520 VO clock controller that
> handles the GPU clocks. This reset line controls the GPU CLKGEN reset,
> which is required for proper GPU clock operation.
>=20
> The reset property is only required for the "thead,th1520-clk-vo"
> compatible, as it specifically handles the GPU-related clocks.
>=20
> This binding complements the existing AP sub-system clock controller
> which manages CPU, DPU, GMAC and TEE PLLs.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--CALOE5J+d774HnuJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8XXpAAKCRB4tDGHoIJi
0gkWAP498RW2NwZO3txiozqaSy4rbLEB63zmzt4SqAiUaOeBVQEAt8JxtyMnMCfk
vhJzjAMHGQhKi4qdTMFnXrJiVS5v1QQ=
=iY3/
-----END PGP SIGNATURE-----

--CALOE5J+d774HnuJ--

