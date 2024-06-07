Return-Path: <linux-kernel+bounces-206347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E448900834
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536DE1F222ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31619CD1F;
	Fri,  7 Jun 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu9exxX+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106A19AD4E;
	Fri,  7 Jun 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772600; cv=none; b=QfcTdPoDbjTzSt3ETeyBpDkREydHFMHDIQmfEXTx5K3+cX19PUljWUraZL1d8cNBNq/jdl4z2Z10Re91Nngx7OTDShcL1C/SK1Zs2s9ogw+4Eqrmw//3CuLfrN99JVEMpPwW7RKL8AuKGyW2KmhLq/FLYMmLpnLGcZKZnBlCNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772600; c=relaxed/simple;
	bh=4gR8xxsDzn89AEBZY9bCk38wSrFhLDr+8xtncFpD6Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzh6qn6sfBue+FC0TY+vhNxKt4G9WY/Z56hwiSJ3mjEBLjN+60sfCB1taomkV5J/sHXpB4o0VVxuWGNLMLlibAiIM0QMn3vah1xe4sCX4Kr2dQOuXDkdfjOq1Qvxdyy9QeavMyT2vEqtyFFXv3Dk/DFWnB7jgVvmtc9eIiLA5AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu9exxX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B82AC2BBFC;
	Fri,  7 Jun 2024 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772599;
	bh=4gR8xxsDzn89AEBZY9bCk38wSrFhLDr+8xtncFpD6Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fu9exxX+roB9Uu+dO21iVZwiT9RXi2Xm2APsNYQVWfSOQUpW347vV20/HOesIN8nr
	 gUxXZkfix2bjLhBymZDwETKE6xSdYTcpN+aPxNKOL0ymRRs3NClK2AWVvwES2ZXXd5
	 TSYwH7SwlmBtjDdBiQnJABvsZnNhlbZHD/r1wofzEXS5JASXO9CUob59fc5bNKFVrv
	 H+LHf1o64yEGLpOzIe/hm/W8CUDEAwG0ihFgbTVdzaVxxU0WICCmhNvsohrATeOomV
	 Hr+MNtcVT1ZRgcG4EkE+P6zbUez83MoZL7erDBguYktJc4vuph3/nZI3MlqZXcNHNe
	 EvXXZXJ9kgHaw==
Date: Fri, 7 Jun 2024 16:03:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Viacheslav Bocharov <adeep@lexina.in>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: amlogic: add binding for
 JetHome JetHub D2
Message-ID: <20240607-flatfoot-endurance-934bb299c6e4@spud>
References: <20240607145148.2246990-1-adeep@lexina.in>
 <20240607145148.2246990-2-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0EFJB7UY3eHZb3HP"
Content-Disposition: inline
In-Reply-To: <20240607145148.2246990-2-adeep@lexina.in>


--0EFJB7UY3eHZb3HP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 05:50:03PM +0300, Viacheslav Bocharov wrote:
> JetHome JetHub D2 is a home automation controller, based on
> Amlogic S905X3 SoC
>=20
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--0EFJB7UY3eHZb3HP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmMhMwAKCRB4tDGHoIJi
0kABAP4zhbmujaFMgWvXg11gfLRm75AooEjghwdLWFJok+IQAwEAqYc6WFBpNXx+
8WzQ08DCs3rKN8W5v5fzYs9vukKmPAk=
=OswS
-----END PGP SIGNATURE-----

--0EFJB7UY3eHZb3HP--

