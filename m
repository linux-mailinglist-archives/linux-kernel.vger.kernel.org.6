Return-Path: <linux-kernel+bounces-225684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B509D9133B0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B948281A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAEF155CB2;
	Sat, 22 Jun 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKO7LBZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4C5A788;
	Sat, 22 Jun 2024 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719057938; cv=none; b=jOOldknBxVoL+K4FUD/lR9uWp1qGqc25wSWzRVRXpgyMv95fBfL0cYxKQYBLu2K/1f6Jcsne/MlG+mYzez+jDDDintnjPpHHz0AxEYuKs66NcMk7ep2wUe7o9NJqMKwEKwBJUlWR4DYwVLTz8rw8gI4uzON4d3/N0iYBsepjhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719057938; c=relaxed/simple;
	bh=F/HLmJ2OBhyGpSULyV0Nh9eCof/TATNsIly3LECh6ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuggkETIeqwGwDbg7FfE2Mxue2DSKcMMIyrb1T/bPevi+hfJteKPDRwef64WMQyjBmhRiHDback+Xf2/bMqxqtTgH3wMCpuo+DBT6GBld9x5euzE+P97Lkxm0j9D9QPxw0ntz/u+g6BrOvMdBJL/b0OxMEKPZu871+9IDuM8T1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKO7LBZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567D1C3277B;
	Sat, 22 Jun 2024 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719057938;
	bh=F/HLmJ2OBhyGpSULyV0Nh9eCof/TATNsIly3LECh6ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKO7LBZTR0tKVxgEsvQAUoeYdlosxGN3h1igYU2mkQJCzQNsGUiFKc7+5xOb/0WM0
	 MmB/4V+MP0ZbhkWoZJiDN728uTNvZuEImxrwmEB4BanE1pyzKIvkfM+KWVQkXOx664
	 81xUm8L71rQmpdiDqc2mCaafgsYYmdgj05+cUp+k3pmPxRsKiGXJgtuwvuTZiFi+qz
	 dOSiqG1xAWRxoThDk4SlzqIyae4rSYYOhHZMRQEH5xdeKatxtd6VqUe2tsAMgV2d3Q
	 Cll3SALUIsjPqpgExFnK00qbpMD4rE15mQE+E1ZO60vwurYfDHR5fh5aeRy+mcbpZP
	 LoGcaKM8hKFsA==
Date: Sat, 22 Jun 2024 13:05:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add Neardi Technology
Message-ID: <20240622-algebra-fifteen-10e9ba3a44ca@spud>
References: <20240621134030.243646-1-knaerzche@gmail.com>
 <20240621134030.243646-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0AAtk5XzKyJNFG7G"
Content-Disposition: inline
In-Reply-To: <20240621134030.243646-2-knaerzche@gmail.com>


--0AAtk5XzKyJNFG7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 03:40:27PM +0200, Alex Bee wrote:
> Add vendor prefix for Shanghai Neardi Technology Co., Ltd.
> (http://neardi.com/)
>=20
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--0AAtk5XzKyJNFG7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZna+DgAKCRB4tDGHoIJi
0rnGAQCgzpNSudyZd5E3mPkcnUrBMAM9a3S3F0D8rb7Ed92cOwEA8v4ZtzZ4oLUW
5F4zzsYfQr44x7LrENvf5e/EcBNs2wo=
=9SoF
-----END PGP SIGNATURE-----

--0AAtk5XzKyJNFG7G--

