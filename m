Return-Path: <linux-kernel+bounces-380380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B508C9AED6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BCA1C238F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A3F1FF020;
	Thu, 24 Oct 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owkHAY8B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0811FAEEB;
	Thu, 24 Oct 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789888; cv=none; b=tKrVzH9Px80flAmVF7knZyMuYPa7AmvnvxdOBRqIMwW7Km4EiWspsqrYQddOXvCBt8cGqp9vnm3JUKvmpP/yhITUNKluxxJaYy0Ch2u65L+O1L1C7OVYqY809VV9vnsXEzb/MLnnNKtkuXW/Gc5wSvCmIC/mKCRnp8taPtH2m7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789888; c=relaxed/simple;
	bh=1WdqHo2HGJNMs69cX9FV+ZG0Dwq2tMCHFmlCiNatbhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNRbYkZO7xsq6yoWH67CuTWC8YmquwcI8DMrNFjNO9O8YExJI6bzc5XMbpsDf0YOY3dWl8HT8xac7A9WA5as0VusWoMVGI3rhhMIzZFbGRax0PLKZ5jKgnx2DrTYtvIfCA+WMhVpTmXm8Ccv5CWmNlXfMZISmtrdqP7z4c9hqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owkHAY8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE66C4CEC7;
	Thu, 24 Oct 2024 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729789886;
	bh=1WdqHo2HGJNMs69cX9FV+ZG0Dwq2tMCHFmlCiNatbhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owkHAY8BWsoaieEkorRl9l8idOW8A7qWWrzJrQYEaIWd3/AiHDETi/2T12XOXPCAG
	 2OrsyWVwm/2tNVdkY3IKD7AucgATNf06M2nRpRQnjhoi3CHhCBBNhJdsKPn8B39DMp
	 cVlbGvcZ0medVgSlP9EmuiAvsIjzUhqG8QsJbuP0WXri0Jk9QHv8WlneCPEDeWsUsv
	 /a1AmGH1nP6OtGRUfiLt3Stk68BZ4iLVUxDahrdIwh2eEB6eIKCcis23ejYTkkSWlz
	 7FCKNWdglX+tdJLNtUaHQMPLV6eGguo0DWAxwxDvI6TbeL6+0Glb3G3k/qaS9GTj3K
	 8B6uEiNuS2rYw==
Date: Thu, 24 Oct 2024 18:11:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: tglx@linutronix.de, daniel.lezcano@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: timer: fsl,imxgpt: Document
 fsl,imx35-gpt
Message-ID: <20241024-plaything-failing-8a91c9b051ce@spud>
References: <20241023185841.1183706-1-festevam@gmail.com>
 <20241023185841.1183706-2-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ht6i6mn5ygm0dad1"
Content-Disposition: inline
In-Reply-To: <20241023185841.1183706-2-festevam@gmail.com>


--Ht6i6mn5ygm0dad1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 03:58:41PM -0300, Fabio Estevam wrote:
> The i.MX35 General Purpose Timer is compatible with i.MX31.
>=20
> Document the fsl,imx35-gpt compatible.
>=20
> This fixes the following dt-schema warning:
>=20
> timer@53f90000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx35-gpt', 'fsl,imx31-gpt'] is too long
> 	'fsl,imx1-gpt' was expected
> 	'fsl,imx21-gpt' was expected
> 	'fsl,imx27-gpt' was expected
> 	'fsl,imx31-gpt' was expected
> 	'fsl,imx35-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', 'fsl,im=
x51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
> 	'fsl,imx6dl-gpt' was expected
> 	'fsl,imx35-gpt' is not one of ['fsl,imx6sl-gpt', 'fsl,imx6sx-gpt', 'fsl,=
imx8mp-gpt', 'fsl,imxrt1050-gpt', 'fsl,imxrt1170-gpt']
> 	'fsl,imx35-gpt' is not one of ['fsl,imx6ul-gpt', 'fsl,imx7d-gpt']
> 	'fsl,imx6sx-gpt' was expected
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Ht6i6mn5ygm0dad1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxp/ugAKCRB4tDGHoIJi
0jDVAQDnbXO317H8zdaeX6UW4R5EaUI7ZGJMBdt9kKnxIZqtWwD/XO4mTjtsDeiy
15VLLZlDLydimwb4mDZ+RxWfDQJOcQI=
=GZyF
-----END PGP SIGNATURE-----

--Ht6i6mn5ygm0dad1--

