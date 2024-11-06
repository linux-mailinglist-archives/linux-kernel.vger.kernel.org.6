Return-Path: <linux-kernel+bounces-398755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA329BF57D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E205288D19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232ED208226;
	Wed,  6 Nov 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Y9Jzil5A"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87D836D;
	Wed,  6 Nov 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918578; cv=none; b=oaP6JSpo9kcd7jIH44Dw2gBOvIc76dgYtgKKC7/SI8N7+3T22VGF/vZTWlOpxrqLRw4wfw/IXAkDY0eoLBCYzqHYsFRiDbhAjCz665nH6HW9mG8gd58eeoiJ1tb8XhDsX4Qqp17egOLlZRt8/hqdLI026J2VaCJEsifI7gwP3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918578; c=relaxed/simple;
	bh=3gfijm/RLD+lXbuyRgVfXKimTXT6rUTvCVarP1pDH3Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YK3nXL++F3Bl2BwIErsVitV4EdVHEcUHoDY5CW4syPmUqrJ+6Eb2HxyInpc3CM9JOJF6AI+snSSdfDWkeK8fID1vDFBHV904ip3B14sDViuPb0F0mvVKin6lmjZ7yYuINBOjJQ+4ZCRNrNx/thoHdWHbXjUZE9//o17dU9q+Cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Y9Jzil5A; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id EF3D01019FA;
	Wed,  6 Nov 2024 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730918034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gfijm/RLD+lXbuyRgVfXKimTXT6rUTvCVarP1pDH3Y=;
	b=Y9Jzil5Av9lktyWzyjck5L5dXnYb6m0yXBzLv3pR4HmNXjiwIcJsGmIZLUOKrL6lMCt5F7
	JZRgz1b3Zbu/EXW5NJNHWy55/Zu183V1fF70x7JJF6NnVsSwvARaiXOJREA4+UE25lyXeM
	hjetEtcISGGoqhrUSt8W1UhJZejmmKo=
Received: from [127.0.0.1] (fttx-pool-217.61.145.66.bambit.de [217.61.145.66])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 2019910051E;
	Wed,  6 Nov 2024 18:33:53 +0000 (UTC)
Date: Wed, 06 Nov 2024 19:33:53 +0100
From: Frank Wunderlich <linux@fw-web.de>
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
 "Rob Herring (Arm)" <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Russell King <linux@armlinux.org.uk>
CC: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Drop undocumented SATA phy names
User-Agent: K-9 Mail for Android
In-Reply-To: <87r07p8x12.fsf@BLaptop.bootlin.com>
References: <20241014193528.1896905-2-robh@kernel.org> <87r07p8x12.fsf@BLaptop.bootlin.com>
Message-ID: <0A5AFF77-D888-4151-9C15-15A408709857@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 84d1e7cf-5cca-47d1-bd64-002501d9a1b8

Am 5=2E November 2024 17:28:57 MEZ schrieb Gregory CLEMENT <gregory=2Ecleme=
nt@bootlin=2Ecom>:
>"Rob Herring (Arm)" <robh@kernel=2Eorg> writes:
>
>> While "phy-names" is allowed for sata-port nodes, the names used aren't
>> documented and are incorrect ("sata-phy" is what's documented)=2E The n=
ame
>> for a single entry is fairly useless, so just drop the property=2E
>>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel=2Eorg>
>
>Applied on mvebu/dt64
>
>Thanks,
>
>Gregory
>> ---
>> Cc: Frank Wunderlich <linux@fw-web=2Ede>
>>
>> There's also this 2 year old patch fixing other SATA errors[1] which=20
>> was never picked up=2E :(
>>
>> [1] https://lore=2Ekernel=2Eorg/linux-arm-kernel/20220311210357=2E22283=
0-3-linux@fw-web=2Ede/

Hi

How to deal with my patch pointed by rob?

regards Frank

