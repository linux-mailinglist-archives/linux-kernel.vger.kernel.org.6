Return-Path: <linux-kernel+bounces-204653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069558FF1C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB7328511E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40180198E87;
	Thu,  6 Jun 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgh/4/r8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972E153511;
	Thu,  6 Jun 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690107; cv=none; b=l9Tsw4zO5Aa0zNy/lM00D6Cc7AKMBV8AVaX7zoyBrLpTS8COlD/KuL4sGJCvaD9Ju02e9LmlHpbBbl3TwQ7ayKJaVuzpFx40xF3STEXXafEor9Em1/XnRC4Tkq8gzy8FJjinVEemMiaX3xw1Mv7z+e3/AcNqAr43RAXUPQ0M18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690107; c=relaxed/simple;
	bh=UmCxizvm3rPZ18X39bpJ5dPVaD+xg52JPfN7bRM6mjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn7m3mG8IIIALbH4E1hlWgX/lbqI+d5A41CDQ1r6X7Hsx9aanD9q5AIurjlc2pb8tQBYZbHPz36/G0cl4sihwqdawAxBZ5OnUXUyDh8qmIUEsJiuV0CQyFwkuSWkZ5eGDKGuXgg7iHcev9xLsWX0E6b7j6Sv6A78znMkcYQwc7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgh/4/r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3074C2BD10;
	Thu,  6 Jun 2024 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690107;
	bh=UmCxizvm3rPZ18X39bpJ5dPVaD+xg52JPfN7bRM6mjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgh/4/r8y1ht0dQWNTA3d0N0tSKSedHgcydHx39SJCfR47uwyeai8NiJPUrZsdu6Q
	 Y2+Sw3drdOUCDfCUliRgezLGTQflWADHttk6KFAPsl9qP9yNq5EPltRIXJPU24rPQU
	 QfjiVfuWbmbtUmf5mvecvAjTVi7lJUYHF76Mv4m1cU8mfRQf+QVYfVMOf+9i8uTXkY
	 45rltO4yBVglKtnyGyUvS1LXcQw7fA+j8J/0mQjajIERORDCX3+p0zDcBrk019No5D
	 FrrTZronBlNN2Bi57J9L1JHtHwHboDR03IfOYzq0TQk5aiIgW5Ia0U9Aqd8A+YDWE1
	 HdUAzJQfDgJcQ==
Date: Thu, 6 Jun 2024 17:08:22 +0100
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
Subject: Re: [PATCH v2 3/5 RESEND] dt-bindings: clock: rk3128: Add HCLK_SFC
Message-ID: <20240606-rudder-urging-b3adff371b09@spud>
References: <20240605210049.232284-1-knaerzche@gmail.com>
 <20240605210049.232284-4-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nr0MJ9IweRh6y/Hr"
Content-Disposition: inline
In-Reply-To: <20240605210049.232284-4-knaerzche@gmail.com>


--Nr0MJ9IweRh6y/Hr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 11:00:47PM +0200, Alex Bee wrote:
> Add a clock id for SFC's AHB clock.
>=20
> Signed-off-by: Alex Bee <knaerzche@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Nr0MJ9IweRh6y/Hr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmHe9gAKCRB4tDGHoIJi
0jn9AP9SMAO9sum1e1deg3jz2j/qKh9LNAHOswIPlSqJXs+jdwD/a08TAeMh5Eza
L1XTPyQj2TxsBm1lt+YZp4ZN6on0lAQ=
=f9NK
-----END PGP SIGNATURE-----

--Nr0MJ9IweRh6y/Hr--

