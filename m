Return-Path: <linux-kernel+bounces-355571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F42995435
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4592D1C22A63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0B4502B;
	Tue,  8 Oct 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh5p2v75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70EB33986;
	Tue,  8 Oct 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404245; cv=none; b=C9Q4s/+1xNwbRaNPbkU4WUTOk0WTKj76C40x6bWA3mk3kdjL+sN+jyf/spPKkTc1rnhJEtUG47JBINMitOe4p6eGgagnGq+eNt0pk0scK3yb8ME5vM2DaL/cc3Bbom82JltuFi3ehNxRTpuRszFovAILKMCu4Z92lUCzTAWdCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404245; c=relaxed/simple;
	bh=5sJgUKLYp3tZ9et6ymOPVCIytCIoWndZUy/ubGUBJww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2CT2FHUrBGsg+nW4TXvZ1V7sSSxGtFlIm6Xf5QLPUPMYCYHrwux1dMfcRfzbai5p12gPHUGZR3FAFYVi3ovdwijiz4e37YeB46Y8T+uY0VUC690obDxEnji7lmScOqST4WDIJQMUoX0sSILMHLsvqHTMzMHOQ407Q6yo+kQD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh5p2v75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E462C4CEC7;
	Tue,  8 Oct 2024 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728404245;
	bh=5sJgUKLYp3tZ9et6ymOPVCIytCIoWndZUy/ubGUBJww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jh5p2v75JB9c6YxFvIR59GTVIA1ie1Eazh0hURVSjQKU6nURA5UTPgksSQbav6H9y
	 V3Hqf9KjyBXD6OjHlRASh36AfnUNagMtkOnGszULE0hfnAihl46dY/55pUF4W9YejC
	 /TkjfRN2yg3Y7tKBN+IKMEovkd76UGkIy21rJH3NAJaK+E4ivPMq9+uLKvcg3x6YT7
	 QefzMaK1FPSrVR+v54Iv/Z8YsMc10TIvrrbBza5+q/N+BiMPlPTY8wvJZwcCE9ut3q
	 6VwGuAaLBU1YpGO5qOjbrV+pvX32aoCZ969lRzB/9oHoN/+cnL3ce5A8mjMnoPnNAI
	 ZhOUUR49SpVxQ==
Date: Tue, 8 Oct 2024 17:17:21 +0100
From: Conor Dooley <conor@kernel.org>
To: wenliang yan <wenliang202407@163.com>
Cc: linux@roeck-us.net, jdelvare@suse.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH linux dev-6.11 2/2] dt-bindings: modified ina2xx to
 match SY24655(SQ52205)
Message-ID: <20241008-unlatch-frying-d7576b77f99a@spud>
References: <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
 <20240911122518.41393-1-wenliang202407@163.com>
 <20240911122518.41393-2-wenliang202407@163.com>
 <20240911-cahoots-wildland-0ea4d25d8cd8@spud>
 <6dcf956c.c4f1.1926bff1453.Coremail.wenliang202407@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qFwHXDDGM35DQfTn"
Content-Disposition: inline
In-Reply-To: <6dcf956c.c4f1.1926bff1453.Coremail.wenliang202407@163.com>


--qFwHXDDGM35DQfTn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Oct 08, 2024 at 07:58:51PM +0800, wenliang yan wrote:
> Modified the binding of ina2xx to make it compatible with SY24655.=20
>=20
>=20
>=20
>=20
> Signed-off-by: Wenliang <wenliang202407@163.com>
>=20
> ---
>=20
>=20
>=20
>=20
> SY24655 is a fixed gain power monitor from Silergy, with a power supply
>=20
> of 2.7-5.5V and communication mode of IIC capable of detecting bus voltage
>=20
> and voltage on shunt resistors. Its first 5 registers are identical to
>=20
> ina226, and also have alert and limit functions. So, the sy24655 is
>=20
> compatible with the ina2xx devices.

This should be above the signoff and --- line. Your patch is pretty
badly malformed, did you use b4 or git send-email to submit it?

Cheers,
Conor.

>=20
>=20
>=20
>=20
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
>=20
>  1 file changed, 1 insertion(+)
>=20
>=20
>=20
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Doc=
umentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>=20
> index 6ae961732e6b..05a9cb36cd82 100644
>=20
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>=20
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
>=20
> @@ -20,6 +20,7 @@ description: |
>=20
>  properties:
>=20
>    compatible:
>=20
>      enum:
>=20
> +      - silergy,sy24655
>=20
>        - ti,ina209
>=20
>        - ti,ina219
>=20
>        - ti,ina220
>=20
> --=20
>=20
> 2.17.1
>=20
>=20

--qFwHXDDGM35DQfTn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwVbEQAKCRB4tDGHoIJi
0iwQAQDbWxYff2PbrxzCJq7RCXsWrg6/BXo3TOEkUGvAXrvz7AD9H9vexHzz+KOJ
9ItTMS3wmwKI6SzZojMatysuiil1iAo=
=2YUE
-----END PGP SIGNATURE-----

--qFwHXDDGM35DQfTn--

