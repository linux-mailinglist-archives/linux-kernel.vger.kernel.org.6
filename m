Return-Path: <linux-kernel+bounces-229296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6918916E01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCFDB24E83
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00903175558;
	Tue, 25 Jun 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgrbfoR9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B9172BB5;
	Tue, 25 Jun 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332667; cv=none; b=Kg1o3tLLRXznkVgLonQ1KKuU++My9v3kEY2k1Q24B5IyksxQmy0ZFVCCVnybEyU+q54QEPLaqAC6amZ6snqGCOPhLubczpCfqIjopVkkivzE848gmPdPcLQMvGf0jtZj+CkPOu8Xb6t4nfC8+cWZmTTfTNbvgFHYJa14eua45vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332667; c=relaxed/simple;
	bh=0QVvKqcwgvS3lPG925rDyCTxG1L91/pvChBSPlVGGlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY9aXPuqaGY6Oc7+m0XdSmiDIQmOnpQkgvkFPKSwP4wgltV/72ADJUd4qbAuIHb2//DGqdveDUCDfEHjv2SkHT/kzAdD+/HotiWgVV2JZCdKKuVn4svjqapkTldkzyrYYT4HLRMSA9VjLheipXr5LgnIaVe9+5M1nqd2sX6Ey84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgrbfoR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CDCC32782;
	Tue, 25 Jun 2024 16:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719332665;
	bh=0QVvKqcwgvS3lPG925rDyCTxG1L91/pvChBSPlVGGlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgrbfoR9nl2pf3YsCEgrLtdYt03TOkClt+FHBwHFR27IogxDz+3H6bpqD2iTpit0H
	 r8rAFweOKMdxn8aZsuL+PStcyMdasMLpNV/r99zDsMTymo3xfz/AYpu/J5aKUyp4MT
	 VrZ4wORBzDUXVpLwH5yqjQamuBYnA+kuYQ90mmHD21V0sK0tq8LhHfFA4j9pal4umo
	 eMawEEGfDCt55o1ZQuST4Q47ubrYnEmxar8PWtBtPALlGnvdcTCL8EwAG5Y8nd4Twv
	 b54dKfaPzXX8CTcXIrFrakXDN4xjjW+7EwUtI1ilHxqzOSRDPv69JxFMJg/ucAoKEN
	 R7xCWWCwiKKBg==
Date: Tue, 25 Jun 2024 17:24:20 +0100
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
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add prefix for lincoln
Message-ID: <20240625-almighty-bunkbed-b86cc81b6f7d@spud>
References: <20240625142552.1000988-1-jbrunet@baylibre.com>
 <20240625142552.1000988-2-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tCHnCQa5ruuYmpM7"
Content-Disposition: inline
In-Reply-To: <20240625142552.1000988-2-jbrunet@baylibre.com>


--tCHnCQa5ruuYmpM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 04:25:48PM +0200, Jerome Brunet wrote:
> Lincoln Technology Solutions is a design services and LCD integration
> company
>=20
> Link: https://lincolntechsolutions.com/
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--tCHnCQa5ruuYmpM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrvNAAKCRB4tDGHoIJi
0g6/AP9AwuiZKpmnLuQ+xLr4pB+Cp+y6NaM5yxpKRxqmfPhOIwD+OzslrIUxoNK7
obIe+hNh/+QUSpatoLxVBdcVucPlKAE=
=my+1
-----END PGP SIGNATURE-----

--tCHnCQa5ruuYmpM7--

