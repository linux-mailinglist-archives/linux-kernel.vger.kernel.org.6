Return-Path: <linux-kernel+bounces-289602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2043C954807
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0670283D77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA7C1917F1;
	Fri, 16 Aug 2024 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw+HXZxx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9C817;
	Fri, 16 Aug 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807550; cv=none; b=MAr6W0gKHeLon7zNEuIQA3gvjaAsqlXi0bFFFgGZ9qgZoyAu50HjPhO9hNodsqlufXShWjrgNhsERy5pdc8jaGUL+zhvlTpU3Ip/fogTEEWo/piJWNdcCyAJQdRbBy7tALA79MoKJtHVG0HTAP72yYMwZQRVvDa57QaYV3CBYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807550; c=relaxed/simple;
	bh=zGBmiufFWB1qORJqE0Y47lGuLk5Hkpu3ssKQ5ejIvps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ES+ws3mr+/Map3w1P327mgn1AZbm8oIe2kO6V4ljmSiVuBPe75JcPUBq43Sand+Ywr48INS6KuKV7YvXtA6hUwqxWHSUFfkFJS1TtsdBKR4o6S4gmlNHGNTv4g9jEbn7UffKCqc+qJrH+GxXBScvu5O7riDVPTZnzd/I5ulsIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw+HXZxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD59C32782;
	Fri, 16 Aug 2024 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723807549;
	bh=zGBmiufFWB1qORJqE0Y47lGuLk5Hkpu3ssKQ5ejIvps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jw+HXZxxi0vBn+UPeR9K+moRgCK/sYBixvT3+lGTlupo8aZHhwXPicpAUUNf38xFB
	 XW6xufS9Pxsxgb6SjYkm1DH4s5oeRGaEGtJHDdbJ8HQ6tp+7KhyOLOYkuBNC+mZhYP
	 dNmoHOCqtBiaC26tmFsqAzfVUQljRYHILGEAb5rKJCnc+pNmoEkWCnGJO/XacUGUwl
	 SKNegtMqBvWZESNXxSB56st+Ntv5sELQ1EMkjEQebmAZW6qOlCaWvPslRg+l57Lnbs
	 Vg/lMBaAleuzcYYxA20lKVdmENmsFs5kOeWMAwJ+VQqo73UFH53s4pEcRnDIxGzdtn
	 fTNxQbr+pVjrw==
Date: Fri, 16 Aug 2024 12:25:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, vkoul@kernel.org, vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org, tiwai@suse.de,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/3] ALSA/ASoC/SoundWire: Intel: use single definition
 for SDW_INTEL_MAX_LINKS
Message-ID: <19ab3bfb-cc7c-4f3d-84bb-ef35d8849064@sirena.org.uk>
References: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
 <20240816023331.6565-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cht0WOIPE29U/xlX"
Content-Disposition: inline
In-Reply-To: <20240816023331.6565-2-yung-chuan.liao@linux.intel.com>
X-Cookie: A Smith & Wesson beats four aces.


--Cht0WOIPE29U/xlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:33:29AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The definitions are currently duplicated in intel-sdw-acpi.c and
> sof_sdw.c.  Move the definition to the sdw_intel.h header, and change
> the prefix to make it Intel-specific.
>=20
> No functionality change in this patch.

Acked-by: Mark Brown <broonie@kernel.org>

--Cht0WOIPE29U/xlX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/NzgACgkQJNaLcl1U
h9DnGwf+LUX+JoB8jRWojBPjSAqpLjWlqeTf7t4lBfGo0LaEqSJjURWw+4y9CCWf
EE1udx0SCAXnD28vHN7vke+tD3POf/Cpo7PyabnOdw2HKA0PSTMTuJgH7i/KuY6K
EqJLUKMqqVhFhAmCTvcVaXZC3pIiwuLIttI7/c3Fnch2h8VVfaBCleAR3OCN89/Z
Vba3ddiEJNiENK6s3b4YRPqDLEiDpA63NgmTcNgliSvYL7hLYRAa9uUzkYAOc9OG
7kkBjhNTBA4pUMhecSaLDoOytPI4i/vivNfu7UH/MUPTSjCuPh/HI9XAEzOLZEpP
YCe/OmMri0yobpJfLmhTSzm/EJGHUA==
=7yUI
-----END PGP SIGNATURE-----

--Cht0WOIPE29U/xlX--

