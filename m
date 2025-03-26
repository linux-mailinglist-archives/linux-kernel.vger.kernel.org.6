Return-Path: <linux-kernel+bounces-577398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BCBA71C80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930EF1891B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C981F463C;
	Wed, 26 Mar 2025 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QbM8kxMP"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED661F95C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008194; cv=none; b=UZg9xUQEBStwqTtNoZbr8ut57TMPfCIt6qMxDGgL/A9kyZm/LLETz/aqBKFaCaZlCSksPjXeSEi/JqSIA1sjAA/MB8sbw/iBH5CEp8+uvrj30S1XAyNuIwmEokgVdR1tRXUj//RP4dZlh1UrCUF1LX8q7k/7ExujrYcu5qkoETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008194; c=relaxed/simple;
	bh=bXJ0oLNBJborP8h9cyHjqDVZTHl+kJAv4+LmY4HiteE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyZ2tSqz0bcqBs2I46/gUeqBVQv+RMls3NvKWk7d1JSBfXOlsg7NdebecqQEzZkcDli5c/OWKilNzSkhHYhBnx0meH+jin8onV8ks0mCLFhRB7HGqRwf7eTm5gWhb8N+ZLGqCo63HJtCYkCI2PJyjciJqwakF6kVddhczPZPw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QbM8kxMP; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F09EC44430;
	Wed, 26 Mar 2025 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743008191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXJ0oLNBJborP8h9cyHjqDVZTHl+kJAv4+LmY4HiteE=;
	b=QbM8kxMPImrGfqF9p3+No83/t+WyUVxfVNs/L0d0z2vUk/leyEF4Zx/TwywPHZ1Qro2CNz
	lxWvBQ9ErT6upGfp1dDLgndh/jtlfruny4TIlbRRQqQQ1AZJYPrvv97VHpA034E9oK3LY6
	gArvg8O9LO10Zttnt0OEEr2q8syIEDoFDHEK9BuUa6SKuOQIKQGhtXh6EApipoJc9djCX/
	K6VKnqDryZR0TW6NUjGFc4fo2pS9y1R7cxPj/D6wuzgZDLZW4wGqC5FI3A6mk68J6dkHqc
	B6EZe8ptg1vt4pXN/y106q8QqmkVp5SHfjjqV5+ZK2DnShFMhBkazvoAuXR/9g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  "open list:SPI
 NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,  open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] mtd: spi-nor: changes for v6.15
In-Reply-To: <b4a5c030-e8af-4724-a0aa-b53f7e08f365@linaro.org> (Tudor
	Ambarus's message of "Tue, 18 Mar 2025 08:21:01 +0200")
References: <b4a5c030-e8af-4724-a0aa-b53f7e08f365@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Mar 2025 17:56:30 +0100
Message-ID: <87a597ohmp.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeitdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhop
 ehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 18/03/2025 at 08:21:01 +02, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> Hi, Miquel,
>
> Here is the SPI NOR PR for v6.15. We'll try to have it a week earlier
> next time.

No worries, I do not need earlier than that.

Pulled into mtd/next.

Thanks,
Miqu=C3=A8l

