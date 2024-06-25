Return-Path: <linux-kernel+bounces-229297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF481916E04
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8211F27F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A2173325;
	Tue, 25 Jun 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR7IVHvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01D49629;
	Tue, 25 Jun 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332690; cv=none; b=ezZI/scUNN0okW9oDedhfFZRB8kjkb5XHHB6kGEH/fSt4vOv+9ZyhI0cQdye6GdxKHoR6WVbnZKrMRfFEimc0tb+boP2y1KAiYHpE7atEo9sYnKoxXpR0EsmItiG5xvU+tLGKlI5H5W2kdbsqMsotpaPIpdYjYyo+VRb3JV7BLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332690; c=relaxed/simple;
	bh=lYDZtizy+im1T5YJ4mo2HhxfZZpr37Ozz/iQz39NWs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL+N3VJhtAt25Dpub6f0OSNX+hFg8d2UYb3NKB3Qsx6onBjMD4llqDxA9+lUI2BJOyocaeguQA/egtnzuLBV1Db4u9xI8YBHtQy3AUPEkGHbKnc++kGH84LYYt4rcNCAaH3pVzLqnwCsjboMGXbG0zdauE5Jo19DR1akQ+axMM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR7IVHvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AD8C32781;
	Tue, 25 Jun 2024 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332689;
	bh=lYDZtizy+im1T5YJ4mo2HhxfZZpr37Ozz/iQz39NWs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bR7IVHvz7zvwwpZnNmTN7xLrDnYTwByGNkr1jO/jOMCJHEaDyfsaA6/hSd3lnA8zI
	 3DP2SVqQKObxwJRtz9aTgovlYpeLYUMKxnvmUiuIVEXO/Tjltt2r1xXeVQTkKw83qx
	 pLN5nPjmXKZYj+mHEWHjEwo9OJBggqK/QXkXaRMBG8ltms3MEcbF/1MZHHQ9kMmEda
	 Rl1mSkObSDTftIm7thxqE75oNyBiRM0uYnakLPmglWIUgeuMUqq6YWKtC+p6BdQOiV
	 ZlELPAQqf4Jvvv+/RKvDisQLf4LXcFOOJcY6MUHc4D+cNsGpMtEoyA7LP1y/GSbThC
	 q7064K3T1BuHA==
Date: Tue, 25 Jun 2024 17:24:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] dt-bindings: panel-simple-dsi: add lincoln LCD197
 panel bindings
Message-ID: <20240625-strife-dynasty-1b9d28f937f9@spud>
References: <20240625142552.1000988-1-jbrunet@baylibre.com>
 <20240625142552.1000988-3-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XenD3tfZ7uLpcvf/"
Content-Disposition: inline
In-Reply-To: <20240625142552.1000988-3-jbrunet@baylibre.com>


--XenD3tfZ7uLpcvf/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 04:25:49PM +0200, Jerome Brunet wrote:
> This adds the bindings for the 1080x1920 Licoln LCD197 DSI panel to
> panel-simple-dsi.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--XenD3tfZ7uLpcvf/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrvTAAKCRB4tDGHoIJi
0iaYAQCiFHD9IPGVzSbTPfTJrD2IbShD2Jmo8vjuglk8LNwNkQEAwqlMbOuWq+vX
B/r+amw8NtAdsB1hFHVlXxuPPc1lhgQ=
=fGVq
-----END PGP SIGNATURE-----

--XenD3tfZ7uLpcvf/--

