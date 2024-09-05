Return-Path: <linux-kernel+bounces-317156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3708996DA12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A2B1C24EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7465719D07F;
	Thu,  5 Sep 2024 13:21:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632419AA56;
	Thu,  5 Sep 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542461; cv=none; b=kXfyvyK9V+9YwrZ1t8NojKw6XLfVfX3XuBSM7zSXyMCc/CbZss3P173FSirXmj/GazVfaO0gYtAA+1HlUDLREHlV73Q37zcKxAelLbeh4hmJ/qRSHYFE5w1vvLXJEDhlmXiwBntjopQcJtSvsQpmF1hvUMtAoDxHaFKT2YZgPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542461; c=relaxed/simple;
	bh=4aAje/6fAqnRk/OlwFXe3sa/wcaB7DG2rt2eGKEFmTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EozBXrxDUxP8j1rFvkzZhWIYWfYD/GY0JOOYSi170WtjKKlKqg0p4mWD455QvcbljOaVIRYXMprdwGC5DzJ5tBZr8iK0Mt/jBVsjGx/xzLS0K8QOSqYJDVBs4XqCBPSJXZOget8phHIqCBScU0EaGX8Fz2SUAkUNw4NljkLcEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F109FEC;
	Thu,  5 Sep 2024 06:21:25 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28343F73F;
	Thu,  5 Sep 2024 06:20:56 -0700 (PDT)
Date: Thu, 5 Sep 2024 14:20:54 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC
 dtsi file
Message-ID: <20240905142054.58194beb@donnerap.manchester.arm.com>
In-Reply-To: <8a80465aaa4b7dc4c8c15d7a73944cfd@manjaro.org>
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
	<CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
	<21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
	<20240815181508.6800e205@donnerap.manchester.arm.com>
	<06cec3fc98e930bedc8ea5bfde776b3d@manjaro.org>
	<0fc37f3074a3e99c15a2f441194b7032@manjaro.org>
	<CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
	<20240905133412.6ba050de@donnerap.manchester.arm.com>
	<b07f1365a6f942297f7a3308fa628187@manjaro.org>
	<20240905134254.6e15a1e5@donnerap.manchester.arm.com>
	<8a80465aaa4b7dc4c8c15d7a73944cfd@manjaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Sep 2024 14:54:03 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

> On 2024-09-05 14:42, Andre Przywara wrote:
> > On Thu, 05 Sep 2024 14:38:53 +0200
> > Dragan Simic <dsimic@manjaro.org> wrote:
> >  =20
> >> Hello Andre,
> >>=20
> >> On 2024-09-05 14:34, Andre Przywara wrote: =20
> >> > On Thu, 5 Sep 2024 20:26:15 +0800
> >> > Chen-Yu Tsai <wens@csie.org> wrote:
> >> > =20
> >> >> Hi,
> >> >>
> >> >> On Thu, Sep 5, 2024 at 8:17=E2=80=AFPM Dragan Simic <dsimic@manjaro=
.org>
> >> >> wrote: =20
> >> >> >
> >> >> > Hello,
> >> >> >
> >> >> > Just checking, any further thoughts about this patch? =20
> >> >>
> >> >> Sorry, but I feel like it's not really worth the churn. There's not
> >> >> really a problem to be solved here. What you are arguing for is more
> >> >> about aesthetics, and we could argue that having them separate makes
> >> >> it easier to read and turn on/off. =20
> >> >
> >> > Yeah, I agree. If a board wants to support OPPs, they just have to
> >> > include
> >> > a single file and define the CPU regulator, and that's a nice opt-in,
> >> > IMHO.
> >> > But having this patch would make it quite hard to opt out, I believe.
> >> > For
> >> > Linux there are probably ways to disable DVFS nevertheless, but I am
> >> > not
> >> > sure this is true in an OS agnostic pure-DT-only way. =20
> >>=20
> >> Thanks for your response.  The only thing that still makes me wonder
> >> is why would a board want to opt out of DVFS?  Frankly, I'd consider
> >> the design of the boards that must keep DVFS disabled broken. =20
> >=20
> > Yes! Among the boards using Allwinner SoCs there are some, say=20
> > less-optimal
> > designs ;-) =20
>=20
> I see, but such boards could simply disable the "cpu0_opp_table" node in
> their dts(i) files, for the encapsulated CPU OPPs scenario, and=20
> everything
> would still work and be defined in a clean(er) way.

I agree, and I was already about to suggest this as a reply to your initial
post, but I think I tried that, and IIRC this doesn't work: the "status"
property is not honoured for this node.
But please double check that.

Cheers,
Andre

> I mean, if there are some suboptimal designs, perhaps the defaults=20
> should
> be tailored towards the good designs, and the suboptimal designs should=20
> be
> some kind of exceptions.
>=20
> >> > This could probably be solved, but same as Chen-Yu I don't see any g=
ood
> >> > enough reason for this patch in the first place.
> >> > =20
> >> >> And even though the GPU OPPs are in the dtsi, it's just one OPP act=
ing
> >> >> as a default clock rate. =20


