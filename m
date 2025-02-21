Return-Path: <linux-kernel+bounces-525379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF5A3EF43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D63A18835FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF33202C20;
	Fri, 21 Feb 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="gE0Pt1bl"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009E33EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128258; cv=none; b=bR+LqbdvKL6J73fkiqqP307TFd/2BEbF1nK33fyk0Nnc8Bju2+9AuIEqxO0UZVwt3yp1Gwfq2pkMd8LwWDGAAUH1qBmr/92w63fAg9m8ucrI6GrNf2GvNCztwnOUglxwVgnRkBe9MKJ9R2vYPmuXkKMppkVuSneSIMwsGOxTvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128258; c=relaxed/simple;
	bh=dO+Frs1sPoZMSwklZEazWEWZBqiqTqwxiWKEBiQiXUs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=d8vQCuzekaGtmjsQqv+lB/r0QcHywFHtLjQjqZ10xwjRxsv2nGsocaIzBZrhlcxpb8sMlcS9WGPz+kfS3Ul2+lfP94qXBCJmZqmA02PF06PUnWsEPmbtN/98a4uxjGXOFuPPDHxqR5MsGd24famr+DocdfGGW58DIE7ER+ISxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=gE0Pt1bl; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1740128252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ptMvqBkUwZrolxZJc9519N5cAklfWd2ezc61uzEJHZA=;
	b=gE0Pt1blbpbAPFxRS/bKRMrivKdpBXa2QMDSrpiH61pu6ds8O/vnsT6hKsOdeIcS8RyNLj
	QTA/i53abyk7Q66m2v+eJS/6YadfPEZ9KVeYRbpnvy80QBcwax47rxs8Eden3o2bMCQxqo
	kdc3gwczMSOw6a/hKD5nB2niOHmO3ZS1/LYmcpDXgPKxP11T7uLfs5JMFX2w+atB2tAfrG
	KJOPeCga0DdWQFJGTEb+faRZLRsb+S6Qdad6o+Tv6CYnDLItKo3769rF05sLSA2rXFXrL+
	7ZEumCt/skoivVn/G8zKILbinpzXm1oU/KvrC2xDwm2T/g1h5MSczJziKc/KMg==
Content-Type: multipart/signed;
 boundary=bb0d416b7a86ddc7225644bd7fccfe77947520006e455b4b349d45e7250f;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Fri, 21 Feb 2025 09:57:14 +0100
Message-Id: <D7XZZ70KM9NT.14VSJDFUTH0H5@cknow.org>
Cc: "Valentin Kleibel" <valentin@vrvis.at>, "Vinod Koul" <vkoul@kernel.org>,
 "Chukun Pan" <amadeus@jmu.edu.cn>, "Heiko Stuebner" <heiko@sntech.de>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Kishon Vijay Abraham I"
 <kishon@kernel.org>, "Jianfeng Liu" <liujianfeng1994@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-phy@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Jonas Karlman" <jonas@kwiboo.se>
Subject: Re: [PATCH v2 0/1] phy: rockchip: naneng-combphy: compatible reset
 with old DT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Salvatore Bonaccorso" <carnil@debian.org>
References: <20250106100001.1344418-1-amadeus@jmu.edu.cn>
 <173831716590.670164.5196739962949646746.b4-ty@kernel.org>
 <f64ee4ee-7e56-4423-813e-b87e023e893d@vrvis.at>
 <D7VJOFXU540M.2PAC1RFXAH19B@cknow.org> <Z7gosm7PJMR0zCg4@eldamar.lan>
In-Reply-To: <Z7gosm7PJMR0zCg4@eldamar.lan>
X-Migadu-Flow: FLOW_OUT

--bb0d416b7a86ddc7225644bd7fccfe77947520006e455b4b349d45e7250f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 21, 2025 at 8:18 AM CET, Salvatore Bonaccorso wrote:
> On Tue, Feb 18, 2025 at 12:45:34PM +0100, Diederik de Haas wrote:
>> On Tue Feb 11, 2025 at 2:03 PM CET, Valentin Kleibel wrote:
>> >>> Chukun Pan (1):
>> >>>    phy: rockchip: naneng-combphy: compatible reset with old DT
>> >>=20
>> >> Applied, thanks!
>> >>=20
>> >> [1/1] phy: rockchip: naneng-combphy: compatible reset with old DT
>> >>        commit: bff68d44135ce6714107e2f72069a79476c8073d
>> >
>> > Thanks for your work!
>> > We found your patch after NVMes stopped working on a rock 3A with newe=
r=20
>> > kernels and successfully applied it to kernel 6.1.128 (currently in de=
bian).
>>=20
>> FTR: I've reported it in Debian here: https://bugs.debian.org/1098250
>>=20
>> I confirmed it (also) broke on kernel 6.12.8-1.
>
> FWIW, we have several users in Debian reporting the problem, so if it
> can be applied to mainline and then flow down to one of the next round
> of stable series down to 6.1.y that would be highly appreicated.
>
> Diederik, if you were able to test the fix, you might contribute a
> Tested-by (although as I undestsand its not strictly needed at this
> point as commit should be on way to mainline and stable series)?

AFAIK a Tested-by could increase the chances of the maintainer accepting
the patch, but that has already happened (commit date: 2025-02-04).
The patch was already verified to fix the problem before submission:
https://lore.kernel.org/all/20250103171109.2726312-1-liujianfeng1994@gmail.=
com/

So AFAICT another Tested-by would either have no effect or a delaying
effect (adding it would change a bunch of commit IDs probably triggering
various CIs to run again).
I'm not aware of anything (else) I could do wrt this patch.

Cheers,
  Diederik

--bb0d416b7a86ddc7225644bd7fccfe77947520006e455b4b349d45e7250f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ7g/9QAKCRDXblvOeH7b
bnRDAP9IYwH1LfihZ3pGIVB+pL5ZDzXlBKKNwHBNmJle70hhwwEA1xo5LOIrFy9u
tmsN/WVn+DJq0WWtQrSDQ4JpbQ3F4g4=
=1hY3
-----END PGP SIGNATURE-----

--bb0d416b7a86ddc7225644bd7fccfe77947520006e455b4b349d45e7250f--

