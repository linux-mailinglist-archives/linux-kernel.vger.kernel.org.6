Return-Path: <linux-kernel+bounces-337407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0B9849A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA9F7B242FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E841AB6E6;
	Tue, 24 Sep 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKt/X549"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FB13B280;
	Tue, 24 Sep 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195535; cv=none; b=pnTpBQAGHCjIDzhrsD8leVO/qfZ0yu30ignEmN7KU2gXkjVtIt3M5L80YAabrR7pxAvU5xft+sj+pSZExIrccjIW1TBCp6oRJ466cMX7++H2h309C0QEYi5B5H1JyvqAKpoyUFxlRfuR0kca9nKTkPXc+ydDJ+eLoT3fnhX6Z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195535; c=relaxed/simple;
	bh=oryTiLrzqpBideC04Yo8+knXVyCH+BqfydoGzD6x9G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSYwuXNVRCR22lF5lWoqRaGwiUFI+An4ZyN+36ydYY6lU0gupo56yegX8kw6R98Cf1gu7ZZW+GGBoPpnFS3Uch7+HuL7F/36QX7JhGmuQcKJHYRgQleqV2xudx6J2K8h4PSDsYKzcHvZhh64h/DfXx53qtNtDyLoRk4YYnK82ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKt/X549; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F86C4CEC4;
	Tue, 24 Sep 2024 16:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727195534;
	bh=oryTiLrzqpBideC04Yo8+knXVyCH+BqfydoGzD6x9G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKt/X549n1d8+xpD6mx1F8WAqmaI638ga64G9N4965FKL/Af8uth0kpwRlMGogb5n
	 79w48rQHXcEA9G1YZhRCz70CvDx+AQNPcbk6yXdvMCEGyaNW+PYzgfJ+eZvKCor5FR
	 l6PacQwukJCLZTU/fZz8iAdFTijpoVwsvRlAIODmLcbhNmNZ95TRoRBxLRBQxwSzrT
	 wfNX4gPLAauSclS9EJeG62yr1ywft746TJmaild/+9D6MK/+YY+IqoXC1dhtqjbqpO
	 Ncv4ak9m5zX66pbVLXKv91HMxS6MnAvzaSuYvsJbPgoI6wPQErmUBzbf5tKCLw+FoV
	 Bkx1ZZ9lL8eXg==
Date: Tue, 24 Sep 2024 17:32:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Junhui Liu <liujh2818@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Junhui Liu <liujh2818@outlook.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add support for canaan,k230-rst
Message-ID: <20240924-amicably-deserving-6e1ab5da11af@spud>
References: <20240924-k230-reset-v1-0-d0cdc11989eb@outlook.com>
 <20240924-k230-reset-v1-1-d0cdc11989eb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ACDapMgSuw0TQGYv"
Content-Disposition: inline
In-Reply-To: <20240924-k230-reset-v1-1-d0cdc11989eb@outlook.com>


--ACDapMgSuw0TQGYv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 02:00:40PM +0800, Junhui Liu wrote:
> From: Junhui Liu <liujh2818@outlook.com>
>=20
> Introduces a reset controller driver for the Kendryte K230 SoC,
> resposible for managing the reset functionality of the CPUs and
> various sub-modules.
>=20
> Signed-off-by: Junhui Liu <liujh2818@outlook.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--ACDapMgSuw0TQGYv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvLpiQAKCRB4tDGHoIJi
0puaAP0epM/2Qkp4MI6TZwm7MYSYaxwTef9ENDnrZDvp1Ld6UQD5AU2PBJAICCDw
x8InvyIg9n6tlZCISb6hGJdMdSJurQE=
=WXPJ
-----END PGP SIGNATURE-----

--ACDapMgSuw0TQGYv--

