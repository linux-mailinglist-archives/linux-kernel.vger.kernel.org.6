Return-Path: <linux-kernel+bounces-229294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1F916DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F6F1C22324
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54DC172BC2;
	Tue, 25 Jun 2024 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCe+ijNM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843C49629;
	Tue, 25 Jun 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332623; cv=none; b=byowBXlahRJRbdaMzjIUwbWum0FbVqga76gcLzgtdxtlRrwoTrxXDAutgB6QDAQTwDb1rtxwCWtzH+PqAfTX8WRohKaOe/nNePZf58xMt+eGCvf0B5WwdfF89CWb202WOqmyrTMdCn8+EwoLrShikkMN37SNFlBTmUlamrRMed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332623; c=relaxed/simple;
	bh=T6WcmYyrG4RDnVy0C9I1xyHe/lqPeAD4ypoU12fA2sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh5ATZeA/HmOz7Dl4z1HMDeMbDRo3lLlPndwoCdLhhUUWJ9uJWH+GNzzAC6BAzZUERrxMNfIUf1vILOLHMfpV3EdARisLu204stZMGNOcsyd7c8BZpMdqFW1aoDfXtVqdXAE31Q+UKqyEv7F9K23xrxbyPCe4lN4KaiBAIUvb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCe+ijNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BE2C32781;
	Tue, 25 Jun 2024 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332620;
	bh=T6WcmYyrG4RDnVy0C9I1xyHe/lqPeAD4ypoU12fA2sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCe+ijNMzfgTJ8otc6zD+pzRapbGk8sJQ8A41JfbOlO4wTgmQSH4RH3QrTP8eyzmo
	 M0KTLmYsBNKMlM8tNqcpHQJR7XmMgT7RM+CMlPWTuCgI4yB3hJzwPZGlsUVwcXMzlJ
	 +4GwL1Up06l+dkuzxzIW2wZ6GxHU1Evns7R5+bcZNaM4NZpPmXOn7SgwdfcVUBxkHZ
	 PaEeDjt3vxoNe8KGCyj7AS1PrxRkUobtWC/xfnQyljoK5Ds0iffqi+J0juuviWEZ4y
	 LJB3UegpXQESQu+qTblA0t/hv1+IMomRPs/evTRhpSOZPlTBqG0HYLpv5RCRc0U4hM
	 46HFiD2YDSQZA==
Date: Tue, 25 Jun 2024 17:23:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] dt-bindings: display: meson-dw-hdmi: add missing
 power-domain
Message-ID: <20240625-growl-unseated-e612193d93bd@spud>
References: <20240625145017.1003346-1-jbrunet@baylibre.com>
 <20240625145017.1003346-2-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ryZ1T0F0MK8qog8O"
Content-Disposition: inline
In-Reply-To: <20240625145017.1003346-2-jbrunet@baylibre.com>


--ryZ1T0F0MK8qog8O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 04:50:14PM +0200, Jerome Brunet wrote:
> All Amlogic instances of the Synopsys HDMI controller need a power domain
> enabled. This is currently missing because the Amlogic HDMI driver direct=
ly
> pokes the power domain controller registers, which it should not do.
>=20
> Instead The HDMI controller should use the power controller.
> Fix the bindings accordingly.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ryZ1T0F0MK8qog8O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrvBQAKCRB4tDGHoIJi
0j6wAQCWm7LMe5lduj3W/J09vudOmNS2YYempj7Y7+BPJ0R2gQEA1WXqC9XZoQ97
I4MAXT7SsMcT9W2RDG9SUfFvkITeNwU=
=UL7b
-----END PGP SIGNATURE-----

--ryZ1T0F0MK8qog8O--

