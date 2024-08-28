Return-Path: <linux-kernel+bounces-305255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0798A962BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3681C23D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FDD1A4F0C;
	Wed, 28 Aug 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MQYRoGTP"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E821A2564;
	Wed, 28 Aug 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858222; cv=none; b=aBsXrDQePHZ0IzfVsVJNN9QjHQY7f21UrVc0UtfzSuCJjfXRT4H4Kk1e0HLqeiYjO/ZYmLCTcNWDz48nXK7JyKGvQmoho+buPC+iCaxz5OX3C1SBFyLlC5cHpbmLFDuPk6wa9RxlooCafpmQ9tq/9I71RaftuV/NiPFcYmZ58HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858222; c=relaxed/simple;
	bh=m2LJPV/xv2gr2TpnpPHS6gazUaUtlhauhnAOhX1T3OY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=S3lXV+x4lcPwvxGAi/r58jx9558IxJ8hPofVjFQZ+kQeb6KUZABGUiqIDG4Y68L/QZaMnqpQB5KdJQi11nV07NgFZDY1gk6Tb6ocS/7Fj0my0jXm+5GuOPHJzxRHoTRLDl2a5Ir5kZSOpbsRgyWnhgsp7mbzAXUzqJ3i2o3OAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MQYRoGTP; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2238EC0007;
	Wed, 28 Aug 2024 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724858211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m2LJPV/xv2gr2TpnpPHS6gazUaUtlhauhnAOhX1T3OY=;
	b=MQYRoGTPQ4nxGHNWBrjt+t8MFmNFBl4WF98zHoNDVP24pfr1z02sQoK76WStOCvfxMIA1R
	dp5HcxJOVkQM5Ik+IvZT4V8PemFEfp6DiM6kNkYje4oh+4+9ewoIudZv2B/ukxpPkKC3GF
	0QLY0kGk0Dw30hpvUpYqSIOFP5FQ/akkg8MIfqni3kNIMC75K7Ugulbd5Hii2PQog6YkzO
	UcaAu2GYPpQFxXzoOZKNdwxrIGXfliHpqdpQQRDiQ3vuPEzSb15pbWvPOPWZ65p5pOgH/E
	fjt39tplPOqg4Ce2nRBE9/pjRzbinB7KBJzePCnuT6v+WthbHHqf72jsv3yJYg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Aug 2024 17:16:50 +0200
Message-Id: <D3RN7EPR2YWE.1VJ7Y8ZXCWF5R@bootlin.com>
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH RESEND v3 0/4] Add Mobileye EyeQ clock support
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240730-mbly-clk-v3-0-4f90fad2f203@bootlin.com>
In-Reply-To: <20240730-mbly-clk-v3-0-4f90fad2f203@bootlin.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hi Stephen,

On Tue Jul 30, 2024 at 6:04 PM CEST, Th=C3=A9o Lebrun wrote:
> This is a new iteration on the clock part of the Mobileye
> system-controller series. It used to be sent as a single series [0],
> but has been split in the previous revisions (see [1], [2], [3], [4])
> to faciliate merging.

What's your state of mind on this series? I am happy at how it turned
out and believe the whole system-controller for the platform is modeled
properly now. It works as expected on real hardware. Pinctrl got in.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


