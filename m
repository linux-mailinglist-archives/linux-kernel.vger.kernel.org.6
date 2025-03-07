Return-Path: <linux-kernel+bounces-550182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E667FA55C50
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBC31718A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0A13FD72;
	Fri,  7 Mar 2025 00:56:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB985270;
	Fri,  7 Mar 2025 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308961; cv=none; b=o7soto3WNJe3FxutdT17TJH9J4AIlXWYFpQPSfDQ6XafotqOGm9X+DHGJBTAJBxzm+YLt8Tki5Zf+8IyicMp3v/0Ng79KE8edey96vYq7AgIV3YC43kNiaz+4+dODmNtId1vtLx0gLUhkG+S+FOsESa7Nok4/0pIevSuP2NLHuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308961; c=relaxed/simple;
	bh=7pZqwwAprPyeaMEDZxlPD1LzwzVajGFbBevaf2ksr8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o85ncvqMcbEP2PcZHKEXNNBzuwv0FNiqfZSYDD344B3LmDFS94Qk5KReRQ+iCwhaO2I0pjsgksV2Q8DGKFyslUCZbGDofY2r7VR4EokpyEA5Y6UBdeIZgeV6A7kedFEG6SOVdoZqZjf/6m7Jt4hqa6bHuvW8M4eLuBw94oq42FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CD7F169E;
	Thu,  6 Mar 2025 16:56:12 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19EB63F5A1;
	Thu,  6 Mar 2025 16:55:57 -0800 (PST)
Date: Fri, 7 Mar 2025 00:55:55 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Samuel
 Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] arm64: dts: allwinner: Add Allwinner A523
 .dtsi file
Message-ID: <20250307005555.2c52199a@minigeek.lan>
In-Reply-To: <2646028.Lt9SDvczpP@jernej-laptop>
References: <20250304222309.29385-1-andre.przywara@arm.com>
	<20250304222309.29385-9-andre.przywara@arm.com>
	<2646028.Lt9SDvczpP@jernej-laptop>
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

On Wed, 05 Mar 2025 19:46:20 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi,

> Dne torek, 4. marec 2025 ob 23:23:02 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> > The Allwinner A523, and its siblings A527 and T527, which share the same
> > die, are a new family of SoCs introduced in 2023. They features eight
> > Arm Cortex-A55 cores, and, among the other usual peripherals, a PCIe and
> > USB 3.0 controller.
> >=20
> > Add the basic SoC devicetree .dtsi for the chip, describing the
> > fundamental peripherals: the cores, GIC, timer, RTC, CCU and pinctrl.
> > Also some other peripherals are fully compatible with previous IP, so
> > add the USB and MMC nodes as well.
> > The other peripherals will be added in the future, once we understand
> > their compatibility and DT requirements.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 598 ++++++++++++++++++
> >  1 file changed, 598 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> >=20
> > diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun55i-a523.dtsi
> > new file mode 100644
> > index 0000000000000..01e662bdf5521
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> > @@ -0,0 +1,598 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> > +// Copyright (C) 2023-2024 Arm Ltd.
> > +

 ...

> > +
> > +			mmc2_pins: mmc2-pins {
> > +				pins =3D "PC1" ,"PC5", "PC6", "PC8", "PC9",
> > +				       "PC10", "PC11", "PC13", "PC14", "PC15",
> > +				       "PC16"; =20
>=20
> I guess PC0 should be also included, for HS400 capable cards.

Sure, it doesn't conflict with much else (just NAND flash), so that's
no problem.

> With that fixed:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Many thanks for that!

Cheers,
Andre

>=20
> Best regards,
> Jernej
>=20


