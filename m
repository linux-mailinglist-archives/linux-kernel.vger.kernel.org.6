Return-Path: <linux-kernel+bounces-317097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E6196D928
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4451F280FE6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB0D83CC1;
	Thu,  5 Sep 2024 12:43:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A05199FDC;
	Thu,  5 Sep 2024 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540180; cv=none; b=h/gTyG5DPMfqpVpP3WsPdtW9bt9j2Com+1f6vHSbRG6vATnF1BsJfZbztZncMqeof8nUWEcsZNsDzF9XyIkbPJZ35hGSr8MCFaOb9LyXj+6Oit0JVFrKVbW2L0z9t1oe+Qjlf8Dn9kHMsZioIqMc99jTAcIQNnMiLmEiGhuucs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540180; c=relaxed/simple;
	bh=uHJ4CVK0M79YQsCQMD0Q281L0veqUxMJ55zxfk7CVNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fP1pvuuhJQ+XwXUDO/6t9CSe83UUtRFkKCD5R5p8Pjq4erIIbT5U3XgzCnOwGOk5fKdanJnDwkHpjsGIorVgKPTIWTCPdYVDSYnqh5DmSqXVhB5m+oBZMFC+WHj31daPCngBKG20FiAX1mxRKOgcmNPEzb2q4Lg92zQvMs0yopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB2CFEC;
	Thu,  5 Sep 2024 05:43:25 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EEC3F73B;
	Thu,  5 Sep 2024 05:42:57 -0700 (PDT)
Date: Thu, 5 Sep 2024 13:42:54 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC
 dtsi file
Message-ID: <20240905134254.6e15a1e5@donnerap.manchester.arm.com>
In-Reply-To: <b07f1365a6f942297f7a3308fa628187@manjaro.org>
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
	<CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
	<21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
	<20240815181508.6800e205@donnerap.manchester.arm.com>
	<06cec3fc98e930bedc8ea5bfde776b3d@manjaro.org>
	<0fc37f3074a3e99c15a2f441194b7032@manjaro.org>
	<CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
	<20240905133412.6ba050de@donnerap.manchester.arm.com>
	<b07f1365a6f942297f7a3308fa628187@manjaro.org>
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

On Thu, 05 Sep 2024 14:38:53 +0200
Dragan Simic <dsimic@manjaro.org> wrote:

> Hello Andre,
>=20
> On 2024-09-05 14:34, Andre Przywara wrote:
> > On Thu, 5 Sep 2024 20:26:15 +0800
> > Chen-Yu Tsai <wens@csie.org> wrote:
> >  =20
> >> Hi,
> >>=20
> >> On Thu, Sep 5, 2024 at 8:17=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>=20
> >> wrote: =20
> >> >
> >> > Hello,
> >> >
> >> > Just checking, any further thoughts about this patch? =20
> >>=20
> >> Sorry, but I feel like it's not really worth the churn. There's not
> >> really a problem to be solved here. What you are arguing for is more
> >> about aesthetics, and we could argue that having them separate makes
> >> it easier to read and turn on/off. =20
> >=20
> > Yeah, I agree. If a board wants to support OPPs, they just have to=20
> > include
> > a single file and define the CPU regulator, and that's a nice opt-in,
> > IMHO.
> > But having this patch would make it quite hard to opt out, I believe.=20
> > For
> > Linux there are probably ways to disable DVFS nevertheless, but I am=20
> > not
> > sure this is true in an OS agnostic pure-DT-only way. =20
>=20
> Thanks for your response.  The only thing that still makes me wonder
> is why would a board want to opt out of DVFS?  Frankly, I'd consider
> the design of the boards that must keep DVFS disabled broken.

Yes! Among the boards using Allwinner SoCs there are some, say less-optimal
designs ;-)

Cheers,
Andre

> > This could probably be solved, but same as Chen-Yu I don't see any good
> > enough reason for this patch in the first place.
> >  =20
> >> And even though the GPU OPPs are in the dtsi, it's just one OPP acting
> >> as a default clock rate. =20


