Return-Path: <linux-kernel+bounces-180086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775A08C69EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18311C213F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDE0156230;
	Wed, 15 May 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk1o38ud"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCFD155A39;
	Wed, 15 May 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787979; cv=none; b=MCAfroDx5ZY0J0jktej28iTFL4KHu7mGg+eRHWVUjgcv21qZdC2XRHVnkNGjrepFrP6QmxCv9KN0Pcin1Bcw6Q2xsEX4MA8yhria0Sq8Ys0LWk6woD2j5AqU2HQc4oVbCQrqJAIisbO73KPBDx4qU9IDGTSxRAOdlLcTClbCXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787979; c=relaxed/simple;
	bh=m3oTwZX8lO/oSjtm0KYRpA5KUrBDdcrAO064V0gwf80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPzn8Qnx7+n4lxREhQBNm4B5Lh7BPFmjnoPXt0UUNKjPgCLQNRyC9ZeZQLUVTRaGKvSHTAyhuInB5x0WZak7wwsezDgSqKPQT/1kqDyr7EyP9yWlaLxwjhj/PC00/xW9M2wL/HfrCzpQsSwn1Ua3ufefdWrZOZ5VcM/OmIcsVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk1o38ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17ADC2BD11;
	Wed, 15 May 2024 15:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715787979;
	bh=m3oTwZX8lO/oSjtm0KYRpA5KUrBDdcrAO064V0gwf80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dk1o38udslJlUDnF92qRzNs5897o0hK9UkNftJGKBpE9ysGQ1CDQtJ1PBEca/opa/
	 ASR1yN9b0NqZs9xVR6Fm3qi4E5Ewh6MkCIZm+N+IX5udHsmYPOBlN1wF+HeDh62YHZ
	 YqpND4EVlOshC/2lgTpusYxLX/f5oh0/Ms8GUmq9l92fdZ1mEWv/MuLuFwQy+jFEeK
	 mM9KmFTRaS2gtP3ZGQVSLugUPiQWlsi9ph0xLloN0G+qpM1R4rguFicBguL/NSQh8L
	 0St2JLTGE4K9NUBetxGtr/BqZrDsgTm7Y6o2Na9XEP6eX7iRVXdGOLaWGcjN/av6+B
	 v+ePq1BIlT6iA==
Date: Wed, 15 May 2024 16:46:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Pratik Farkase <pratikfarkase94@gmail.com>
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: brcm,ocotp: convert to dtschema
Message-ID: <20240515-brilliant-sanitizer-58f6b6a7411d@spud>
References: <20240515142926.68153-1-pratik.farkase@wsisweden.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nkNZN2v6/WIDYak3"
Content-Disposition: inline
In-Reply-To: <20240515142926.68153-1-pratik.farkase@wsisweden.com>


--nkNZN2v6/WIDYak3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 04:29:25PM +0200, Pratik Farkase wrote:
> Convert the Broadcom OTP memory controller to newer DT schema.
> Created DT schema based on the .txt file which had
> `compatible`, `reg` `brcm,ocotp-size` as the
> required properties.
>=20
> Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--nkNZN2v6/WIDYak3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTYxwAKCRB4tDGHoIJi
0rWaAQDyjgKa0X1z1cnn2u6eAJ62HBcxd1mVWFD05jilGtAVYwEA6fnL0gBlqUVs
UzWvvvoV7t1mJ5QGeJmuoJBqo5L2zQk=
=MF7U
-----END PGP SIGNATURE-----

--nkNZN2v6/WIDYak3--

