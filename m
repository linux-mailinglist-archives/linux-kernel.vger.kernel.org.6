Return-Path: <linux-kernel+bounces-225629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D30913313
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81907284C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBD14F121;
	Sat, 22 Jun 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP3KR/OU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE9818;
	Sat, 22 Jun 2024 10:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719053579; cv=none; b=kHF04h/2JqpCJU4ItlU2WJIq8nAPO1wkorfzPtP1WPIG7TxpmvDogxV0rmQb2nnqwFxU6t5+Zl9HLTSljA6BkCi1K2jb32GuNVEnf2mdpHw19Qr6aJ6ahqWD8zvH8WI7T9FG4ExgZhulIHoXDiBGp2tt7sK9oQ4AhqdJxSUv6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719053579; c=relaxed/simple;
	bh=Aby3/xgh3G3AwLRO3U9OesgT3ykhTtfb684/BtS9wxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re8wt/UgekbKngffHun6MrMBOL4FjuumtQ4ijhxrNqfaCQcUGSK+hLJqLTgJSEdbZ84hTxkBSc+qYzWPTrWSg6wLHgpDKQkdyGU4wcsaWyCWp8MClF7zzFg9BFRBJj8Y/OscjPC8UQpwfaQtoDCuTake6sAxXUuj66vqm5m8FYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP3KR/OU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE06C3277B;
	Sat, 22 Jun 2024 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719053579;
	bh=Aby3/xgh3G3AwLRO3U9OesgT3ykhTtfb684/BtS9wxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CP3KR/OUqB92LQjCAZxOkDifteoHeAhP7Kinfl8vi7l8eUJk8Ov8PzAAR7EBiphM0
	 juLNyPMnJvyKSQHJ9PjW4UPWxrMP4fjl6L831PiCtsxsgzOS6IB9rS8rTEz3m0HRXM
	 xZa/uvv6zbaZUDMqGjthQkUw52kECLyfSbvn3zz/NeGWkFQcD+4Fm6/NABcylwKnV/
	 lEcoyPo8qT1OOaD1wtpgh8/0qPpzswQnILlIdMor0kBYuFHGRMfKPN+tOvXJntwi6C
	 IwEWD3vNkIE/hMzkcwngglpxT4jmpyolKo/Io+qvkLmpAYL9jJRr3DTxTFgorS7DKw
	 tlFhrWukxEN1g==
Date: Sat, 22 Jun 2024 11:52:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Furkan Kardame <f.kardame@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: mfd: rk817: Fixup clocks and
 reference dai-common
Message-ID: <20240622-exquisite-absently-e35b2cf335e3@spud>
References: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
 <20240622-rk809-fixes-v2-1-c0db420d3639@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dAUJD4FRJ6nYYvth"
Content-Disposition: inline
In-Reply-To: <20240622-rk809-fixes-v2-1-c0db420d3639@collabora.com>


--dAUJD4FRJ6nYYvth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 12:57:18AM +0300, Cristian Ciocaltea wrote:
> Ensure 'clocks' property does not allow more than one item and add the
> missing reference to dai-common schema.
>=20
> While at it, move 'clocks*' and '#sound-dai-cells' properties to keep
> the list ordered alphabetically.
>=20
> Additionally, drop all useless/redundant descriptions.
>=20
> Fixes: 6c38ca03406e ("dt-bindings: mfd: rk808: Convert bindings to yaml")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

I'd argue that these should not all be the same commit, but w/e.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--dAUJD4FRJ6nYYvth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnatBQAKCRB4tDGHoIJi
0neAAQDWAkLuiwFC1w0jc6OAX2oc8m2ifAVd8Z+rai077JX7TQD7BJlOUtK+SpJm
40x6H7TsC/mgAc3SI1EV6y2+Ie91VAM=
=JKbI
-----END PGP SIGNATURE-----

--dAUJD4FRJ6nYYvth--

