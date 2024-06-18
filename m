Return-Path: <linux-kernel+bounces-219781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7359290D7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFEA1F23D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BC94D8C8;
	Tue, 18 Jun 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYixjFoj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAC4D8B1;
	Tue, 18 Jun 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725570; cv=none; b=YMvN1450mbY5GKWYgybczM23CMsWox6DR3YsejaaxxGdQOLnOjTQZJa54nw2Ba4ixT2D0wvpHhbnO6XYmjZCxe56gA+IZ0Toi+81Ro/nz1EwfNgEc22/jpAHYva8E/7nN8txIC7y8VIeqKWCQ8HGJSewNjgO/QhEkpd46RyphGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725570; c=relaxed/simple;
	bh=EK96rzd5A3P5K/VFg0/wmbgbJAOIBXdNn4AqTodCC/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGnhsVnNG2GCW+rTdUfl8Y0hCC7U3qw4QAi1/ufycXcUM9Lh30QdlTmV+rBCzsK7cQFm06HeQ8zz/veeWuSbCJBdKbJW/h/nKYrhW157BjhT6pMd57GladoniBMyX6m4vyb4vu8VWrqQ8PljncHfXcrwV7xjcOmNG9rYyK/FEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYixjFoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FA8C3277B;
	Tue, 18 Jun 2024 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718725570;
	bh=EK96rzd5A3P5K/VFg0/wmbgbJAOIBXdNn4AqTodCC/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uYixjFojwYot5ptgE8zN8lK5mY7IGCZXpxfYVbMszYvYSEelI8lHUao3DGvWPlg5k
	 hwwBLEExc0JXQTUQEdNha6rzAP2jPtpp8ldU5kgLqN3GYKPau2dfXWsCnNhaNF5USA
	 df5CVUGzm7k5TcAVbPbxrguu5YUnli+5a/oZVpB/Utc0bDOWzjomV1oxRkvEezJfCe
	 +ywNochVPUF8sy7hEux93xLluKCRITb2jLFd25wiNIF0dVmIu9ivjt1CJ0xpKVEfV2
	 WIkaTxxUPB+QLqTWgRxm9nvqDKjvbh/rEKttRQf5raAX8mIWr7HOCyjHnJg1QZVa9G
	 /PBLff63dEzpQ==
Date: Tue, 18 Jun 2024 16:46:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/9] dt-bindings: vendor-prefixes: add spacemit
Message-ID: <20240618-geiger-morbidity-89f93030cc40@spud>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_24CA6BAF3BB2E3A6C490854834FAF2E1080A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cwg5FMgi/syvrj0E"
Content-Disposition: inline
In-Reply-To: <tencent_24CA6BAF3BB2E3A6C490854834FAF2E1080A@qq.com>


--Cwg5FMgi/syvrj0E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 01:20:46AM +0800, Yangyu Chen wrote:
> Add new vendor strings to dt bindings for SpacemiT K1 SoC.
>=20
> Link: https://www.spacemit.com/en/spacemit-key-stone-2/
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Same nit here.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index fbf47f0bacf1..7ee6e4a89376 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1362,6 +1362,8 @@ patternProperties:
>      description: Sophgo Technology Inc.
>    "^sourceparts,.*":
>      description: Source Parts Inc.
> +  "^spacemit,.*":
> +    description: SpacemiT (Hangzhou) Technology Co. Ltd
>    "^spansion,.*":
>      description: Spansion Inc.
>    "^sparkfun,.*":
> --=20
> 2.45.1
>=20

--Cwg5FMgi/syvrj0E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnGrvgAKCRB4tDGHoIJi
0ngRAQDHlcWYxf46LvAXnaqeqZZo+TyovpuMV8gHkopB9T5GoAD9EIEWKyaHtlRf
RkUEtENONd86bn0hR/ZFzPCvY/u2/As=
=ho4q
-----END PGP SIGNATURE-----

--Cwg5FMgi/syvrj0E--

