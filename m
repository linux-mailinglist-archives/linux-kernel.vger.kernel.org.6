Return-Path: <linux-kernel+bounces-201088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B968FB92C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4939285EB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A001487E7;
	Tue,  4 Jun 2024 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzXHR17z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B6A33F6;
	Tue,  4 Jun 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519058; cv=none; b=XqmXOGn8+50mTK2Llg8y03FlY+R2ImC3o0KdMNpRwviaLxqUCLwQYnVdGPuiS8IGo6Y4vexbxDEdnU2XdyRXPSJknkH5o2OLaQDYobDFsojyedvaWmWv8Alc8O7bk+DfRmhZztr29UYQDsNgM0jYEGzNJopBX5pDfWpegmXeDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519058; c=relaxed/simple;
	bh=Y7+FgLP6I8iI3gluqNCiw0N+h9DglAWZrrm+DHCQYzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0WW2WUDYeCus2Ou5Baxp+gFtice7wUx6osFPLjvWYitWfFt/ZuZL/vzgSa1Vu9q44uHxsiV5FkE++LuIiyx0luHgiHDhA3rBdxGHy0D2KVSUtS0cmK4FjSuKAwxlwBrF/QrOZYvmP3OJAhYUZyq8i6C4cSbp/tdudn5Vy62uKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzXHR17z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F359C32786;
	Tue,  4 Jun 2024 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717519057;
	bh=Y7+FgLP6I8iI3gluqNCiw0N+h9DglAWZrrm+DHCQYzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzXHR17zM9MO7WcS93M+5rYdbppUnueqnF3e66ILV8dNc6JwpFbE10Uuqp1AbSWkV
	 jvLFa3rayffCWDjtCeluxzx5xNUuqIp++haB4igQGRAWPK+eBNO7xZZ3pWQ5hK49W4
	 /KJ6muSyaQXjHng54GMm60gSWSne+KcM8VVsimD5QABIGGDVYUrRFGHnB2MAdRSGeP
	 tAWgnB2lpPn6UTBLqK+LTazcK7+mkwdMDDmr9ARkq9gBusUfZPtw9acdl4qkkErNWE
	 fIExAHW9EeNLtr5Tu4FbvGzlujfx4bDgrpoLlop6xGTbMqr8Zt1YpNATORXUSlfx0s
	 oZXYaHtLp7z2g==
Date: Tue, 4 Jun 2024 17:37:32 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, steven.price@arm.com, matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-bifrost: Add compatible
 for MT8188 SoC
Message-ID: <20240604-etching-shrunk-162bf233f483@spud>
References: <20240604123922.331469-1-angelogioacchino.delregno@collabora.com>
 <20240604123922.331469-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZNmaHLwdV+0Ezx3e"
Content-Disposition: inline
In-Reply-To: <20240604123922.331469-2-angelogioacchino.delregno@collabora.com>


--ZNmaHLwdV+0Ezx3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 02:39:21PM +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible for the MediaTek MT8188 SoC, with an integrated
> ARM Mali G57 MC3 (Valhall-JM) GPU.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--ZNmaHLwdV+0Ezx3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9CyAAKCRB4tDGHoIJi
0oOXAP9m+tBb+Ha+VYSTduN6nFhe1pWIbILjHx6C4dAD0iWh0QEAuYAAlRVVGxPw
NPLSMqfSlH7QXMhB4oIEvdfuTrfDIQ8=
=meGF
-----END PGP SIGNATURE-----

--ZNmaHLwdV+0Ezx3e--

