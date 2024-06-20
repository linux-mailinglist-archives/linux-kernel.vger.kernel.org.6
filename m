Return-Path: <linux-kernel+bounces-222986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C15B910B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107B91F2339F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D21AF697;
	Thu, 20 Jun 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOM6BGt2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9921B1B151A;
	Thu, 20 Jun 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899677; cv=none; b=i4S/2/+rIP1SLb78DuSw/nS/uofIKKOJVn4hCAGQB+06xS4ZG+VW/SrNjwN7/s7uZnmrxYZ4Vv/mW3E5EVrnWKwDHNCDnNRazs1ZA/3o3JrKDOXXyuhFlxEMm/GxW/I7spgbJnOgxMMbPwUc1fx8JZh2PSh0gdgsL1+pP48LNqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899677; c=relaxed/simple;
	bh=ENq0t7yuq+8PH8wBYrueBrGUXOhLYaXTE7V+KPZiQ24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jovPrV87BNbclnLFTR8YXKCUe2i3L++SARRl7z2rtsBfeAlGVeqKEbIF9v6mkAZi5E8D/0UqlzKhgXBLh3mpePQLARNh3rNiGConBFIuLUGvL4vbabm+GGgH4UvF35PkSbgZtn5oVCq3B3z9mILdjec7vyATXFfoS7YSgC4MGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOM6BGt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C28C32786;
	Thu, 20 Jun 2024 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899677;
	bh=ENq0t7yuq+8PH8wBYrueBrGUXOhLYaXTE7V+KPZiQ24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOM6BGt2OOXCTOqxJ7ShuoaMFdMiVWHmjpUpg1mXdxvlFUOtYed5cN6M3EjLPURge
	 vQSW78nBzJaTu135tqXoLoTQHOxBhyFEp7F4RNx0FIWroniF7oIS60DPtXKubR51hU
	 ijLNnFIjLJlpIapK49s4gMGN7+KaQxW/dabYuVeT+czmM8cOdq5myHvWfy8B/PiRIf
	 4GdTOpc1A1QOnNwR1VLBCAZMFTpPsbU4ar044GAxaKWOzmW3UzcXi56d12g84+F20/
	 OtA0/vn+ihqVQ43J0mogXSsGnJj6ZT5tguC6rNDGcjwel1TXg3RuNHIo3aM7vyVkUp
	 KjEM4xtBhznJg==
Date: Thu, 20 Jun 2024 17:07:52 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: mediatek: Makefile: Generate symbols for
 DTBO support
Message-ID: <20240620-luckiness-creature-612b1720f8f3@spud>
References: <20240620101830.1097548-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZcV0FUu31o22hhk2"
Content-Disposition: inline
In-Reply-To: <20240620101830.1097548-1-angelogioacchino.delregno@collabora.com>


--ZcV0FUu31o22hhk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:18:30PM +0200, AngeloGioacchino Del Regno wrote:
> Add DTC_FLAGS '-@' for mt7986a-bananapi-bpi-r3 and -mini to
> instruct the devicetree compiler to enable generation of symbols.
>=20
> This allows proper support for Device Tree Overlay(s) for those
> boards; future boards that need DTBO support are expected to add
> their own DTC_FLAGS_{dtb-name}.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Adding these symbols has on a few occasions lead to people asking if the
dt maintainers were okay with it, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--ZcV0FUu31o22hhk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnRT2AAKCRB4tDGHoIJi
0hUvAP9lshp0KANjh89e216Ok9kbY6stskVHqQWSUOM7b67zcgD9ErHLBYOeldcf
llLJ64iVEOOmmfgVgnzRP7FjP+N0+wk=
=Y/hg
-----END PGP SIGNATURE-----

--ZcV0FUu31o22hhk2--

