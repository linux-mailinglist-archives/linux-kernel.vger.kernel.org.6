Return-Path: <linux-kernel+bounces-519565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D206A39E15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B61188A6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD282698BE;
	Tue, 18 Feb 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="REM1HypR"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFFA263F36
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887084; cv=none; b=ir5fy3RYHfEsX9ZYzpNrta2W8rAQzRrFERB3RA9MCyI+YvrOMXoWIVWdGD1O3+jSuAQ+FW1fthKeHZMDA/Essg+9UzToN+2HhQy6qfo24ZS/2thS9mQQWDTWNjVyIoHKl2bWZZltMdZ6uF1CsjQN+HBaTUWXwghvNRDcnv8QAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887084; c=relaxed/simple;
	bh=8xlBvlT1ncNuT1sCXGrTRplOr5KkFj1epDesmlYbJOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dW05AHoW8EAhUEpOl27f68S3KIa54ynKn9qjHd5l2WGFgYvPXctnOv7qjC1YLIzt6x/vR56pgOWC+rdgd/fMATB0j76UZzjl3rUBwLMHRITEaNQuURaah2+FWjlDj35oInMs+t7wQWNyPhFUgTGcGTa0z+6e3kXtuwoi7gH6D5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=REM1HypR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06CFA44433;
	Tue, 18 Feb 2025 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739887080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xlBvlT1ncNuT1sCXGrTRplOr5KkFj1epDesmlYbJOQ=;
	b=REM1HypRKk4WKtQ4dKkZZ088MQh01odk+WoUWHcTP3hn/DTdUYCg+jzXGMIUglgrZ6MldV
	2ZuEkjWXuuX6HzjCgQs2FFChVIDaekrzqm2uaiB65FKMtKCqRbCCzZCTheq+IMan+gIWSs
	jNT7IXeUF2xiTQ/SF3ov88eli51ZRx12BSPIfBRmXNo2zeXCC99Fl3X6dXhd1OVPcYacgS
	dVTXneD/bqdtQmS4vDnpZ1HtWRT/QwUqnjwL1aUIBhMpHznrlJ8OpBRGTn4qlfNt+2A9Yz
	jCvLwdIV6/uZWHCScuc6oW37UA4j2ac3L82vV+6EU6trtbeXciiYddSu5npLyQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Terence Eden <terence.eden@shkspr.mobi>
Cc: maximlevitsky@gmail.com,  richard@nod.at,  vigneshr@ti.com,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] Fixed a spelling error in the comments
In-Reply-To: <CAPFVDHokn+kfyk9AxTHuBJjRKMNJjZy8w=e-qzvXaA8Vfcq6Dg@mail.gmail.com>
	(Terence Eden's message of "Tue, 18 Feb 2025 13:21:42 +0000")
References: <CAPFVDHokn+kfyk9AxTHuBJjRKMNJjZy8w=e-qzvXaA8Vfcq6Dg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Feb 2025 14:57:59 +0100
Message-ID: <87o6yzs6c8.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeegfedtfeelvdeigedvjeelgfelgeejhffgueelvefgtdejheduffehvdehgeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepthgvrhgvnhgtvgdrvgguvghnsehshhhkshhprhdrmhhosghipdhrtghpthhtohepmhgrgihimhhlvghvihhtshhkhiesghhmrghilhdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvr
 hdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 18/02/2025 at 13:21:42 GMT, Terence Eden <terence.eden@shkspr.mobi> wrot=
e:

> Continuing the work of Commit #8ab1b51 /
> https://lore.kernel.org/linux-mtd/20240923065649.11966-1-shenlichuan@vivo=
.com/

While the diff is obviously fine, I'd prefer if you could write a proper
commit log.

Also the title should be prefixed "mtd: rawnand: r852: "

Thanks,
Miqu=C3=A8l

