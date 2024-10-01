Return-Path: <linux-kernel+bounces-346354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD998C380
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 021BD28211A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539A1CB522;
	Tue,  1 Oct 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzFW1AOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038C1C6889;
	Tue,  1 Oct 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800400; cv=none; b=OKjlyOdfGWmYeGqiyvpnWYa9I7hUUIZCHEruM9ndQUhM2yL1L2o4k3XXJPRuM4FsZRhxL5vOfvFSrah+dr8U0Zl2PZ2NOun592JoiFTsr+VFNwf5WFigbaYH8/qsLDsOTEZvpYIBBt/50GjdMgR/jboCFtBxJx0PaMzaDuQf0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800400; c=relaxed/simple;
	bh=X0lJq5RdgPEACT/WdHb/x2NfIY4RhprJCqlbygUaMaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWKoANLHAj1V64wkuXYnPEktzWhlpOHALf2Rpwqkgq6p71Ax5XB3QUMRcvH7rvBES1+DCUOG9tucO04isJofLmYD13wu7J/sjAJu7dhFrvI9tb2S7ECdLqrWptJ/Dg25b6DV/aQOCtwV02y6tDyfypwAjGkmEfiWu9UdM4rvj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzFW1AOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E02DC4CEC6;
	Tue,  1 Oct 2024 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727800400;
	bh=X0lJq5RdgPEACT/WdHb/x2NfIY4RhprJCqlbygUaMaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YzFW1AOpy469RKawKUfXdJ6L/eRuZbdzob5SrZp+C580YNUs9a42kgHjA4u93T0Sg
	 QWMZY+KY+g0K9Z0a7McI76dsOC8d1++btsAVr4dtQE5TeLPEOSCTiosCcrdGT30QOX
	 zvd198xB1swEzKWUj/FcPtZ0uwwSDqeJMN9FQnKDjALf5rDOXGR941hVzd8Z+avPLm
	 1y7MC5uVf+iSChH6BQfpcrLR8jKpuyWgtsLiWgzEDX7bJG7Ug/dXFBwBpws3ycfsLI
	 G33BjGm+InXft043BymQQh/2jDEyee5euEBUJ6Vxt97G7sGDnZSwILunmHwT9HXA+D
	 wcvMWQ1HbbPtg==
Date: Tue, 1 Oct 2024 17:33:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: regulator: vctrl-regulator: convert to YAML
Message-ID: <20241001-purplish-extrude-4e4e74361ec8@spud>
References: <20240930210424.1994047-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GbHUkAU+w4x7KlLL"
Content-Disposition: inline
In-Reply-To: <20240930210424.1994047-1-heiko@sntech.de>


--GbHUkAU+w4x7KlLL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 11:04:24PM +0200, Heiko Stuebner wrote:
> Convert the vctrl-regulator bindings to DT schema.
> This resolves a dtbs check warning for the rk3399-gru devices.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--GbHUkAU+w4x7KlLL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvwkTAAKCRB4tDGHoIJi
0nQRAQCNRlqFTWXfbpQ2K+hdGQ3hM0+FtNiHTWqxVRCGjQf/fAD/aU8P1g8bx7V/
KBXaKK664muw9qBwrekuaNtQjg7rjgA=
=N7sW
-----END PGP SIGNATURE-----

--GbHUkAU+w4x7KlLL--

