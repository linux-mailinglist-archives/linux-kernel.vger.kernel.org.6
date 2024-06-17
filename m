Return-Path: <linux-kernel+bounces-217829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8018F90B4DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932E51C21369
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A8155A32;
	Mon, 17 Jun 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFh0vSlj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA915573F;
	Mon, 17 Jun 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637139; cv=none; b=WzzsUki5iYM8Gbtry3MOWpfe2OQMPx5++e54EZVGb+0qy36brlTKwJYMydrpNc1x/0NN8ySFySd3gkxzjibjOjmpxllI9GydCJMIQ/tC3+LlF/kYTmAa8P7ZfrrMPqZUiDe12mZJkVaYttey4lLc8m+0tA0Qx80CcbhPJNxYDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637139; c=relaxed/simple;
	bh=heEcD7jP+9sbk2WYP48DwhYQ31/7MqNBiwMnGgFNoos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3VSq2zNR14qxU5PLXFGj77em+emKGH9Kn3gau0EHCk5sZbi9bhZNiovHUW8TKl2lpARvc2EJoVCLeaGIXDPYczTtUDpSOJu1fYkslrsAQ1e3UfMUi2viXSCoWZaBm3Piy1VcYmSwQKBTUxvpxnZWjw+uqpm/Qw5g80nVl474zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFh0vSlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66083C2BD10;
	Mon, 17 Jun 2024 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718637139;
	bh=heEcD7jP+9sbk2WYP48DwhYQ31/7MqNBiwMnGgFNoos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFh0vSljOiT3mLP4VuA9fmWsEfm3G8wYGAttwWhHIkApQxTJbt8ZfWE8uikq+8QIT
	 umPSlhJ+qjHRRaecJy3sPS3A6qidL+hA7NkXJ5uAGaNnIyARSUmIP+u421f0pB83ro
	 S119pBD+xmYsXOe7VevwgsSaTqMIlKmNPzxGjyFUlKLACP6Ci4PEUVLAyaCDorNrC5
	 NyNfWZE4rHJKI028XLHld5/6WIz6yPoTVqPafoUuzQ/5mG6FmmwM26zfhsmws+DvUK
	 eXI/0R9uRlxQVRJman/9IH/ZTf2OThbfdUFTV2NMq6Rdbg7mqBGItws0APwDkjOCUV
	 tH0gXur7Res1Q==
Date: Mon, 17 Jun 2024 16:12:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: thermal: convert hisilicon-thermal.txt
 to dt-schema
Message-ID: <20240617-latter-recovery-b7ef60fdf9f8@spud>
References: <20240617-hisilicon-thermal-dt-bindings-conversion-v2-1-5eea9bc59c77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y2bjfCNhCmua7HYd"
Content-Disposition: inline
In-Reply-To: <20240617-hisilicon-thermal-dt-bindings-conversion-v2-1-5eea9bc59c77@gmail.com>


--y2bjfCNhCmua7HYd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:20:52AM -0400, Abdulrasaq Lawani wrote:
> Convert the hisilicon SoCs tsensor txt bindings to dt-schema
>=20
> Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
> ---
> Changes in v2:
> - Remove extra node in example.
> - Use standard node name in example.
> - Include additional defines from includes.
> - Add reference to thermal-sensor.yaml.
> - Remove redundant properties and comments.
>=20
> - Link to v1: https://lore.kernel.org/all/20240613224204.185844-1-abdulra=
saqolawani@gmail.com

Why did I get sent a v2 of this 3 minutes after I got sent the v3?

--y2bjfCNhCmua7HYd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBSTgAKCRB4tDGHoIJi
0nJ8AQDi+q3L2R7LqolMueilkU8RIIcJOEtwkOSf3PX6Dia8RAEA+M9ZnwhwyGZa
Cpi9Fe03nanVH4KljShDO2MMYWPHXQQ=
=b5RI
-----END PGP SIGNATURE-----

--y2bjfCNhCmua7HYd--

