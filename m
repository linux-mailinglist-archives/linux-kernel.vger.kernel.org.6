Return-Path: <linux-kernel+bounces-376660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3D19AB48D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1631C22F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F01B654C;
	Tue, 22 Oct 2024 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTgj2jKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFE256D;
	Tue, 22 Oct 2024 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616378; cv=none; b=qyTloraSGwOSKhYyghft6qRotEW40uLoF3jl7hojWQjGFHSj2qCcs4EW5KjlxLfW10zbZPtPIFle5KtAcejs6P4BslzS0cQ+RcQV8WljLoGO5KbYd9CPgNRGDzWwYUt6lQ9oag1yBEPakbey1byIsbMsiJVXecxChcBV4qsNpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616378; c=relaxed/simple;
	bh=mA5JfNNOYj/yFZVtsZkUwXCpe/lM2gtIB21VQf58k+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBGfAMrEYe/Ub85upRAOlbkZ1DHOprUiM80oPT4mosKJ6OflsEChEMFwYFSfy2c/1YW99i+d3X9Oe7cyb10ElVAHNDRGW/EXkL6fQ8mS8ZzhD8EnXuiI/wDKJ7tgYRQxDwN5XUbwunk1MrDd4oqV92UUHDIIsBKsm4tIxrTQKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTgj2jKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE4BC4CEC3;
	Tue, 22 Oct 2024 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729616377;
	bh=mA5JfNNOYj/yFZVtsZkUwXCpe/lM2gtIB21VQf58k+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTgj2jKcPesaQK3VZpFE10HJRc1ynK40vkx11OXoKGZ85NbZEj9PG6Ryp6v9NH41O
	 vj0ghE296PUWSnNEHYq1BqV1osojy50uDT0nVeXgxzcykJg2wgcAJEPAGg8x2sFfZM
	 zwBUhLxJHn69TtM2lrWL6po2r4/HhN5ryJJM/dBUEqkQwiUQLYmOr/m871z73w6BC+
	 /mmSo8Zz1a0+no9GYExusSy7Ldb/8R0W10fYZGtNtISN50zcKHw4SwyXRsLNjlWeKb
	 rBf2m+lhao4c8plNPZtOIG3cwz/PyNG0mzdxEaFzeqlzOc7eyhKdjLmC9fyV/oLaEy
	 cqj9K0OkRgWzA==
Date: Tue, 22 Oct 2024 17:59:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: add compatible strings for
 Kobo Clara 2E
Message-ID: <20241022-uninjured-sepia-58fbcb283845@spud>
References: <20241021173631.299143-1-andreas@kemnade.info>
 <20241021173631.299143-2-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="whFWgqmw9ezpt/VJ"
Content-Disposition: inline
In-Reply-To: <20241021173631.299143-2-andreas@kemnade.info>


--whFWgqmw9ezpt/VJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 07:36:29PM +0200, Andreas Kemnade wrote:
> Adds compatible strings for the Kobo Clara 2E eBook reader.
> There are two variants differing in the EPD PMIC used.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--whFWgqmw9ezpt/VJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfZ9AAKCRB4tDGHoIJi
0hguAP4hBeIlzePBXA6EaNTr8IqT3/psBuyO6nOvuZ740uA4ZgEAiwYU/GX6CDxG
kya3rjDIV0h6wF/8ACagOKjVFFVaUAc=
=Fd7d
-----END PGP SIGNATURE-----

--whFWgqmw9ezpt/VJ--

