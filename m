Return-Path: <linux-kernel+bounces-346346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443E98C368
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF8D281560
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B41CB338;
	Tue,  1 Oct 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGUpjX+L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F21CB30A;
	Tue,  1 Oct 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800190; cv=none; b=QE0I9nIURYLmLPiXgUMz5TZMJdd6CMe6vHJOJxhapyhddTHfJagm1Qc/fSBmfmFOT9B0H9AtimVpdmz19JpivlqeC5dBID8qPCukdsdxjQgY9oUxXLEKx1ci6xCgLKY782wk6OuvwPS74vlW7GyCuBOniRhPgFu6unUMSQy8wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800190; c=relaxed/simple;
	bh=NADCzdoQHxs70dLpOpbEBc5B9Lh4rNs0x/YVRXbRKtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYU2GQuO5fK1Se2SvCqXQ1sAq416zAq6W4M/+PUax486yJssf0YHpMkLcq6RsBesQUVNFSblma5axgib3Jl3odPH2yRj6dGiK6gFLfNQtiwIOrB8P6ZRrwRWp0ubJglbOkXMeuXzKGna2eCDJMp8y8ucUq2ImL74b8Zd1D+zlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGUpjX+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDFFC4CEC6;
	Tue,  1 Oct 2024 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727800190;
	bh=NADCzdoQHxs70dLpOpbEBc5B9Lh4rNs0x/YVRXbRKtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGUpjX+LuiqN3KWetChgzoYXfBenHHtLsdXiXqbBwZ44bjG0kRwOG3cm/F+yeuZ6F
	 UCxop9wZ0qgFzdyF3BJPWp/2/129n+yQim9R6dxLCm4HR9/ZpiOlUY+p1ibiByj+GJ
	 v74QablmQyEHsX5Al0T3YNe0+UHJci2p7RffPLbgjY860SrdkgGsY5ivp0y2rJipgf
	 Fxj1ALXwGTNGHpFL9Iq7ZC3uMFtbj2oSE8GwBxXCXFp/5fOZYsF/QJMWRSk0J5aQRK
	 gMkiklyuESZwIas0Kvhu2G4lbkThSg5L7FNWX8CKFuWSxMBiW7CDQ1us0xDIKEFW/A
	 xLoe1ypz+dR8A==
Date: Tue, 1 Oct 2024 17:29:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: reset: Add reset ID definition for
 Rockchip RK3528
Message-ID: <20241001-stooge-bok-7ddf3f4b317e@spud>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ISxsTydP0q9GjrUj"
Content-Disposition: inline
In-Reply-To: <20241001042401.31903-4-ziyao@disroot.org>


--ISxsTydP0q9GjrUj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 04:23:56AM +0000, Yao Zi wrote:
> Similar to previous Rockchip generations, reset IDs for RK3528 SoC
> are register offsets.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>

IMO, this and patch 1 should be squashed with the binding itself.

--ISxsTydP0q9GjrUj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvwjeQAKCRB4tDGHoIJi
0qMUAP0R35Kp7N0yiWHGvT8ezIOH7i0YqKkCIk6WMj/ucdRkXQD/eOjndIh/aHFA
+NF/S6xtMCZxgREjsLUe9dSdtvfZ1w0=
=uWpo
-----END PGP SIGNATURE-----

--ISxsTydP0q9GjrUj--

