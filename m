Return-Path: <linux-kernel+bounces-176539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D7A8C3156
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD781C20C9C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78FB4F5ED;
	Sat, 11 May 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvlxNuzJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768843AC3;
	Sat, 11 May 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715431438; cv=none; b=alIEUon/TBWAAB/b7dUbOpAxJqzY5or0nOReS3Yw7rdy4++R9bMFAHnluhdq0UpZ0M21SiYLAO1vU1OhVEJltWaTOIM8E6o6RKF3SNqB5j2Dwy2KzyQHVk0FfC/Y5lzZecKg8dzgADOVJP5DXryGw+NoFNMX0yeosg02dt7P9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715431438; c=relaxed/simple;
	bh=Heqxbaz7IRkaiOkEqwlaEs6UMSLxPs//aTSXpSJAoyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpAOGt3eh9uaQHIdcWCd3uBI+e+u56PAkU/oOCmwmp4yzUaeK1W3jlMvv8/eZNEY0jVakP9T2dVvw0La1iJRfITywFe1IF2WL4Qhci1y8U+Dd97YAl/JuzahkR6yg650C8rt6Qsi5VzIClkrWgRXttSRjd4818Oqq0Xvwu26aqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvlxNuzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688E4C2BBFC;
	Sat, 11 May 2024 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715431437;
	bh=Heqxbaz7IRkaiOkEqwlaEs6UMSLxPs//aTSXpSJAoyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvlxNuzJxnNxHmnVUQTfZ/5WiD4NdTPU593BfTO7dAE5AgZLRbuU+Cs8tkknUIBHQ
	 JsZ8j11OunGHPhl9y/fNuzCpGHYUM5h5Dg9jiYtB3e/ud90Pk51bxJzeCo873jvSIP
	 YpVheCugpfdIRypsxVv4WOj0To7QcSe1PIOEKy3LpaMKbyxsO5QgXEAh1uo1ba+DL2
	 9hOvQFnA2HJ2ZWFkTiU+GooUBAFwKt/SSuQTgQCM4VTO6KciUvUXqliCNoOo8pYEu3
	 zyTUWwDeSN7T7fLjVp5bzEVUwXXD6izQYf02mAPz6rtwznHlBdhGoUZY0AV8g3F+Rw
	 HQW3AEH7XTX3g==
Date: Sat, 11 May 2024 13:43:53 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: Remove obsolete RTSM DCSCB binding
Message-ID: <20240511-tactless-detract-fcdd54175849@spud>
References: <20240510123238.3904779-1-robh@kernel.org>
 <20240510123238.3904779-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Go3BzI9BedJnqz4Y"
Content-Disposition: inline
In-Reply-To: <20240510123238.3904779-2-robh@kernel.org>


--Go3BzI9BedJnqz4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 07:32:36AM -0500, Rob Herring (Arm) wrote:
> The Arm VExpress DCSCB binding is unused and was only ever used on a s/w
> model over 10 years ago. Remove it.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Go3BzI9BedJnqz4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj9oCQAKCRB4tDGHoIJi
0rV7AP4jv8IXL3lwmDUHag/Rpo/TuIOclNafawCydHVzOLwZUgD8CcykhNVt+vnF
VhEFjC+BiXIEajmc1HWbAyiOy+kyqQk=
=BERQ
-----END PGP SIGNATURE-----

--Go3BzI9BedJnqz4Y--

