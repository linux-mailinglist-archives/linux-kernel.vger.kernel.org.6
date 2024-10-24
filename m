Return-Path: <linux-kernel+bounces-380273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108419AEB60
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3871F244C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E581F76CF;
	Thu, 24 Oct 2024 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Amgj9rjT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A291F76A9;
	Thu, 24 Oct 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785850; cv=none; b=nv1q3P7ZwsbVVmC9rzEa+xwsWKJgBoY4aMwIVu8rv8Q4pMNDKmH3y5PvvkxlQGK9IyhEECrpHU89GtYIuOarB4EnzIdW1QsgflNSKVObtUGWoDfOObNN0mmMeFZTJVR5JxcAbcgpAeF+fTi5fTfY+qX5faan22n0XB7EBf131/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785850; c=relaxed/simple;
	bh=qIkOxIq97P2O6Gu+DLiuvn/RMN7SEd2Sbsm8fcvwju0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8/3Mlhd8KcTEGM0r1R0Rrp+hZDurrNtN4BCqpPaLsyTcmakUe/07/WnTH0v48oYb7lLgzZtoKjMcn8CL3u2RA/H6YFde20Ozd/zq8lIrxfpTUKTzKrdfPPfFEYS4WakPko75/vfXJWhtAnGYnk+FWRbYKyILLJ4KjmHi+ZFoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Amgj9rjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D56C4CEE3;
	Thu, 24 Oct 2024 16:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729785849;
	bh=qIkOxIq97P2O6Gu+DLiuvn/RMN7SEd2Sbsm8fcvwju0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Amgj9rjT6okGjpJlT7kg3kLcymJBnG/LvyVfgweNxht8CbrutPzsktUTb6r+GHkJE
	 L0B3TAzPVlqmky7r5QkrpAwti2aDr5VP39PCmq44U0TPXRMts5RgnNM7CXrx8t5oaf
	 VZr21or9sH9PvAfcwDaK9vVm0fkmbg/l7fu8C8vdulLWXCJFl3A6LyB7OMKi4Je+cP
	 ZobumImXUysN73+kbSS6pj74vpYtcaXiDBwoO9sB4r+M9TiH27dVEzWlEb/xt4uA6A
	 VS00Cv35qqMWpMyv4UA25wZBKMYmKeV1h8FiDUAVev+GYziRAL1NdydFFTMWpB/B5N
	 pLsrnfryPtXsQ==
Date: Thu, 24 Oct 2024 17:04:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 2/3] ARM: dts: imx: Add devicetree for Kobo Clara 2E
Message-ID: <20241024-afterglow-elk-e7c3a2b40fee@spud>
References: <20241024142206.411336-1-andreas@kemnade.info>
 <20241024142206.411336-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T3UjkdWASUbyf0tP"
Content-Disposition: inline
In-Reply-To: <20241024142206.411336-3-andreas@kemnade.info>


--T3UjkdWASUbyf0tP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 04:22:05PM +0200, Andreas Kemnade wrote:
> Adds a devicetree for the Kobo Clara 2E Ebook reader. It is based
> on boards marked with "37NB-E60K2M+4A2" or "37NB-E60K2M+4B0". It is
> equipped with an i.MX6SLL SoC.
>=20
> Expected to work:
>   - Buttons
>   - Wifi
>   - Bluetooth
>     (if Wifi is initialized first, driver does not handle regulators
>      yet)
>   - LED
>   - uSD
>   - USB
>   - RTC
>   - Touchscreen

>=20
> Add human-readable comments for devices without mainlined driver and
> binding. Such comments can e.g. be help to find testers if someone
> starts to work on the missing drivers.

In case me not responding would case this to get delayed or w/e, thanks
for adding that.

--T3UjkdWASUbyf0tP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxpv9AAKCRB4tDGHoIJi
0uAYAQCqYOgTn9AGX8//+f/z/8np6mw4cZpj4O0o2rhhFIEZYAEAmZt0drEaPIEn
SjW+fgPKfA06B7JMovRg/rmq0gvLvwE=
=Vkas
-----END PGP SIGNATURE-----

--T3UjkdWASUbyf0tP--

