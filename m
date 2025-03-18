Return-Path: <linux-kernel+bounces-566508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACAEA678FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEAC425820
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E3320E6EC;
	Tue, 18 Mar 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KFMhNaM2"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDDE20E032
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314633; cv=none; b=RzyEnqPa7W5OQNhWb80b4gB7ZpjoereKSr1GnoFQCcNp3LBWpc9IvPvyfU9eHbWVl8AQ0DvB8TtPDH99uifpGwcLS7LAs86rUmzJLmHYN9vprOdJEYldivXY+0qfBKF1cwx79SsId88oXobIRoiLRDufhnGxcrHnQAj5RC7tyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314633; c=relaxed/simple;
	bh=XzfXbxaaJ94ghDS0wLR9PIRYCqP3c89Qe1Vxv9SXXtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjVZac7Cm/rqjnfHun3rGbX2vLqZfcVb83ZRsry4e1F2vDvPjsvOgfRSTslZPm+ox2yvCbT89AAIq1rtcFwbnwFRAeLPh0jjOprbuA1YKbVEbNeXD/GeVwMF+6QHanPk+qlTLEY9dmO5Q4QYn+IRtP/ARR4vCt5AWEwcIaorU3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KFMhNaM2; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD8B544185;
	Tue, 18 Mar 2025 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742314626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MC2A6PNfzll9VLItZ+nZI46h7G7PS7pxgkQea5MRVo=;
	b=KFMhNaM2YdK0R5QUeFTiQUkvmUkvMJMxBw0kFjGpQUDGJIF6502dLuf8Upx6G+QsxRdE4k
	2Q6lNB+/PmEX0otv5IMxZnveG0SRso2jFHjWBttpF0cOUEF4Ut3eWt32P9ObRu2NSE2S85
	aTw/IeCwaey76sc+gJkJcMcV/nLdN8deqqcHMSSBlL/la4St2ouL/B2bdNYq1BKwUmluNO
	0KuM9Y0elvr5xRcFmGCRTSEDCmY9vtGdHGIJmYrIzvVKta07nhMq9T/yj0tHz22L05d3A/
	I8NgNWSk3UW9UIuwQlGuy5nII3dbjAAojYVS6Mqwc10NV66UuSkCkUvbVSINCg==
Date: Tue, 18 Mar 2025 17:17:05 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: frank.li@nxp.com, miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org,
	Stanley Chu <stanley.chuys@gmail.com>
Cc: linux-kernel@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2 0/3] Some fixes for Silvaco I3C controller driver
Message-ID: <174231461561.2047387.4537921401617051173.b4-ty@bootlin.com>
References: <20250318053606.3087121-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318053606.3087121-1-yschu@nuvoton.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemugdujeefmegsjegstdemjeeitgegmeefudefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemugdujeefmegsjegstdemjeeitgegmeefudefgedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehfrhgrnhhkrdhlihesnhigphdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqiheftgeslhhis
 hhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehsthgrnhhlvgihrdgthhhuhihssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhgvrhdrmhgrihhmohhnsehnuhhvohhtohhnrdgtohhmpdhrtghpthhtohepkhiflhhiuhesnhhuvhhothhonhdrtghomhdprhgtphhtthhopeihshgthhhusehnuhhvohhtohhnrdgtohhm
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 18 Mar 2025 13:36:03 +0800, Stanley Chu wrote:
> This patchset adds some fixes for the Silvaco I3C controller driver.
> 
> Stanley Chu (3):
>   i3c: master: svc: Fix missing the IBI rules
>   i3c: master: svc: Use readsb helper for reading MDB
>   i3c: master: svc: Fix missing STOP for master request
> 
> [...]

Applied, thanks!

[1/3] i3c: master: svc: Fix missing the IBI rules
      https://git.kernel.org/abelloni/c/9cecad134d84
[2/3] i3c: master: svc: Use readsb helper for reading MDB
      https://git.kernel.org/abelloni/c/c06acf7143bd
[3/3] i3c: master: svc: Fix missing STOP for master request
      https://git.kernel.org/abelloni/c/0430bf9bc1ac

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

