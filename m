Return-Path: <linux-kernel+bounces-171845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17038BE963
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E237C1C24694
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2624C180A94;
	Tue,  7 May 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyYtMK/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B6199E9F;
	Tue,  7 May 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099723; cv=none; b=uKO232HxanHdekjt1GVgiET83MWrh6M/f8a4RBqqMZ9zWj4QduenJOdYx4X4nM542RI71GfDU55s0Pfub6WYhe0ZSE7Kc4zOnydb2G0raAps9eKPhv4RoOHiu2Sc3XqH3Po5W0lET5kO7ODrwh61uLH+irJFC4oqo147cp6CxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099723; c=relaxed/simple;
	bh=6BuoEP69iJQFTmo0l+aKAmmdfXJuE/M0HIl7fyjjuRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTGhw0k/LH56gXu2/v+g7eqdus5QQ2sdh9uYxtcszMO3Eae/8IkP9nvSLUHMdRROxqSv/8TIcRxtOwoWYZ9AibySAcXz1Y5UfFwmcuJdTVjYy9xR18E4yUEgBep/jChdY6Wujsea+YxKPpn/9hzVcf/yxNDiyWdzxlhQZl1doCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyYtMK/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527D0C2BBFC;
	Tue,  7 May 2024 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715099723;
	bh=6BuoEP69iJQFTmo0l+aKAmmdfXJuE/M0HIl7fyjjuRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyYtMK/eL10nLiDdj/jdaWGHvz9tdmIjPuGjMN4piG9lIXruppRR/ZI6Htlj9Wg6Y
	 QPn+5XpPNhdQLn8mie8dU6DQq9bHp6wMuPPycJb8j37Xdw+2spRsVI0PF4ZQDgVodm
	 sIgAAQftKW8fDfN9uZBXukS0GQD986J4z49FvovdkWRusokNTf+W9DuO3WbeFWb6C0
	 kcZkCqmB4AMha8bWlF4/WjZfxBxztgxRaAkY2bKfDTFWcyvgZjdJ6nVjWYXpIKecyE
	 adN+K+POS4UhFWhNxi35rUTG7C2oHHsFoRQsa0rzgyTDzCK388/7AcLuK7mZHKdmr5
	 fEFcPcfoTvEXw==
Date: Tue, 7 May 2024 17:35:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
	dianders@chromium.org, linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, airlied@gmail.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com
Subject: Re: [PATCH v4 1/7] dt-bindings: display: panel: Add himax hx83102
 panel bindings
Message-ID: <20240507-joylessly-litigate-be6a83058ed9@spud>
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
 <20240507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2Nhu63EKR1l31LzH"
Content-Disposition: inline
In-Reply-To: <20240507135234.1356855-2-yangcong5@huaqin.corp-partner.google.com>


--2Nhu63EKR1l31LzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 09:52:28PM +0800, Cong Yang wrote:
> In V1, discussed with Doug and Linus [1], we need break out as separate
> driver for the himax83102-j02 controller. Beacuse "starry,himax83102-j02"
> and in this series "BOE nv110wum-l60" "IVO t109nw41" panels use same
> controller, they have some common CMDS. So add new documentation for
> this panels.
>=20
> For himax83102-j02 controller, no need 3v3 supply, so remove it.
>=20
> [1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=3DzBQJUC4CB2wj4s1h6n6aSAZ=
QvdMV95r3zRUw@mail.gmail.com
>=20
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>

Other than the issue Rob's bot reported, this looks fine to me.

Thanks for the updates - but please test your bindings!
Conor.

--2Nhu63EKR1l31LzH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjpYRgAKCRB4tDGHoIJi
0t9VAP9HNYeHrikG32rNlR6KbTJBlAm+FPDMLfH0vjZbmGR9FgEAt7OVS+Lp5Uqx
c7yaTo/RJ2Ft85p6pEOuYB/Yhh2Izgw=
=aoZ/
-----END PGP SIGNATURE-----

--2Nhu63EKR1l31LzH--

