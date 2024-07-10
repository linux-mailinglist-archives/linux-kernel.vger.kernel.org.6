Return-Path: <linux-kernel+bounces-247122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3523292CB85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40D9283D39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1ED80C0C;
	Wed, 10 Jul 2024 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMbZNrIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B298BEC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594841; cv=none; b=jJYEtOIr0owJ/C49AjgjfWb6uxpm4Rxct8DdPVWj0LJV/owZOf6DCvvL5S6RDl752ulWT6ZcM7N77uBjrFmHZMpHvh3ckKKyRrqu4qBApZVm5wpW7CljiWIGqLjHf25AQYuw6ym2piZPNxQT9VsVBJUVlUPUKVCyVhsb0kNlkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594841; c=relaxed/simple;
	bh=x8GBngejj0m77ddusgbzZvxU8YJqB49Y9l+UOIB4xmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec0Rn41kMlKj3TZY2q8rC2VAkomtwvCmzYt9dNMiDIYxrhqx5ea65G3YpU1b3vNgq0IpyDV2FvoQq24kExFkEgcJXkj6X09Gf4HcUUATHBQBqRfnRJWA3EbQG7DkWKgB5gvPcUSQghj+2kGwHBK6a3Zz9XGmRFvGDjpCM22nWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMbZNrIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71010C32781;
	Wed, 10 Jul 2024 07:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720594840;
	bh=x8GBngejj0m77ddusgbzZvxU8YJqB49Y9l+UOIB4xmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMbZNrInU+R3SFzHh1k6lwaOD7cMdHRtOLtPAfepFHCUCGV3m2QhuaxfZmACJ95Pu
	 7EMjTYfHHKPtlm8Rm8+BbFK2VNR6rzK62fBB/qCq0KC2q4ZEgUqYAqnJCcjKgkD6zi
	 W3AFN5eqkm+yZVVWcLuYiDTL4k2okPpT0a7dO0D55hfhWJ/9D4YD1LIA/wnHPaS7XM
	 Pa/VLN1d37xlf53TITz02NTWdTf3qagr0Ng+6kCaHquQEtkgFQJslS7XJb807IqIMa
	 2PTOdrxyjUKvjz5/OdOk3hTWn/p6IZl8BDyDD98WhrcPo4cdf2+aYCorC2TGcoqriV
	 y4Bm3wZMTjiEQ==
Date: Wed, 10 Jul 2024 09:00:37 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
	hjc@rock-chips.com, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/rockchip: rk3066_hdmi: change to bridge driver
 mode
Message-ID: <20240710-daft-brave-woodlouse-eb76b7@houat>
References: <08fc2878-722e-4884-94f3-19ec4717cccd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="55im7zqn4h44tcza"
Content-Disposition: inline
In-Reply-To: <08fc2878-722e-4884-94f3-19ec4717cccd@gmail.com>


--55im7zqn4h44tcza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 09, 2024 at 08:01:26PM GMT, Johan Jonker wrote:
> Change rk3066_hdmi.c to bridge driver mode.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Generally speaking, I think you should use the new HDMI bridge
infrastructure that recently landed in drm-misc-next.

Maxime

--55im7zqn4h44tcza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZo4xkAAKCRAnX84Zoj2+
dryRAX9YiJOsTbpyWzR2aqSOG506OuP0LZ1kg1b+brmWtuQR3QWgW3B3LGcd5c0Q
IzhZ+zEBfjJE9PFtVPe+zJqbdBk4Td9pLMrSbYo1e0i+pLwapXFH+E4Mo3k5i9M8
ZiupE7/QtA==
=elhX
-----END PGP SIGNATURE-----

--55im7zqn4h44tcza--

