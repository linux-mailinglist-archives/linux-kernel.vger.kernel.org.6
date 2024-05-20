Return-Path: <linux-kernel+bounces-183990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B008CA113
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B431C215C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830D137C37;
	Mon, 20 May 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsfXIztt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584D136E06;
	Mon, 20 May 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225143; cv=none; b=vCSihNU7gNKAlGUAPXpam0+RjJPyDDw11UlFDkcAZ11mZEkrOVD3aQFR0MV4so8D6FgbbEw88Q//GwZqtvpkXb/g7rS1fOnTwE9AZoa3n4zljyBYavcHPRx9Md1/FnWIMsVFhpLT60XZV8vCUrrFHsdlz0URjQ5EmA4jO6y7CSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225143; c=relaxed/simple;
	bh=wr0nmpDfQPW4pQLxsGVaB7ZdXI/vnTpElAOkO3HRsi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8TzFHAOZ4vFeTAhb/Zh4EGx/hEjiD3VpVzsh8EXiCzZNBCjQBouRMZS5xH0PT+DtkYD0I8ktdF2zvy+5a5eLMRiy53F3QbOU1ZTC04AFfDv87AqEW53l0vTJM7QtB0bSuW09YJa3ScxjAJvNPTjKdR4+hJfQX4aN+FZfpALiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsfXIztt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30722C2BD10;
	Mon, 20 May 2024 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716225142;
	bh=wr0nmpDfQPW4pQLxsGVaB7ZdXI/vnTpElAOkO3HRsi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsfXIztt0/y9pDVIWGBaeNbk3MQP6ZcOxE2PlJVxY+lqJzbORwXyCZaMqZd7iBRTm
	 HbdOpBTxobcRlT6zLsH9uBTXi0yJFOVjZebWicyR9gIvqKdRg93C401ca7Ko6cWqmc
	 R0HjFxDV3LAuhC/m9MCuqJexCxvWUknC33m2oW/HZOjZJhtrx0nuPvmVEmjT+Ra1oO
	 Hb4SKfNcZ0ssnIXZycuAFPvVcNxmjVHihHE6F8dXM8eccx6c7i3pRcJgNJosgno/+6
	 gsD28JUI2WWgJf5KFx3FSnkM4A4f5OF7JG4MLGfyxC7ohdAEEvxK4+7b1/bjdOAlGq
	 l/D79A2oSeD1A==
Date: Mon, 20 May 2024 18:12:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,juno-fpga-apb-regs: document
 FPGA syscon
Message-ID: <20240520-unchanged-progeny-e15f742ee16a@spud>
References: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1qg6jsoVq3uoyOgX"
Content-Disposition: inline
In-Reply-To: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>


--1qg6jsoVq3uoyOgX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 10:39:02PM +0200, Krzysztof Kozlowski wrote:
> Add dedicated bindings for the FPGA syscon registers on ARM Juno board,
> to fully document the block and also fix dtbs_check warning:
>=20
>   juno.dtb: apbregs@10000: compatible: ['syscon', 'simple-mfd'] is too sh=
ort
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--1qg6jsoVq3uoyOgX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkuEcQAKCRB4tDGHoIJi
0iJ4AQCtXnEdVRN4c5Oxt481DWOdzAqgZu7frHcPUmGCAzhYKgD/VGsqHMzy179h
jy1dPUQhAlWgBWE5ehIUBqtvRLHoRgU=
=8IvQ
-----END PGP SIGNATURE-----

--1qg6jsoVq3uoyOgX--

