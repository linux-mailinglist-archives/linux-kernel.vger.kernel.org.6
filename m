Return-Path: <linux-kernel+bounces-302368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E445195FD54
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBCD280DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051C719D894;
	Mon, 26 Aug 2024 22:45:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48E6199E9E;
	Mon, 26 Aug 2024 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712333; cv=none; b=T6ZbPDMCR/tr8TF5PH3QPdaCEmG8bzVALCRlUnsRnyqey3+0EcTMvfukfnISp1PW4v9Lhd2bm2BuHTeuAZ16i/1jZB93DTNy5l5Ox9j9hDuLGsk456qOjJeT4NzYnVqeauaQXqhyTIlzjqICoq5nIW+Q7jSKFbNlb+TIXZU+aGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712333; c=relaxed/simple;
	bh=nlVeaFDeJycv8bOlvV80IU26OalvyxUWvNVbkeKJzrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeI2W6X4C52N+QihwoLcJ6Yi3jPY8ruHUZ7or8Ar9THlO86P19TYqUv29teXLlSUHAJxxivGLkXq3GGSPWZn0bI6gdj/NFQuZTuQhPZ40pKWFTDefb9qwG2/KL/xzY5xn71MawXdBdfbzy1JrbK3yMZkCkn/qQgt7/Ru+O+C0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E523DA7;
	Mon, 26 Aug 2024 15:45:56 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 023683F66E;
	Mon, 26 Aug 2024 15:45:27 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:44:52 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
Cc: wens@csie.org, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH PATCH] arm64: dts: sunxi: nanopi-neo-plus2: Add pio
 regulators
Message-ID: <20240826234452.0d015548@minigeek.lan>
In-Reply-To: <aa33692c-4cae-4c41-959d-f2ecd56334b7@gmail.com>
References: <20240824-b4-fix-nanopineoplus2-pio-regs-v1-1-7c5f7da445af@gmail.com>
	<761f18d4-9274-4983-a128-94efb96e1c59@kernel.org>
	<51f28d92-f670-47de-8e2d-53cbecfac081@gmail.com>
	<CAGb2v65M6Zz7=TfRwF0urbELNaaazMZYsd3dtHYzwdJvzoho3A@mail.gmail.com>
	<aa33692c-4cae-4c41-959d-f2ecd56334b7@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Aug 2024 16:24:41 +0200
Kry=C5=A1tof =C4=8Cern=C3=BD <cleverline1mc@gmail.com> wrote:

Hi Kry=C5=A1tof,

many thanks for taking care of those warnings and sending a patch,
that's the right way of fixing things and I wish more people would
actually do that!

I also checked the schematics and the H5 datasheet, so:

> Yes, you are right with vcc-pd, I misunderstood it, thank you. Let me=20
> explain and ask about the rest:
> VDD_SYS_3.3V =3D reg_vcc3v3
> Groups PA, PE, PF are powered from vcc-io, according to Allwinner H5=20
> datasheet, Vcc-io is connected to VDD_SYS_3.3V, just like mmc0. Should=20
> those be set or omitted?

Yes, you can set those supplies to reg_vcc3v3.
It seems like most of the boards's I/O (expect PD) is actually 3.3V,
driven from that one discrete regulator, which is correctly described
as reg_vcc3v3. This isn't very clear in the DT (it looks like a "dummy"
regulator), which is what probably triggered Krzysztof's comment.
To make this more obvious, please change the regulator description as
seen in sun50i-h618-longanpi-3h.dts: There should be one 5V regulator,
as the external power input, from the MicroUSB port. Every other
regulator should be "chained" to that, via the vin-supply property.
And add a comment mentioning that it's a discrete regulator, maybe
even mentioning the chip name (SY8089A).

> vcc-pc (ball G15), which is labeled as vcc_io2 (probably wrong), which=20
> is also connected to VDD_SYS_3.3V.

As Chen-Yu mentioned, VCC-PC is not mentioned in the schematics, but it
must be 3.3V: there is a pull-up for PC7, to 3.3V, also there is no
1.8V regulator, so the eMMC must work with 3.3V, supported by the
missing vqmmc-supply property for mmc2.
=20
> vcc-pd (ball J15) is bonded to VDD_PHY_2.5V, which is always on and made=
=20
> from VDD_SYS_3.3V, so I should make a new fixed regulator of name=20
> "reg_gmac_2v5"? Mainline eth driver does not implement this pin, so it=20
> would be used only for the pio.

Yes, please have another "regulator-fixed", feeding of reg_vcc3v3, and
mention it's a discrete RT9193.

> vcc-pg (ball H7) is also VDD_SYS_3.3V.

Yes, that's the same reg_vcc3v3.

> While PL is supplied from vcc-rtc (vcc_rtc, ball K6), it is connected=20
> directly to the VDD_SYS_3.3V too, should this be the same regulator or a=
=20
> new one or omitted too?

Since they are directly wired together, it's indeed the same reg_vcc3v3
regulator.

> Do you agree with my findings? I hope they are 100% now. If so, I will=20
> try to make V2 with a new fixed regulator of 2.5V for the PD.
>=20
> Many thanks for your replies, I will do better next time.

No worries, except for the VCC-PD at 2.5V this was actually all correct.
So well done, especially for a first try!

Cheers,
Andre


>=20
> Dne 24. 08. 24 v 14:34 Chen-Yu Tsai napsal(a):
> > Hi,
> >
> > On Sat, Aug 24, 2024 at 5:08=E2=80=AFPM Kry=C5=A1tof =C4=8Cern=C3=BD <c=
leverline1mc@gmail.com> wrote: =20
> >> I am sorry if the message is wrong, this is my first patch ever sent to
> >> the Linux kernel. I have checked the schematic of the board and it
> >> shares the same power line with mmc0, so I assumed I can use the same
> >> regulator. Thanks for your feedback and I would be glad for your furth=
er
> >> response. =20
> > So some of the pin groups do have dedicated supplies, and should thus be
> > described, but not all of them. The schematic only shows dedicated
> > supplies for PD and PG pingroups. So just add those. PD supply is from
> > 2.5V ethernet PHY I/O regulator supply, so you would need to add that
> > as well.
> >
> > The datasheet also mentions a separate supply pin for PC pingroup, but
> > it is not shown in the schematic. I would just omit that.
> >
> > And as Krzysztof mentioned, device tree changes should be to model
> > the hardware, not to work around some operating system warning. At
> > least most of the time that is. So your commit message should also
> > be about fixing the description or providing more detail, and not
> > about the operating system.
> >
> >
> > ChenYu
> > =20
> >> Dne 24. 08. 24 v 9:40 Krzysztof Kozlowski napsal(a): =20
> >>> On 24/08/2024 09:09, Kry=C5=A1tof =C4=8Cern=C3=BD wrote: =20
> >>>> The board does not have a dedicated regulator for pio and r_pio,
> >>>> but this fixes the kernel warning about dummy regulators being used.
> >>>> Tested on the actual board.
> >>>> =20
> >>> Judging by commit msg these are not correct regulators. Please do not
> >>> add incorrect hardware description to silence some warnings coming fr=
om
> >>> OS. Either you need proper (correct) hardware description or fix the
> >>> problem other way, assuming there is anything to fix in the first pla=
ce.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>> =20
>=20


