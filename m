Return-Path: <linux-kernel+bounces-344173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2DE98A5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEB81C21BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC618FDD5;
	Mon, 30 Sep 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV97WcvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4B17DFEB;
	Mon, 30 Sep 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704075; cv=none; b=T8JhfJvYqE+WDmU76lxTZ1yp+fMnpotrstV9BNNC7PIFwaupQAn5asQ/tB5Km8Kq72XfrOrrrtytXjTP705IWHX469IjQNCSize0h4xTZapNDTictu+n62w1uxjRM9UUUIUM7Ag0cZRFuvf8Fj2GloDsFW7iJHXDea0VF2Bpm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704075; c=relaxed/simple;
	bh=XzNX2t1xxnZjsa7RwzNfCX2nQJVLYaCqjyt7jh1gGFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgiwlwhEEkv1AICQ4C/U92wUrpwItqXBgBRy2BQCivS/2F3NsZ+f7niWM4uVScvEILoS2ClAYUOInCVhuZSeaAvE2ZETeKwN0RMUgMDVtwW2C0cD8l3LMu12pwJk7s+p5z45dxrDMFVroFN2ZdPvs6KgroOqbub7ENggscQn0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV97WcvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE964C4CEC7;
	Mon, 30 Sep 2024 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704075;
	bh=XzNX2t1xxnZjsa7RwzNfCX2nQJVLYaCqjyt7jh1gGFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FV97WcvEspdNiIELdtSLP0YgKC1mXjqYTLWmnYS+2VcsRv3+ZQ5Dl8JmAQ3Q0vP5r
	 62xEk7CbD9QzZzTax9fNs48PgkJfmdKO8uW54DVHmWJLEMfpQVyYw4WtOECC53eqYK
	 HavTuduBMipJQvS/lUyQ9S7hY0VcPv85i7tqwSUDUJwFYQ0FzqEAKfVuezOlNNk/dT
	 gvRknUCS+jh1MGm5LaXY1x/UIHXCCpytGlgmephdhnBLoymxg0ymce772lJxqG6RBT
	 zoAdkLb/HeY8NOmZSQXrGi5BBUTLbj4dWIUDNgUJpiKVkllF6Z7BDcP+9xZtdngRyH
	 G2vlT3i20/yqQ==
Date: Mon, 30 Sep 2024 14:47:50 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 08/20] dt-bindings: clock: mpfs-clkcfg: Add
 PIC64GX compatibility
Message-ID: <20240930-twister-coveting-2861bab77048@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-9-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nX8cDUaRrz3hvHbN"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-9-pierre-henry.moussay@microchip.com>


--nX8cDUaRrz3hvHbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:37AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX has a clock controller compatible whith mpfs-clkcfg

NAK, v1 comments need to be addressed before this can be done.

>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  .../devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml    | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcf=
g.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
> index e4e1c31267d2..ca889f5df87a 100644
> --- a/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
> +++ b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
> @@ -19,7 +19,11 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: microchip,mpfs-clkcfg
> +    oneOf:
> +      - items:
> +          - const: microchip,pic64gx-clkcfg
> +          - const: microchip,mpfs-clkcfg
> +      - const: microchip,mpfs-clkcfg
> =20
>    reg:
>      items:
> --=20
> 2.30.2
>=20
>=20

--nX8cDUaRrz3hvHbN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqsBgAKCRB4tDGHoIJi
0kWoAP90aUTipNz/ZVbmJigGdbXIDI8KgMG45+NYCz6lVdWSYAD/aANBl+86hp5W
hdXibaIItA0jDG1eYPCvKYWoUVxHvA8=
=fM/P
-----END PGP SIGNATURE-----

--nX8cDUaRrz3hvHbN--

