Return-Path: <linux-kernel+bounces-255284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D594933E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55B91F22290
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5F618130E;
	Wed, 17 Jul 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujq7Is0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728A1802DC;
	Wed, 17 Jul 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226300; cv=none; b=K4xUHzII9DBQU4IXXfKEE6oCAViyrZLliJ2GWUmKhbDDuIM2gKH7iMnrQUDaTg4NwpaaXzdiCBX7opXanwNXpEWPdJBMNk7FgBUu+a60ph4u8JW3Dv/9IXR10Uk+9SjYb9EcGVzG5pwvIyLD85H6ViHcYGDbZIIjXMo9o9vQDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226300; c=relaxed/simple;
	bh=F/95jOqqUWmHLY8Y3mhofPF2OMSPHcbueeuNkZhH9oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orcXkH2C7VCBkGBSIsDTNo7x2wdmQUwhm7lsOXHK9nwnKagJ1fQzd73B2EWQICpZdHF0E9l8lFxmVqs8+zYsvwZMwSwMZYhd2b/pkUpgEmIeeI8YIz0Mt24lQYdyZ6ldTunzcNV+rZ1mjUGsxqgmLxbLfBJ3w4swsWCbOB/ChHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujq7Is0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEB6C2BD10;
	Wed, 17 Jul 2024 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721226300;
	bh=F/95jOqqUWmHLY8Y3mhofPF2OMSPHcbueeuNkZhH9oU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ujq7Is0bDM4e+5rpC5i+fr9sNIUG4lqH6V3s5Z/kvVwZ29/fWtnKurLD2PsVmUlso
	 vQu2aJpR3lSL/R/uiAa5NKjfGhWvE2uvJ9noiRGJ2kvupaZ1xFTZOJ/FmBxVJQKjyT
	 zlzzLse1FVXl/W6PvHLWBRLdoJh/ndkbz94c+gr4OVWC/rKrzcK+LHbEG6zbHJrqWx
	 3XI9OXfqvBePfZYT5UWcM+ULXGFzlUF4cBDk9jjzwrPeCNyFGhojRIFe/6BRUS3KOC
	 mhW9PTfUAjvwTr9Z9zaxKAt9RMdeZYfBcFySEVDg9t6Ig1zCNwBXdmL3AhUcCX9c9W
	 R0Wo1X2sUUM3A==
Date: Wed, 17 Jul 2024 15:24:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Yanxin Huang <yanxin.huang@unisoc.com>,
	huang yanxin <yanxin.huang07@gmail.com>,
	Wenming Wu <wenming.wu@unisoc.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: sprd,sc2731-efuse: convert to
 YAML
Message-ID: <20240717-move-jogger-a01fd2015889@spud>
References: <9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4VW+Z+Fn9ly/ZGMN"
Content-Disposition: inline
In-Reply-To: <9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com>


--4VW+Z+Fn9ly/ZGMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 08:54:47AM +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC27XX eFuse bindings to DT schema.
> Rename the file after the only in-tree user, SC2731.
>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--4VW+Z+Fn9ly/ZGMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpfUNwAKCRB4tDGHoIJi
0h1nAP49WI7YC21XHbycMJVltiB7JgalCPZVttqh2gkUb13MxQD/UogHuV03RWt1
YtC//BamDPCMgkwL+U7YKLXmWbD5QAQ=
=JkxJ
-----END PGP SIGNATURE-----

--4VW+Z+Fn9ly/ZGMN--

