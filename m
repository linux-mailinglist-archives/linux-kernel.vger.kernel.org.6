Return-Path: <linux-kernel+bounces-344208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D3898A673
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528571C22B59
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88F119A2B7;
	Mon, 30 Sep 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsTXPcUR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB96198A25;
	Mon, 30 Sep 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704567; cv=none; b=gN62VTItJvq1MRMMiDT14gI56tHRmRLUUjb+sIRd7wjpivGYxgD1xhR26fJoEkVLge9go2A7CGzSd3jW2yRZf2+blb+jwKDdkOZYnyE2oTS4psRTziG3Qs1AQ59FDWmGFfx5iOv0cinAMqCWUT4zR3fym8iLqI5n4sdE+w9+AaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704567; c=relaxed/simple;
	bh=vY2/ZJaIITkqinrDuxkwQ8SQ7pATOYMl7NM5kwz/bcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPFnCq25jxVksmqNYzDKZIvXkhlS05DhNiSxzFbaIkgoswzUrDLtzoiR2huZDmlXClYv5T1fiVXbc0bh+s8L8ZEBOldO+6F025lI0JmQkAOs/0N+KPe4G4+06mtN+Rf4Gmq59/mffkdCHQJ4mNnOFW07RhY5wZwK6xlcw3NDDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsTXPcUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66E8C4CECE;
	Mon, 30 Sep 2024 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704566;
	bh=vY2/ZJaIITkqinrDuxkwQ8SQ7pATOYMl7NM5kwz/bcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsTXPcURHj4NGESNY8Wovdg8I5ZV8AH5sbtqv6xZKgGQszSQ8O7Bj4fjf5s3ZK2Se
	 eNLlsZz3kEcKf22SdFmJmsadpfrSRUEyCfIkkJJ97vt9KC7/t+eBp7ZeWWbHKuWFHz
	 dMiI34gf6GsmiFPTF7tVGX1bX/AdDYLA0xFtSQs725DSccw29UHHm0G/XPmrBm4Td6
	 kalOy9Zo8mx01gloAKIoJCjUyuUtaNWiy9xPKfWsltAfwKrLSWfzInE5Qu21UTriHd
	 23UOjHeJDaAxWw76HWcSRiyLBJ0Wfdgkvub1CU9tnSNHPj3V9WMc54PNJbBMRFP9FR
	 8zHUOII/gp1GA==
Date: Mon, 30 Sep 2024 14:56:01 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [linux][PATCH v2 17/20] dt-bindings: timer: sifive,clint: add
 PIC64GX compatibility
Message-ID: <20240930-snoring-unrivaled-e38467343b3d@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-18-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dSbwHpb80TnozwLx"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-18-pierre-henry.moussay@microchip.com>


--dSbwHpb80TnozwLx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:46AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> As mention in sifive,clint.yaml, a specific compatible should be used
> for PIC64GX, so here it is.
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--dSbwHpb80TnozwLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqt8QAKCRB4tDGHoIJi
0rCvAP4vzWvnhiMvF2ZY727kJEZwoxR525N4pnNj7KNgJPIvzwEApJcgXaWQguqJ
CMrkpDxQgZiPsoJKHJFePVHjEYbcPQg=
=6F/K
-----END PGP SIGNATURE-----

--dSbwHpb80TnozwLx--

