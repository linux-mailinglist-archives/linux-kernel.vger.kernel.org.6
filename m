Return-Path: <linux-kernel+bounces-571345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC1CA6BC05
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90A53B88A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209678F4F;
	Fri, 21 Mar 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIpxtmgS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0A12B93;
	Fri, 21 Mar 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564947; cv=none; b=fl38tbxdEdLAguCVsl/CevQ2baP3VdGqi8biJzB4UqUMepQsYo6zTcUX+OFqwC2u1u5uBzwqakw+AQ9oK5zalZ9mvEyc9ohPUSrHC1pgMF/eCx4Q55qEMCfp4W3ZyYABi4N+Q4nT4VeRXMCF0zjeJynJiY5GWIj/Geo9pHfI5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564947; c=relaxed/simple;
	bh=XMf6BryNFVZ63rPqVOKkd17vE8DYqJc2NojkuAUjB+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0/tMXb4P9rKMBZIyGOAYVXwHrOKqIdyETTLYhbHX663X4dMNt88cxWgkK7JBWD6oGQOYAk0yCegkQ7akYhYRPKnpEK89Rupc/ri3jQ9JE7jWjaSSM2R1OaLzwP7mrep1eVTV3euMZ+mcl/TlRJDI+NAM4TWMzaRvWs1CZYC1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIpxtmgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BFAC4CEE3;
	Fri, 21 Mar 2025 13:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742564945;
	bh=XMf6BryNFVZ63rPqVOKkd17vE8DYqJc2NojkuAUjB+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kIpxtmgSUvIqfPCky+wiYuDfxwLx60X0yG9XZjLJePI/+GY67vhxiNJXjbcf8cVJa
	 EYsCBmqEqXoJ0hTlsyO95g8KT+BcsknA44wMquGwqyU67tCUqLvNxNmjpsiQhskmWS
	 DkwcbHQIPPe/JH32WTQX/FO1TmGhDRDrwpUXitBzmvNUqZnpgLV3cxCoPmAZ1BVgXA
	 JKjaGZc/zL93ba5YxtDJ1WZIASp8yRBk9Ngh6+rqk1PHz5oU1W3lJ+bjgajwNhumv4
	 8KBfV7Js27FsbSsiFMulpKvPVFQKQ+2u1WYY5QRslO/qLHgyi4oXaGHXB5CGHHp6aD
	 x+Ktkc+O6A+Mg==
Date: Fri, 21 Mar 2025 13:48:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, vkoul@kernel.org, vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: Re: [PATCH 1/1] ASoC: SOF: Intel: Let SND_SOF_SOF_HDA_SDW_BPT select
 SND_HDA_EXT_CORE
Message-ID: <Z91uRsxrJxz_arjO@finisterre.sirena.org.uk>
References: <20250321023032.7420-1-yung-chuan.liao@linux.intel.com>
 <20250321023032.7420-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vv2JVt9SZzODQS9E"
Content-Disposition: inline
In-Reply-To: <20250321023032.7420-2-yung-chuan.liao@linux.intel.com>
X-Cookie: Well begun is half done.


--Vv2JVt9SZzODQS9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:30:32AM +0800, Bard Liao wrote:
> CONFIG_SND_HDA_EXT_CORE is required for CONFIG_SND_SOF_SOF_HDA_SDW_BPT.
>=20
> Fixes: 5d5cb86fb46e ("ASoC: SOF: Intel: hda-sdw-bpt: add helpers for Soun=
dWire BPT DMA")

Reviewed-by: Mark Brown <broonie@kernel.org>

--Vv2JVt9SZzODQS9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfdbkUACgkQJNaLcl1U
h9Arnwf+KcwvGFYVLtK1K75TCpXlqyoQaeZP6+uZOGuFc8rBVzpJPMQpeGa+C4OV
6lygaI50sQydgpqVLI1QoARXOj9CS2npzZ6TVUIJaMoJdgYNqSU8uu35/gfy+Tcf
95bTpGpl51f0W/SwnzfjGXIw9ra50wfhIT2c372HtcX/1eOOUOKd8jluJr+rUHMA
FYGucQDFGMVbfA/Hw7OQIRDhU+2gsFlh1AFyoTJKTArDayTk8fOh/n+dMsoJWeFN
jzvp4XkqZptx7KtoyP62nCHJG8lTIIdwUEGhsYIiDo3UZuy9EiIlvdUIgGiq50md
NXtPr7P+0OCouPN1rHNerFIcOTLbMA==
=9w3/
-----END PGP SIGNATURE-----

--Vv2JVt9SZzODQS9E--

