Return-Path: <linux-kernel+bounces-376619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585639AB403
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19455281F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B0B1BC07E;
	Tue, 22 Oct 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKAWY84C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211421BB6BE;
	Tue, 22 Oct 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614579; cv=none; b=ldEFxP7kzgWb/fZISHmzqJlIUyQfmb9ZplaSMrlutez2eGFq+sz7TCYgp+ygXOpaP/mZCn3o1xi0YhC9Y3rVUWW5/f4GUgegAzdCPRGBsZeHkd3BQV58jcdEsMHCXhnec0eVIJlQCs8op2T4pRpMxX4V37cZcV+H659cnjfoK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614579; c=relaxed/simple;
	bh=5wV9lnVFNK+HdNXRALcplaf89RqIx+4YA6FgHy39/RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4IZxM1Ja9LenKkO1y0hk+0K/ZE/B0lHJX4bTPKH047QU+uYVe12LFchj+MO6ELuE9Yqz2UsJf0NxCdGgSZ+PNqgwOqAs7tQWvd/I3G0dPl576jbAhEioha+pzu+v99ncncH1cwL+qXDenlqc4/2cRGyzrMPfOHcvMVgYyRiM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKAWY84C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08D1C4CEE3;
	Tue, 22 Oct 2024 16:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729614579;
	bh=5wV9lnVFNK+HdNXRALcplaf89RqIx+4YA6FgHy39/RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKAWY84ClLqqe19sEAzkR2gYSRXNjARiRFndNlwkyX6wQvhbx5ybPpAl7aGeaZKbr
	 UKucbk8FRYAJimk6oqV6n8szjCctvZfmSgaC1fN0hRMkcy5G3r02MLxB/oNp4ZVj+V
	 S2vR0IJXGKyk9nVSLMawXwCsOW+MHyjnM404G2PFYMGs0+ORg0YFy0RnBGOAE+U9rP
	 e4tCQrSjkDPcx43EaNwvDAJT03KIAedAoIbsu3bKyrsG+/fdy5VOmmiahSR0UaNbxM
	 B9w328iCwv6T07uKpTE4WiZRrbfuWkY4cK4n+NBJWeWYhJfLs9fylDCsi2qkTDbW4n
	 kx/lhDLTm5SPQ==
Date: Tue, 22 Oct 2024 17:29:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jdelvare@suse.com, linux@roeck-us.net, sylv@sylv.io,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: pmbus: Add bindings for MPS MP297x
Message-ID: <20241022-deprive-proofing-b946577969c1@spud>
References: <20241022103750.572677-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CoNj/PdDBWmFbLqu"
Content-Disposition: inline
In-Reply-To: <20241022103750.572677-1-naresh.solanki@9elements.com>


--CoNj/PdDBWmFbLqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 04:07:49PM +0530, Naresh Solanki wrote:
> Remove mps297x from trivial-devices as it requires
> additional properties and does not fit into the trivial
> devices category.
>=20
> Add new bindings for MPS mp2971, mp2973 & mp2975.
> It is Dual-Loop, Digital Multi-Phase Controller with PMBUS
> interface
>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--CoNj/PdDBWmFbLqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfS7gAKCRB4tDGHoIJi
0nnDAP4taMo8hzhLydnC1/qGDhjgfi6mlBseHp5cpnJ7EVSqgAEA300DtfFu+Ltn
kHPzzG4dxIwtQRLJymBIkpE4HqNlJgk=
=E/th
-----END PGP SIGNATURE-----

--CoNj/PdDBWmFbLqu--

