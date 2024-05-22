Return-Path: <linux-kernel+bounces-186473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC968CC49D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC371B21E13
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9985731B;
	Wed, 22 May 2024 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7ZvkPfd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D895A139B;
	Wed, 22 May 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393885; cv=none; b=bflh+SziaYsBb+OK61HScciOxgHwSr7SPuk6ol2Vkwe5yDHjppvEHnCXIwn64swIYoyMwM6/8AHtCGtoy/L1CLlBlxACJgr2Z92n7szbUZ+mtWl8P/YnaQb4B9wVHMaVDCGhnxM/UGlbM6/dzqphLYOPMS7gOuH0w32o2ccL1qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393885; c=relaxed/simple;
	bh=1vicdVPng3fETAqpS3OYsILf4v6JPsudUhtYWNmeKFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPZ87+0bc7xp7CfnHIYE/kknHGLV8XDsDGekeZUYw4H6qE3KNBa89/ffyKf9iEOrqvluRW3O96AGKsZjlOe22Q4BcuqYoI9tHJN4c45RgYKprv35IjjaRpGg/M6hcM/PXJdqbrHLY3Rwo0SidJV60Kj/6kbfgfWCou293tijIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7ZvkPfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC34C2BBFC;
	Wed, 22 May 2024 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716393885;
	bh=1vicdVPng3fETAqpS3OYsILf4v6JPsudUhtYWNmeKFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7ZvkPfdyjrKlBm/FTG9TU+EkjklqPbuERB6Y9m9/+Q1jHW4x/d2W2a6TX+FECKfh
	 vJ/92gc2wjm0s0T7DBHTxNoE+byTqlUs5TWIYHv7NtJKe2jlstI8AFhwb/q4sBAIjT
	 xWm2hwH9VU9fSc7lMGttMImlnx+PQZmVTP+5nNY8Gz5K5KMgwQydASFhhEEvzsXvf0
	 Sx4ytR4LzuMmUsSVwAirgrB3/wpaElPJqgNm/FpOJOGivEJa7UJBVgC+t+EjV2AbyP
	 wj4NGmOVQKxIWLsgMMaWHDqGdO+z1CfqUmp9llADlZhHV8GdSHrojF1K/uNOLlzZaX
	 0TUjw1qAG7A8w==
Date: Wed, 22 May 2024 17:04:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/2] dt-bindings: interrupt-controller: riscv,cpu-intc
Message-ID: <20240522-yoga-blurt-dc5e40a0ae3a@spud>
References: <20240522153835.22712-1-kanakshilledar111@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eeg5JD55UAT+KHlg"
Content-Disposition: inline
In-Reply-To: <20240522153835.22712-1-kanakshilledar111@protonmail.com>


--eeg5JD55UAT+KHlg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 09:08:34PM +0530, Kanak Shilledar wrote:
> This series of patches converts the RISC-V CPU interrupt controller to
> the newer dt-schema binding.
>=20
> Patch 1:
> This patch is currently at v3 as it has been previously rolled out.
> Contains the bindings for the interrupt controller.
>=20
> Patch 2:
> This patch is currently at v2.
> Contains the reference to the above interrupt controller. Thus, making
> all the RISC-V interrupt controller bindings in a centralized place.o

Don't do this, it breaks tooling:

	b4 shazam 20240522153835.22712-2-kanakshilledar111@protonmail.com
	Grabbing thread from lore.kernel.org/all/20240522153835.22712-2-kanakshill=
edar111@protonmail.com/t.mbox.gz
	Checking for newer revisions
	Grabbing search results from lore.kernel.org
	Analyzing 3 messages in the thread
	Looking for additional code-review trailers on lore.kernel.org
	Will use the latest revision: v3
	You can pick other revisions using the -vN flag
	Checking attestation on all messages, may take a moment...
	Retrieving CI status, may take a moment...
	---
	  =E2=9C=93 [PATCH v3 1/2] dt-bindings: interrupt-controller: riscv,cpu-in=
tc: convert to dtschema
	    =E2=9C=93 Signed: DKIM/gmail.com
	    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
	  ERROR: missing [2/2]!
	---
	Total patches: 1
	---
	WARNING: Thread incomplete!
	 Base: using specified base-commit 20cb38a7af88dc40095da7c2c9094da3873fea23
	Applying: dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dt=
schema

If you change one patch in a series, the whole series gets a new version.
Just let git format-patch do that for you with the "-v N" argument and
you'll not have to worry about breaking people's tooling.

Patches themselves are
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--eeg5JD55UAT+KHlg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZk4XmAAKCRB4tDGHoIJi
0su4AP9z+Txrf6KWtFYERWILq00267oges3Pu8u242cyzQesKQEA5Yre424wVHVT
o9tzXZgPfqWGP7LkQ5a5BFjbABdJ6wE=
=CDKs
-----END PGP SIGNATURE-----

--eeg5JD55UAT+KHlg--

