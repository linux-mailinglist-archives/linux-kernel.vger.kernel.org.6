Return-Path: <linux-kernel+bounces-317056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0672596D8AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FBAB22CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F119CCE8;
	Thu,  5 Sep 2024 12:34:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CF719AD9B;
	Thu,  5 Sep 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725539659; cv=none; b=tGGdKcEtqOqLmiKuyQx8vJoCfYMUMCTCP2vGxcNQcjzJvbxAZCjsvTAepx4We/jJg9AjG1gVkChtPF/tQMwCSmXckqWLQ5gLCLb7sh32A4JWKSlOPSC82OKDf68Mev26PMYjU8Sid8xEKLhSooSOoPrLbsOfrwOspkxGZfyo6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725539659; c=relaxed/simple;
	bh=WaoLDSIgx75qbd67sSRqavcQwcJBnauhGsDAwwyu4sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHzAunabc5zm1bdTx1nVw+4s23+j+0tgrDf8haVXY0/dynfv6Sh0sHMbDpDW7Jj2Ot5CzV+LuYrbuPg2wCVlUC3N+oBM/8xE/mSrHCx8mJ2te/1bFmMhb0XlOBR93mUX1wvyi/tgEOdOTYb887vJWVHgPXAXN0msbHlSpgn1YG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 827C7FEC;
	Thu,  5 Sep 2024 05:34:43 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2884B3F73B;
	Thu,  5 Sep 2024 05:34:15 -0700 (PDT)
Date: Thu, 5 Sep 2024 13:34:12 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dragan Simic <dsimic@manjaro.org>, linux-sunxi@lists.linux.dev,
 jernej.skrabec@gmail.com, samuel@sholland.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Move CPU OPPs to the SoC
 dtsi file
Message-ID: <20240905133412.6ba050de@donnerap.manchester.arm.com>
In-Reply-To: <CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
References: <92ebc9cba6eb669df73efd478e4f5745056a4ce5.1723614345.git.dsimic@manjaro.org>
	<CAGb2v678Z8TMKZmBmmd5hW9XBdKw9KD+JgrsMm5e8sSoYOq3wA@mail.gmail.com>
	<21d6e75bc33ef2b7f27932fee1b8de05@manjaro.org>
	<20240815181508.6800e205@donnerap.manchester.arm.com>
	<06cec3fc98e930bedc8ea5bfde776b3d@manjaro.org>
	<0fc37f3074a3e99c15a2f441194b7032@manjaro.org>
	<CAGb2v65h8zaxoEKeqdT8BZD9t=4gf0QM7zBnhuDoiEhHQLKduw@mail.gmail.com>
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

On Thu, 5 Sep 2024 20:26:15 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> Hi,
>=20
> On Thu, Sep 5, 2024 at 8:17=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> >
> > Hello,
> >
> > Just checking, any further thoughts about this patch? =20
>=20
> Sorry, but I feel like it's not really worth the churn. There's not
> really a problem to be solved here. What you are arguing for is more
> about aesthetics, and we could argue that having them separate makes
> it easier to read and turn on/off.

Yeah, I agree. If a board wants to support OPPs, they just have to include
a single file and define the CPU regulator, and that's a nice opt-in,
IMHO.
But having this patch would make it quite hard to opt out, I believe. For
Linux there are probably ways to disable DVFS nevertheless, but I am not
sure this is true in an OS agnostic pure-DT-only way.

This could probably be solved, but same as Chen-Yu I don't see any good
enough reason for this patch in the first place.

Cheers,
Andre

> And even though the GPU OPPs are in the dtsi, it's just one OPP acting
> as a default clock rate.
>=20
>=20
> ChenYu
>=20
> > On 2024-08-17 06:25, Dragan Simic wrote: =20
> > > Hello Andre,
> > >
> > > On 2024-08-15 19:15, Andre Przywara wrote: =20
> > >> On Thu, 15 Aug 2024 18:34:58 +0200
> > >> Dragan Simic <dsimic@manjaro.org> wrote: =20
> > >>> On 2024-08-14 18:11, Chen-Yu Tsai wrote: =20
> > >>> > On Wed, Aug 14, 2024 at 1:52=E2=80=AFPM Dragan Simic <dsimic@manj=
aro.org>
> > >>> > wrote: =20
> > >>> >>
> > >>> >> Move the Allwinner A64 CPU OPPs to the A64 SoC dtsi file and,
> > >>> >> consequently,
> > >>> >> adjust the contents of the affected board dts(i) files appropria=
tely,
> > >>> >> to
> > >>> >> "encapsulate" the CPU OPPs into the SoC dtsi file.
> > >>> >>
> > >>> >> Moving the CPU OPPs to the SoC dtsi file, instead of requiring t=
he
> > >>> >> board
> > >>> >> dts(i) files to include both the SoC dtsi file and the CPU OPP d=
tsi
> > >>> >> file,
> > >>> >> reduces the possibility for incomplete SoC data inclusion and im=
proves
> > >>> >> the
> > >>> >> overall hierarchical representation of data.  Moreover, the CPU =
OPPs
> > >>> >> are
> > >>> >> not used anywhere but together with the SoC dtsi file, which
> > >>> >> additionally
> > >>> >> justifies the folding of the CPU OPPs into the SoC dtsi file.
> > >>> >>
> > >>> >> No functional changes are introduced, which was validated by
> > >>> >> decompiling and
> > >>> >> comparing all affected board dtb files before and after these ch=
anges.
> > >>> >>  When
> > >>> >> compared with the decompiled original dtb files, the updated dtb=
 files
> > >>> >> have
> > >>> >> some of their blocks shuffled around a bit and some of their pha=
ndles
> > >>> >> have
> > >>> >> different values, as a result of the changes to the order in whi=
ch the
> > >>> >> building blocks from the parent dtsi files are included into the=
m, but
> > >>> >> they
> > >>> >> still effectively remain the same as the originals. =20
> > >>> >
> > >>> > IIRC, this was a conscious decision requiring board dts files to =
set
> > >>> > their
> > >>> > CPU supply before OPPs are given. The bootloader does not boot th=
e SoC
> > >>> > at the highest possible OPP / regulator voltage, so if the OPPs a=
re
> > >>> > given
> > >>> > but the supply is not, the kernel will attempt to raise the frequ=
ency
> > >>> > beyond what the current voltage can supply, causing it to hang. =
=20
> > >>
> > >> Yes, this is what I remember as well: this forces boards to opt in to
> > >> DVFS, otherwise they get a fixed 816 MHz. Since there is only one OPP
> > >> table for all boards with that SoC, I think it's reasonable to ask f=
or
> > >> this, since the cooling could not be adequate for higher frequencies
> > >> in
> > >> the first place, or the power supply is not up to par. =20
> > >
> > > If the cooling isn't capable enough to dissipate the additional heat
> > > generated at higher frequencies, the thermal governor is there to
> > > handle
> > > that by lowering the operating frequency.  If the PSU isn't capable to
> > > provide an additional watt or two, I think a better PSU is needed. :)
> > > No reasonably sized PSU should work at ~100% of its power output.
> > >
> > > On top of that, all currently supported A64-based boards have the CPU
> > > OPPs defined and CPU DVFS enabled, so no such issues are possible
> > > there.
> > > Though, there could be some issues with new A64-based boards, which is
> > > discussed further below.
> > > =20
> > >>> > Now that all existing boards have it properly enabled, there shou=
ld be
> > >>> > no
> > >>> > need for this. However I would appreciate a second opinion. =20
> > >>
> > >> Well, since there is no way to opt *out* now, I am somewhat reluctant
> > >> to
> > >> just have this. What is the actual problem we are solving here? After
> > >> all
> > >> there is just one OPP table for all A64 boards, so there is less
> > >> confusion
> > >> about what to include in each board file. Which IIUC is a more
> > >> complicated
> > >> situation on the Rockchip side. =20
> > >
> > > Well, this patch doesn't solve some real problem, but it makes the
> > > things
> > > neater and a bit more clean.  The things are more complicated with
> > > Rockchip
> > > SoCs, but following the concept of "encapsulating" the CPU OPPs into
> > > the
> > > A64 SoC dtsi makes things neater.  Moreover, the A64 GPU OPPs are
> > > already
> > > in the A64 SoC dtsi, so we could also say that folding the A64 CPU OP=
Ps
> > > into the SoC dtsi follows the A64 GPU OPPs.
> > > =20
> > >> I still have to try "operating-points-v2", but at least on the H616
> > >> side
> > >> putting a 'status =3D "disabled";' into the OPP node didn't prevent =
it
> > >> from
> > >> probing. Otherwise this would have been a nice compromise, I think.
> > >> =20
> > >>> Good point, thanks for the clarification.  This is quite similar to
> > >>> how
> > >>> board dts(i) files for Rockchip SoCs need to enable the SoC's
> > >>> built-in
> > >>> TSADC for temperature sensing, before the CPU thermal throttling can
> > >>> actually work and prevent the SoC from overheating, etc.
> > >>>
> > >>> The consensus for Rockchip boards is that it's up to the authors and
> > >>> reviewers of the board dts(i) files to make sure that the built-in
> > >>> TSADC
> > >>> is enabled, etc.  With that approach in mind, and knowing that all
> > >>> Allwinner
> > >>> A64 board dts(i) files are in good shape when it comes to the
> > >>> associated
> > >>> voltage regulators, I think it's fine to follow the same approach of
> > >>> "encapsulating" the CPU OPPs into the A64 SoC dtsi file. =20
> > >>
> > >> As mentioned above, I am not so sure about this. With this patch her=
e,
> > >> *every* board gets DVFS. And while this seems to be fine when looking
> > >> at
> > >> the current DTs in the tree (which have it anyway), it creates a
> > >> potentially dangerous situation for new boards.
> > >>
> > >> So pragmatically speaking, this patch would be fine, but it leaves me
> > >> a
> > >> bit uneasy about future or downstream boards. =20
> > >
> > > Frankly, I wouldn't be worried about that.  When a new A64-based board
> > > is added, it should be verified that CPU DVFS works as expected, etc.,
> > > before the new board dts file is accepted upstream.
> > >
> > > Maybe we could take into account some possible issues when someone
> > > starts
> > > putting together a new A64-based board dts file, but there are already
> > > many dangerous things that someone can do in the process, such as
> > > messing
> > > up various regulators and voltages unrelated to the CPU DVFS, so
> > > everyone
> > > putting a new board dts file together simply have to know what are th=
ey
> > > doing.  I see no way for escaping from that need.
> > > =20
>=20
> [...]


