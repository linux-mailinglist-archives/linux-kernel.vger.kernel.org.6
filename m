Return-Path: <linux-kernel+bounces-321074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCCC97141D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC963285200
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CAD1B3B30;
	Mon,  9 Sep 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HA1fYfiy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCC1B3740;
	Mon,  9 Sep 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875051; cv=none; b=gEZ1Q5sUQy9CQld+tmtFVNvEFDKVYLTxfWNPBnlQLOIvHrZ/0Os4e0Bv9m9iykcxzcN0RHsCsX0uWc7LKipfRx4eZZ35NTXz0zybV+ut192Wye5rhtiloxtxNwP1zxl7Va6aDnnoLzkePizHBweazgo/HYq+zrqpea9aNd63Kfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875051; c=relaxed/simple;
	bh=h5LA/enNgw1sNFYXeart0ZorY5rVj4crVb/Vfqx8aUI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lP7TkxGkwmaYG3OWHslPTLnAgEo1lp8N8oiHHqohpHNQhD2kHBJ7cVGV5hCxwd6UtKSptZb5vYkQq7KVYysUptmmXxwOaWAfRPpb4ApcX6Lr3WgtnL0D9Ld1SbFE4kFD3fsPQ6C9jhTfUoPe+oXGGM4aR4RTg0Xp1F4nO7WXFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HA1fYfiy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725875050; x=1757411050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h5LA/enNgw1sNFYXeart0ZorY5rVj4crVb/Vfqx8aUI=;
  b=HA1fYfiypLp2Xd0x+Tbo5DuzRn63fI5PiZz7WFnXD/MfgwWppH/ou7IA
   K/mPqBbMe13EpuzQdojyXUt5d+GKEkwrbWAlXDLIPC1TWBCNR1qimNE61
   Ik5yQqA04nYhh5orvoQRVNuGyr2uIFlwnvxH8qXUdOAlsLR6tgErTQ6xw
   YpGWcobcwdU5UNCouyj97VuY4lRYcGSK0TqXQqMixm+Wb93DEDleZXHES
   aoR1jzcqr6puAQl0DxHA8/MO8Y8/IJ/s5NR8U3XlBvCjgdKKuPzpvo8ND
   b9/LEFHUnxZjyURkh/RVMpmaX3vcmRJ6nu8wuCKUOh/w7JmsSD23TzqM/
   A==;
X-CSE-ConnectionGUID: L5CatC7qR+24yrk0PqV2lQ==
X-CSE-MsgGUID: JW9LqD7NTV6izxZSQ6janA==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="262473465"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 02:44:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 02:43:27 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 02:43:25 -0700
Date: Mon, 9 Sep 2024 09:43:24 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 8/9] dt-bindings: phy: sparx5: document lan969x in sparx5
 dt-bindings
Message-ID: <20240909094324.u2aahgnrmxkxt7fc@DEN-DL-M70577>
References: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
 <20240906-sparx5-lan969x-serdes-driver-v1-8-8d630614c58a@microchip.com>
 <c0aa5342-a2af-4ac4-bc33-b6dbfff77f63@kernel.org>
 <20240909082241.hvw3a7yig3pujrsk@DEN-DL-M70577>
 <ee4d4375-873b-4b9c-b694-f0191e5c2c54@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ee4d4375-873b-4b9c-b694-f0191e5c2c54@kernel.org>

> >>>    compatible:
> >>> -    const: microchip,sparx5-serdes
> >>> +    enum:
> >>> +      - microchip,sparx5-serdes
> >>> +      - microchip,lan969x-serdes
> >>
> >> It seems there is no lan969x SoC/chip. Are you sure you are using
> >> correct naming, matching what kernel is using? Maybe you just sent
> >> whatever you had in downstream (hint: that's never a good idea).
> >
> > You are right. There is no upstream support for lan969x SoC yet. The
> > upstreaming of the lan969x SoC has just begun, and this series is part
> > of that upstreaming effort. The lan969x switch driver (not submitted
> > yet) will depend on this SERDES driver, however, their functionality is
> > really independent of each other. That is why I am also upstreaming the
> > SERDES- and switch driver series independent of each other.
> 
> That's not exactly my point. Becayse lan969x appears. I claim you use
> incorrect name, so are you sure you do not use wildcards?
> Best regards,
> Krzysztof

Ahh.

So the problem is the 'x' in lan969x, right? I think we have a habbit of
documenting compatible strings like this in bindings. Anyway, what I can
do is document the different part numbers in the bindings: lan9691,
lan9692, lan9693, lan9694, lan9696 and lan9698.

/Daniel


