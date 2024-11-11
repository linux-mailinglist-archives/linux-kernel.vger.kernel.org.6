Return-Path: <linux-kernel+bounces-404704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659FB9C47BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCA89B2E724
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B71B5ED4;
	Mon, 11 Nov 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMxx9aED"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DE1B140D;
	Mon, 11 Nov 2024 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357539; cv=none; b=Cpnm5xXMKPHeqr+wkKaeZgrdygu4olAFXvDgW6H/lK4f7//sE1u+ij8r6Dxh6DFz15XiUYxbI/7WPbBaajZP7XnSqqEAe9I1UDCMuUnvoX35OH7fm7Cvx3883SfDTdkq8+V16pdiJfF/8HZ4GuSgLndnQzfjQ29/93WGZjiY2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357539; c=relaxed/simple;
	bh=djMNGaQ/Qm8y7P2WAqMoUhR3bHcJfux22jLxPWnwt7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSGmlP1QUt2/xEcrdTbjEMuDYShCyXvF0gEkCo3Y3Up5reZfM5Brpv1CnklZjnLTfi+BHrXp5Ut6zcJ+fF6gSEEAJKFANFINeWZgj/GkOiAGBn76MFe0o8k44vNipujBT4UDTGf+hBSL2F2G6MuyGnEAsI+Jh1CKiRQ4+VIKzeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMxx9aED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081E6C4CECF;
	Mon, 11 Nov 2024 20:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357538;
	bh=djMNGaQ/Qm8y7P2WAqMoUhR3bHcJfux22jLxPWnwt7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lMxx9aEDFsRHFU9J59SLZyiNT8kbHFDn7fUkPmcv9AhkrCy21K6Ioghb7rA7+FRJG
	 3npZalpf22upqrfkQAuAE/+a4jxllgKt0T4GgpqK6p2bpiwQk5cPtLukHIe6Tu9wTk
	 3CdG267m+CXrO5bMZMupxW8ZPo2YgVAy1QFxGbe79i3q+8tGIorvAJ93QrllqlBGUR
	 ioiMEmdRV4EBoPWPh4KmGdudLeB2dj9qpQDP16Oy1mQr/dqNNtiF9bVSx+91lybjzc
	 I5MZzZdkm10U7mdx6ncjxuVRsatijrnYFZoK2OWSwBK8rwv1m3tGgToF5bwIagQ5x5
	 x3IpULG3Or5hA==
Date: Mon, 11 Nov 2024 20:38:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 09/14] dt-bindings: usb: add A523 compatible string for
 EHCI and OCHI
Message-ID: <20241111-trace-pesticide-c305256d66c8@spud>
References: <20241111013033.22793-1-andre.przywara@arm.com>
 <20241111013033.22793-10-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aWiLqKPu1sC87/i7"
Content-Disposition: inline
In-Reply-To: <20241111013033.22793-10-andre.przywara@arm.com>


--aWiLqKPu1sC87/i7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 01:30:28AM +0000, Andre Przywara wrote:
> The Allwinner A523/T527 feature generic EHCI and OHCI compatible USB-2.0
> host controllers (in addition to an MUSB and an XHCI controller).
>=20
> Add the new name to the list of supported compatible strings.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--aWiLqKPu1sC87/i7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJrXQAKCRB4tDGHoIJi
0r1+AP9zPitmmB2ZMtnAQQceNFS4HjeZEEtBJfv++JTB1miWJAEAzRrSYoJ5fJw/
zDTa16sR58pG7oExAo6Z0iylP9g0MwE=
=FdHP
-----END PGP SIGNATURE-----

--aWiLqKPu1sC87/i7--

