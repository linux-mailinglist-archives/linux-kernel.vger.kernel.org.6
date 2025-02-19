Return-Path: <linux-kernel+bounces-521634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB8A3C031
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C633A4844
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3D519CD01;
	Wed, 19 Feb 2025 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R/XiG+vc"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206BF15B971
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972277; cv=none; b=IDEI0lUzOC062GDObKLW/vGSJs3eNd/ESS0Ya0zQ+0aaP5AZdTVSW5yhZYhO/4IXBp06HORuwtfIjyfXqOKYvQI0av+EdANO2MlgEduQinBxC7UY+MXa6eJX+we8laykNsEEdzNgWIl6AVJKsoq6c4BB+lV10kjVbCgtPr3SdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972277; c=relaxed/simple;
	bh=xelb3uTbyJbD6ziZm0ICtkbfAe0dxfj9+1SMig9luXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KjBVlq2/8sUFSl6i0r9YHQJRPJ4PLihadi7JC9ZMvEFDA5NHJlpdxZ8LSVJ/3BDLhi+tS2OgiEgsNAxDZs/VJ9ThOfNRL1IkxcV2rq6OjKHAsUx673fSgAiPlmNJoib+M0zS1pp+SCpemGx1JOylU7aFrtAIEilkiStSBQ/x3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R/XiG+vc; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88687441A1;
	Wed, 19 Feb 2025 13:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739972273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NKhJ/Q8IUhIvUPdebLpQjQhKk2oKj3YTLMTrfN7R7g=;
	b=R/XiG+vcgXEwoHPPxo7DQgQOu364eE0gUT7tOlyJQ1UJhTtObADApSOUrY5LEaubgLC2fC
	vNbKpASviEuUl1WJYUjKd5L8PQEVjU8OZRH3JLR7cTAQ+ki3yJqvk0ACFq+VAuR+Zwm1HO
	lNDrNG0m5UKM4yJQDPobCOnxuQ0mGJZ++enLNJnJLaQihtcPLUANYdgYub45jLDSHgnph7
	mc+oCIsY+7VPDqzmPQv8MTdsJMj7QQLzPRUvK4MZsA+rDvxCmxAYQMmkavt8XR8pUWgd60
	YaUZy4OCymUOAPkqsJeRD7YlnfJ8QqA11tHWSRIEDgIjSpstEuS09VUC6iVO+g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Terence Eden <terence.eden@shkspr.mobi>
Cc: maximlevitsky@gmail.com,  richard@nod.at,  vigneshr@ti.com,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: mtd: rawnand: r852: [PATCH] Fixed a spelling error in the comments
In-Reply-To: <CAPFVDHob_mna4DRc91cNVAF85px91NV7gjJr-kbY63EYCnJ=EA@mail.gmail.com>
	(Terence Eden's message of "Wed, 19 Feb 2025 11:59:10 +0000")
References: <CAPFVDHokn+kfyk9AxTHuBJjRKMNJjZy8w=e-qzvXaA8Vfcq6Dg@mail.gmail.com>
	<87o6yzs6c8.fsf@bootlin.com>
	<CAPFVDHob_mna4DRc91cNVAF85px91NV7gjJr-kbY63EYCnJ=EA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 14:37:52 +0100
Message-ID: <874j0qqclr.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeegfedtfeelvdeigedvjeelgfelgeejhffgueelvefgtdejheduffehvdehgeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepthgvrhgvnhgtvgdrvgguvghnsehshhhkshhprhdrmhhosghipdhrtghpthhtohepmhgrgihimhhlvghvihhtshhkhiesghhmrghilhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvr
 hdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Terence,

On 19/02/2025 at 11:59:10 GMT, Terence Eden <terence.eden@shkspr.mobi> wrot=
e:

> Continuing the work of Commit #8ab1b51 /
> https://lore.kernel.org/linux-mtd/20240923065649.11966-1-shenlichuan@vivo=
.com/
>
> This fixes a spelling error in the comments and removes an errant newline.
>
> Signed-off-by: Terence Eden <terence.eden@shkspr.mobi>

I'm sorry but the formatting is still wrong:
- Your commit title should be "mtd: rawnand: r852: Fix a spelling error in =
the comments"
- I recommend you use git-format-patch or b4 to format your patches,
  which will prefix [PATCH] automatically.
- You need to increase the version when you send an iteration, this is
  v2, next will be v3 and this must be also done automatically by the
  tools, the final result should look like "[PATCH vX]".
- When sending a new iteration you need to give a changelog, and do that
outside of the commit log, ie...

> ---

  ^^^
Below these '---'

Thanks,
Miqu=C3=A8l

