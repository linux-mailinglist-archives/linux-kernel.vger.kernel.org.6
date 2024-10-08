Return-Path: <linux-kernel+bounces-355586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0FB99545F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80B8B25100
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90A1E0DC0;
	Tue,  8 Oct 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WenUi9nM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DE01DF241;
	Tue,  8 Oct 2024 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404800; cv=none; b=dCedQ3ai2CTsXJUMHRiXQUIEX+wNsJF7LaYqzSoEGpvtasZNrsJ9iTeWohz7Ds9OVBCB0/1kfgzbn2lq7vFw8wqZYanEUxIMkVWOnO5flid3FsgrN1HJxpiqIJQplxmFPkC+6Bt+spJ6Ue2RU0+runC0tA4F3bcEkCm2cH0TTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404800; c=relaxed/simple;
	bh=g3mTwkOGnaGYMekj4pHF5T98Ay768IFcDD66yHGl9vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO/QzMgo1TpmlN3xKAIDGa7x+ElhNK28uxxoE1i2hEt432/11MUIRm8vCPjyxDPmwGzc4k/B3Z+rd0Rniw0jLzmCUlmh/JiitSyR+XzSoOa08jXvK+iZlW7qw+j9b7Qgl/d17OjHPaxlSkaDK+Jr8XB3SAL9TFTN0NRvaZgbguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WenUi9nM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26445C4CEC7;
	Tue,  8 Oct 2024 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728404800;
	bh=g3mTwkOGnaGYMekj4pHF5T98Ay768IFcDD66yHGl9vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WenUi9nM1S3TtiQlmPE1/7+zo2OAB+Q9nS9pcM3TsZ7YIWHvmjFxsZJXhCGwYPooV
	 kL70DsdAFOpw9yx1CUd72izaMzeL2tCCt6DF7nPyPfWsbPlEve4W2zoBveFsp4jkcM
	 l7shlIGVFMi4AsXbAt/gjm6ykh2FrZ4Yk+7hrBxJGk4LGxVizKBvz0z+Zgh9NuBlAW
	 nEOKEPXfwIGie5KbFpUBRATJifcA85IKwoBR+6MS+lZvHR9nar3P0Xy6uEL8LWMpEn
	 TPRFNpMQFIdPqkgiW7KZWyqL9MreLu4hfponXKqlRDXoG/2DA4RU4aAWmkqgP2n8RX
	 y0qWkHo86RAVw==
Date: Tue, 8 Oct 2024 17:26:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wenliang <wenliang202407@163.com>, linux@roeck-us.net,
	jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux dev-6.11 2/2] dt-bindings: modified ina2xx to match
 SY24655(SQ52205)
Message-ID: <20241008-audible-immerse-9be169b3150c@spud>
References: <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
 <20240911122518.41393-1-wenliang202407@163.com>
 <20240911122518.41393-2-wenliang202407@163.com>
 <20240911-cahoots-wildland-0ea4d25d8cd8@spud>
 <f721966e-4e75-4aa0-8d0a-4e2bf73cf9e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zyl02mF8vy9zqIwE"
Content-Disposition: inline
In-Reply-To: <f721966e-4e75-4aa0-8d0a-4e2bf73cf9e9@kernel.org>


--zyl02mF8vy9zqIwE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 02:35:38PM +0200, Krzysztof Kozlowski wrote:
> On 11/09/2024 19:49, Conor Dooley wrote:
> > On Wed, Sep 11, 2024 at 08:25:18AM -0400, Wenliang wrote:
> >> Modified the binding of ina2xx to make it compatible with SY24655.=20
> >=20
> > Rather, you should explain why the sy24655 is compatible with the ina2xx
> > devices.
> >=20
> >>
>=20
> This looks like patch for some forked tree, like the BMC folks are
> doing. At least linux dev suggests it.

CC list wouldn't imply that it is.

--zyl02mF8vy9zqIwE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwVdOwAKCRB4tDGHoIJi
0rVXAP9bLpLOltPkImxR7yAF6jz37KVoRQN+/ZMA02nPw3ubhQD9HltuY1oft4J2
jKGj2FVZfDfx5hCFYGdjAo3xn0ZscwA=
=b50z
-----END PGP SIGNATURE-----

--zyl02mF8vy9zqIwE--

