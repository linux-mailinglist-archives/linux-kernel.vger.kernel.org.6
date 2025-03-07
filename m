Return-Path: <linux-kernel+bounces-551441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F7A56C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECE2188D821
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7645F21CA0C;
	Fri,  7 Mar 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gd5HiUh2"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27235219A8D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362319; cv=none; b=W3PaZw84md0TUcD9GlCrGsA5qcAMGDv0Ho67Xb7XkhokYGsAKhSk4MgtuULfI09CavckfclDxz/xhTJMM+6KtCNYqSnWeZr45c1f+knCoGfM7u9rxaIA7gtRiZ7oZeUZx+mkdQ700Nu+CzzNUsXb7TNwv+w8EDsWBUDbR28AO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362319; c=relaxed/simple;
	bh=lFokjgXN66NU6UY7FiQpAAplCEXLV6xOpR6rSfWxUO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TKNuz1pTgaUV7wZRdJ/UOngsOp6luugvBjXm59oXL9q0nUGRI8dcEmmIiJB0nRaYDpzvnmT3wY3MYRYmQzEYeUB+gDOHhRYJNlAYZSVUNC+WdRiVEsQ3DyVj+kGmvDoDIOYcC35p0r0cn7c5H4UEgaz8C4jBJ/4uDdZC8bhipo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gd5HiUh2; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DDBA443B4;
	Fri,  7 Mar 2025 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741362310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OjuWZXi6cWhgssI2+VsPPFlins6SAB/6GLoccrMh4c=;
	b=gd5HiUh2uWuQrp2x1ZoVKEQF8UqNMs7UrM8oYx9boARoxCDMuFGa9hYTkoYypch+e3fhf3
	LB8i1kNLhzTOwkeWxJ+kXoY7gA1Vkvh1zCwI8G4aDdnBnjDPgWsQfyoy5raQMx48he/MvG
	4WQTa3jO01616/0wA6AaxBU698Ys7qiqYSgJYcmTF43Djchk1BmPP3ZX1ExpkdfFOqfsAa
	1fvBDFiJm5CHpf7TpJIBZAT3PI9rtEW+r8xtaXl8cQdtEXPmV7UlSth9anaEbgWqxJKhjG
	q60D7nh01Mr2n8nNXKPbrDLAff6wcnT+nIgdtsDci81sdoVEGawJwHWeOoz6JQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Santhosh Kumar K <s-k6@ti.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <michael@walle.cc>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  Steam Lin <stlin2@winbond.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] mtd: spinand: Use more specific naming for the
 reset op
In-Reply-To: <9004166e-5535-4024-8114-9fdb217407bb@linaro.org> (Tudor
	Ambarus's message of "Fri, 7 Mar 2025 15:38:45 +0000")
References: <20250307-winbond-6-14-rc1-octal-v1-0-45c1e074ad74@bootlin.com>
	<20250307-winbond-6-14-rc1-octal-v1-1-45c1e074ad74@bootlin.com>
	<9004166e-5535-4024-8114-9fdb217407bb@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 16:45:02 +0100
Message-ID: <87v7skrgjl.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrddujeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrddujeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepshdqkheisehtihdrtghomhdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtp
 dhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhtlhhinhdvseifihhnsghonhgurdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Tudor,

>> -#define SPINAND_RESET_OP						\
>> +#define SPINAND_RESET_1S_0_0_OP						\
> Hi, Miquel,
>
> Have you seen any reset op with address or data? If not, I'm not really
> sure whether we shall change the name for these basic operations.
>
> Changing them to 1S-0-0 may also indicate that there are resets with
> address or data fields, which I find confusing.
>
> I think the change is good for reads and writes. I'll check further in
> the series and let you know.

I want to rename this macro for two reasons:
- We might see in the near future the addition of 8D-0-0 ops (I plan on
  working on it).
- I would like some kind of harmony among these macros.

Now, whether is should be named like I proposed or just
SPINAND_RESET_OP_1S, I have no strong preference and I can change that
in an upcoming version.

Which one would you prefer?

Cheers,
Miqu=C3=A8l

