Return-Path: <linux-kernel+bounces-376646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE19AB467
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A90FB21A34
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0130E1B654C;
	Tue, 22 Oct 2024 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHIC81dB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3471A3AB8;
	Tue, 22 Oct 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615910; cv=none; b=EKP5Yyr0l+oBxXW5QWdSHVlolrTniQBlAsLyKuBT8h+uKvN9niibH7+BKMwek/mMkCVbWg+ttKijkzpLKFSd4LirWoFyNugNhVuA7g6TlF3ECtMJsB46Pm4I2YaIA40L18cu/3mIhsQT08BcunbwJ2+prQRedxVLErpwOF/AbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615910; c=relaxed/simple;
	bh=G+lVpa+HnPdLU2XGwcAvTF5ynzGYq9w6uSs7iS+poiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4CwRnLNL2mXfGzLfLTaCM5/Ev8+gLTsKVrC/4DkTIWfPjbEEp2WLKQSRYUmiTKZO3XQbt+fjStv4cTxwazmxrAo7bRGygSEwmkRhlP9iTuM4tpDIvBQpvEAdN+83FiFdUXO9rYBvDWmnxW9N3wzPo9FwH1IxTowxV6wuADCILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHIC81dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59311C4CEC3;
	Tue, 22 Oct 2024 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729615909;
	bh=G+lVpa+HnPdLU2XGwcAvTF5ynzGYq9w6uSs7iS+poiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHIC81dBP9ugP/4tCZ8LXztynVpyHDmlQDRf1SqH02QlVBi73aXTrcEd1Ya1jfdIm
	 dkTRdc31gQW6eiaTi3qmX6iCf6c7GUpSdSLueYyyq3bwP6uzC0GqmQmYeJljzTQgJQ
	 UntfusMGk/vzWjxLqQN87jgNrOPxXzxCbBuFch5Q1gG8TT8NGVHv96p5Z57PsrVBx+
	 SchaGgBEBrF4tr3UWQW2zxwZXjOEv5v6/RiOmijniM6r1aaUqf5Oug9Qh7I5ZKP0u4
	 4ggcgVFh7Lyb0XXeT5r9YF2Dqjd5nV3B+uHyQpjFEt3VX9hPvUxAMDnBkQ/NCE9CcV
	 ov2TFuVQDVevw==
Date: Tue, 22 Oct 2024 17:51:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Jason-Hsu <jasonhell19@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Message-ID: <20241022-clean-rebate-e986d6a82a05@spud>
References: <20241022021724.2322506-1-jasonhell19@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o2l81eJhq7XAs0r5"
Content-Disposition: inline
In-Reply-To: <20241022021724.2322506-1-jasonhell19@gmail.com>


--o2l81eJhq7XAs0r5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:17:24AM +0800, Jason-Hsu wrote:
> Add Linux device tree related to Meta(Facebook) Ventura specific devices =
connected to BMC(AST2600) SoC.
> Add subject prefix for the patch.
>=20
> Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

The indentation in here is very inconsistent. Please fix that.

--o2l81eJhq7XAs0r5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfYIQAKCRB4tDGHoIJi
0iUgAQDUmHPH4stEsqpdhMw9XHmJe8bKOJjTaat6ZehhyI3fNgD+J4CDQVPiHtlr
y+45Gh+Rxio1Oy/A586b7BrY+pdXeAQ=
=sZs2
-----END PGP SIGNATURE-----

--o2l81eJhq7XAs0r5--

