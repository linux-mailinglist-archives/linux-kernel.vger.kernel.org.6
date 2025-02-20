Return-Path: <linux-kernel+bounces-524798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21174A3E741
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD5E16E013
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3B1FF7D3;
	Thu, 20 Feb 2025 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L19XVOcB"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A961F03C4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089364; cv=none; b=otjF8DAeaA8w0nWgEu9iOSMVCWo8ENK4fTVCttxs2II8hcCn9HJDSVpylkJ8yEBVaiuOUhjQSdeyAyA+oJ0X77bIJLN9Lj7l+h9oH1Pqt89yntx4HbkUuBl5YH6jgsYfjCUoEinZwbjuddwaUlqAxC1XME9TwC/yzhtZQmNC1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089364; c=relaxed/simple;
	bh=Qk46eOwmfnB/fNW3txcLxyQ//kct9eJkKtX0ruYzmGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7HyftiD9bQE9xAXrre9WG4e512KgSrBfn/7w9SsVdLhqi1MXphZLodFmrLVD8gjMtRfjPFzROGFVdlYF9tahXkhiJhSm+df9+V++0+eh3Ewjg3UAEs6hIdssrWVjQdzBYHEoXVe/Udp8hM6y5wsZXHv/fEKh+1ycb0LhtZrH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L19XVOcB; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E62F843137;
	Thu, 20 Feb 2025 22:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740089360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XR5kIZpUVnxd7NQva8Zt0gnaC0IasQ2WCr4TJ7Zil3U=;
	b=L19XVOcBHKdvLxCS0Zx5UodskMhTSSsvc+dv4kDB9sXNQ6yMsGw9B4R9q31athnkEHjlpT
	Ml+tFdPj3xrLyvHT3QYTMIhrFtfcMFnL4XwiSuTd3ZrqvUvQIEH5w5AhHHacdx35FMuCn5
	t/sFUZbFYufljky9AHMGCnH5aZ4hTcXZDRSyf/GQtM9esLe/oLUzn+1ilqwdEKqNWggZBo
	yvpfEmC0FXlfoxjJ7WF4VbvswDBzmOVQgF6DVwWKKhOG0U07Vubeb6XA35CyToB50lTEk+
	/Nwk4PXYCvOBTcAAU6T2LcFlMAnDoRPNKqaaQI5TzWVVHcZNqIC4+fDg7AiMuw==
Date: Thu, 20 Feb 2025 23:09:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: frank.li@nxp.com, miquel.raynal@bootlin.com
Cc: conor.culhane@silvaco.com, imx@lists.linux.dev,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: I3C: Remove Conor Culhane from Silvaco
 driver maintainer
Message-ID: <174008931864.597348.8655184807057605761.b4-ty@bootlin.com>
References: <20250204161151.2179596-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204161151.2179596-1-Frank.Li@nxp.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeikedvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieejfefhffekjeeuheevueevjedvleevjeetudffheeutdffudefjeduffeuvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepfhhrrghnkhdrlhhisehngihprdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegtohhnohhrrdgtuhhlhhgrnhgvsehsihhlv
 hgrtghordgtohhmpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 04 Feb 2025 11:11:51 -0500, Frank Li wrote:
> Conor Culhane's email address (conor.culhane@silvaco.com) is no longer
> accessible, and there has been no activity from him on
> https://lore.kernel.org/linux-i3c/ in the past two years.
> 
> To avoid email delivery failure messages when sending patches to the I3C
> mailing list, remove him from the Maintainers section and move him to the
> credits.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: I3C: Remove Conor Culhane from Silvaco driver maintainer
      https://git.kernel.org/abelloni/c/6f61e5dce268

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

