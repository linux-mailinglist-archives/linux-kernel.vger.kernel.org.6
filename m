Return-Path: <linux-kernel+bounces-304511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17767962125
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84FAB23B84
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FB01591E8;
	Wed, 28 Aug 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="YGqt5rhN"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D885328DB;
	Wed, 28 Aug 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830272; cv=none; b=gwtFEuvqESXNG31yzUIsaW72QtpFaL2Lu2zMNuSrMxhfv8DWheXznqX1mJiPzeP66jgpT170bv1I0djTWr3xs8N+yC2Tg9qtBH9qbB7rg4zFunw1kVR/F4xvf5HbcTUnxQbKZpbqTe5+CSXn6RUhi/ds7qRZQ2KEEIkGwL/xloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830272; c=relaxed/simple;
	bh=RVZ2WzypTVL8aXwnyta5z6xdCi/wY4px/T4jPpfoPVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbfaXliByqBa9HdhcjTe/TffXyoLaMl4f0umOzJ4VJKmYJkHgO/c10dFseRmZ3E+SFC3vnceA4LlN/mtL/oLZGXndb3eSStuUEoBFaRlMOlQO/wkhQe3Hpyr98Xq/oy8vXYhXI0olFTqjPifURomji/9yMX5+H7I9AjTK+Rv6NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=YGqt5rhN; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 216621483485;
	Wed, 28 Aug 2024 09:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724830268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mTvFLF+yscDR3yye+ivUrz/P11CO4Y8bZCNC+3JezZE=;
	b=YGqt5rhNIJ39St7tOOHVoemuVYd5/rMXiYi8EdmgACC8TdsAHxUcUe1FN94tgvWynWAlAU
	PKe2NISLCPNy4pX0Nb/3no98nY9aonaTpLg3XhI8zNFkkBtJCSvB+IglMxrr7vr9VPte7w
	Q3vBgjl+KI+0zRRDHPccIsVzY0D6oEw9vZHC2Nf8C9XZSdsRTHC37Fbhkxe40WmSYABpP9
	+EXSidqte4a6aeOp1N6796wKV5vxNGWjJPaT0Fys/Z52ZdR2nralwZTyssZljkgpYEUrzW
	No6P/LQ+NMTXxMTKovJ1bY6sSUrhuDFvbbBiNTWUqswBfca8IU8AVDE4LS0a9g==
Date: Wed, 28 Aug 2024 09:31:05 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Christian Melki <christian.melki@t2data.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v1 00/12] Microchip OTPC driver on SAM9X60 exposing UIDxR
 as additional nvmem device
Message-ID: <20240828-steadily-nearby-1fe97d4cbe97@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Christian Melki <christian.melki@t2data.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240821105943.230281-1-ada@thorsis.com>
 <717bd06f-3eba-4825-a53f-b2f9aa1c81c8@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <717bd06f-3eba-4825-a53f-b2f9aa1c81c8@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

thanks for having a closer look on the series.  The issues the bots
complained about are already fixed in my working copy and will be part
of v2.  Detailed discussion on particular patches itself over there,
general remarks below.

Am Sat, Aug 24, 2024 at 07:17:43PM +0300 schrieb claudiu beznea:
> Hi, Alexander,
> 
> On 21.08.2024 13:59, Alexander Dahl wrote:
> > Hei hei,
> > 
> > on a custom sam9x60 based board we want to access a unique ID of the
> > SoC.  Microchip sam-ba has a command 'readuniqueid' which returns the
> > content of the OTPC Product UID x Register in that case.
> > 
> > (On different boards with a SAMA5D2 we use the Serial Number x Register
> > exposed through the atmel soc driver.  Those registers are not present
> > in the SAM9X60 series, but only for SAMA5D2/SAMA5D4 AFAIK.)
> 
> Not sure if you are talking about Chip ID, Chip ID extension registers.
> These are available also on SAM9X60.

No, this is not what I'm talking about.  The Chip ID and Chip ID
extension registers are common over all SoCs of the same type.

What I need is a unique ID, the same sam-ba returns with the
"readuniqueid" applet.  The SAMA5D2 has this in SFR_SN0 and SFR_SN1,
handled by drivers/soc/atmel/sfr.c driver.  The SFR block on sam9x60
has no SNx registers, the unique ID comes from OTPC_UIDxR here.

Best thing would be a simple nvmem device for the SAM9X60 providing
just those 4 registers, in a similar way the sfr driver does for
SAMA5D2.  This is the motivation for the series and what's eventually
done in patch 12.  The other patches are just fixing the otpc driver
for SAM9X60 so I can add that nvmem stuff.

Greets
Alex

> > There is a driver for the OTPC of the SAMA7G5 and after comparing
> > register layouts it seems that one is almost identical to the one used
> > by SAM9X60.  Currently that driver has no support for the UIDx
> > registers, but I suppose it would be the right place to implement it,
> > because the registers are within the OTPC register address offsets.
> > 
> > The patch series starts with fixups for the current driver.  It then
> > adds the necessary pieces to DT and driver to work on SAM9X60 in
> > general.  Later support for enabling the main RC oscillator is added,
> > which is required on SAM9X60 for the OTPC to work.  The last patch adds
> > an additional nvmem device for the UIDx registers.
> > 
> > This v1 of the series was _not_ tested on SAMA7G5, because I don't have
> > such a board for testing.  Actually I don't know if the main_rc_osc
> > clock is required on SAMA7G5 too, and if yes how to handle that with
> > regard to the different clock ids.  If someone could test on SAMA7G5
> > and/or help me sorting out the core clock id things, that would be
> > highly appreciated.
> 
> Please add Nicolas in the loop on the next revisions of this series as this
> should also be tested on SAMA7G5. I don't have a SAMA7G5 with OTP memory
> populated.
> 
> > 
> > Also I assume some more devicetree and/or sysfs documentation is
> > necessary.  If someone could point me what's exactly required, this
> > would be very helpful for me.  You see I expect at least another version
> > v2 of the series. ;-)
> > 
> > Maybe some files having that "sama7g5" should be renamed, because that
> > DT binding is used for more SoCs now and deserves a more generic name?
> 
> Not needed, adding your compatible there is enough.
> 
> > Thinking of these for example:
> > 
> > - Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> > - include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
> > 
> > Are there other SoCs than SAMA7G5 and SAM9X60 using the same OTPC?
> > 
> > Last question: Should the UID be added to the device entropy pool with
> > add_device_randomness() as done in the SAMA5D2 sfr driver?
> > 
> > I sent an RFC patch on this topic earlier this year, you'll find the
> > link below as a reference to the discussion.  The patch itself was
> > trivial and not meant for applying as is anyways, so I decided to not
> > write a full changelog from RFC to v1.
> > 
> > Last not least, special thanks to Christian Melki on IRC, who wrote and
> > tested parts of this, and was very kind and helpful in discussing the
> > topic several times in the past months.
> > 
> > Christian, if you feel there's credit missing, just point me where to
> > add Co-developed-by and I'll happily do that for v2.
> > 
> > Greets
> > Alex
> > 
> > (series based on v6.11-rc4)
> > 
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-clk@vger.kernel.org
> > Link: https://lore.kernel.org/all/20240412140802.1571935-2-ada@thorsis.com/
> > 
> > Alexander Dahl (12):
> >   nvmem: microchip-otpc: Avoid writing a write-only register
> >   nvmem: microchip-otpc: Fix swapped 'sleep' and 'timeout' parameters
> >   dt-bindings: nvmem: microchip-otpc: Add compatible for SAM9X60
> >   nvmem: microchip-otpc: Add SAM9X60 support
> >   ARM: dts: microchip: sam9x60: Add OTPC node
> >   ARM: dts: microchip: sam9x60_curiosity: Enable OTP Controller
> >   nvmem: microchip-otpc: Add missing register definitions
> >   nvmem: microchip-otpc: Add warnings for bad OTPC conditions on probe
> >   clk: at91: sam9x60: Allow enabling main_rc_osc through DT
> >   ARM: dts: microchip: sam9x60: Add clock properties to OTPC
> >   nvmem: microchip-otpc: Enable main RC oscillator clock
> >   nvmem: microchip-otpc: Expose UID registers as 2nd nvmem device
> > 
> >  .../nvmem/microchip,sama7g5-otpc.yaml         |  1 +
> >  .../dts/microchip/at91-sam9x60_curiosity.dts  |  4 +
> >  arch/arm/boot/dts/microchip/sam9x60.dtsi      | 10 +++
> >  drivers/clk/at91/sam9x60.c                    |  3 +-
> >  drivers/nvmem/microchip-otpc.c                | 86 ++++++++++++++++++-
> >  include/dt-bindings/clock/at91.h              |  1 +
> >  6 files changed, 100 insertions(+), 5 deletions(-)
> > 
> > 
> > base-commit: 47ac09b91befbb6a235ab620c32af719f8208399

