Return-Path: <linux-kernel+bounces-304589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80C96223B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509631C20B36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75015B99E;
	Wed, 28 Aug 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="f1ZoVOfn"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29027158555;
	Wed, 28 Aug 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833379; cv=none; b=JZS177V+cLSUGh5Jut7E9itOYyqvMYfzzzZrjwBCsxSBAKyA/GNkTXHJyohNi2dZcKrtiTne6zoPuUtQFE7ULlTZpQCDyE821xA3XC4GI1aU9onLzxBnrrB6OpjUEQZcuzM0/zjiEs4ss8aapjkCQt4lU8tdabXL54nOc1YbBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833379; c=relaxed/simple;
	bh=TESPxoG35Yu4y7QJolsevP8Mipu70lwcubrQnddJE3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7CfQtGJr73LvOpViRRBB8zpZyCLhGDfK+Wpu1tC2CHkxuItkN7rf3BxHl5+grpS2DS9bBicQSeK8HwKyjfobPpJgw0k8l0dohAg4QxTDkp9ZxQlCCfq2SsBy1NRE/uQBAh2jlKYq2ILEa9/aNgxRRFgdzuArico39+fWCuHi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=f1ZoVOfn; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD71B148344A;
	Wed, 28 Aug 2024 10:22:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724833374; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=n36lbJ1RcZw+/6Kq/jx5kroHT/WGfkmxgJ22etZFzFs=;
	b=f1ZoVOfnrcISoaqx5OZFe/XoOd84aMa9zfM8WTNBX+4fwp3vjrTkBxnrAHXPVK0fiJ3a8V
	5ou3JlDKvDIv20hMhqmN4fTEZ06uBHfuEbHoCk5aFjZ+jNLgevz9KuuU8/1UgDkZvp9hoJ
	aeiiQUlfF/hrpAMHnOZ52VBT4ruzMEdAcmN/yocxIkRIMoYHV3OoG3nkJWRLoLhKDARvAg
	ZOIaIpkSr+E7KOueMb1823qfBLzRJ0/mqPGZuAacpOs5+TmXjMx863ufeHnBGBhsgWCmAV
	2HymNhaM1nYSKYAnlLZh4dCa1BUuxudgF8/qI7qn1o/zss3FJplOLsS6TndEiA==
Date: Wed, 28 Aug 2024 10:22:52 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Alexander Dahl <ada@thorsis.com>,
	Christian Melki <christian.melki@t2data.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v1 10/12] ARM: dts: microchip: sam9x60: Add clock
 properties to OTPC
Message-ID: <20240828-paddling-manhole-0946de0f3670@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	Christian Melki <christian.melki@t2data.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-11-ada@thorsis.com>
 <f956020f-d10e-413e-9015-d80b84a95364@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f956020f-d10e-413e-9015-d80b84a95364@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Sat, Aug 24, 2024 at 06:57:23PM +0300 schrieb claudiu beznea:
> 
> 
> On 21.08.2024 13:59, Alexander Dahl wrote:
> > This will allow to enable the main RC Oscillator from
> > nvmem_microchip_otpc driver.
> > 
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
> > 
> > Notes:
> >     This requires some DT bindings update, right?
> 
> Yes

Okay, I suspected that already.

This raises the question if the main rc osc clock should be mandatory
for SAMA7G5 too, or if SAM9X60 and SAMA7G5 should be handled
differently with regard to that clock?  Affects both binding and
driver then, see NOTE in patch 11, which is directly related to that
question.

> 
> > 
> >  arch/arm/boot/dts/microchip/sam9x60.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > index 2159a6817f44..4f0651b8cb60 100644
> > --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > @@ -162,6 +162,8 @@ otpc: efuse@eff00000 {
> >  			reg = <0xeff00000 0xec>;
> >  			#address-cells = <1>;
> >  			#size-cells = <1>;
> > +			clocks = <&pmc PMC_TYPE_CORE 11>;
> > +			clock-names = "main_rc_osc";
> 
> And this should be squashed w/ patch 05/12.

Okay, this may require patch reordering, we'll see.

Greets
Alex

> 
> >  		};
> >  
> >  		apb {

