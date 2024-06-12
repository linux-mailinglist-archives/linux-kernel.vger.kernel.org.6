Return-Path: <linux-kernel+bounces-211907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFAC9058A8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF50283EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED6180A9D;
	Wed, 12 Jun 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AboZ7OzY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957020315;
	Wed, 12 Jun 2024 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209422; cv=none; b=jXaTD6kFWliROH9kv3BKIcVtpVl81+Zb7FljHQaAgzT6R0QEa2lmAgzWWO40CiynGjbqUhdZWGfYHWiql7qg8CcYLqxwoTRY6a+fyJ80KMU1GuZ8TNSkpvomvoUJOK5N7Dm9UKo2BEzKiBss1QDYdr9VJ9NmDgYOtPil/x8XXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209422; c=relaxed/simple;
	bh=X0/5+Nm1b/oPWZLoKH0sRvgVDCqZffjyPq8AqfHh8So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGjbW6ynNoSCNwo8+PbdBPS59Ia5DnIJV8Yx3r3HbhKpKQnyrFxwAHcfzAzaoD/HF+jCAywfTVTWCiqGi0bsEZXtpP74dNpTPZCH13QQoNYuqlmp7ek8FKtwbx1qAouvTA3nI1/jFrN/g0s7OPwLxK+GUEkgcQ9+CGTu0okcWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AboZ7OzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F699C116B1;
	Wed, 12 Jun 2024 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718209422;
	bh=X0/5+Nm1b/oPWZLoKH0sRvgVDCqZffjyPq8AqfHh8So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AboZ7OzYmfkBwTfZK8oAjsmu1FRiwR7r1E1Ahqg+QqYJDKPmVIoJ0QG0RTmFFmBhM
	 xtmaFsM35oTjnJw+hcCnGLmVjInAWOHI5r4EBZ+Y4QlcVZ/mWD7LMZthx0W1BFyGeF
	 xxrVbKDFaA+kP3lYTKQkKJ3Wy9gbwG8c2awz8gESTVvn4YdcBKIBVwgPp4OyD84qwY
	 mnn5IJSiyfXm1dAqSA2V4dEVA2RKXOoN4LZ1w0yQZjX+xZLs5Ei+IZxXFPaXPk1ypd
	 Tjx/HY/hEvKvqsUWtQJ8dn9HtMjPUbFJQ+1F3MtOc5em6695t+IjOh+ronBAvBdGql
	 pepxhANH78sdg==
Date: Wed, 12 Jun 2024 17:23:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: ti,nspire-keypad: convert to YAML
 format
Message-ID: <20240612-salaried-obstinate-7d740d0e6845@spud>
References: <20240612150711.26706-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="70p5/Bv2FyztGcqR"
Content-Disposition: inline
In-Reply-To: <20240612150711.26706-1-afd@ti.com>


--70p5/Bv2FyztGcqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2024 at 10:07:11AM -0500, Andrew Davis wrote:
> diff --git a/Documentation/devicetree/bindings/input/ti,nspire-keypad.yaml b/Documentation/devicetree/bindings/input/ti,nspire-keypad.yaml
> new file mode 100644
> index 0000000000000..ed3cfff13addc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,nspire-keypad.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/ti,nspire-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI-NSPIRE Keypad
> +
> +maintainers:
> +  - Andrew Davis <afd@ti.com>
> +
> +allOf:
> +  - $ref: input.yaml#
> +  - $ref: matrix-keymap.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,nspire-keypad

Since there's unlikely to be another device after all this time, this
should probably be a const, but that's a nit in an otherwise okay
looking conversion.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--70p5/Bv2FyztGcqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmnLigAKCRB4tDGHoIJi
0qTAAQDGn71uhkPoA4n6qZjtdgRvv0cdsoLDXdVsB3NvLrFqHgEA1JiL7Y0LVhO7
kFPRROyOI6Fg/DBQApJfamM+maAe5ww=
=dqFa
-----END PGP SIGNATURE-----

--70p5/Bv2FyztGcqR--

