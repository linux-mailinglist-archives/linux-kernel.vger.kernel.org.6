Return-Path: <linux-kernel+bounces-404702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A99C46FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6169C1F2188E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52431B1D61;
	Mon, 11 Nov 2024 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWXc5pWh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E32713A250;
	Mon, 11 Nov 2024 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357508; cv=none; b=BGJqntR8cLvmAY/iPrANZdTJtgth1nRL8v96HCNKNuPvaJV/RzJbvLUGG0yUy7xSOFAP93lmSjAdLjDm0jsBJ9GruWHtzo4VUQJPKoTCAoV+I50xQyk2dAkPzp1XbqW9SyfKZ1/nFLlzmctXobz8I37XN1cgZuGKhl7uL8Pj7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357508; c=relaxed/simple;
	bh=TNNplGwAI8gh0I5Pqtu6RqhbXECKQS6cRoMzXUn4TS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hibvHPgCJiXKlav6vcysfn5HCC5im6Vw3qs91EM5/DNBpo0nV5K3DXuLcD5Eq5u69/Pi4QS0h6XbCZwed3JQp8TQ0AZt+ZF8bL2zCgNbnbfkjb7TmgjaoCJyAFr2L4jVvbNOe8Wh+6NRDReJTz7M2V2yNCb+bNIxB1mDfwgx34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWXc5pWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D9AC4CECF;
	Mon, 11 Nov 2024 20:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357506;
	bh=TNNplGwAI8gh0I5Pqtu6RqhbXECKQS6cRoMzXUn4TS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWXc5pWhqQbWp8jIQB7Mdj+ZcVrD+jybfBmPAu+aj1vN288Hz7eG220SzV3k4AM0d
	 USqPCLYyuEIHKJEqd9PVuvfKLkCFYfj91Js+jqOVLf/6WUXyJNY0Cd1PIS8JTUD9tQ
	 l40zZ/FQPi1/TVlvx9x1T2+vCh109aJI6ZJF74mpIyraO+vuJkCtRkvVEoVF09/IZP
	 NYRipAmSUc+URcHSkJC3zcSrzNAyaZ7L/xQi8HxMmeYbdfY3PPi8XICP1yhpD5vBwm
	 V+R7qcuJg0eJ3Cg3/ZR53uA4yO/YJFEci6s3xUM/wIrsClEXkwLB9fWl2SmWSKv893
	 lkoxVkkrTcAJw==
Date: Mon, 11 Nov 2024 20:38:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 07/14] dt-bindings: phy: document Allwinner A523 USB-2.0
 PHY
Message-ID: <20241111-try-wise-ab60e1e488c9@spud>
References: <20241111013033.22793-1-andre.przywara@arm.com>
 <20241111013033.22793-8-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dPZZt7w9L6VIEeoP"
Content-Disposition: inline
In-Reply-To: <20241111013033.22793-8-andre.przywara@arm.com>


--dPZZt7w9L6VIEeoP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 01:30:26AM +0000, Andre Przywara wrote:
> The Allwinner A523 SoC contains a USB-2.0 PHY fully compatible to the
> one used in the D1/T113s SoCs. This PHY controls the two USB-2.0 ports,
> there is a separate and quite different PHY for the USB-3.0 port.
>=20
> Add the new compatible string, with a fallback to the D1 version.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--dPZZt7w9L6VIEeoP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJrPgAKCRB4tDGHoIJi
0tMhAQDL5lYdoIVI+tyQ5e2LO0x+cNYTehVUHu2f/hlo/r/sBAEA9EHYEDD2CXif
jOL2MOGtJY1t3gHVTDKPuJvnSVgriwo=
=da5U
-----END PGP SIGNATURE-----

--dPZZt7w9L6VIEeoP--

