Return-Path: <linux-kernel+bounces-449774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636749F55EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7AB1636AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E441F8AC5;
	Tue, 17 Dec 2024 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4SAPZDe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C11F868E;
	Tue, 17 Dec 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459594; cv=none; b=k8YVEcJGNZ20kFw3TCuZZKogtM237g01ddP9m9wQNhjZousp5QNaoIDxOSG7AenLbnf0DYqXPQeDQ4UxR52alDtK5+XM6mU0pj41Hm2uKH4xKbgGZ0ubmMjBOo6znLhQq9VTZJt3IclKaJwflkrRjsjhXOt36RfOP1N9utjz8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459594; c=relaxed/simple;
	bh=3KXuVnD9D+xJr3IbkexI7hbjcfsyh7wWVwrrKoPjpeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I012L9+akaygoQDRas9NdoV8r9k0JrtWrdwU4xQ3Zy4uNakwgExOt0GZwcdsC4wFB3HHb4q88flxW+yOyPGWrjxayGC3cTqEsjf/4Nb9JLUu1afcnoVRg3EAbAh3JnfA4PYseh6leQhYxTQmqt3SL/jNd3oRb8EawY/2Qb932nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4SAPZDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F80C4CEDE;
	Tue, 17 Dec 2024 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734459593;
	bh=3KXuVnD9D+xJr3IbkexI7hbjcfsyh7wWVwrrKoPjpeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4SAPZDedYs3kXXyLmJSO7yQxmKumVijVWPamYYOeh0Kpif9cqyzpymhMfLZ3oo1y
	 9QREygSOnYVvrDDgvtnt5Sx/QZi3w5jispy1rhlyN/yf9pgJPwaBUTTrG69WDWLi+6
	 8QrF7zvyZOg4ttrVPksHfvRFucpsiV2gQ2HJZAYnRwHJpOUGfNV10kC7S55pKheg6H
	 Q1w7loIbHIfi4r+nqFtd/XhyyF05Q+x3JzYgnUGEMwa5lY7P9emcXufhgHvw7jRCJE
	 7LMzyE9mrdtKdYe9yVt/ghr8oXCHrQHBEsM6GXdG0vc6GLcT4SJ3ZP/elgVDcPsSO7
	 AQD3bp1QXXf7g==
Date: Tue, 17 Dec 2024 18:19:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com,
	conor.dooley@microchip.com, conor+dt@kernel.org,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/4] riscv: export __cpuid_to_hartid_map
Message-ID: <20241217-grape-disdain-26ee36738961@spud>
References: <20241217113134.3508333-1-valentina.fernandezalanis@microchip.com>
 <20241217113134.3508333-3-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vlUeFHDDVuswpK1n"
Content-Disposition: inline
In-Reply-To: <20241217113134.3508333-3-valentina.fernandezalanis@microchip.com>


--vlUeFHDDVuswpK1n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 11:31:32AM +0000, Valentina Fernandez wrote:
> EXPORT_SYMBOL_GPL() is missing for __cpuid_to_hartid_map array.
> Export this symbol to allow drivers compiled as modules to use
> cpuid_to_hartid_map().
>=20
> Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.c=
om>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--vlUeFHDDVuswpK1n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2HAxQAKCRB4tDGHoIJi
0uPrAP4/CsqF4xQUklJpDfXANiZA1Z3vqLRdOQwomW1QCh6cwwD8C4TNhyPMruzt
3n13BSc3PEpaygd3us95wNDVC00i+Qc=
=ZwHv
-----END PGP SIGNATURE-----

--vlUeFHDDVuswpK1n--

