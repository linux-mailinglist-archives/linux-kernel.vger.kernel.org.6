Return-Path: <linux-kernel+bounces-395016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833119BB72D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DDC285A9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9AB146A69;
	Mon,  4 Nov 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cRjLhFr0"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541AA13D53B;
	Mon,  4 Nov 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729236; cv=none; b=DbdTBqZI/ZZUMDRePQ17OioB1YH5dT60PfqA/Z6fa32eH62yvNuP5AksQHfZrbqLpBhwWKFZrtIxnupyJVJMlFXt3YqGOQMR/e4m/EONSoFgq18SKA3hD4nYQVwZPl8w3ZvDb27PIZc1kuzSK5i1Vj4SpotCX9m8y+A0kRE3f7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729236; c=relaxed/simple;
	bh=B8odhM7UPcMhmpxm3mWImmDZ/9cHGLITO4s4AdFDJWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYVhry07v4RpdJ4jZhBke3VAZvlGZoMMgTSLhP6yMfskF95qp3LQkU8Ds5BOTiQv37Gd9yXhJ9pDeSWJO5y+pXsJ0lhnQris3qB+ri5JmUquCl20mG1X1noxyaQj6W964NuCSnTrW/WGvI7j3BIsZOAWsgwpYgfsD2uJJbU4SZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cRjLhFr0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6VRgHvhRBcsiarlO81XsRqHDaYbJX07q/lfMCHSL7Vw=; b=cR
	jLhFr07FMo7N7ctDTbNF+ir8U7lbv8Gb099mzLhmfw9NZE61BKGCacgyO8LoWGeR4zCHUa6TZYYNw
	slezT1CEaDM3oMcdHt288NG/jbNqpRXra6CLMFVtbj46wnKwAYymL5wHkXL+LyheURO/DwXs0pDQ1
	+SoxkDhNAhnpJ2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7xjX-00C6ul-JE; Mon, 04 Nov 2024 15:07:07 +0100
Date: Mon, 4 Nov 2024 15:07:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Herring <robh@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: marvell: kirkwood: Fix at24 EEPROM node name
Message-ID: <9fe4cd4a-8f97-484e-94fe-b49b12f7b52c@lunn.ch>
References: <20240910215914.823546-1-robh@kernel.org>
 <CAL_JsqLLRSEaDv=Zm_LQH9cpgH2prh21+cmovgSR=pzQTuRtZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLLRSEaDv=Zm_LQH9cpgH2prh21+cmovgSR=pzQTuRtZQ@mail.gmail.com>

On Mon, Nov 04, 2024 at 07:24:50AM -0600, Rob Herring wrote:
> On Tue, Sep 10, 2024 at 4:59 PM Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Ping!
> 
> Are Marvell platforms still maintained?

Yes, but on a sporadic basis. Patches tend to get collected somewhere
around -rc5/-rc6. So i would expect a notification from Gregory
sometime this week.

	Andrew

