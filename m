Return-Path: <linux-kernel+bounces-288191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB903953719
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335631F21E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D681AD3EE;
	Thu, 15 Aug 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0U6AqhV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68840176AA3;
	Thu, 15 Aug 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735502; cv=none; b=aRbAlIOUVggaPEDnVbumlk2MUhOj7N5Ket2r13Cs8k/CqjFM9zBhAVrbYtZh4RlVwL62gOTGBEKfJ+IUglgteeVgKf+SPgBN68zLWpyCbY5hQ1E0nxo+0ah4VxrTiv1XGCe+EaGgF04xI+zlnU0HUc9udwMWjAUh/RbHXumsU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735502; c=relaxed/simple;
	bh=jfl+2SpFY5Z+BI+cjXUq0JYuiOx1Klxf78ouc2lbKMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWeIVJesE3Z2CwOGsadgL0McjQfxCdGseGfAL3dCe96a024qV4wdqanbtiZUupN+DBF9CAHz/YhDciNJFr+ReMUa8XVxb1gjs7Izd0KRercI+aLpYCMXgHZk3SnCaAYw3Jr0LG1+MJKHrzLlgqdXi8vLZsTsYWXQygqm/rxmWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0U6AqhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA36CC32786;
	Thu, 15 Aug 2024 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735502;
	bh=jfl+2SpFY5Z+BI+cjXUq0JYuiOx1Klxf78ouc2lbKMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0U6AqhVBk7f0u/M12xQutAuqe8ftcZiSIJcb7psBURESIi9Lr+vhUAWncMnIXnui
	 wGrFadkLGIdLYp4BF6RVJjRdsH1/67WpAuDspWQNcPZeGMtfSYsiFd1dfwjQnuYQvV
	 /UFADwbIOLT6jyElHI2lynsTisScCfNEonnXWIMrE1RxN79djUnowJS2QbfAEAXcyU
	 IqF9U7Ul3m7V6un3q82OJRdk8qxRQYqHZ+aaGQSMsdz5rliu971Stq9S7yZR339NgF
	 mXcdRXv8LkFq6k+3r3yMdBjTAJgflBR4bmGJ5Uv3FgPoRnlrQr0p0/TKRLYHSsu38A
	 pK2emROEHgYzg==
Date: Thu, 15 Aug 2024 16:24:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: soc: ti: am645-system-controller:
 add child nodes used by main domain
Message-ID: <20240815-overdrive-applaud-c8e086274d3e@spud>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
 <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1m3TTYEptL64IC9e"
Content-Disposition: inline
In-Reply-To: <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>


--1m3TTYEptL64IC9e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 06:37:18PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Expand bindings to cover both the MCU and the main usage of the AM654
> system controller.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1m3TTYEptL64IC9e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4dyQAKCRB4tDGHoIJi
0ogCAPwOvkwkXDEue9KCO5mdFkOq8r6hNmvMqsKehAIJWeprWQEA7rQUh1LqCCnR
cGtyZ84vST4SBGwqL+qSE/xR57D9fQU=
=D40y
-----END PGP SIGNATURE-----

--1m3TTYEptL64IC9e--

