Return-Path: <linux-kernel+bounces-192587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527EB8D1F70
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0315C1F233AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E923716FF47;
	Tue, 28 May 2024 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhadhZBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562E79F6;
	Tue, 28 May 2024 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908469; cv=none; b=VM2x7ZAaI3Zr5AZLwRmu8yAHwRMT7MjsdhWHL0HnQ0qI/SfNJN0tZsa6woW6/Z16GZIdA0UxN3Fg2411QzM8bOy0fDFG4K1RuRV5Zxl3IziUp+U9p+fYMJfgt4kXqte7yfLg18uK8k3f/Ixt1CxJekZ1GyKh2K1dLAXrdQg8+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908469; c=relaxed/simple;
	bh=griTV/d48tFOAXbKZWjbvzau5IV3Ow0cB3k5rjAzDCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3FcH/0LZvFhZf3oaqYqhhPZB073QYXNPxFf8HNv4iJEebB9rP8nxBJP5lKv8sw6eb2uDGuJ1WL3oBHp5Fu2+oABMsYsJid+jWRKH+iXxfFeSgVuZrk/FrMKmOol9LKtUPQGsuVOj5SdgSV7+SJPo4Ld0TKu3evLeUAzRVayOIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhadhZBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70411C3277B;
	Tue, 28 May 2024 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716908468;
	bh=griTV/d48tFOAXbKZWjbvzau5IV3Ow0cB3k5rjAzDCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EhadhZBeE18WbKLGgiooW0VxGSBMEhOGF0MwqnuuP6kyWUWmWddS1L6G9AB8+8lm5
	 jd1V5dCU0ZRklMWsON+LU9+l0O1ByZ/Y/GmZcuj+JmkXJ4KJgwz7ebYT+N0RXxE8Ho
	 RYFvX1N6JjSPzDnv+ut2SQFeIBGkeyW1blw4RemLnIUH0d/6ZH6f4/2NPFmLXfsiEJ
	 4bf9tDYqxR3zJ40ngwSx60e5oa/NG0NRfU5cYq8NB2LXw9ECQLxIAXSdmyIMlO58s4
	 i8JBbcvamnRvXTHGyIgoaPbSQs2UO3v5DCr+FVPkSJNsHSi2QUHSpSBXpUn9MlF49l
	 fsEWFwyBrCeKw==
Date: Tue, 28 May 2024 16:01:03 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, steven.price@arm.com, matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: gpu: mali-bifrost: Add compatible for
 MT8188 SoC
Message-ID: <20240528-flattop-foe-05d6ba73cc06@spud>
References: <20240527092513.91385-1-angelogioacchino.delregno@collabora.com>
 <20240527092513.91385-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lmQ6jMLH/WOT5YCV"
Content-Disposition: inline
In-Reply-To: <20240527092513.91385-2-angelogioacchino.delregno@collabora.com>


--lmQ6jMLH/WOT5YCV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 11:25:12AM +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible for the MediaTek MT8188 SoC, with an integrated
> ARM Mali G57 MC3 (Valhall-JM) GPU.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Chers,
Conor.

--lmQ6jMLH/WOT5YCV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlXxrwAKCRB4tDGHoIJi
0gxEAQCJxm0YW/F3sE3EG2ygW0Xz2I0KMa2JKGoLWElXy5gVRgEA4qAauCj9sAWK
GjEwoDHxelJzjM0hfALT/Qy2rP/GQQg=
=atEx
-----END PGP SIGNATURE-----

--lmQ6jMLH/WOT5YCV--

