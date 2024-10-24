Return-Path: <linux-kernel+bounces-380362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBC49AED15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3421C219ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5161F80C4;
	Thu, 24 Oct 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWfTNV4Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE61DD0D9;
	Thu, 24 Oct 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789504; cv=none; b=FRYjEJOBZEIlq2jd063V2nnT0P5RyAtxhOZ1XsKLter5CWFwdNnEYTHvP1WEGh6hO2H3vpYSMY8qt2sKUtN/8caev7BAvCPW3hZ7mJWW0HaVQbvb2nhH7rFjcV95G7hu1VmBVGUiubH4DQTB6dDKLtuXRH3yPWRAvMhelsxZIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789504; c=relaxed/simple;
	bh=N7N6QXRB+ovyAVDEtuqEAO0cC0MzxLTBg6Wql3hIpG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2sbmbdgZPFipOEBF88i/9lqL4Ky4MaaOp7rm4CAO9qDZESZCz0hxK0wVc9+7kN5U0kchTrkqidgffSxQx7qRQj2Uvl06bFG/b4VjTiUpPcaMQYpmAEUuTYlr/HT7BoyGQwcK9Ix6iO+Eq6tt4oPFnGcbWmdAdJBnP5MbPcWB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWfTNV4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A6FC4CEC7;
	Thu, 24 Oct 2024 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729789504;
	bh=N7N6QXRB+ovyAVDEtuqEAO0cC0MzxLTBg6Wql3hIpG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWfTNV4Qt3xOgEwh1JC8eIYgPqEVEYIZScAxT/4ojLpkBTpf5tgwQkfqSF1e+N+jr
	 jQTHHLpXZ4ONSx3gC+gmenNBsboACV5PcWOLWubUdM3tUC8pHScXDrV9d4BC8EQeoC
	 ErYzpm6i60JrvlgkgsGPr5IgaRMjYdO2KwQkqNgBBAa7WjJllkDiQGZh2Yhq0sjy4I
	 MKI7eGLv2r9y0qZCqb1T4McCi0rKJMcBAWDvdfpYwbqhsxaakjg1iup7MpFdDgEq/a
	 u/z2N9iELJgGHoiWj2NTiGlxG4S9tW7l83g1E3RR9XSb/Smdz9yANyto5axjYDhTQO
	 OVlE+USiB+vwQ==
Date: Thu, 24 Oct 2024 18:04:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: tglx@linutronix.de, daniel.lezcano@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] dt-bindings: timer: fsl,imxgpt: Fix the
 fsl,imx7d-gpt fallback
Message-ID: <20241024-pep-proud-d714705c9ddf@spud>
References: <20241023185841.1183706-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5GUth0XOvb8nVxp6"
Content-Disposition: inline
In-Reply-To: <20241023185841.1183706-1-festevam@gmail.com>


--5GUth0XOvb8nVxp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 03:58:40PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> imx7s.dtsi correctly describes the GPT node as:
>=20
> compatible =3D "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
>=20
> Document the fallback compatible to be "fsl,imx6dl-gpt" in the bindings.
>=20
> This fixes the following dt-schema warnings:
>=20
> timer@302f0000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['fsl,imx7d-gpt', 'fsl,imx6dl-gpt'] is too long
> 	'fsl,imx1-gpt' was expected
> 	'fsl,imx21-gpt' was expected
> 	'fsl,imx27-gpt' was expected
> 	'fsl,imx31-gpt' was expected
> 	'fsl,imx7d-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', 'fsl,im=
x51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
> 	'fsl,imx6dl-gpt' was expected
> 	'fsl,imx7d-gpt' is not one of ['fsl,imx6sl-gpt', 'fsl,imx6sx-gpt', 'fsl,=
imx8mp-gpt', 'fsl,imxrt1050-gpt', 'fsl,imxrt1170-gpt']
> 	'fsl,imx6sx-gpt' was expected
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--5GUth0XOvb8nVxp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxp+OwAKCRB4tDGHoIJi
0v/CAP4n36jVWrgh3x+vdOBqKn+NTHSuLsxXHINgpQ2AoNnjlQEAok8fcpbaLkAJ
xnoDV7a+AvYpqTLpapBNDg4WbMyhIgI=
=6cJq
-----END PGP SIGNATURE-----

--5GUth0XOvb8nVxp6--

