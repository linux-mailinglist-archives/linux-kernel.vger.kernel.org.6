Return-Path: <linux-kernel+bounces-192569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6208D1F35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993E7B23202
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F7216FF37;
	Tue, 28 May 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deXF0UgB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB217C7F;
	Tue, 28 May 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907651; cv=none; b=I7qJviX0m/+E+Nd2B4O3c9Fnfu09H48OYY/QgT9Xpg7V5Sn+r4LvlxHWYwN28rJ9kmC6wJesXlEf4OIlTLgGKe3P6bR0H5f1/14JqunuyJMum9+IQtI8tQ55GsggbR9NHSFpg+TSqjQI8/lxwu7jH/7WSBIhyHQsJh9DlaCSAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907651; c=relaxed/simple;
	bh=75oAGp/ALt8LJghJjZRrjJGgwjH/DmPA8ZSyKZE3uaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckCdfeb7/zGWX8feMNDVXc+k/D4zUIvdEUJbH7SZQYkbpqZpc1b41zGQE/DKwftGsZtVgeVv9tScUSFpgYOQXUTN09iG5llAemZlS4+qy853pS3W78oZnOgbTrohSoMYX9kup4Df7sRNbBX5WmttlNEb9wqID7jhmJH/ylGtIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deXF0UgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8024EC32782;
	Tue, 28 May 2024 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716907651;
	bh=75oAGp/ALt8LJghJjZRrjJGgwjH/DmPA8ZSyKZE3uaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=deXF0UgBXtZqGCnwXbQVAU7ywUPhEcO3MKu/pyCmgbZVCSpJqU8wJpTrM27+O4JGp
	 sxWNP6247nP+k/s1BGElVOiHIZnsmU7bAGEn3yKCEbXvQjUNyWGoVTKM88GNJ+NoB4
	 22kbsdeuq42nTXIVeRczrIxrXKGirG0JGhn5mqZCkrgTzrwbERKeMjr0l2mWJWqWp7
	 a1xVn/2sfWCRYpsyQHmX9JyYww4hITelATN2FqqQvBDmNPgrddO/JCUy4TKyRpnQXz
	 IUbpPu8Ba8pMhij6lSKvt42UrKZRlTV/gWuz6Yr1vSkfI8IXjWpIfUyKJtrACrVUaV
	 undMCexnwuECg==
Date: Tue, 28 May 2024 15:47:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, frank.li@nxp.com,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 1/2] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <20240528-revolving-barometer-7f0559020021@spud>
References: <1716865154-25044-1-git-send-email-hongxing.zhu@nxp.com>
 <1716865154-25044-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6MUTDMyW2IA39pPQ"
Content-Disposition: inline
In-Reply-To: <1716865154-25044-2-git-send-email-hongxing.zhu@nxp.com>


--6MUTDMyW2IA39pPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 10:59:13AM +0800, Richard Zhu wrote:
> Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> Introduce one HSIO configuration 'fsl,hsio-cfg', which need be set at
> initialization according to board design.

With Frank's suggestions,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--6MUTDMyW2IA39pPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlXufgAKCRB4tDGHoIJi
0hrpAQDtIMLWV/dPOnO/6goc25NA22vAu/uIJ2Ra0/mupzNaAQEA2dgQNokIlLju
4UGM9OXfVIq+7KWo9Vesx0JLo/HNZAc=
=olHp
-----END PGP SIGNATURE-----

--6MUTDMyW2IA39pPQ--

