Return-Path: <linux-kernel+bounces-435374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E09E76B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFB9166B81
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476081FD7AD;
	Fri,  6 Dec 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD20P7A8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355C1C5F01;
	Fri,  6 Dec 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504907; cv=none; b=dE18TEMngjxqecKIn0yGBWoDAhp2le5DIaQPdl5GxIMVOltvRphsIIu75Sl/KflgMSOSdFalmIV3oNfAct3ZMGx+XHpNqt8412nSTDkwNOgXOkwm/7JXzSbb1/LLw1wI7ESSYevH9+6Vkr+jlpdEbYDxPLjXgOvDgBL1s63L33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504907; c=relaxed/simple;
	bh=oYXk78DguqmWey11v7mAxjM3xS6Ls/etqK8HPTlNkGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3Jtm53yNcyctxaiyK5RA0SKwPPlAHcH97ANGl4FXeWlIQQqnFas75CNi0/FzRaHznRZxMlYE0GiCytE/BMHHs+r6KSjg6MDj2t83KmZEkdFx9Qxt8qzvhs+YhrPKS6/b7hiBlbFnxwcDhMT7kt6htb3AJ0HtG2uko8q9Fist74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD20P7A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDCAC4CED1;
	Fri,  6 Dec 2024 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733504906;
	bh=oYXk78DguqmWey11v7mAxjM3xS6Ls/etqK8HPTlNkGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JD20P7A8yotk3HVF+vGps4oaX4LMTplnWL83uQ0SKduxvxwnumqO79NxHgNtTCGTl
	 29nW4iip3nvYrCU3faOcHR4ZBDaESDr7XPH6W2BU5Tcpx7ez6ZiZquIsPDhvJpNH1l
	 YoYm9Ss1l/N6VnC+3Jwje5iteSQDSWDDdjZ5sAQjtkpvk57WdU4nt8ZrMjlV0K/Xiv
	 2NSegsbNQIdayAJDScIlHFIu96GJsfH/hjrZLCQhHYFjkgl9odnAHw41FJD9JQ4S2M
	 g4kPV8Y/drHLI8V1WZsH0JZb3LSbryzYh/ZvDSTy/LwvvcF540aB2Be+5fxVw7Ec/U
	 +LUwbtnbIcaDg==
Date: Fri, 6 Dec 2024 17:08:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: rk3188-common: add
 PCLK_CIF0/PCLK_CIF1
Message-ID: <20241206-quadrant-gliding-e28b79c09c2e@spud>
References: <20241205182954.5346-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+WMJfWqySBiE5lAc"
Content-Disposition: inline
In-Reply-To: <20241205182954.5346-1-val@packett.cool>


--+WMJfWqySBiE5lAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 03:29:35PM -0300, Val Packett wrote:
> Add missing clock IDs for the CIF (Camera InterFace) blocks
> on the RK3188/RK3066.
>=20
> Signed-off-by: Val Packett <val@packett.cool>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--+WMJfWqySBiE5lAc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1MvhQAKCRB4tDGHoIJi
0gXmAQDcyyvFy3KyiLq5R+rlrAMICJX7YrKsc+OvE2KCmEcTNAD/fhjjqAfa//QL
2SeKT/q6t6QTbe+vLT7yJIe7e8Mkvg8=
=L2tt
-----END PGP SIGNATURE-----

--+WMJfWqySBiE5lAc--

