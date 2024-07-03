Return-Path: <linux-kernel+bounces-239731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE892649C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0922B1C223A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA2181B9C;
	Wed,  3 Jul 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAydLkCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E45180A92;
	Wed,  3 Jul 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019613; cv=none; b=Sd/wx4z2l5BW/38MgmIFJngrc1KNag0NRBIPD3kuhGnCiAG/PVNBcW6Ad08jjNCJc3tYM3x4HSr3ZJCGXtr+XTZjxDwCsDUT8OaIXXIcZXtzqwegvZqJI8EEhlk/yCsUg5c+T3ztj33HhgZCknsA9zwm/9ESNEyx0AvXe7hwZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019613; c=relaxed/simple;
	bh=Q5QXeckq+uzJ3iLBFgmqaQoU67PR7ujYRkejbXOVseI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rbvv0hEEMbCxhLYtSIqkfKphOpwCKomctFOCjOjLIU6pF3J0qeaBsPQS+J/RTqITZDF2gBTcZYBQVEjJvQamKUsCcyrrd6Ptihz7a9QGK//R3VoBFLdCgcW0PM4RldYFqlca4UmT1+px62IGf1wm5C2F5RRwB5p5rFM7IGDGuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAydLkCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE1FC2BD10;
	Wed,  3 Jul 2024 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019612;
	bh=Q5QXeckq+uzJ3iLBFgmqaQoU67PR7ujYRkejbXOVseI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAydLkCH7NrYcx7tFvUrYpuTzMcsfxFcNISyOv+2XofNGe2yNefXoRYIqJ8wGFOsF
	 TicYHRmZUvr0renf29m/uEhpOR93NZxaaroVR0vfH5Dz/TaWJ04l9DBvCZaTEwKYtZ
	 /W2BQ3pCdOrN+rglgAg1nN1bVBdO9X7pBkxkLsC8X7KtfXMjld+mD2+UM6odySF8gY
	 ZYLE/TMxtu+8Uk4fi/NhEKrnfAxY8RECBx4s6GlUiM/GefgZQqKPhkE1mDIxyrrD6F
	 p+y01eh8ppyE8VacHvta5AxWAEwO6XQSGIqzvtof9w3Od9CxZlGV/THnnXhYw8gjmz
	 u7qq3+cd/dDkg==
Date: Wed, 3 Jul 2024 16:13:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: sprd-timer: convert to YAML
Message-ID: <20240703-slogan-reawake-413f7db2d065@spud>
References: <ZoU95lBgoyF/8Md3@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gv8gm/4CVXynuw1q"
Content-Disposition: inline
In-Reply-To: <ZoU95lBgoyF/8Md3@standask-GA-A55M-S2HP>


--Gv8gm/4CVXynuw1q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 02:02:46PM +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC9860 timer bindings to DT schema.
>=20
> Changes during conversion:
>   - rename file to match compatible
>   - add sprd,sc9860-suspend-timer which was previously undocumented
>   - minor grammar fix in description
>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--Gv8gm/4CVXynuw1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoVqmAAKCRB4tDGHoIJi
0kSWAP0ZO7U4OqQw/vPrqmpiEs+BI1Cu4br9uvcpBJMvdGtZywEAvBvbrvTkSB7s
6qble3XTWwW/zR2cchpH+LC6Dz515Q4=
=v6j4
-----END PGP SIGNATURE-----

--Gv8gm/4CVXynuw1q--

