Return-Path: <linux-kernel+bounces-424678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E09DB7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4334163D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593619DF8B;
	Thu, 28 Nov 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shQG5JeW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACF19ADB0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798491; cv=none; b=WuK6ACIb/wTDCnFN03nYmDiSIoHLiZpseqrI0Fh4ObB5a3D3/6BQki9LxD0yOSlXj3742l9It9jz4vFZRDUbpCQnuRsyYcPgxgo+1H5w9E0qi+oePGb8dLptlPL53DZ8N6zIxqMrkhw6FGhDg0uISKMiHyLz0hPD0UkmpCFnVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798491; c=relaxed/simple;
	bh=uTxcaGHyarht/eBbrB9eFSjtfp5FO0euprQVdFF/Jd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVTSpedXkC/di9HW9m+RZ7McI2G7CAy3DeZASvEY+hEq8l1rHUr+5tVzzMykrARlWlBIqSGG+MztrJahsCcb+Oyz2DT/5PbepDNP1StSCAiSZ0VAQ/bqCckm6PEIKFREsWAR9QhvwH7UAJLuJJdulopnN0z4dko5tU14nNEtOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shQG5JeW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A708C4CECE;
	Thu, 28 Nov 2024 12:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732798490;
	bh=uTxcaGHyarht/eBbrB9eFSjtfp5FO0euprQVdFF/Jd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shQG5JeWb6bT7YY6AkYM3vxQou1HqPVqfoB9inPcwx+UrskEcg7bCXYtHGbmrvoUq
	 i8IjvkeThxcXWEyHUXlag7WWVAsWXL+IeCQlP6RATWVEocCrUyLbBuAG5R6nTbdswo
	 DAyelQdJAUF/foHb40vmJfBjppn3O5Ss5rfefDZgTpz7zrqJycoNFLS+xEUyteDOm2
	 BCeY9om57A/RJOo1HVAAyB9cE1qqGATQcZg4jN04um8yzPtCjfJP3qX9a86br+Pm9+
	 g6XMDnQGLDtpdeTw8kMvAPX/y7M7eZDqq9f9pquf2NntX2fYvtvH0U5UAtFQO8sZXs
	 iDwbvYzQwnKSA==
Date: Thu, 28 Nov 2024 12:54:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: detach regmap from dev on regmap_exit
Message-ID: <91c85c92-573f-4ddd-9939-628b9619d733@sirena.org.uk>
References: <20241127212233.330983-1-demonsingur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZlEjmhEaKFy6qEmX"
Content-Disposition: inline
In-Reply-To: <20241127212233.330983-1-demonsingur@gmail.com>
X-Cookie: Close cover before striking.


--ZlEjmhEaKFy6qEmX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 11:22:31PM +0200, Cosmin Tanislav wrote:
> At the end of __regmap_init(), if dev is not NULL, regmap_attach_dev()
> is called, which adds a devres reference to the regmap, to be able to
> retrieve a dev's regmap by name using dev_get_regmap().
>=20
> When calling regmap_exit, the opposite does not happen, and the
> reference is kept until the dev is detached.
>=20
> Add a regmap_detach_dev() function, export it and call it in
> regmap_exit(), to make sure that the devres reference is not kept.
>=20
> V2:
>  * switch to static function

As covered in submitting-patches.rst the inter version changelog should
go after the --- so it is automatically discarded by tooling.

--ZlEjmhEaKFy6qEmX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdIaBUACgkQJNaLcl1U
h9Ch4wf/ZhzOWYLGZ1uocxQHT62zv3rv4rULD/wsAIyUfMjkd77nSZ1WtnzLJTCT
V1aR4OYRrpM6StEL4lvjEyA7TkJDrSkuVKqDGkPwoktXBIKBgOSysj/evhXJJ1lj
T5L7NwZqPr9NUtQ9TJ/m/H57MQC7lo/S1hJGn+DTBkKMNpYIX1VIdE161Ji0Uilk
6b9lEADQ2CUM3m/jgC/jQ2Cu1lyfjR9kID5BraFub63J4dr9c9RXHjNRq+E6D4lf
mh5s3ZbQFEuegtPqaXvDcPLsqrnc/3HukJQ/NmuGAtKNtDCMCqLptXDDzPJ2drwh
qXOVJnAXf2cXhsNVjU9Kmyh6ceieLg==
=J5rM
-----END PGP SIGNATURE-----

--ZlEjmhEaKFy6qEmX--

