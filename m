Return-Path: <linux-kernel+bounces-433767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059129E5CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E3E1884734
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B015225799;
	Thu,  5 Dec 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqCZMf1U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86A22578E;
	Thu,  5 Dec 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418864; cv=none; b=e8xPp5vyNj/rbTJQ+RY58Cefg2iWUFwVKshXaGP8ycyX43HgTF/h9vHhDcZJcjnwz2pqKrZyGd8IplbXBYE2spvoBNOQLOGUNxmv1GjoKsXZ7zadIu3rDv+qgp4YYWMXXXWgeXWjkkFY9SSOozF28RGZqDkXSasARkXFaCRRlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418864; c=relaxed/simple;
	bh=DvxoChevFDcpPFuBoB9RlJpW10YfXE7rNoibpEC76z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXkINtxk3cWIPGLT69TN5kDPG3avKU8QsVViNaBnDNkiwsc04wzYHXQYchC48WQFt4g6+Crmv9Md6DuL9XehlH7PPGJlMjujHkUkj/hN/LdrwhX9bJWFP3tiJqQyCCc/2Ch9BxFwEZzuuk3hqGHFGXsJxzmiINw7iCM8ggQEqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqCZMf1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F28C4CED1;
	Thu,  5 Dec 2024 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733418864;
	bh=DvxoChevFDcpPFuBoB9RlJpW10YfXE7rNoibpEC76z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqCZMf1UjcdONKdFB1EAa5RuQouG9awwXivJhG7HsQs0m+9HR13r+kx3TcsG6LlSe
	 vm7PBCKCjamVbe4PxqVt3Sru9UR+MOT+nA4IcTXI0s44I9o6rozBMzrF8KNpV710IL
	 C38+hAiXd/R/C+8tKk74s38O0Bp114wBUa3J3Iy6mospoSH1PlBJUN2tMm0rGlxEso
	 Hfdo/Bh88K3z4QS75TwvGtf52C5Y+Mn5D5J8DP8oJ3f1Py8VmjSLYypt/Imf+qrSOx
	 oAlPLU6lBP700E3BzNBETYo1HosJ19hLcwkQYQ0NlmkWcyJYY4E0S/dbcCWl/K/6Cl
	 Cu058GEnHvENg==
Date: Thu, 5 Dec 2024 17:14:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>, Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Tim Lunn <tim@feathertop.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: arm: rockchip: Sort for rk3568 evb
Message-ID: <20241205-twisted-vintage-c4db864b6049@spud>
References: <20241205103623.878181-1-kever.yang@rock-chips.com>
 <20241205103623.878181-5-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rzNymi1S7MvzfVbm"
Content-Disposition: inline
In-Reply-To: <20241205103623.878181-5-kever.yang@rock-chips.com>


--rzNymi1S7MvzfVbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 06:36:21PM +0800, Kever Yang wrote:
> The info for rk3568 should before rk3588.
>=20
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--rzNymi1S7MvzfVbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1HfagAKCRB4tDGHoIJi
0h/3AQDatnQCPpZyqr5jco6CiQ99+WPzSf3clYyZmVhCPAUq9QD/Y8+mQW7x17Dz
8urifTAfl+oyCfmNeD47h/oLvA5tggk=
=LEIv
-----END PGP SIGNATURE-----

--rzNymi1S7MvzfVbm--

