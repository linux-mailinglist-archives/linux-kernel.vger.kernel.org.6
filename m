Return-Path: <linux-kernel+bounces-423630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E789DAAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022061679E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886211FF7CC;
	Wed, 27 Nov 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puOXGKqF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76931FF7C3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720863; cv=none; b=L/8aKxa7Y/da7gQ1rDLnQeu7dYKcQezcKPNkOtSdnYqrLHNYguakUewmTIR13071697VPq31oQrK8POprEKjq5YeQZY4CK2j1nnj6gNYXKZ7GD5dc+SPxf/Zsdx/V525fhwpFp1ow42YF0klbYz00NtrtZ+xXmhccVVXquGg5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720863; c=relaxed/simple;
	bh=oLpo+hWAgB+0siG+hnBSnXiUeJoq42VkWg/Lo9jL3Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzvjLyquKxlzHFOegiDAXMx8G1DUs7jhcXnVBoFyyxZ5qx+qCITIanAiuiRtd+y1LDUh23PJwaVg3I0cgQ4I8+0Ew2R4++APoTJG6zUo4cFXo0HdKKZ9iRgJDi3IdKokNWQBFBDsfkA5ORseedIgCy4vBVtZLP2Hq3xiy/Ner6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puOXGKqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17077C4CECC;
	Wed, 27 Nov 2024 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732720862;
	bh=oLpo+hWAgB+0siG+hnBSnXiUeJoq42VkWg/Lo9jL3Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=puOXGKqF5ksn1wblnOcY2BV7BD2hEY/PjaVbaN+hAVlxwkGS0FpNeONX8QwQ7qur7
	 yhSByGKFSXLUkUUpN2RKWdm2kPqdc7XHB2oYqjgBb6mkPjZ07SCnTGKzAB9ijG5DZ8
	 /cewMaPyrYnZOUvPMzn6C4tbgo//s+dFcbcXQJqC6JUIkjHMPzpDMjxygqfCQkojID
	 HuadncSYPfE02KOcwaRevfNPCCf0sBxzHJ3w2hqx/7bBHcUh9Mx5kcXmkF5ZIjnqXg
	 XGqRCkhT3+fuKVThkldBn0zSIq5lccl8nERIlK2BOo0QGhJElH7p8CQq00TMTojKZK
	 PC1iuy5aHH7Ug==
Date: Wed, 27 Nov 2024 16:21:00 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/vkms: Rename vkms_output to vkms_crtc
Message-ID: <20241127-aboriginal-spiked-centipede-cabef0@houat>
References: <20241122-b4-vkms-allocated-v2-0-ff7bddbf0bfb@bootlin.com>
 <20241122-b4-vkms-allocated-v2-4-ff7bddbf0bfb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="umgahrspnwgk4kha"
Content-Disposition: inline
In-Reply-To: <20241122-b4-vkms-allocated-v2-4-ff7bddbf0bfb@bootlin.com>


--umgahrspnwgk4kha
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 4/4] drm/vkms: Rename vkms_output to vkms_crtc
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 05:35:12PM +0100, Louis Chauvet wrote:
> The current vkms_output structure only contains crtc-related members.

That's not true though? There's a connector, the connector's workqueue,
etc. in there.

Maxime

--umgahrspnwgk4kha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0c42wAKCRAnX84Zoj2+
di2IAYCNsqVrXaL8QKjOZw5i0osxjLvTGT3ohksTk4Zj5bIm4IEGtJ0YI+Xn90dH
Q8ljx/gBfjTY6PHH9jJz0+2aX68O4rXlj7iP6f0SBFqF/R2EhaeDh3HGjt3g2ts6
Gi8ti7HFnA==
=pbn6
-----END PGP SIGNATURE-----

--umgahrspnwgk4kha--

