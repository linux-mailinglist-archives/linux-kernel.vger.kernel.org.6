Return-Path: <linux-kernel+bounces-526372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE93A3FDD3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C31B3BD998
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6EC250BF1;
	Fri, 21 Feb 2025 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2M1eUcu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF536AF5;
	Fri, 21 Feb 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160016; cv=none; b=Tg4pGKoum8Dq/rolhSj0WILqRsOwysmYEZ5HQ2nUN02kHunRxSphOLzgnhtOOF/w3jjUrPyiK2zPQijZHL1HOVRUGXTDElvzW9aMg6DCzD+S+A/KOlv0BTnoqTAEWsQrI7wD4+mE05WAMVRhrbMymVmSuHK2M3v9UFybTJ9WNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160016; c=relaxed/simple;
	bh=pkMm6RkLxj0MLvOjXO6Zq/qKdEhQUSinbouhRvXjrME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCyNPQjdxPMMPvEc28YjX3zrrUHKqbj7EWfn1y7ljuKvIRexuO2VumjPYfg+5JMDGnFqHnfYiuGSdrASqBJH37xAaog3v+JrE/Dt6Ml198FmoEOW47XSBvKbEAnmg3/P9FUKc60MVBxN7tdMJiL5v5QutuWpzDxWnfpD0Vtm6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2M1eUcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF7AC4CED6;
	Fri, 21 Feb 2025 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740160015;
	bh=pkMm6RkLxj0MLvOjXO6Zq/qKdEhQUSinbouhRvXjrME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2M1eUcu8YEAN59gO+QTHvsz8Moc4Z/JlLwFqm+v/GWd1vBBTNc2rH24rR6ZVcXwL
	 dzZJm7j3LZoRHOURuEfI/MDagEjV+GlTv+Eb67Am2ydeTZq7BxXc7lchUWMQjDohVW
	 22UXQr6iX7OYOL84YR3P8NFyPiDcF9DjhJTTSWNPptqAUH3B9Fuj8Ef87jObOvwgnh
	 Zy4Z/MtHsvC7wWf3SN4pl5hMfn4f2iQpsIjLRHzf0zVb+UZoHHMq7YF6QOIXSbvOYa
	 HOOH324RwhLUXaRVOoqfs1oEYc/BvNbwy0ziBrR9Sa3NJwlm/V91QWfbALwNK7oSkp
	 hwnMT3PYOfYaQ==
Date: Fri, 21 Feb 2025 17:46:49 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Chris-qj chen <chris-qj.chen@mediatek.com>
Subject: Re: [PATCH] dt-bindings: usb: mtu3: Add ports property
Message-ID: <20250221-reenter-sassy-5b27b03f8b06@spud>
References: <20250220142230.2530583-1-macpaul.lin@mediatek.com>
 <ae34efcd-4fe1-4e45-a1e1-0744138a84b9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="szY3iyQERCl/suc/"
Content-Disposition: inline
In-Reply-To: <ae34efcd-4fe1-4e45-a1e1-0744138a84b9@collabora.com>


--szY3iyQERCl/suc/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 04:56:00PM +0100, AngeloGioacchino Del Regno wrote:
> Il 20/02/25 15:22, Macpaul Lin ha scritto:
> > Define the ports property in the mediatek,mtu3 device tree binding sche=
ma.
> > Include definitions for port@0 and port@1, specifying their roles as
> > High Speed (HS) and Super Speed (SS) data buses, respectively.
> >=20
> > Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@col=
labora.com>
> > Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>=20
> Some SoCs do have SuperSpeed peripheral mode, so for this commit
>=20
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--szY3iyQERCl/suc/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7i8CQAKCRB4tDGHoIJi
0nPqAP0fP5poDJRA3Z3q8SHg6Q/EHMEj/DnqgJGRMdIOzsP9RAD7Bc10OD+TWsBu
8fXcBQQfSDrvW31wIXdCY/T7A+BXmwE=
=4Nd+
-----END PGP SIGNATURE-----

--szY3iyQERCl/suc/--

