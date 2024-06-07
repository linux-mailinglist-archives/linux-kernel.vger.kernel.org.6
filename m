Return-Path: <linux-kernel+bounces-206310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129649007B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2AF1C21511
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFC319DF6D;
	Fri,  7 Jun 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajpPnekz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023D199E89;
	Fri,  7 Jun 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771829; cv=none; b=WDFKNpCQP41ZDWXnXcmxw+HFda2QvIlnVkDHq8KvadVV9X6+a7ArvXlP8mCjeVUozC0h9/fGIOnCJ49rxG2eW1+Fgf3ltPlMvR4BwJU6MN4/cAFTbmbn/3GnEcnsmNTDJ3Su+u2cX6ows/h234l2n1gjl3/54iPFr93JMEQJGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771829; c=relaxed/simple;
	bh=Ri87GktoRdbIrRZ4CFHdq761BmHVMP0uI9BCFg8/uUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+5nohpI1SFlUVgvK5QnC3NjvTBoRt77GqVzCr6Y61bRnoEIHXOGuv3iy07On2dvxO/DcZkuoygVI/msHveuNswlkWQMNx776h+GoPSgCRkFPtJa+HMsSbdNCRVwj2Vwi38k5GUwJiRt6smdm1L85fXWjP31Re6Qvba1iEY2Qjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajpPnekz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942B0C3277B;
	Fri,  7 Jun 2024 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771829;
	bh=Ri87GktoRdbIrRZ4CFHdq761BmHVMP0uI9BCFg8/uUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajpPnekzaeDsiKbcXi7JmQ1H14SkDq/KVtLrBwMpKKm3pPbbQC/XhwIsBiNjZYKyd
	 n0syZ89wyadP9smzrCuCvUanaH8L+0udg6KLkyWVzRjCY4PyhV5UTq28Fjo/buxHqI
	 XVVbtd7fR0cUP+3BRQJjrUNm2vTVzuxmaWCs0QsHTUbeDTLWg7OjNT3d0jj8VET0mW
	 aNKXJijIhUBbrqPTpstowjiQS70DcZXvgXHaKUfcD00jha6DmLoJMyAMD0EGCU91xT
	 /jo5frptrBtdIRWNEELO4cjyTcDX4yxhFOcP/tllDC5um8RBM2lX+vM9TbBmfKWLHm
	 IhCVeuFvDgmLA==
Date: Fri, 7 Jun 2024 15:50:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/5 RESEND] dt-bindings: clock: rk3128: Drop
 CLK_NR_CLKS
Message-ID: <20240607-dealer-vertebrae-9b22db3dc43b@spud>
References: <20240605210049.232284-1-knaerzche@gmail.com>
 <20240605210049.232284-3-knaerzche@gmail.com>
 <20240606-dispersal-buffed-27a6e7540d4c@spud>
 <1f549cba-a754-4256-aa4b-dbc630e5e451@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pn98VwvBn/z4pnw6"
Content-Disposition: inline
In-Reply-To: <1f549cba-a754-4256-aa4b-dbc630e5e451@gmail.com>


--pn98VwvBn/z4pnw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 07:26:06PM +0200, Alex Bee wrote:
>=20
> Am 06.06.24 um 18:09 schrieb Conor Dooley:
> > On Wed, Jun 05, 2024 at 11:00:46PM +0200, Alex Bee wrote:
> > > CLK_NR_CLKS should not be part of the binding. Let's drop it, since
> > > the kernel code no longer uses it either.
> > What about other operating systems etc, e.g. U-Boot or barebox?
> For u-boot: RK3128 hasn't been switched to OF_UPSTREAM yet and it still
> uses it's own (dated) copy of the dt-bindings headers [0] and besides this
> macro isn't used there. Barebox doesn't support RK3128 at all and I'm
> generally not aware of any other bootloader/OS does which does and
> especially none which uses this macro.

Okay, thanks for looking into it.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--pn98VwvBn/z4pnw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmMeMAAKCRB4tDGHoIJi
0gLAAP9Z9FIoMScpKcRZaz/8f9q0x1pPmmkVVR4gcGHKm4Jw+gD/UZS0U/GpLXTT
qhR6kXOZM+E1lndKozOzLvUKmPweXws=
=CcOd
-----END PGP SIGNATURE-----

--pn98VwvBn/z4pnw6--

