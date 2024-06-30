Return-Path: <linux-kernel+bounces-235258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 772E791D27F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EA91F213C9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AC15383F;
	Sun, 30 Jun 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="N0x1hXEY"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E7282F1;
	Sun, 30 Jun 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719762203; cv=none; b=WGT9MkeRCYjV1YcrmksOlDq7fbbUdsKylbGnfCMDWacLq4gZWy+pAOfng6eiTASt35a5+fdYkG590MykqhkJR62mpfvQ+jvBejO7G+Ar2ClIVL5ZyZ9sdfNUoH4Bd/gVYJ03MHKa59KCEcNjStMmcRYmUM1XB7hp+ub6ZU6tSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719762203; c=relaxed/simple;
	bh=AUtORzMDdCMyeiqRqRZoORUxo2N6tHdV8x1n9L+WDrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEr8YBlQWnm4tLUkj10F1VHgm99xgO4QfCrLdni0maAAjgj54M78Wrsrkeh0I9UTNqrcww8N1w3f7cXcu1bBks8XGbKQZzYcBdlSROnVK+D39aiZqQQNKGFsJUkNzE8SB/RjNSADiBYJB3ycNTywxdDmdllIasHl6NjVYsYrNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=N0x1hXEY; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: dsimic@manjaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1719762198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJzZ3477L/XZ9+MboeTgz9sk1fFCg1tDlQJ3aVTYhSc=;
	b=N0x1hXEYCl5UUvG0T2FsNMb8/KJ1nkk7nMOyENDU6LXly51iZCMAVCWNh9rLTbiHw/W319
	/zDEg4l7UGyAD7IOcm7sX1l9ts0It1sIpS8+FSfZCur11KldCixQgICk56V7f4c2lL7+nz
	1BcHOty8s1OiHvrfkwknrTuZl62JkjjXJqwN6VdrGvpuIsuxmLUIWBMt/rO0WXHyEv6q3b
	+A0uN8mk5Etjwp62UgRcDUfjaNYcL6DhvQvI/0xpfX+664ySLcRcU3iD7pg7bZJDAdkNZC
	I3VbUWjUg5ZKakvKgXBMSffK4+cPhKrD3Uhczx0lkpzwtsbgYR1TRgg9HppC7A==
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: heiko@sntech.de
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: robh@kernel.org
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
 Diederik de Haas <didi.debian@cknow.org>
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: Add GPU OPP voltage ranges to RK356x SoC
 dtsi
Date: Sun, 30 Jun 2024 17:43:05 +0200
Message-ID: <2573506.7YG5XaKc65@bagend>
Organization: Connecting Knowledge
In-Reply-To: <b8951ac4e29184fa35919c6ab85b8f87@manjaro.org>
References:
 <bdb60f1f793166cd65f58ab7aea025347076019c.1719679068.git.dsimic@manjaro.org>
 <2442162.AJoTavkB1d@bagend> <b8951ac4e29184fa35919c6ab85b8f87@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3294961.YX3dR29aPv";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart3294961.YX3dR29aPv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Dragan Simic <dsimic@manjaro.org>
Date: Sun, 30 Jun 2024 17:43:05 +0200
Message-ID: <2573506.7YG5XaKc65@bagend>
Organization: Connecting Knowledge
In-Reply-To: <b8951ac4e29184fa35919c6ab85b8f87@manjaro.org>
MIME-Version: 1.0

Hi Dragan,

On Sunday, 30 June 2024 14:04:50 CEST Dragan Simic wrote:
> > I also expected that (for v1) there would be a similar construct as was
> > recently added for rk3588. But I should interpret Heiko's comments as
> > that strategy should not be applied to rk356x?
> 
> The trouble with applying the same strategy, ...

One of the reasons I like/hoped for it is that I'm a 'sucker' for consistency.

> ... the need for voltage ranges depends on one of the board features,
> i.e. the GPU and NPU voltage regulators.  As such, it still has to
> affect the RK356x SoC dtsi, which may warrant separate
> rk356x-gpu-range.dtsi, for example, but the troubles would arise ...

... but it's probably better if I (generally) abstain from taking part
in the discussion about the correct/desired implementation as I don't
understand the material in enough detail to meaningfully contribute.

> That's why the v1 went with a macro instead.

... which didn't seem to help with my consistency wish ;-)
(AFAIC there's no need to discuss this further (publicly))

> > When we/upstream adds npu support, I think we should also follow
> > downstream's OPP values, unless we have a very good reason to
> > deviate from that.
> 
> That would make sense, especially because we haven't had the NPU
> supported before in the mainline.

I first wondered why you hadn't *updated* the npu OPP values ... 
to later find out they haven't been specified at all in 'upstream'.

Cheers,
  Diederik
--nextPart3294961.YX3dR29aPv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZoF9CQAKCRDXblvOeH7b
bkBSAP0azzram50AgiLu7+7CoG5ibxdTLWfqWJXFnDz/NRklwQEA2F+7ZSC8Ny2q
vSJyaTgsxoSxeIKiNdrNgVIRgBAx/w8=
=NjR2
-----END PGP SIGNATURE-----

--nextPart3294961.YX3dR29aPv--




