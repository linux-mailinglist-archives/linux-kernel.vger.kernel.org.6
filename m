Return-Path: <linux-kernel+bounces-278332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C763794AED3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7362C1F21D69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5216C13CF86;
	Wed,  7 Aug 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw4pgZTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C147829C;
	Wed,  7 Aug 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051471; cv=none; b=VAj7Crjf92ncozpfpnEmIJ9V2wFOtrjjsxMWhe9JV/senTpdayr/CpDyszeBBuDFuo8wqtqHVo+cnYodHRJsP3BvvbWiBD4OmOlX00ZK7D4K5YArthWK3jZiZ/SP1zBavoRAqq4YC9qY5LJZl99EmNklNMYBhlUQ0tsFiISkt1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051471; c=relaxed/simple;
	bh=hbD18wpdDV3KchTLv7sj/3wb4UnZsJ7riubip8+IJwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGZtSmy9hgM+exLFm93yMJOQny1FHuHpfXbeOMqt5c8pyTj1UgMEEkDlGxg+oOqrSOZYIuEJ0qkMnIhWBVCSvajyxH/OkUpS/WWrvyAcIgvtPD/Fm2KovKcHYgiOwmMPoYD0aOyYQdRKECEW2Hh4m0f3t3ZQMd5X0EKLPlEEEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw4pgZTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FDAC32781;
	Wed,  7 Aug 2024 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723051470;
	bh=hbD18wpdDV3KchTLv7sj/3wb4UnZsJ7riubip8+IJwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nw4pgZTefnO7avtCPMVQstyX97iC462m7FD5w1dXh1fkQ/9mPKlLNNubZx+ZfUJQm
	 qOo5lAf28VGGdcDSymjMKCjtZ6neqLnoUc7K5WqomruIBbvguNyDJFerncqQMljwoJ
	 WjFthV3FTjv7bpxyp6maMFk2m05chP1pj7KfdLA4bcjzbdSyDbpS/oB4KuGuzhwLaI
	 I7AdlivDTr9CYDb3T3kyak8ECjTX17QqCJLAsFsqJ3485alabUTCAuDPnUCMUrMnZA
	 atW0HBtQnXcf6YP5McBSV13XHPqQeYv5og5UXvj4mjujnGK/6HbUBOnsw40FEeE/2J
	 yixW1fYez22+g==
Date: Wed, 7 Aug 2024 18:24:25 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] dt-bindings: Convert and move Mediatek clock syscons
Message-ID: <20240807-affair-dad-33a8762606c6@spud>
References: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="REeeJpUvoCaayRRY"
Content-Disposition: inline
In-Reply-To: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org>


--REeeJpUvoCaayRRY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 10:58:52AM -0600, Rob Herring (Arm) wrote:
> This series converts all the Mediatek syscon bindings which are clock=20
> controllers to DT schema format moving them to 'clock' directory. The=20
> existing schemas in arm/mediatek/ which are clock and reset controllers=
=20
> are also moved to 'clock' directory.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--REeeJpUvoCaayRRY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrOtyQAKCRB4tDGHoIJi
0gT7AP9dwMq7I7wZCotZ1n+Gjx12a1KtqSo4cnqfp4j75rBYDQEA/xBDTFpSj9qX
KmtHZQWDrYgsoR4KuFTOZ+ZG29l9awc=
=Jukv
-----END PGP SIGNATURE-----

--REeeJpUvoCaayRRY--

