Return-Path: <linux-kernel+bounces-576992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 462FCA71715
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149291894ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ED71DE4DD;
	Wed, 26 Mar 2025 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkisAdSx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993CD1A0BDB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994390; cv=none; b=Zn1TyJ7+u8UH4CDRibpclsVfSmj5Pk/KmpHMU8t8DeDcKjckjmOV1YOAE6AnQJFCVhRp49AuML8R2GdjSkz8LNzZ/xeDA0odx1HVsxWLqAeIbCa5jSeFsG8/ox1bieP89YxGqP0nZzGmKzmHYlXaRxCQj0vV5GKNBEFy4Q9to5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994390; c=relaxed/simple;
	bh=Cqq5jFzCIxmCfFNfx8fwKPnSTQb3kUzy1eRUhjzrldE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrhIJ7rk1U57DoGel4IePEE5/7Cw0CO8rOljnAlNHA3Z75sb28MqI9Rm6WJuZUdefY6jHhQuQm5GVabvw9gICJinzEC9HwmTzVujG1rOnTYtsYWGOgw+0lJ4QvirJ5xMQTNpDubAP3QCYajYijWq19CHDqVRUMkopS/OyBAFO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkisAdSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BF9C4CEE2;
	Wed, 26 Mar 2025 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742994390;
	bh=Cqq5jFzCIxmCfFNfx8fwKPnSTQb3kUzy1eRUhjzrldE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkisAdSxKmv+/MjMr5ErVd6QF7g74npArnonU+YNAJfW4r/9788VEzgL/SKlE+Sw6
	 IqTduXX573j6yK4HkYMY2IZzwQCWs6YPTe3uIl0gnuYoHtGkYUnmB//+4DzPwqzbaI
	 r27weNycZUflsBXAsTK7q4x7fDNTyXQfl3Q5R8B7o1W082A6/PZP2Zj7bbZx1Nb35k
	 P9Je9l1xHq9u9iLYlakBlh+vXjOgLekcHY8D9huepbSMJZPyweeLzk2iHEGcQL4UIQ
	 XQQxkCIIrnUn5JEMMZqjKRsRpSlPBGaAOBBTn+kvwYN1ifC4eQ6sMg7H3nUNWCZ+ZG
	 EkdlhIr6bUoGw==
Date: Wed, 26 Mar 2025 13:06:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Brady Norander <bradynorander@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 2/3] ASoC: amd: use new ACP dev names for DAI links
Message-ID: <4045f230-1fdb-4a2e-b2a7-2dfc088c1a03@sirena.org.uk>
References: <20250325211545.2099169-1-bradynorander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T2l1mc34r2ShMavw"
Content-Disposition: inline
In-Reply-To: <20250325211545.2099169-1-bradynorander@gmail.com>
X-Cookie: To err is humor.


--T2l1mc34r2ShMavw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2025 at 05:15:45PM -0400, Brady Norander wrote:
> The old names used automatic platform device ids, which means they could
> change. Use the new device names which will never change.

I've got this patch and another patch numbered 3 (but not properly
threaded with it) but not a patch 1.  What's going on here with
dependencies?

--T2l1mc34r2ShMavw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfj+9AACgkQJNaLcl1U
h9BbKgf9FssF3nnIHWH5FPoiteEcuogQ4BsueuLhkuqvS2WEMv13QmYNjmvQX8V7
46fhsyJnOnurd1bBx8R5G81IMH1OpVwX2fjubZ3vMAiIizCRFUjOFKgDreQ5gyQ6
Vy4FzzPgRpvHTLO4z40w/QHn8GCS8nTPjWYD4x+cdWKuEjsTw1wLRsnLWP+DljR8
qQ54VgeCXMT6csyjbS5fcDm5ejF49pZHjhP1Z7h4SRAKQfr/ShXr08jJDVnon27B
cb2SOsljdkCrMRnkLw7yqGZqNlXQxjldrwc5Ms95+k/K7LpeIa8D/5sWRgEuGKJK
+9XfW3rHBnlx3hI94terbCtTg0SHsw==
=NV3P
-----END PGP SIGNATURE-----

--T2l1mc34r2ShMavw--

