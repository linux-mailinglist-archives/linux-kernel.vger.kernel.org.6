Return-Path: <linux-kernel+bounces-250495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ECB92F87C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A661E1C2108E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06887158A35;
	Fri, 12 Jul 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZecFFwwt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4EB14A4C8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778113; cv=none; b=tj6Fgg/UABLNLXOFOY9B09CS2+2e//qsRR8vNr/14XsEX/eIRQojTeKPLNe3DQg4X6Ku8pA+Ip0PD40z4MftaauhGVFKMhkdt+ihJJkFzavo/A9WWq1dQGetQSXZnf6QJRr8lWl0WlX72ND16zv/sv0PK+50rIoTug+YNWP/UxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778113; c=relaxed/simple;
	bh=VHgWyoWjIKaO1gLhmwyqxCG0NgL1aQmum5wsVrDPiiE=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=k7vntSGtCnmofk1YSfjo3SwvGRKOT7P3OtXHRQ0GmqolRbsjlFeXTZ4q1AoiB7hxRVqXZSrPfBYOra+C0qAESt0pqu2Y5WfK2N5gyuP+eDLaWx6BzX36FjS2JL8+iVO3U6sj1LR9XYhms1IE8tOIp5qes1N0ThTznnv4MUvfM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZecFFwwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3E2C32786;
	Fri, 12 Jul 2024 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720778112;
	bh=VHgWyoWjIKaO1gLhmwyqxCG0NgL1aQmum5wsVrDPiiE=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=ZecFFwwtAOOh80u9qYekts6l8YtCdGU8XuUm+MNK8HHev1vlPyexWEISjh0+hvUBG
	 1ayBH6kTc2hC/9xkViVT/C1PqnzHi4riccGduaeyeSKvkwWNNyNK1vXVteWzbt1xzR
	 VeMkpwkv5WclR9EqxIEq7y2n9nPq+Xh43YnebkzySOHBlCgYKLuHkqvP2E749NDGXz
	 tq0rfl7Fx9l0cwnOpwuMqjdhzkozLhZrEtSB6L3qszO87Ax1ukfa1qPYxR5xtR3R2g
	 8bgkzOCE0NwnVv6RLOhJWzXfNLbJbLBUOLv/Rb3Obak1Miezs+gsvrjIzqsi7SrFvn
	 ahkJeQYZ4mzpA==
Content-Type: multipart/signed;
 boundary=aee9b33c528211d8b06b0c46e19f7e654e98074c381b0b5a8e637c093686;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 12 Jul 2024 11:55:08 +0200
Message-Id: <D2NGXHZ2VTK0.M0AOB4CM7MHM@kernel.org>
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Rasmus
 Villemoes" <rasmus.villemoes@prevas.dk>,
 <linux-arm-kernel@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Esben Haabendal" <esben@geanix.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v3 00/15] mtd: spi-nor: macronix: workaround for device
 id re-use
X-Mailer: aerc 0.16.0
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
In-Reply-To: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--aee9b33c528211d8b06b0c46e19f7e654e98074c381b0b5a8e637c093686
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Jul 11, 2024 at 3:00 PM CEST, Esben Haabendal wrote:
> As a consequence, the SPI_NOR_SKIP_SFDP flag is no more, and all
> drivers that have been doing optional SFDP is now marked explicitly to
> do that using the SPI_NOR_TRY_SFDP.

First, I haven't looked at your patchset at the moment. But I'd like
to take the opportunity to discuss the following (and excuse me that
I didn't had this idea before all your work on this).

First, I'd like to see it the other way around, that is, doing SFDP
by default and let the driver opt-out instead of opt-in. This will
also align with the current "SFDP only driver", i.e. if a flash is
not known we try SFDP anyway. Going forward, I'd say this is also
the sane behavior and we don't have to add any flags if someone want
to add support for an (older) flash with the same ID but without
SFDP. With the current approach, we'd have to add the TRY_SFDP flag.

Now we might play it safe and add that SPI_NOR_SKIP_SFDP to any
flash which doesn't do the SFDP parsing (because it has size !=3D 0
and not any of the magic flags set) - or we might just go ahead and
do the probing first for *any* flashes. Yes we might issue an
unsupported opcode, but we already do that with the generic SFDP
flash driver. So no big deal maybe (?). Vendors where we know for a
fact that they don't have any SFDP (Everspin I'm looking at you),
would of course set the SKIP_SFDP flag.

-michael

--aee9b33c528211d8b06b0c46e19f7e654e98074c381b0b5a8e637c093686
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZpD9fRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gW0QF/aA10t5iors/5JcBokw9E47uTSzUvxCoi
NSOzc/Px3FUg1ZGuj0lS82ccJeCIbR69AX4gt2bRjp5TWDp7clxAH0mAE0UWreMw
ZHmZ6GClSkkuvrktzl8GLR5tFulIDA5Xabo=
=LhXX
-----END PGP SIGNATURE-----

--aee9b33c528211d8b06b0c46e19f7e654e98074c381b0b5a8e637c093686--

