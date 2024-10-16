Return-Path: <linux-kernel+bounces-368446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D319A0FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BA8289959
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87AA20F5B1;
	Wed, 16 Oct 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb4jm9TV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617117CA1D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096585; cv=none; b=EcvxpfUlHrRLsH0djQ96K+3S3SOOchc+9jnhiuI2MBexm1ztrxrHp9ZcXVslndkmh3stNvSmOND9/YOUaE6QA10JdjIHbfWfwNptKCMA/PbKVFeP8OstJRIv2GzKngWCjLCJEqcoubsueyFtUnG/HKo8gksu4CB2P6p3vgPAJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096585; c=relaxed/simple;
	bh=tEgVuItg9cKERlMvE79FjV7ymN+CZ6ZP2s9MIK145nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcCdJ7MlaojB7r3jNC7ebjQEc8b+OlGcQHI/IsoyQx7PX0pavBJHBEym40V5MxrOPNbta4KqvEAk5geKbXOW+UzoCWHx8s3sR6NDOFP3Mhpiz50X6X8OZW/IWIza2488zpmWD9yNVy1gGcwT2CojgV4sDBDxCEZ7ZiUudTHWpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb4jm9TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A9DC4CEC5;
	Wed, 16 Oct 2024 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729096584;
	bh=tEgVuItg9cKERlMvE79FjV7ymN+CZ6ZP2s9MIK145nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kb4jm9TV6i5pyRvbIxxFyJ36GfgAdlGlmUeIfkQchmXlTcTyC2z9w3lCBBynL2U5t
	 oR4Ss5dvNlX54np68CO6aHHro1SP1G1asBe9wNZY3OoYosxS7kQ4sqYDD0p2b7Tetx
	 uOmUV6wepZd0piOPbXFxmLE2a4wf2taN9BLkUMBcoZ6zp8Kl80OYGrBqzCsf3nrfSs
	 AmHdXvDKqgyqyyJXKJVce8y23bfxLER9G8bSmY7mG33JA6nHkiv+a8CoXNvylEuTLy
	 p1u9kaEBwPc2fvD2Z8jViCKBUYMAJxBUEPhn/WqaSZihaHCMccQellatM1kTCXBEhq
	 +w3smA0r9gRdw==
Date: Wed, 16 Oct 2024 17:36:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Jamie Gibbons <jamie.gibbons@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] firmware: microchip: auto-update: fix poll_complete()
 to not report spurious timeout errors
Message-ID: <20241016-abdomen-agent-4f24e0f68fbf@spud>
References: <20241016-slouching-excess-d7a62fc926a1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PllR1fdHlubf9A7B"
Content-Disposition: inline
In-Reply-To: <20241016-slouching-excess-d7a62fc926a1@spud>


--PllR1fdHlubf9A7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 05:35:06PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> fw_upload's poll_complete() is really intended for use with
> asynchronous write() implementations - or at least those where the
> write() loop may terminate without the kernel yet being aware of whether
> or not the firmware upload has succeeded. For auto-update, write() is
> only ever called once and will only return when uploading has completed,
> be that by passing or failing. The core fw_upload code only calls
> poll_complete() after the final call to write() has returned.
>=20
> However, the poll_complete() implementation in the auto-update driver
> was written to expect poll_complete() to be called from another context,
> and it waits for a completion signalled from write(). Since
> poll_complete() is actually called from the same context, after the
> write() loop has terminated, wait_for_completion() never sees the
> completion get signalled and always times out, causing programming to
> always report a failing.
>=20
> Since write() is full synchronous, and its return value will indicate
> whether or not programming passed or failed, poll_complete() serves no
> purpose and can be cut down to simply return FW_UPLOAD_ERR_NONE.
>=20
> Fixes: ec5b0f1193ad4 ("firmware: microchip: add PolarFire SoC Auto Update=
 support")
> Reported-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

note to self
CC: stable@vger.kernel.org

--PllR1fdHlubf9A7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZw/rhQAKCRB4tDGHoIJi
0miUAP9DZg+s4X9HStNvKpoT3C/o+qTS33CtyQ6GFiSOaEq8dgEAy7LnQJb1n9Kn
0KOH/EpfS+kx4vlKWk0/60nK48nH8wU=
=ZYWB
-----END PGP SIGNATURE-----

--PllR1fdHlubf9A7B--

