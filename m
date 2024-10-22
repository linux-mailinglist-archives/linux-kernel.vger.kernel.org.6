Return-Path: <linux-kernel+bounces-376648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CAB9AB46B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2231F243A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A5F1BC099;
	Tue, 22 Oct 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWiS06E8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A81A3AB8;
	Tue, 22 Oct 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615971; cv=none; b=JpZrVw7TT7aFAHe7YSWbQdjyDNPIwbgJ28y7Depfd4JG2Z8Ixk4/4saGq22qumYo3m/KEweTdQrFNLGvvFufbvbRtCrd8XnNWQL01IxRQMpWypvyfYQnQmS8E1vv0dQ5XZBHB8uHMV/CvoBl7ONldOD2swBfBJ8jRhL7O0DmI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615971; c=relaxed/simple;
	bh=ln4RaaN3hlStJiTXS0w9jYwOdR139lH8BqX/igzVO24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8Y/btDRDbZhJuDauHRukk0EP9KpD9UIf7IQBz9Mah8wqyy4h0NTUCMOTnfPGE/J2F5ujSybtu1pEXjcCXCN4662gGCcMXfF1+cTgGlqPEU7tdi+hMzolQ4Tcnoyyv5x4qklOhQOtl/ndrd05jGO0Pk6l3CSp6hhhNBGznrp3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWiS06E8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7616CC4CEC3;
	Tue, 22 Oct 2024 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729615971;
	bh=ln4RaaN3hlStJiTXS0w9jYwOdR139lH8BqX/igzVO24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWiS06E8fIgaC4r7wPMNYXeRYiTBAmYLGVQUKjMNITcw08Fw6uwutF5fWI550+rth
	 T/p5M4HbpBxbsnfyqFmGNulDYnq34JR7ZsOeVwLKO8KnEsmLU0CQORaqKD14/ghtaT
	 FThIm0Wh8W13pUVQnfeKMEthtbk/cNfcsJHSIFppbr3GFOePWwciY4+UdxHHI4z75n
	 sCL8CpvOxdQsOVQf3TW59ZhS6DszXZnH3BWFpfszSa0fZ1qXaQ5xqmyEVs3Y25lE/t
	 4nPXgpbIp9gA/fopANf3AUs20HcnXBiLtuFIRbco1U6CbJKvAAgSLDtJDe704kEP2K
	 mUZJMkYGswZFg==
Date: Tue, 22 Oct 2024 17:52:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Jason-Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Message-ID: <20241022-purgatory-modify-fdcc5f1cff23@spud>
References: <20241022021511.2322303-1-jasonhell19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLTSOIWSP2DWBufY"
Content-Disposition: inline
In-Reply-To: <20241022021511.2322303-1-jasonhell19@gmail.com>


--yLTSOIWSP2DWBufY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:15:11AM +0800, Jason-Hsu wrote:
> Document the new compatibles used on Meta Ventura.
> Add subject prefix for the patch.
>=20
> Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

This patchset should be threaded. With taht,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--yLTSOIWSP2DWBufY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfYXgAKCRB4tDGHoIJi
0jmrAP0atEdkBB4ulX4MyZxjcMS8Bvmm6/bB2RqP6JF7ZeGqxQD/fD2F3B7QKFDh
ACUq1/f1Z9ZRHQIm/8YMh9sujE+HnQo=
=Wg7A
-----END PGP SIGNATURE-----

--yLTSOIWSP2DWBufY--

