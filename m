Return-Path: <linux-kernel+bounces-524366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27912A3E23D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE81F1888835
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3EB21324C;
	Thu, 20 Feb 2025 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcmOzMvW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499C204875;
	Thu, 20 Feb 2025 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071888; cv=none; b=nhBPryCukQCE+Sxm6C5css82NM756AalXoF/93Cl+r+OXDsmyJhK6C7JlOjLzeQNVRQSOSbuiK1NbA/uA7/HYIpWKF3+cs+EBUR7py0Mf/q5LzeYwxZrjF1rKoH/Hf1bSWqG3FBt5IHLtT29MZq2tl3o/b/YXSsXLUlBAcVI/JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071888; c=relaxed/simple;
	bh=Z2dgO0/WumT0UHpa9g/06CqR8KBq3+iPEhbdAQlISMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaO042bwNv6BZTngBdLtDpc+cqsWHsfD8Vg4tTWl7jcrbg+PoXFPjn3lOQvooP3CZ/92qmA317v0rAH78gCGlQXTS8G6MgYAdQAyXlvwvsmjDBEW5CYLe52qnAXTMixD0k21yRk8TDN6qxa+82ii38Va/t33dWt1RGxmzMiNCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcmOzMvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B913DC4CEE2;
	Thu, 20 Feb 2025 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740071887;
	bh=Z2dgO0/WumT0UHpa9g/06CqR8KBq3+iPEhbdAQlISMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcmOzMvW4JIwJparBiYVKIryFuiTlW2Pqv3d/5vZ9aqOGbSzX2myip7poZdKwQxF/
	 kco7+x0wcGepCahG6fG0kJ+OX+2q6DDFFYRksccaPpTzcUSASKXlGr+6DGjPx3ti0L
	 47IhkEtO1nGrTNLup+6HGfXnihDHyi+0n72UbxHTcyrDs6sg1PTdp2IzIzDZkG3Dur
	 MUbJx9n0ZcRIGxSKiCheGaeoXS5Z+cSQhdrWXy2+XHij3t67Xc12I50Od96cKnkh1S
	 wbXDmzuOmXXcv0PQiFkWqau/auRrUmJClFqqUkE3ogOx6lKLKIx46SiljExgCDS1aa
	 NAZTXhuW/V3Vw==
Date: Thu, 20 Feb 2025 17:18:02 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: mediatek,mtk-xhci: Add port for
 SuperSpeed EP
Message-ID: <20250220-travel-undercoat-339822407907@spud>
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
 <20250220105514.43107-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZISaQ+/FlBvHadWX"
Content-Disposition: inline
In-Reply-To: <20250220105514.43107-2-angelogioacchino.delregno@collabora.com>


--ZISaQ+/FlBvHadWX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:55:12AM +0100, AngeloGioacchino Del Regno wrote:
> Add a port used to connect the SuperSpeed output endpoint to a
> Type-C connector.
>=20
> Note that the MediaTek XHCI controllers are always in front of a
> different controller handling the USB HS (usually, MTU3), so the
> only port that this controller provides is SuperSpeed, while the
> HighSpeed one comes from elsewhere.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ZISaQ+/FlBvHadWX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7djygAKCRB4tDGHoIJi
0pwNAP9LSza0fN2VrkokGvJROiNTsBtv8u28z6YZ0tVasE/wSQD9GZqsn3abIJ14
wNsSo8xwfhXVj8RsgcZpEbcLFtCN+Ag=
=OB/N
-----END PGP SIGNATURE-----

--ZISaQ+/FlBvHadWX--

