Return-Path: <linux-kernel+bounces-237950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2599A924115
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12E21F24258
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9743C1BA087;
	Tue,  2 Jul 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7uH0Kax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDFBE7F;
	Tue,  2 Jul 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931372; cv=none; b=BwV4GbGg90Nr2VPnqRbL0jtKgwIpvt6qF0J8ZDxqPSloHWSb6aLJg35OHyJQFQkonW45XVcf/aGiip0LlXUBu5JBTgDd8qBMZSU5wyzsGqpOl9BxseKH8Apstw5ghCWVWAAbTGE0H6EQCriGnNcKzH/ImHaPBvaa3+EWexlBZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931372; c=relaxed/simple;
	bh=V0uekJLLnO8HH1U4kVAv/bV1cAEF38ni3DMFNyDOaPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhBYfPfUbMX5MZmFM1nuLIVNcxsjj74f0Ih1BCC64zEtqonQXq05rAlDvxz04CkoelaeiR6Nlxped97mrpS/p8OL4O/MkmyqsqWQdRO00qT1rQuJt14dtfl4HvUV3D3JaKpmIZfF2Pgwl4B7zU7WGzs+YRhbK854IyKxMIQL6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7uH0Kax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F544C116B1;
	Tue,  2 Jul 2024 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719931371;
	bh=V0uekJLLnO8HH1U4kVAv/bV1cAEF38ni3DMFNyDOaPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7uH0KaxSF/k9vKRkI88LOipINDeNnpeDsRw2riJqFWEdjsJlqjPdmhj7OTigUjyt
	 XF5cIQPDeaPw+JiwmRzIdhIsLE21xNfbfn/x/gzM5CYGlpJMo921XfbHkaqAH77sti
	 yQiS1QgDRvj1a+vfhxSIPyuHd0axFp9xEMpAFOLdkc0IjpwvkFXN0g7dodkOQ1NJGI
	 3pqQvD4ybnm31VrW9Msm9tEHliqwBng5lt4qzT/KM7hsa8ma2KH31gBoAUYfyEhVTn
	 +qkaWprfYELD0BwYBM3ON5zVG6VFw8Cqfg9SnF7DEeagPTIAXQnOda3j5dB+OTv5H5
	 FlF2Z+7/KR5lw==
Date: Tue, 2 Jul 2024 15:42:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
	dianders@chromium.org, linus.walleij@linaro.org,
	swboyd@chromium.org, airlied@gmail.com, dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, lvzhaoxiong@huaqin.corp-partner.google.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: Add compatible for
 melfas lmfbx101117480
Message-ID: <20240702-unplanned-oat-b4757f618539@spud>
References: <20240702130138.2543711-1-yangcong5@huaqin.corp-partner.google.com>
 <20240702130138.2543711-2-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oHUFRZu9Gcv6C1ca"
Content-Disposition: inline
In-Reply-To: <20240702130138.2543711-2-yangcong5@huaqin.corp-partner.google.com>


--oHUFRZu9Gcv6C1ca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 09:01:37PM +0800, Cong Yang wrote:
> The Melfas lmfbx101117480 is a 10.1" WXGA TFT LCD panel with jadard-jd936=
5da
> controller. Hence, we add a new compatible with panel specific config.
>=20
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--oHUFRZu9Gcv6C1ca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQR5gAKCRB4tDGHoIJi
0lP/AP9hjJ3cSdPG0aEpu2VcKOIuGrQ1XIWAreUik6m9rgLemwEApSrqFpUqtJ23
JH+naFm1JeFIQn25OcRek7vQecXFLwg=
=MFC5
-----END PGP SIGNATURE-----

--oHUFRZu9Gcv6C1ca--

