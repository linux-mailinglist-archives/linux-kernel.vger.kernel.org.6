Return-Path: <linux-kernel+bounces-400429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9419C0D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934AA2830B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCC216DE8;
	Thu,  7 Nov 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxzJ7e9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69018C33B;
	Thu,  7 Nov 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002463; cv=none; b=IrYsjUdpDt5lHV/BT3xtmR97n3q08TEpdXq4KJ4YlcVrVuTemBk7AKmmGT4PbpU1bSNGd4e0j50/JY0ujVjeNApP/Rzg8er0rN47Lm2/dK7UqCEpquonPAla1PLgo+P9qAx6HggEjzEVmEMg2TagahiAaLRU1niY3YtpDYcmPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002463; c=relaxed/simple;
	bh=OJ28I0PlrfDGsM6GmEbYmkXlZzDvc4e7sr48tLGE4N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klcCgefCBOofS6FC+6/Roa8UmJwybrJ0eCP9M00TaCNcfyZytMjQ3++Aa3jxqS1HVN7CUdxifGPtLG7wdn/t3RwdHyBc5UaJOz8lax8gkE6PTZEP8D89vWgScW6QPA5ckPrMwppE6V5A1lSWMiY3K1+T+JWnisXHJVWU24cfhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxzJ7e9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E14C4CECC;
	Thu,  7 Nov 2024 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731002463;
	bh=OJ28I0PlrfDGsM6GmEbYmkXlZzDvc4e7sr48tLGE4N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxzJ7e9QjvO/I1j2hWY+0GGF7em0kT08NpIA6x7rsC6EvHWCgkINyq3DVqJX15Tup
	 xFpnF8Fzc2lnHPmsubtYMm2D7Rkv3FjBJxEGqKyoQp0WjBHXCEJdG0IjGuLrD5naF5
	 Py3FVpgewow9h/nphteyLpyQ2VosR14VO15XBbst0yiR/B/w2UT+RxfNUXuoLGP10j
	 juiyrYQFhGqRc4TzIvwst2QxlwDSLddqkTsD+vjMpWNJfTacVoGql1YLgXonE4d4On
	 s3hX+XIpH24JpzpsMYrWoE/4aZ3TV/Uk6gmr/hK03z3ogzjE1yLGou4wtr//hIMw78
	 WgtJHPzWo5JbQ==
Date: Thu, 7 Nov 2024 18:00:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <20241107-hankie-stadium-a664fc460776@spud>
References: <20241107-ondie-v7-0-98829fc8a958@gmail.com>
 <20241107-ondie-v7-2-98829fc8a958@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kOaLo4DZsENTEN9l"
Content-Disposition: inline
In-Reply-To: <20241107-ondie-v7-2-98829fc8a958@gmail.com>


--kOaLo4DZsENTEN9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 02:47:08PM +0100, Marcus Folkesson wrote:
> Convert the bindings to yaml format.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--kOaLo4DZsENTEN9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZy0AWgAKCRB4tDGHoIJi
0oiPAQDSCtDLCED8EAoTptq5tkbjjT0G8TcgQnM388R0Vci7WgEA7mDZkTVF3Xay
eySyrZhk3/YsgTE3xjB4qFV1xvlZJQQ=
=LSHt
-----END PGP SIGNATURE-----

--kOaLo4DZsENTEN9l--

