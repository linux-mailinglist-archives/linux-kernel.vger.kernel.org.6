Return-Path: <linux-kernel+bounces-256486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CDA934F38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48F91C21268
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BA61422DF;
	Thu, 18 Jul 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdgKwijx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E512F5A1;
	Thu, 18 Jul 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313646; cv=none; b=kdcCLL2NeisLhWWXYioKmim7YWf2B+2v/xfut3mHoSechHkwuyPZqsp9VFCMtbTC93F00jjr7i1N+9IpN7Kq61tOgzs1xIWO6GEJdxwON2FLjHhQIJTh2/0KlcDn4z3S8osWGXkrEznek0cwk2XMBh1jOkVhke/H6DJotgHjnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313646; c=relaxed/simple;
	bh=ZJA6wCOIVK2oYGcTiSoQeiIL2wzQYTjcFaiDvZNNNVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipsrm7GRRAj2pCjTGQ5AX+qRsTwMrqHNMfyBzWPyMPD/BnBRNcSlvM8/8DXb7MHFoZmlW5AFF2TekCw94UYWJuUh8dyGZZTt5HOTRdrm0AmPnhCn3ryU6er4SnyiXCkOmpVo6x16j83BpT+OBiYzwIjLSw4TC5xAKxRoEDNfZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdgKwijx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE89C116B1;
	Thu, 18 Jul 2024 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721313646;
	bh=ZJA6wCOIVK2oYGcTiSoQeiIL2wzQYTjcFaiDvZNNNVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdgKwijxt5c+WNciEbwDX2fpIkyOLLptPagkP1LIRQoAzwBfO8RAkQxj7H2yXFA+E
	 VRs6b42QyiUCbfKY1AFTdTM6KdTNGhbzEFc0UOaOOF9O1LDFdqs0TjWWIKXIOE4QGR
	 j2ku3xHr0emwy+FmD4qXnNniUy7q1Tsg7Z/rpujDfj53JiXS1cTF1yx905mTj4W3sg
	 9hRNFYM52DPeSxLEwC7gH5bjb2uXrGm6tQhqochPhA2ZcFin5lCvlMeLN7xBMldTD5
	 ei/Z54j6KpbHupYb/0oJb6/35YduzeY1IJRoLop/Qwo8w5S2A+0eLcUQfhjc3xHKZt
	 I80NTYgMLCSXQ==
Date: Thu, 18 Jul 2024 15:40:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Collabora Kernel Mailing List <kernel@collabora.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: rockchip: Add Firefly
 Core-PX30-JD4 on baseboard
Message-ID: <20240718-hatchling-exalted-476331573f88@spud>
References: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
 <20240718-rockchip-px30-firefly-v3-1-3835cdd22eae@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8AqXso0jA0hE5+Q6"
Content-Disposition: inline
In-Reply-To: <20240718-rockchip-px30-firefly-v3-1-3835cdd22eae@collabora.com>


--8AqXso0jA0hE5+Q6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 09:40:24AM +0100, Christopher Obbard wrote:
> Add binding for the Firefly Core-PX30-JD4 SoM when used in conjunction
> with the MB-JD4-PX30 baseboard.
>=20
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--8AqXso0jA0hE5+Q6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpkpaQAKCRB4tDGHoIJi
0vrbAP9dgm0O1UO4FcnZshjAL3kbxGVkVSse63OyvplnrHApMQEAzBheFeanM/+X
EZDWnhCo/wVfyt/hqPe9lII8ypyRywE=
=PFWj
-----END PGP SIGNATURE-----

--8AqXso0jA0hE5+Q6--

