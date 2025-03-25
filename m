Return-Path: <linux-kernel+bounces-575004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF625A6EC75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC0116A1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0818C1D619F;
	Tue, 25 Mar 2025 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivr42c1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A139479
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742894965; cv=none; b=CJBqSkBlVlbtjmAHrjRrEXfra84BmN92bsfqYQbyjhIfHjbyY1TiiNOri17jDgInbA2h/iGEnS+OXkzbrCGuhslEorrWVnxv0RHD82aXsMedkDG8diDDBCo6LRCvHfGQWXKHPTjq1ARSqKYohk1AMMYTNkkP/TpQ7pc0XD1DN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742894965; c=relaxed/simple;
	bh=pQJrDsIRCGcaaAOV8R2YCpZCdN6goihWB6J8Dl3Ulgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b67yqomE9HSbuzndYHB/LBsZ58ToGZkSEUu2V2j15vtjpBplGePkZLOVLsfXAaWUod7Y+RW1zEyfCLM0Q5/MVgI4C5AGc2PA/cGZYPB0MarPy90x28oljztFrT+/Ja2Ht0g56uJcHM5Zjiob80g02pPTBdetc37HlsqoMMKN/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivr42c1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766B2C4CEE4;
	Tue, 25 Mar 2025 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742894964;
	bh=pQJrDsIRCGcaaAOV8R2YCpZCdN6goihWB6J8Dl3Ulgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivr42c1q3TF/Ref7GLfnx6ku/lWFi6YTjMADcS4+j5HlJRoR6WlK1Si9vGi8spEWc
	 3tj+modCybXkdT89qZc3LEaNcZkQrKt1xmIny27eGo61yrPMqzbJMKxRBLMHTlAA+T
	 Fbeernee2cE/MUkgn7sSo3/u/FZsoowco6IoN5FVQHEo/ZKI5SA47HVNISlQyEzjdR
	 Pi/805PKncGuqPVgihrGWqyifkfiDxQ5u+QFFo4ZdUJbtnnNFOHTfHhgIys6TCnLYU
	 HnqfNm+RH4MwcL1cxrPE21JtX2su2QMZ6sZcVOKW2NZqdq3LattlqdGhoQ7X9UqL7g
	 U23wM7Rh5EUEg==
Date: Tue, 25 Mar 2025 10:29:22 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: devbrones <jonas.cronholm@protonmail.com>, 
	maarten.lankhorst@linux.intel.com, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: Add non-desktop quirk for Playstation VR
 Headsets with Product ID 0xB403
Message-ID: <20250325-inquisitive-ebony-mouse-bdf185@houat>
References: <20250322122048.28677-1-jonas.cronholm@protonmail.com>
 <875xjxa2rk.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7qo75eqjhxv6bcp6"
Content-Disposition: inline
In-Reply-To: <875xjxa2rk.fsf@intel.com>


--7qo75eqjhxv6bcp6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/edid: Add non-desktop quirk for Playstation VR
 Headsets with Product ID 0xB403
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 11:16:47AM +0200, Jani Nikula wrote:
> On Sat, 22 Mar 2025, devbrones <jonas.cronholm@protonmail.com> wrote:
> > This fixes a bug where some Playstation VR Headsets would not be assign=
ed
> > the EDID_QUIRK_NON_DESKTOP quirk, causing them to be inaccessible by
> > certain software under Wayland.
>=20
> Please file a bug over at [1], and attach the EDID on that bug, so we
> have some clue what's going on.
>
> [1] https://gitlab.freedesktop.org/drm/misc/kernel/-/issues/new

I'd rather have them in the commit log. Nobody uses gitlab issues for
drm-misc, and those kind of issues are just lingering around and
becoming stale.

Maxime

--7qo75eqjhxv6bcp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ+J3cQAKCRDj7w1vZxhR
xVu5AQCE0X6uHOBYnSGbZVafc3oq1zchZWFptDTLm8soyrkaTwEA871ESHNjC/Rb
Liqf9nI8u9d/aG0iVns6ui7AspsgQgs=
=ijSu
-----END PGP SIGNATURE-----

--7qo75eqjhxv6bcp6--

