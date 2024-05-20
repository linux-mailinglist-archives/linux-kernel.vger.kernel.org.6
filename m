Return-Path: <linux-kernel+bounces-183989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DC8CA111
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0784DB21882
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7418137C32;
	Mon, 20 May 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWjJkjow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22603136E06;
	Mon, 20 May 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225057; cv=none; b=UAcXKfuGsOJtEgAT6DfGC/EWyNW2FOkrh2zZGALoKYKw5QmYpbqnMd/nSnW+VVmgaTX+g5CFpUXcJGWZjF/AzHKmn7SX+YayzN0Qslj6Tt4ALMSD3P0AQWajWt1yUMWdCfSfCUfVQxy/GdU4IEhNdEOZ9oBxTjs7LPySEGNvVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225057; c=relaxed/simple;
	bh=A95f339KG0Mw6gRJH3rs+bbchwIdpv8Wui8a/NwYazE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHIBFoBVPj6IgSMD2eaFUbWGlRdi88eWRV9Zs2gXSXqkjF9au2UAhZhTJ2oXKzKhiozawfNaPfNZVDhn0bAFIMqDk+DJYBYHth9AocYg75BXLYt16PRUEa2iAZPK0mEqyB4wQ3XnJ7+XSMMFjUmY7NDwWc1s5qpBfZevcad1by0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWjJkjow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990F3C2BD10;
	Mon, 20 May 2024 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716225056;
	bh=A95f339KG0Mw6gRJH3rs+bbchwIdpv8Wui8a/NwYazE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TWjJkjowFu+tq2iHutHxov2MnhEAJThbzc0X9/KKlYGHwRQz4+0Fxs5In5mUc/7HH
	 goXT2PcqDJ8c09dJhCa3k6loooZJ8RUZHN2NuvlWcSqwEbIy2TUJsIytzZttzvu1cg
	 U0n57huE2vbdB9u9sUfqx/0vfvWN9DsQk6MXUAXbbBPcYN9G5d9v8w6ud/5cIrCu0p
	 g5nALMLpfyoFHyIAKAmYNxZ/AVZvie5/27cSspkPt9CI8Rc3SGYFDZe5x86nkqdG3+
	 NgyHzQ9vxnY46nF3CWiB3/PgtqQtVVGcytacDXlNwlYSadtr/zoPCs7g7TWvchrCFc
	 NNvS/QCjK8d1A==
Date: Mon, 20 May 2024 18:10:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Wei Xu <xuwei5@hisilicon.com>,
	Carvalho Chehab <mchehab+huawei@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: hisilicon: document
 hi3660-usb3-otg-bc
Message-ID: <20240520-bronzing-crumpet-c7b54753d2f1@spud>
References: <20240518204443.122586-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BjHOVWGNqNva6fk8"
Content-Disposition: inline
In-Reply-To: <20240518204443.122586-1-krzysztof.kozlowski@linaro.org>


--BjHOVWGNqNva6fk8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 10:44:42PM +0200, Krzysztof Kozlowski wrote:
> Add dedicated bindings for the Hisilicon Kirin 960 USB OTG Syscon,
> to fully document the block and also fix dtbs_check warning:
=20
>   hi3660-hikey960.dtb: usb3_otg_bc@ff200000: compatible: ['syscon', 'simp=
le-mfd'] is too short

> +title: Hisilicon Kirin 960 USB OTG Syscon
> +      - const: hisilicon,hi3660-usb3-otg-bc

I know you got it from the node name, what does "bc" mean here?
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--BjHOVWGNqNva6fk8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkuEHAAKCRB4tDGHoIJi
0im3AQDgfnEIms9Y5074JBJMH7vVUPEtE04dREj6zOXDDgT/HwD+M4wL1AU+t/CP
RCRge27AevMKxnkyK/2/PcIjBTLgMAQ=
=WMbM
-----END PGP SIGNATURE-----

--BjHOVWGNqNva6fk8--

