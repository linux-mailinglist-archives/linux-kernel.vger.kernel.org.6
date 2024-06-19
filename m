Return-Path: <linux-kernel+bounces-221561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE0490F57F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50C4B216E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C49156673;
	Wed, 19 Jun 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIxHs/pu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6020DCB;
	Wed, 19 Jun 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819482; cv=none; b=hFllq1p7H/dVo+F+JOtnfaHsVsA2WSzhC+LilHkGRyATjcp8ADgraN9x6jIkj0ow/jOzNI1u1CxfTv+SV9Y4WqZFO2nn1gnoxGVFLmR4jtFES2dFcsthNQsvCkYVmYAN3ArKtHMzTBd4ZLLAT26hJpSKXWENKfib2NeOUWOyWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819482; c=relaxed/simple;
	bh=lnBtZ7Sd6MAJnyQFfVV4G49sUMQYjiSa7hqrQHpozik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATv8VMuDaOp0H8EPBMfiF+liMKZARviG5luwzeh859Fl3L5dzv5Z3R5+HlKHpIrTuZX/q2i6OL2PyldX5lSOmCmqO7X3O31aS0kRBm7VYoxGWFmeFzUwZZdGGx4TCGT4mvjAk7xiPXCp5yxeQ3XM4J0WwiqWYMldWgXXY1QivJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIxHs/pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F058C2BBFC;
	Wed, 19 Jun 2024 17:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718819482;
	bh=lnBtZ7Sd6MAJnyQFfVV4G49sUMQYjiSa7hqrQHpozik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIxHs/puxWQlhx0vGCPX0jMsqNTna5ryyot4e/mMfGWARfRYK1u1/D5GfF/0hkYMa
	 g7b8Jv9JllTD/xOjeSlcRYgvFuGGXp2RHweFE7QsaJHB3NxCVjQqcaYsSlWMZmRpIW
	 i/+tEOIz1xrDxXFokhXu2sL9XI/PXMBSF1fGrxV5B7N4dFYx3oh1eW32faPNCHt0Hd
	 cTKE+iT26YQSAI9CC9R0moo1cppquWnjPIxL9qremBtctx4/bieF3Sr1VzOC5YNPhg
	 +d53uD+QV0CLRz4wKGpP99wp9SuiHEGCl1BYwvtxD1NKULErhVL0c9W+UkQp9rDdZl
	 5WO1jsP9RwfXw==
Date: Wed, 19 Jun 2024 18:51:16 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: krzk+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	jassisinghbrar@gmail.com, garmin.chang@mediatek.com,
	houlong.wei@mediatek.com, Jason-ch.Chen@mediatek.com,
	amergnat@baylibre.com, Elvis.Wang@mediatek.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/3] dt-bindings: clock: mediatek: Document reset cells
 for MT8188 sys
Message-ID: <20240619-retold-wolf-c9222edd647f@spud>
References: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
 <20240619085322.66716-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eh3REyk7zO/679gG"
Content-Disposition: inline
In-Reply-To: <20240619085322.66716-2-angelogioacchino.delregno@collabora.com>


--eh3REyk7zO/679gG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:53:21AM +0200, AngeloGioacchino Del Regno wrote:
> The MT8188 sys clocks embed a reset controller: add #reset-cells
> to the binding to allow using resets.
>=20
> Fixes: 1086a5310f9c ("dt-bindings: clock: mediatek: Add new MT8188 clock")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--eh3REyk7zO/679gG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnMalAAKCRB4tDGHoIJi
0gMaAP4gkosxEKLci6rWeKRSAJLtmgO4bDoFaFXCBri5e1osWAD/UmS3HtF1x/5F
UtPqDbZIQqUAV+7Oxtp+N/SWGIUWlwc=
=+3YS
-----END PGP SIGNATURE-----

--eh3REyk7zO/679gG--

