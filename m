Return-Path: <linux-kernel+bounces-539051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250E4A4A042
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3593AF3A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740B1EF366;
	Fri, 28 Feb 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZjHYKfuR"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5871F4CB4;
	Fri, 28 Feb 2025 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763481; cv=none; b=C6QLiuLWauhonLAJ6/qYblLAL2xNdJLVcCVmwJdhRnWTgkwQxVzBLtGLg1Hbr43xq7mSDND+2UUbIeyUreUwRcPxgMqHaA0GENjRsTOZLsc2gZhsZyMxtWcGUPcIDMdajr3R6yoSBomCW35cQW2iY8rNCQG4aXzf8SuFZBsOzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763481; c=relaxed/simple;
	bh=QxhgqHpvOR6xbCNfpUBF3xN4kdDKTxtbTr+dc49HtMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9AE5aGP3a1OfkNQuGmQa0iHJ+W2XlnSYSEG8S8mFYABIqJsOBJyPS6SGGtKNRIFpkWFuqyVfP87V4H2DWLLQcADxERYo04meKEsvqPbQkzQn8tPckWZN2R1YhFrC0hI+xOY8tKuzerTfe+kAPdkJmU9URIwOklyS4v+CptwstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZjHYKfuR; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B205A44293;
	Fri, 28 Feb 2025 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740763476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGJ4IMk/2S17LDkhvq63xf3GveG7JHLPRsDkZ58UWfU=;
	b=ZjHYKfuReiCginek0gxRtQpQEORyx0FtOFMEQHOOGYi5/rLgqlO2nBEWF2MPHmLLDJf67q
	doZ39uHef9kpzhrR07JLduVxaUly0YgJVndRcmHGl9wVHS5oezVNffdfBI2eOj9jatCRM3
	fppR4sBcN8+RCWtfldFGmCF3cUt4+ZApNx9qlWs0Br/yG67bntPHFsKy5F4wR3Hug2+BA9
	5qImyp03z9QovpbndR6K9UKlOlPC9JCSJueFHqftlrraGU02psiazdb3ign77W+G7KV2gu
	s4DfRorOuC8ghThvxbt4rHMR1A1lYdJcpfW7DbdDZXhI27GKP5eKgoVvsuk0ZQ==
Message-ID: <249cb614-5b4d-4bf2-b3ee-58534f4d7852@bootlin.com>
Date: Fri, 28 Feb 2025 18:24:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Describe the cameras in the PinePhone Pro dts
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, oren@taumoda.com, Ondrej Jirman <megi@xff.cz>
References: <20250228-camera-v1-0-c51869f94e97@bootlin.com>
 <0338826971bfdd5b771bc1c6ada795eb@manjaro.org>
Content-Language: en-US
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
In-Reply-To: <0338826971bfdd5b771bc1c6ada795eb@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefqlhhivhhivghruceuvghnjhgrmhhinhcuoeholhhivhhivghrrdgsvghnjhgrmhhinhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveeijeeiheffvefgleetjeehudfgvdejiedvtdegveeljeevheejkeekvefhudeunecuffhomhgrihhnpegtohguvggsvghrghdrohhrghdpkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehiedphhgvlhhopeglkffrggeimedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehiegnpdhmrghilhhfrhhomhepohhlihhvihgvrhdrsggvnhhjrghmihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegushhim
 hhitgesmhgrnhhjrghrohdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghikhhosehsnhhtvggthhdruggvpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: olivier.benjamin@bootlin.com



On 2/28/25 16:46, Dragan Simic wrote:
> Hello Olivier,
> 
Hello Dragan,

> On 2025-02-28 16:19, Olivier Benjamin wrote:
>> This series adds support for the Pine64 PinePhone Pro's rear and front
>> cameras in Device Tree.
>> This is based on some of Ondrej Jirman's patches hosted in his tree at
>> https://codeberg.org/megi/linux, but I have also fully reviewed and
>> re-written the code from the RK3399 datasheet, the PinePhone Pro
>> schematic, and the IMX258-0AQH5 software reference manual.
>>
>> I have tested these changes on my PinePhone Pro and am able to take
>> photos from both cameras using libcamera's cam.
>>
>> Signed-off-by: Olivier Benjamin <olivier.benjamin@bootlin.com>
> 
> I'm afraid that you haven't addressed the notes from the feedback
> you received earlier? [*]  Also, this should be the v2 of the series,
> which should contain "PATCH v2" in the patch subjects, and provide
> a summary of changes in the cover letter.
> 
> Or, did you just resend the v1 by mistake?
>
I somehow missed Heiko's feedback in my email, and therefore intended to 
resend v1, but b4 would not let me simply resend.
My most sincere apologies for the noise, I'll address the feedback and 
send a v2!

> [*] https://lore.kernel.org/linux-rockchip/5127541.31r3eYUQgx@phil/
> 
>> ---
>> Olivier Benjamin (2):
>>       arm64: dts: PinePhone Pro: describe I2c Bus 1 and IMX258 world 
>> camera
>>       arm64: dts: PinePhone Pro: describe the OV8858 user camera
>>
>>  .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 138 ++++++++++++ 
>> +++++++++
>>  1 file changed, 138 insertions(+)
>> ---

-- 
Olivier Benjamin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


