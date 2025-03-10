Return-Path: <linux-kernel+bounces-554659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49435A59B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEF23A8D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3F2230981;
	Mon, 10 Mar 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZdbJLhsM"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F1226CEC;
	Mon, 10 Mar 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624298; cv=none; b=llwiLi/BxqzegSkk/GnCnmE2R9QVMncWThaCQHr0fpR5NqRdRF9SQ/VE4esqFfpe5UnqW3xWHF8FQTOaPVMmdoiopkJt+eHLd+ovBCIlLs++Rc4Krjm7nENwg/lQFJ3QrDUxz6QD0oZ0TWfxqIrDP0SWVGWQsOWgswintn+0220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624298; c=relaxed/simple;
	bh=Men/YQvbniyBZCsHsLLPHLGHHkqzBckBKs8MSvuAcUg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=a+LKSuQhCew/MZU/mjXwhtsyp8bLhE8QDDFxg1nJiOV8MLLg8WeCRZSAeh+fBKnsqqY3P9QFNWGBMd4HPXQYNRoea0qP9VRzBaMA8Ptl3av7Cwrj9zRYyoADsPjyECLrHSfxTHFdxRhc93KSlGJeLOz0LgAP1Mlb8L4oQa/fdF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZdbJLhsM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA26D4421A;
	Mon, 10 Mar 2025 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741624293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Men/YQvbniyBZCsHsLLPHLGHHkqzBckBKs8MSvuAcUg=;
	b=ZdbJLhsMMvNtKlRd1B4Xxs/CP2OEBSFJQYi8sAu5+jOg/ppkH8n8f0wnGfsORUMbLDvZIE
	AFc2QC/dNL3f1ZcCeZjdFlZuvErFK6bCwsSvM1iLlT+9VxJv9pjpgg3ol8YyJtUJcaKRYK
	4i2KuWmOug8oPC9l1Xuj315Yr8zfggcfe3ai92c8dAOo8jvTb+shgcXHN4MOt7v7uyAHX9
	Z2JyH9WSexnJ0tcCb4JEiljRXVxC8vgtnlgJYx65e+JfvoEfJJiYEEJOnq2vZw1ok+u+oY
	fHo5GJw7SIp2R8a2GxA4RMD6pEbMoie43PLSn4PEVqyWWy6jZnGy0xRNqZrMPg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 17:31:32 +0100
Message-Id: <D8CQAAKOZ1O5.8JVESQPJSSM8@bootlin.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6UL SoM and
 Concerto board
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Shawn Guo" <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250310-varsom6ul-concerto-dts-v3-0-551e60713523@bootlin.com>
 <20250310-varsom6ul-concerto-dts-v3-1-551e60713523@bootlin.com>
 <63f8aa7d-fcd4-450f-b3a1-44886a29fc7e@kernel.org>
 <cd2f3c97-53bb-42f5-a3cd-4385bfda5dc7@kernel.org>
In-Reply-To: <cd2f3c97-53bb-42f5-a3cd-4385bfda5dc7@kernel.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvhedtteetheefgfejleeiledvieevleduffejgeeufedujeeufeefjeefveegudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshdrhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com

On Mon Mar 10, 2025 at 5:22 PM CET, Krzysztof Kozlowski wrote:
> On 10/03/2025 17:22, Krzysztof Kozlowski wrote:
>> On 10/03/2025 16:56, Antonin Godard wrote:
>>> Add support for the Variscite i.MX6UL VAR-SOM-MX6UL and the Variscite
>>> Concerto carrier board.
>>>
>>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>>> ---
>> <form letter>
>> This is a friendly reminder during the review process.
>>=20
>> It looks like you received a tag and forgot to add it.
>>=20
>> If you do not know the process, here is a short explanation:
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
>> of patchset, under or above your Signed-off-by tag, unless patch changed
>> significantly (e.g. new properties added to the DT bindings). Tag is
>> "received", when provided in a message replied to you on the mailing
>> list. Tools like b4 can help here. However, there's no need to repost
>> patches *only* to add the tags. The upstream maintainer will do that for
>> tags received on the version they apply.
>>=20
>> Please read:
>> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/=
submitting-patches.rst#L577
>>=20
>> If a tag was not added on purpose, please state why and what changed.
>
> And now I noticed you used b4, so I really do not get how the tags can
> be missing here. :/

Sorry, that's totally my fault here, I forgot to run 'b4 trailers -u' befor=
e
sending... :/ And I don't think it's part of the prep checks?

I will send a new version with the proper trailers.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

