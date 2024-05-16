Return-Path: <linux-kernel+bounces-181323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9D8C7A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9825E2823C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE754C63;
	Thu, 16 May 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng78Igq2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE94696;
	Thu, 16 May 2024 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877326; cv=none; b=Vb8dVC/YezFxWqikT3e9i78vhdpfDEcKW3wzk1R8itiIQzcI5cwt/lT2Z72vSXcuPPi12gBaUY/4dImp6CW21BUgPab4kJnobHqzoq2ap0XeCPOtGQyfzSt0bcEJLVeKC986hjKxcKkRBQSDHpjRGnwGov3TQLChSpKYGHDRQRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877326; c=relaxed/simple;
	bh=MQuJMJ19F8eHIn+GsbLVcyefbZwnWSgXZdCJZ72orq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jx9NmyJKfIn4FbBo4/+bqoPzq4crTnJgby/T0gvEHB4vhoQiFwkVJNRbV5d+eOwSO5iJofdscQ0ArEUFz72XHanDfVM/1CPMrWy4BMhPDCjWScH3c67HeotyVIj+I1eLKaHgOw4F70mgvXeMjXglXiriNcFvO9++OQAYU6QKHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng78Igq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21EEC113CC;
	Thu, 16 May 2024 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715877325;
	bh=MQuJMJ19F8eHIn+GsbLVcyefbZwnWSgXZdCJZ72orq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ng78Igq2kaNxHwfII2XZ1UfhQoW47CkhvS8E0IV3/5keWD1RyAIJlE727ckUTBbt6
	 Is0EmQ580ZVnM/hRHbeRtKr6xd4YFutx+hg8gvy2Ni8R2Nm8yjfXnbslru+VJj2dMJ
	 fzRQ5go3iujG3t7AVUQrD+EzJubQOqtjEFxLbySYzp3UCFv4h9wOxtMSjVwEVMPjK9
	 yJQDQJUyWFMnfUDL+swpG+1g8bTEtpdnXJ5109RDZ+FCL85z6Qpv4MafYqXZ5n1oLv
	 VoKRWgUNSysXqDknSgwWcmYPrCCVz8rOgHW7NdcWkebTg4l5eG7n8tIzBApGX/5pfw
	 EDeDh3eWIZF4g==
Date: Thu, 16 May 2024 17:35:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: add MBa8MP-RAS314 SBC
Message-ID: <20240516-elevation-unpainted-55b5d1fe8615@spud>
References: <20240516112355.200265-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h3kQ6mdWwbFv6y1q"
Content-Disposition: inline
In-Reply-To: <20240516112355.200265-1-alexander.stein@ew.tq-group.com>


--h3kQ6mdWwbFv6y1q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 01:23:54PM +0200, Alexander Stein wrote:
> MBa8MP-RAS314 is an SBC based on the embedded module TQMa8MPxL.
> All relevant interfaces integrated in the CPU have been implemented on
> the MBa8MP-RAS314 for (an) industrial usage. Due to the numerous interfac=
es
> and the small size of this SBC the use in different applications
> is possible without the need of a [special,custom] design.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--h3kQ6mdWwbFv6y1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkY1yQAKCRB4tDGHoIJi
0rTKAQDzqyZQBrZjHiNAaJ6y2j9S7YibT8WO/zEHkAZIfuq+7wD+IjSO86bwF8Iw
YBI365HnkfKPoOPOkUJ6YV5E8HXKoA0=
=Tqup
-----END PGP SIGNATURE-----

--h3kQ6mdWwbFv6y1q--

