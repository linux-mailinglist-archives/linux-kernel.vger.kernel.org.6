Return-Path: <linux-kernel+bounces-223002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6127910B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CDC1C24E10
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03101B142F;
	Thu, 20 Jun 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYJ47wSD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FA1B140B;
	Thu, 20 Jun 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899949; cv=none; b=KSwpMB29foxKNKOaP1o/Ax/me40dyRdZzSph05yBQI/jezhC1fG6Kf6BGOTXIW/Ydif1EFGrTFAVQMc0tKUlkggq52pQzfvgKJ97d5J5VMUpVKekO/73TJmGXXCgK1cEEqcdVNAb2dXQXnW8XK2P6b+IG/MxzYhEvmeDZaiCrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899949; c=relaxed/simple;
	bh=czQWpKjgJU/ptaXUhAAxu1A7j9DtQA2l8Ttg4DhaZ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s47nMSCPUoqBFPXKN2+IeaXbFVGDIXFaWmPHu/TwP6jXEwevo1f4z6v4H61fipqEzt+hXi68Wvge9W1oM9V7KWcB/kFJORIQLcr7rRn/7QsTSSgOxacO+rFLrt5Ei9COtYIPVnUhXPZCsCgivmORdm5iUX1wmz42a4hjY1B5Ek8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYJ47wSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F4C2BD10;
	Thu, 20 Jun 2024 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899948;
	bh=czQWpKjgJU/ptaXUhAAxu1A7j9DtQA2l8Ttg4DhaZ+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYJ47wSD1eTPnOZtFjs4yJYKQ/Rz3C5L+hQQc+5WWuW/8iH+CbE/JvFMJIufgD/la
	 WXoOYDRjgquQ22FzoADILDwY0y+50G23wThJ7w5rdushm+viOq/cKihjDAX6ahgBCV
	 j7gtbeP/nJC1+UiVAx4/3OWObwDmErmmXWwfHfjWEhd5AQv5uiU3pnc0yzMdTszM3S
	 mxRHM0n3HqOTMr49WwtltP4bv2FHIxsAsT0/LaZrxTDwInuEibXIoZ7OCoiBaEMcwl
	 nXHxiNll+fwRctS0Q9vRoeozScxoK9jl74oqHnnieqENjA3uRN7678baOAmWee0D0G
	 rkzU0QRU37Sqg==
Date: Thu, 20 Jun 2024 17:12:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: regulator: mt6315: Document MT6319 PMIC
Message-ID: <20240620-opal-reopen-f2aeffc9b041@spud>
References: <20240620094746.2404753-1-wenst@chromium.org>
 <20240620094746.2404753-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w4lZ/5tY0n345UFW"
Content-Disposition: inline
In-Reply-To: <20240620094746.2404753-2-wenst@chromium.org>


--w4lZ/5tY0n345UFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 05:47:36PM +0800, Chen-Yu Tsai wrote:
> The MT6319 is a pin-compatible drop-in replacement for MT6315 with
> slightly better electrical characteristics.
>=20
> It's unclear whether there are any differences, since the downstream
> implementation doesn't describe the MT6319 separately. Neither does the
> implementation check chip IDs, even though those are available.
>=20
> Add a new compatible for the MT6319 just in case differences are
> discovered later and fall back to the MT6315 compatible.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--w4lZ/5tY0n345UFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnRU6AAKCRB4tDGHoIJi
0gLJAQCl0SjtBohHCsfZ30bxNNke2MgW+12GqK/R+y85NhloxAD5AWXCXO73HtXu
6i5ZD1ohpDU4ZkzCYIdvfAad4Okivw4=
=0rwv
-----END PGP SIGNATURE-----

--w4lZ/5tY0n345UFW--

