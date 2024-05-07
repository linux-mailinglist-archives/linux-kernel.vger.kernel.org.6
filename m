Return-Path: <linux-kernel+bounces-171660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5AA8BE705
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B85B29F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F8168AEB;
	Tue,  7 May 2024 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQpdtnh8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DE161338;
	Tue,  7 May 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094535; cv=none; b=WOcr0qjN6GCvsp71Wdgf8+yjaj5SD1LmnQlG7fecuMywLE+6SXPeEQGvHGPCPizqEcp6LXn2+2JHohjZfbJ27yFGiqmkXrx33ScorGCiqrDCqM3URwMaUyiQ5rv5vnIBAF0Z8PRoIQJzZwCdhY05ofIqOvQqWZ7y1G+xfrGKOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094535; c=relaxed/simple;
	bh=ycm52fKCEVH22ltB8v+hNmkSggINFRR1kVE47PuUHP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJ0SFXyOeQrRz5wjOv+6h4aBdSEyyA1pg7SWZSeBKxs35yZJT/datwaLPRsYdQQOu52+bxVX1dXQBWO3nA95WhKq4nr2RJo+iGGTBpy9mFzp4UkMbMNGwpwQBftM7KtW7swnsaYLqbQPAM9wqVw11BV6NzTUvOLIOt5tjD52bvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQpdtnh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88102C4AF18;
	Tue,  7 May 2024 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715094534;
	bh=ycm52fKCEVH22ltB8v+hNmkSggINFRR1kVE47PuUHP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQpdtnh8YlsVoCH2VLVBNtU2+8DjCmRVpmI21ogmnm+njIqlao248WDYkDMmoe9/Y
	 6wzui6NhfrCOsnXRkaZ2U9ucyRqWQanyCm858zh3Hxcof2nKCcdPYZmaPhKVHCxNhG
	 pndnuBaAiTfDmt+LOSk9aJ3DxaOcAM/ERHs0bSpmOxK63GdGlEbaEDSvSs2fBQiJdX
	 ODP68zn3KOy3gIBKOVUK3YUJonztbsYkvC3hp738xPjF+vRqIhCulzlIX/eplDYwm5
	 +vggzua9WHBPpInKvPjUc90mDc91A5LjKDtoWmzdhXL13AyACK3milO1x/zZSjcKI/
	 mFM+dzuNsPsRA==
Date: Tue, 7 May 2024 16:08:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andy.yan@rock-chips.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH] dt-bindings: soc: rockchip: add rk3588 mipi dcphy syscon
Message-ID: <20240507-obligate-ripping-76ed73f46f57@spud>
References: <20240506124632.3621378-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5hlEgOW23HF9FJZj"
Content-Disposition: inline
In-Reply-To: <20240506124632.3621378-1-heiko@sntech.de>


--5hlEgOW23HF9FJZj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 02:46:32PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> RK3588 CSI and DSI support requires the GRF for DC-PHY.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--5hlEgOW23HF9FJZj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjpEAgAKCRB4tDGHoIJi
0olBAP9j0q1yLiXyy+lGOVgDlPpLYQPtcvDZFQmtY8MeXiLU2AEApyZLt7KBt/v1
Y3oPzSZfq5aiOJR5N+pAz9i30QD0VAw=
=fh3/
-----END PGP SIGNATURE-----

--5hlEgOW23HF9FJZj--

