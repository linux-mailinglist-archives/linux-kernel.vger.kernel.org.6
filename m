Return-Path: <linux-kernel+bounces-208528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB9A90264B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47822822ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2A142620;
	Mon, 10 Jun 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5tw7dn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E91DFF7;
	Mon, 10 Jun 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035690; cv=none; b=IEdQLrXnUgeRFcUzTXmnhuXhazUrAGm/ej5KPbZ1H6CCFsOsAoRRTlfJFVuZsm7P9qdyJ1ZuSk9ONz38Bgr9FvYB+u47sPjYuRQNvdnRCL0scS5yUXHFV887HbfLkGxbRkRL9c+wgC71bkC16/qm1f7aMMYwNVLbY0CmP2P6uKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035690; c=relaxed/simple;
	bh=mZTNkAEKgG/q85m1UYU1gPZ6SrEhgB8KcIIymCeQnzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK9wqHHpHBgRSAv2f/kREwJ4JtMO+Zhdpg4pFYQO0tFtM1tdgpuF7PtKIuxH3ztWo5/r0m7J1aKaRHjJg/Sad9u9G59TuWT01j+DVFLPDy0c/71GQzWncKO267172RE2FMBpakqPQgoMDM9um1B7SbGsJTHTQAwqZDMt6ZzU1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5tw7dn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC714C2BBFC;
	Mon, 10 Jun 2024 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718035690;
	bh=mZTNkAEKgG/q85m1UYU1gPZ6SrEhgB8KcIIymCeQnzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5tw7dn3YElU45yvBOLhN6f5W0SVV/6xBWUrUwA66/yXflEEBhsBqBXNFnIpigCeo
	 IjBgVRzYgfynaHQTWvZIl9hYCvRpwjSHGdlxu4Y5oBGP1mBPyq+B7fKn5Jh4dtlBnV
	 ekgy1SH2jC4KSGljAFkQEiBTGwR1VWot782NbKg060i8coBosZTzJHHy6F3Uq/kcQd
	 D6nu0g/FAhS48IfxJFqlxwBlroDgHH3cuQDfzIj+TMavRGvAfsAkkMiwuUu09qb4WX
	 cLzuxJdD74AZCyL8hTagUfUbvXSzYYoU98GPFIr2D6QQudTo6H/G8OzpquimiqHBOi
	 42v7qLnCSy5eQ==
Date: Mon, 10 Jun 2024 17:08:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Viacheslav Bocharov <adeep@lexina.in>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: amlogic:
 amlogic,meson-gx-ao-secure: add secure-monitor property
Message-ID: <20240610-dropout-compress-6d6a9b749524@spud>
References: <20240610084032.3096614-1-adeep@lexina.in>
 <20240610084032.3096614-4-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4N+yVIGOhUtFEsY0"
Content-Disposition: inline
In-Reply-To: <20240610084032.3096614-4-adeep@lexina.in>


--4N+yVIGOhUtFEsY0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:39:49AM +0300, Viacheslav Bocharov wrote:
> Add secure-monitor property to schema for meson-gx-socinfo-sm driver.

"bindings are for hardware, not drivers". Why purpose does the "secure
monitor" serve that the secure firmware needs a reference to it?

Thanks,
Conor.

>=20
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>  .../bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-=
gx-ao-secure.yaml b/Documentation/devicetree/bindings/arm/amlogic/amlogic,m=
eson-gx-ao-secure.yaml
> index 7dff32f373cb..1128a794ec89 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-s=
ecure.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-s=
ecure.yaml
> @@ -32,6 +32,10 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  secure-monitor:

Missing a vendor prefix.

> +    description: phandle to the secure-monitor node
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
>    amlogic,has-chip-id:
>      description: |
>        A firmware register encodes the SoC type, package and revision
> --=20
> 2.45.2
>=20

--4N+yVIGOhUtFEsY0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmck5QAKCRB4tDGHoIJi
0iydAQD6TLLXFkQ91it+ekcKcRkMfnDbDLyoS4AUCnh1wSh2xQD/RDRupw8OAQo/
Y2gJUImSqXu3pj/lDI8iyrkwkNT8ygk=
=wI0y
-----END PGP SIGNATURE-----

--4N+yVIGOhUtFEsY0--

