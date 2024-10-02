Return-Path: <linux-kernel+bounces-347346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B198D17B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649E4B22533
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6381E7654;
	Wed,  2 Oct 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="R/dy0WlB"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCDB1E764C;
	Wed,  2 Oct 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865737; cv=none; b=rfQNZ/vNYbaMVyuE7LC5Rz8V+RzDXBmCj9iPR6hcpDe1xEReavV5Jed7F1055VHew6L7PuE/zkTu034NV/CMP7vK3YS4RYHsS3yCiNzB2fOCvmRBQqVW0GBqP5lZ1SFWf+Xn5B62gt05qbu9gVTB+Mv4VrNa11bWFEu7hQORb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865737; c=relaxed/simple;
	bh=7UxCXqyJ8nCrRWRcwzmmoBIJLqQByGpc/jGjNDqaAZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utETZA2PKf6/ynGOBtOlEXbRiwrJhDlhavJiAI/E/gpAX54f11YoT2cpzuuFVLzbbYr8y22Jr7VE0d/4y/zJRUQZog82QCbKhtfwyiIfgS81AaSTPxiDKsmw0g2TlSQx7wE0uyTl50s4nfZno2IQqx2QbSU6QOxWnv9UfrPrjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=R/dy0WlB; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17BAA148629F;
	Wed,  2 Oct 2024 12:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1727865727; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=pYaa3U+Z3FT24yI/8gBzN5pJs2DVWha8P7LuEBioff4=;
	b=R/dy0WlBIJPNhxvjnM5PHRsbvqjG1qjnKkNmcFjkNAnDBTOVHLeX8ITqyLf6nK9hiSf4UX
	W80KyeDMaFIhE0f9SbBJMrQhsIOtvHtqAKtw8v81j1aK1YIzTnZAiBRPeI3SEFbQSPapFF
	SnQgaeb+IRfpW2kqdyTLqvJaieEuauGnS+8gA0UWyeR6z+w9h3PnbhvR6yxb7x9DmgJ41+
	HpEXk3nefO1WvIFCwGQpC/Epg+13lGBM7IHmP5WUqAxiqN5jMjqgx0cDuyQa/k2x8zWkTn
	cp45udk1OBF4ZVW9atit40dIRkqoifLOxsBtrsU4wgtwuj/yd5ow0YhsRyFJXw==
Date: Wed, 2 Oct 2024 12:42:04 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: conor@kernel.org, ada@thorsis.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, conor+dt@kernel.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nicolas.ferre@microchip.com, robh@kernel.org
Subject: Re: [PATCH v2 4/4] ARM: dts: microchip: aks-cdu: Add label for LED
 sub nodes
Message-ID: <20241002-scoured-deuce-5c4729a1a2aa@thorsis.com>
Mail-Followup-To: Andrei Simion <andrei.simion@microchip.com>,
	conor@kernel.org, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, conor+dt@kernel.org,
	devicetree@vger.kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nicolas.ferre@microchip.com, robh@kernel.org
References: <20241001-sleet-bronchial-867258945373@spud>
 <20241002103044.108413-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002103044.108413-1-andrei.simion@microchip.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Andrei,

Am Wed, Oct 02, 2024 at 01:30:45PM +0300 schrieb Andrei Simion:
> > On Tue, Oct 01, 2024 at 06:25:41PM +0300, Andrei Simion wrote:
> >> Add the label property here and use the old node name as value to stay
> >> stable and avoid breaking the userspace applications that depend on those
> >> paths.
> >>
> >> Suggested-by: Alexander Dhal <ada@thorsis.com>
> >> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> > Shouldn't this be squashed with 3/4 so as not to break it in one commit,
> > only to fix it in another?
> >
> 
> Hi,
> 
> My intent here was to give credits.

Appreciate this.  And just noticed you got my last name wrong.  ;-)
Credit is recorded in this thread now, this is sufficient.

> If this approach is unnecessary, I will do squash in V3.

Conor is right here.  Please squash.

Greets
Alex

> 
> Best Regards,
> Andrei Simion
> 
> >> ---
> >> v1 -> v2:
> >> - added in v2 by suggestion of Alexander Dhal
> >> ---
> >>  arch/arm/boot/dts/microchip/aks-cdu.dts | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/microchip/aks-cdu.dts b/arch/arm/boot/dts/microchip/aks-cdu.dts
> >> index 0c3373ad1723..b65f80e1ef05 100644
> >> --- a/arch/arm/boot/dts/microchip/aks-cdu.dts
> >> +++ b/arch/arm/boot/dts/microchip/aks-cdu.dts
> >> @@ -99,22 +99,26 @@ leds {
> >>  		compatible = "gpio-leds";
> >>  
> >>  		led-red {
> >> +			label = "red";
> >>  			gpios = <&pioC 10 GPIO_ACTIVE_HIGH>;
> >>  			linux,default-trigger = "none";
> >>  		};
> >>  
> >>  		led-green {
> >> +			label = "green";
> >>  			gpios = <&pioA 5 GPIO_ACTIVE_LOW>;
> >>  			linux,default-trigger = "none";
> >>  			default-state = "on";
> >>  		};
> >>  
> >>  		led-yellow {
> >> +			label = "yellow";
> >>  			gpios = <&pioB 20 GPIO_ACTIVE_LOW>;
> >>  			linux,default-trigger = "none";
> >>  		};
> >>  
> >>  		led-blue {
> >> +			label = "blue";
> >>  			gpios = <&pioB 21 GPIO_ACTIVE_LOW>;
> >>  			linux,default-trigger = "none";
> >>  		};
> >> -- 
> >> 2.34.1
> 

