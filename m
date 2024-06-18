Return-Path: <linux-kernel+bounces-219780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AED90D82C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4771B3359A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4A47A7A;
	Tue, 18 Jun 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGwXCwDa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092D2033A;
	Tue, 18 Jun 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725550; cv=none; b=d3RdrYqHeLNO9fKXN4Gthan0CSpkgEVwmcLM4AmbqFH0jQucYEtFq+Wm357K0qCZdt/y5LqgRK8jPprK+J0dmkQVp8kAfPcJWW+pfKJJ3h9B3bohkwwol9PrGl6nnoni1VJX85bbomuYC70YoOmQHcQLck8/+tAixT2hLfGwtU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725550; c=relaxed/simple;
	bh=+Y3MShge4JrwWG3G/w1pr+rtYWkctyGlLWVNc3mtZi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wq7mK4BPrEsUGuL9Qom+ArGabfrT+AR+1WIeWCFdznugW2/c5BmZxqHs3riBp8SLq15g9KP8xCrYuD3cTpW1pcbJuXvrPQIQc7+Z5Le/XEiQy/S0s5sjv9iryBojpUopCXYyX3mWlD0MOZLjn+OfsirSFCOCCS3TxxF5CJtR1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGwXCwDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5B5C3277B;
	Tue, 18 Jun 2024 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725550;
	bh=+Y3MShge4JrwWG3G/w1pr+rtYWkctyGlLWVNc3mtZi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGwXCwDakCJUruIfaIRhWshWGOnHV4qtpxMWon23cqUzaY8jEJuOA22gi8jFYI4rI
	 ObhcFL5W/oPp5BKpvkSQPbSeJMaBSQDY4paLalSjjq9uuAvFugW98vG76DViAdYOSn
	 MiTD7Ss5k696SALuI3kWSaJZa8iKyQFD54CkoT8nXfEeKa7N3G5eJ5jPIA4zc6BerC
	 LF4UWypbUDJlKcLRe/EfmYH8NwbDEFkzR1hPB5T8igeCesOTYF0lEisHK+nLyQaZAS
	 +qpVUGhnja4cYUWJ40SLHYLDaDLZSlmqkL93FSbpszLkGnOBTz2aGnRg1ivglLIfDK
	 e0+BBcV7FGS4w==
Date: Tue, 18 Jun 2024 16:45:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/9] dt-bindings: riscv: Add SpacemiT X60 compatibles
Message-ID: <20240618-vendor-debtor-c88a8a555a4c@spud>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_947689E304AE5A4C7A48682311DF8920B106@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeJQNOojAFcHf82l"
Content-Disposition: inline
In-Reply-To: <tencent_947689E304AE5A4C7A48682311DF8920B106@qq.com>


--EeJQNOojAFcHf82l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 01:20:47AM +0800, Yangyu Chen wrote:
> The X60 is RISC-V CPU cores from SpacemiT and currently used in their K1
> SoC.
>=20
> Link: https://www.spacemit.com/en/spacemit-x60-core/
>=20

nit: Delete the blank line

> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index d87dd50f1a4b..5ad9cb410335 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -46,6 +46,7 @@ properties:
>                - sifive,u7
>                - sifive,u74
>                - sifive,u74-mc
> +              - spacemit,x60
>                - thead,c906
>                - thead,c910
>                - thead,c920
> --=20
> 2.45.1
>=20

--EeJQNOojAFcHf82l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGrqQAKCRB4tDGHoIJi
0iAJAQC7qcXuTq4ZwTJonJzf+JN6yAvGpeql2DX+RXgpHhAH2gEAySlx6N7CvLqG
WLunJhEKHouFBjgCCw11FxvuAKBU4AI=
=OF3D
-----END PGP SIGNATURE-----

--EeJQNOojAFcHf82l--

