Return-Path: <linux-kernel+bounces-564162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EFCA64F02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942A87A2314
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C223A9AA;
	Mon, 17 Mar 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpSGRI4k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB90239096;
	Mon, 17 Mar 2025 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214975; cv=none; b=p6lT5mvMCLln+YVteUA/rycEX8A/jVBSDC89g82K5hQKjGWP/Ac57TGR++2NMoTgQxIwsEfmsxuhSlgD5SgTPK5A5IEKFMdhmtcmaCO4nn8rdOb4g3Y1aNmdqLFyI100DSNgtWgVUT5+mnQio3BqMRWJerI4XJUVpRkxtvnVuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214975; c=relaxed/simple;
	bh=GGeUu/qHq7ctkvz7APKdufbJEDMrfDRBBej2b3v+epw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMo4yl8pm+wjxCkotusM7B6hv+eeOFj2uL4eDD/n922mBa3QLob5qcr28tX/ZgAaKIaL6Jtcotx7gwmkyGBgsWM2IorKDS8Qw/KLry/s5ngcEI1XIeL2FIaJerTx7PEJ4rDAh7Dj8xYDMwnwpltLrn1+l2FRsXrNvtHwarwzJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpSGRI4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA190C4CEE3;
	Mon, 17 Mar 2025 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742214974;
	bh=GGeUu/qHq7ctkvz7APKdufbJEDMrfDRBBej2b3v+epw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpSGRI4kJhUEnsCcy/8CpzXnlMWUIBo1cSH4DF2IEzWQdqcOZ95jO4rGZMjFPqlxm
	 eS2XbjNbuQARU8BhL/3S/YHuo7jha0/NlPfVQ5KyV8i7ItlRS8s5KBzsgaDgLkLyE9
	 o64qP0A6dPMI7gvsMaOviI2VsE8nuNgtr3hKQw41LphkRdt+wIx6p1D3YkmlZhBs+q
	 bg+vRODyWgooFpZjscrCnqABFcJGVQv3/lPXPgGeZSSX3AbHjtwSpXJvDdZ8eeKIBm
	 iNoflGUtkaBG+pmgCic+OXPizvDBTyqiLjLA3LQf0UNEAxOzZpa0Ooyq/a/57ctmKe
	 K8tmC/ZgSS3nQ==
Date: Mon, 17 Mar 2025 12:36:08 +0000
From: Mark Brown <broonie@kernel.org>
To: cy_huang@richtek.com
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] regulator: dt-bindings: rtq2208: Remove unnecessary
 property of fixed LDO VOUT
Message-ID: <857ca1fd-f7d2-41ec-963d-2b6250ac2cca@sirena.org.uk>
References: <cover.1742204502.git.cy_huang@richtek.com>
 <d90e57c14869415e6322e8b0bbff14da480a0adb.1742204502.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rPU7mO5AV4U9+wRZ"
Content-Disposition: inline
In-Reply-To: <d90e57c14869415e6322e8b0bbff14da480a0adb.1742204502.git.cy_huang@richtek.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!


--rPU7mO5AV4U9+wRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 06:06:23PM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> The 'richtek,fixed-microvolt' is unnecessary. Remove it on the document.

This will make any existing DTs buggy, we should mark the property as
deprecated but valid.

--rPU7mO5AV4U9+wRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfYFzcACgkQJNaLcl1U
h9CVHwf/QfAnMJEcABurm/VTBBbfT0kWSqivM37rkxYl6/Xj7mRjaxU6E+TkSZgc
EaiTpH/hXdvHNeN4az2wO8zm+cT9OInl1PzGDmXeXMyUjadiaAy/TPH3L95BumjE
CRAXXs+ikVvff/99h42y1b/eHXHZLobVzOhygaf1C3u7rE76qqas3XBLNMae1DQi
OllhPCGuIfrB9ajeLUAFJJXirQ+Rz1LYk34WRgXs1whlhHn6k3+GzcXGXHExyu5o
tdNWdpXl89jRw5xcrWx+Kf1/Xu46VCge/VayLstuSj2NIZN9Ct1mhx6xfHhS13+s
fng3/x+YDGPEK21z3BoWgbMhdLvVAQ==
=lgtk
-----END PGP SIGNATURE-----

--rPU7mO5AV4U9+wRZ--

