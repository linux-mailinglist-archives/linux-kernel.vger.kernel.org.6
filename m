Return-Path: <linux-kernel+bounces-374202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13E9A66B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B60282165
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E81EB9F9;
	Mon, 21 Oct 2024 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mla1iWyj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FCE1E7C3A;
	Mon, 21 Oct 2024 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510522; cv=none; b=r6GAr8P3+QEIBZXeUPBEIRPIBv+CuBRCMVDCyP9QwePXwg66rLae8ym8eMZ1wayMqiI1l3mxdq0d+FSdFv7RpKESpUiijadou7KGexTY1lDNyL9hSF2aPu8CWgUvrtGkaf0A03zOO1YmsU5em9JKDS6pH1gIpF9MmfFG8dCfB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510522; c=relaxed/simple;
	bh=NnP5FFpDfPfkxNfCzIGryQtgDRYsg/mYEfAboo/domI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVnpJDNIZrMfFSX6clMk2BWlL7K7C0Jc4ay7J+E7Ydr0D5x9r6E+zRDRlT6sLk1DoLTnKh2ElYrvUJDmXgR2vifiw/Psod8btpYLuGpc42A+SN3DILfg7CHY3XxP575fG77Pb2bPsBLOnsjR0OMSAsYIzkst2XxoIL86sn5AhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mla1iWyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92C5C4CEC7;
	Mon, 21 Oct 2024 11:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729510521;
	bh=NnP5FFpDfPfkxNfCzIGryQtgDRYsg/mYEfAboo/domI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mla1iWyj+nVKFELG9OM0sl2Ck1pK3QghS6o/oTV8/yZO3sp8Lrhej6jSyClxHf+SQ
	 thPx5XAP1aAUIJ1n8IT0COeQ4y0ZeVIqMSpf0KwzwyvEUW9s7CpWQwsoC15nBySc43
	 1cy71HCUjzwiKPiqnJy1LGnFMjS+WcWEl/d6TXrgcRP3gxmWkzvOsGdhscwZhcZYrz
	 xhHGMzlQnf9vWaZ5V5glMtdfRFtUVNGW7ulbJj5vilV63osFGEpT2UZxNnnfvBzD/p
	 Yfm4VG1cmtIGDWWByk79cW/pP9OY7bGx9FXTAiU4LoOm6WYZbCJdJpch2JniAKpXnK
	 toLAL2wB0CzAw==
Date: Mon, 21 Oct 2024 12:35:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, CK Hu <ck.hu@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: display: mediatek: dpi: Update device list
 with power-domains
Message-ID: <20241021-january-dissuade-d391a189007b@spud>
References: <20241019052935.553886-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y8NnBLaHu/CIQkrF"
Content-Disposition: inline
In-Reply-To: <20241019052935.553886-1-fshao@chromium.org>


--y8NnBLaHu/CIQkrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 01:26:56PM +0800, Fei Shao wrote:
> There are two kinds of MediaTek DPI devices in the tree: the ones with a
> power domain and those without (or missing). The former are the majority
> and are more common in newer DTs. Only three older DTs fall into the
> latter category: MT2701, MT7623 and MT8192.
>=20
> However, the current binding only allows particular DPI devices to have
> power domains, which results in spurious binding check errors against
> existing and new DTs.
>=20
> Instead of diligently maintaining the allowed list, let's do it the
> other way around - create an exception list for devices that are fine
> not specifying a power domain. This list is expected to be fixed, and it
> encourages new MTK DPI devices to describe their power domain whenever
> possible; if not, those should be listed with proper rationale.
>=20
> Signed-off-by: Fei Shao <fshao@chromium.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--y8NnBLaHu/CIQkrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxY8dAAKCRB4tDGHoIJi
0syAAP0c5qRTn8GS7F+N997ftgRYudfJIwY28xnK83tSh6fSbwEAnGMsiLIl6DTW
PLKeegSHvQKodm39IEv39tGUs88enQE=
=R8QS
-----END PGP SIGNATURE-----

--y8NnBLaHu/CIQkrF--

