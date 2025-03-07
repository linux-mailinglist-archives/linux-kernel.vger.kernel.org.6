Return-Path: <linux-kernel+bounces-550657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D9A56282
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA993B2D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072C1AF0B6;
	Fri,  7 Mar 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a+JqrXkz"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84839186607
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335793; cv=none; b=upHjD3muAZ1zwMeR0BfDwRdNc5XmiATYKRfsDJZxMKnm++pWXjvJ3lhDFB1JgrDDBmIPvwOd3O4Ex4e0VgtuntMOrWy6SWDoiMZgm99L+7TxHkfLyBucKgBNZymo/E14k4GxgSlOpcQ4LmcJyL6jwuWCXrdAQgBjoNDm6CkPIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335793; c=relaxed/simple;
	bh=VYXYH3Nursl7YH5mZTgIbp1tBPkKvkIol1KbKrK0QGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BsWgLE3AMAdyWbHUonAl1fks0t7RoO3w3gyWpWqtm1ULUiJuLyGKPor3YYknsFDSs11yT3zZMiYF4SVz3oW6WE0ijCGc/Qv+DUSi9bh1FRp7BoNuhZpAZxRBN6cnh3zD1AqQfR23QaPxZnYS6lsKwTvZAJDR6R9tjqjRGqCUVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a+JqrXkz; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9397F4434F;
	Fri,  7 Mar 2025 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741335782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYXYH3Nursl7YH5mZTgIbp1tBPkKvkIol1KbKrK0QGA=;
	b=a+JqrXkzg6T7EjzBwlU+bGU7X4W5BxVKF6hGKXyh38sfXQbEqL/LqemJgg3IFPD1A37i0G
	aYPUtdGJfuKZGz54sUeAiO1shUmMHXX7am3ocUyjvd1jgSoFEpKitO1Lf95pPz4+NS6MBI
	83DxVkWTVNai1phbOLrrFtrdyQ7kXDQx2d/arXlZaesj0z3w9WevNLCt1DmTPFKT6pGAR3
	TEVOw6ZpxXZCoaZLHXMnOW/6wVidGcHWtisxcrwQe8XeaUcoqWsuBsTeU/xl/p42ORq4lf
	Qvm4w6fy59ynVrgcGevgxNV+4MeCmZyGZaEJ5mmB7SdVM/yNyNkR09nhTEXMiw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: spi-nor: drop unused <linux/of_platform.h>
In-Reply-To: <20250307-spi-nor-headers-cleanup-v1-3-c186a9511c1e@linaro.org>
	(Tudor Ambarus's message of "Fri, 07 Mar 2025 09:09:07 +0200")
References: <20250307-spi-nor-headers-cleanup-v1-0-c186a9511c1e@linaro.org>
	<20250307-spi-nor-headers-cleanup-v1-3-c186a9511c1e@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 09:23:00 +0100
Message-ID: <87wmd1s10b.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrddujeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrddutdekrddujeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhmthgusehli
 hhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

On 07/03/2025 at 09:09:07 +02, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> There's nothing used in the SPI NOR core from <linux/of_platform.h>,
> drop the header inclusion.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

