Return-Path: <linux-kernel+bounces-195393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9039C8D4C1B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C273A1C22AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC417C9FF;
	Thu, 30 May 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exG2cj4Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FB17C9F5
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073711; cv=none; b=f52SuoCY9B2A1QIOW4GJlWslW1XxNHfeRNwKDZM95nal2+WXlhQ8Ov/DcGIFoxcE5ovmBvxf4ry0MYxH3Dnew5eTgvjhIb35n0dk9iI7c7mQI+r8J5GtfRQojNmxX/RCuy7DNsQgQU5F+Sg0XoROOqvo09SPNoJWW3+MpIZYVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073711; c=relaxed/simple;
	bh=MinsSWjPSdrlpjgaxrEZgiCjGpaf7eGd+tElRl/ywBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4K7dlC32wZltiyIEjKcztJPX/9LwvL1qpS/Wxaik/+gw635XW0FybiIu99DubL0vlwIEic7x38sdegpzkGPDdCYIDhNt0+ouD97BAxxoZT9piC5bo8zNw8qJpszht+IjMymVRrO6n6fxdySdlt+4VfuQueflzrAC3q3aHRlxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exG2cj4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6FDC2BBFC;
	Thu, 30 May 2024 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717073711;
	bh=MinsSWjPSdrlpjgaxrEZgiCjGpaf7eGd+tElRl/ywBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exG2cj4ZIq4S7BuBx/5J/W4qrYP3cOOpwPtXm1tFTeGBxhKCeP9A0Tk8pskIPH5Ww
	 bRE+V76ch8HHCT0lPdGGxQS7ubm3MT8PX87AAPhNzv1its6TbhVqj0fU31voOvkFjr
	 LaBPL9MyL/bCM2S8aoSLa32GG9/Kd4Q/Q6QLk9z1Y7fxRo/VvqS0fiTsv6FHqF1Utq
	 d2F3OeqE9iL+FUvNU96n7nCKpQo2ZpBokpvsYl1Psa44IOWFLLAjNxGFXVPEmVk7ej
	 rqiQK779z1r2YpeUu7JxE5f8lHBma8Wzhed6/EK97hOnLlbaA8lN6bfuWls6whSqFj
	 ckjwr1SIPaFpg==
Date: Thu, 30 May 2024 13:55:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] regulator: bd96801: ROHM BD96801 PMIC regulators
Message-ID: <6ba7f20c-623b-4e63-9273-e1c5def44b16@sirena.org.uk>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
 <f9e26bc6973f45079476b3ea77f25772b48e835f.1716533790.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5L+PetDXiL6dNsds"
Content-Disposition: inline
In-Reply-To: <f9e26bc6973f45079476b3ea77f25772b48e835f.1716533790.git.mazziesaccount@gmail.com>
X-Cookie: To err is human, to moo bovine.


--5L+PetDXiL6dNsds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 24, 2024 at 11:17:48AM +0300, Matti Vaittinen wrote:
> The ROHM BD96801 "Scalable PMIC" is an automotive grade PMIC which can
> scale to different applications by allowing chaining of PMICs. The PMIC
> also supports various protection features which can be configured either
> to fire IRQs - or to shut down power outputs when failure is detected.

Reviewed-by: Mark Brown <broonie@kernel.org>

--5L+PetDXiL6dNsds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZYdykACgkQJNaLcl1U
h9A+1gf/XF+qlIhOFhJecGpJydlowbw54VbtfkKcy5tz5t40VoPdG6YAEt5I+WRz
CY7sAhY/pcQmvd4GcEnnO4RDVv+emX8NjRd5JiIeWR3XYRUoRs2QtAZF9bj2etKh
+rI0K9wXnQzcf1CQ1Y7hrms+GWO57kik1jgCMCX1hNhqb4whjNOzl8RcuVtWuS5k
5MlqUh5Kp31q9Tijql4jt79GzRl2TY9BvZD+/W7BTYlSiRYcplyAhnAKhf0H3m6U
sBXYKiaXrlUdZy9SWetPHoqtAEJW8qzo+81VR6JHv1tqxfZTx3wvbDEaVAgyRIIQ
R3vzfwXFUcGe8G8tOL65DnT+LVbXkA==
=3s3x
-----END PGP SIGNATURE-----

--5L+PetDXiL6dNsds--

