Return-Path: <linux-kernel+bounces-191291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F69F8D0966
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049531F21F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9288F15EFC5;
	Mon, 27 May 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVXEijB8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13BC2628B;
	Mon, 27 May 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831047; cv=none; b=I3IjqSQavk1UxMDEFJ5w/jCLASD03btpafYF5SmjJCyMI+MVJ7gZKYOJV7yLmS6+fLn1DSbCj2Av59Uvz51WYQWBWl2JFMohKfYimBmHWuD72/hQQIhoyW4+Mt6qtaCPXaZJDVABAKbzmC3TBTWYSVhQmMGiQETnzCUGN5tgheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831047; c=relaxed/simple;
	bh=9quozKrS4U7FAPGz5BHTynZ/dNVRIPV8j95lX0IP9Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJEsldPVy3J+rigiiyexOCvMboqhRhGw6YKzA1MyEGrbFmkg9PVKmSPBHdpNZYGQDlImn4ZNMqhbtQ/4r1/CkMYqU2YjEyRv0wAjItRLP3rMAJVpf4vH7mjE61tlP8Vp4qvP0sQLAXJJOAQ1GVHRuWFZCH9Z8gszzJ9JF6VPnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVXEijB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F71C2BBFC;
	Mon, 27 May 2024 17:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716831047;
	bh=9quozKrS4U7FAPGz5BHTynZ/dNVRIPV8j95lX0IP9Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVXEijB8gd64dUYzLdEP7A3rGajYRg7KWRW4SB01S2amZ41qhypF4TbhbOacZly/l
	 XeIsRw1RZX1PuPNS7VZRdM1KUFIVOZsR8UN0XUW+9dJtBQQbBKXVr3xntBMi+m769M
	 IT/BU22MHJqj7myEWewEFt4IfSh//i+kj3v5zYE+YNGp1nD7/VUa3zlOgeRhQK8wCf
	 EOwz3mJxRLKnEuieSinrmeY9n2bvYSQlAoQD9wyrVkf9qU/B8fFq3htXfKv9rjTx5l
	 PNy0V+E9Iam6zU7nAoXcSdlhavyurp5h2GPrae+WYiLXTuXVglkSprHbsQXM78Znu1
	 JKKMkmXgpzmPg==
Date: Mon, 27 May 2024 18:30:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: hwmon: g76x: Add support for g761
Message-ID: <20240527-chase-lavish-d83386096191@spud>
References: <20240526184526.21010-1-ansuelsmth@gmail.com>
 <20240526184526.21010-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mvSe99LM+FhBGiVI"
Content-Disposition: inline
In-Reply-To: <20240526184526.21010-2-ansuelsmth@gmail.com>


--mvSe99LM+FhBGiVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 26, 2024 at 08:45:24PM +0200, Christian Marangi wrote:
> Add support for g761 PWM Fan controller. This is an exact copy of g763
> with the difference that it does also support an internal clock
> oscillator.
>=20
> With clocks property not defined, the internal clock oscillator is used.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--mvSe99LM+FhBGiVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlTDQwAKCRB4tDGHoIJi
0ha7AP9cIosAN3jL4HNDC5jiBxmlzzpLwTvaO19ZsBVmgxDwAwD8CrTFzshWc9/W
MQogUCU/8P4Fu6gmJJq+ibVUQ0UlFwo=
=hFOF
-----END PGP SIGNATURE-----

--mvSe99LM+FhBGiVI--

