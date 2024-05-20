Return-Path: <linux-kernel+bounces-183991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75E8CA115
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817DF1F21597
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52F3137C38;
	Mon, 20 May 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAr5hP7R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DBA136E06;
	Mon, 20 May 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225206; cv=none; b=X3Aj60sg+/eiH9Ob82IEjsu3izsMFXQrccNcpj0W8NDbCVQqoAbGkGqX/MeqfAerNHmBiI/wVT5Qu552JqijE6I4j0l9u6Ny+2+TpmGKILOeA36VnHhI3CfTeylWKTLcZh8fTWz8xHzsE4OQJBrfhp7nLLGUJu8bNrqSBwjccKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225206; c=relaxed/simple;
	bh=YrH+SD4YzOXa9n9yuBvMlOLK+KSaFcYb6SzEcl5Q6ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFX29a/BQP4r1hzB5Nf9IenKk+9BWILs0UrjgTqJ1LCnduV1KMPqUrv1uPkwYLB9hHyaWXZTlciropNMXZZhWJ80dTxyJrcq+R7KLV//T0noeZtEkLlnr/en7SkNXHQl/YfLW4IfR4w80tetBzGl19LkjX3764N44nmT3lFLkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAr5hP7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9B6C2BD10;
	Mon, 20 May 2024 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716225205;
	bh=YrH+SD4YzOXa9n9yuBvMlOLK+KSaFcYb6SzEcl5Q6ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAr5hP7RfesvmSaZm7QHMyrp8U8HrN0ZLe6GfRHMKTOFJH430XEmxXChNxboPp2V6
	 CXKVGtYZWhsY8NDuYHnBOfkKEIoWv406BQ92TcWPp5m299owYGGVwXBLMQrwi7Qfl4
	 2TIPFajzBIZgME3NWxlIoNeakL89YKNaEzm8fhGtHVXDOZm4y2KKFUSLgkOAcyA1dd
	 WODErsiZ62F8xJHrj9p08C6Ak3k+uiGH4mk83Y++frLlQ/Qfv7xMjWAH+0JXRG9f/D
	 G7jm9PPgHxjQfde2XjhxpvN1QcQNJrJrHrT3jKZpa4Q3HTvv5a9LZq7oyAsK8Ku7En
	 FfBawtIA49bpw==
Date: Mon, 20 May 2024 18:13:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bindings: soc: ti: am62-system-controller: add
 AM62 syscon
Message-ID: <20240520-direction-snazzy-6aa0e8c10c90@spud>
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
 <20240518-dt-bindings-ti-soc-mfd-v1-1-b3952f104c9a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="71CAbP+dR/shP3qk"
Content-Disposition: inline
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-1-b3952f104c9a@linaro.org>


--71CAbP+dR/shP3qk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 10:07:16PM +0200, Krzysztof Kozlowski wrote:
> Add dedicated binding for AM62 and AM62A wakeup system controller
> registers, already used in the DTS to properly describe their children.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--71CAbP+dR/shP3qk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkuEsQAKCRB4tDGHoIJi
0jUBAP9X2x8nVUQ7QarZh6heKxTFs02nGN/RjheEFEt5RKmySAD/TqJSu9lmf3ye
QGFO951H3L5YWBFXpD7/fzVnUWokEA4=
=xngw
-----END PGP SIGNATURE-----

--71CAbP+dR/shP3qk--

