Return-Path: <linux-kernel+bounces-529472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468EAA426C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BBD3B9595
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E42561B3;
	Mon, 24 Feb 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bmOMknQ6"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52824EF60
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411617; cv=none; b=ETi9yRyqtF/4KXAem6e8XlrUR7xT57NxdzFXRuMd5FhTlk+JjlAM6uctKvCH/P+RjqqZhHH05eVjJGqWKXHH+bdxHLK9VmOrU1QuDKTgy9FiIjAwxh3UGPmo0F74XPKz0ZWUo7ALth8Oi3f3I6gn70gOK1m1ZJELqTwBxYYXJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411617; c=relaxed/simple;
	bh=a0Br5zPng5BcERHgdTJASsq7bzIYDr0lBwSIXaqab5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=btCjiNzVsDoH++LFg7Et2d1MTDaMV7rbAF+AhebLljv/GIN1jFRDssxBXW2qq5X6+BAVG/WMzYnUqRWly8p08xdu/VmTuCsEHYLvaJ/pkydVXieTL+My44I9JbMJqrQolCVnJjgKakAXqjXROLJA+Ihd0SMJZezZI0LqeKX4pj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bmOMknQ6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0CDC204D5;
	Mon, 24 Feb 2025 15:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740411613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8zu6iriu9W66WPC/B3i8sY3npwf/ydX5BDm6X9HsP8=;
	b=bmOMknQ6vEly+DJPSbonfXz4HlbSXJgbG5Qwv2sjS/Lt8VdMFEyhbA8ulGft01h728f3hX
	qsg1sxgt4VnZcxFQ4VLhgxLGA0trQZ73oo54Z5GxU+Qj+sYgtqWJX/FgFKtoX6JDm+q1Ap
	IIEKitvfB1ApisNFHpWExYUiK6cdqVN7OuDLeBwp9KYdoEJU17r6qQ9Wr6jG+zabS6L0t0
	nr3bTwpf42JyXcfkB4UY1L7NJe9nPRn7EQJjBtdmABt6HWFH+7cKQF+dDH1I/AhGyDBK3T
	rJTi9F7lnG5IRmJMQLAP2gfMmWf0d+smVMKOivaWbZ9OvnCkDVJA1O74SbH+ew==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Cheng Ming Lin <linchengming884@gmail.com>
Cc: richard@nod.at, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>
In-Reply-To: <20250224070349.446739-1-linchengming884@gmail.com>
References: <20250224070349.446739-1-linchengming884@gmail.com>
Subject: Re: [PATCH v5 0/2] Add support for read retry
Message-Id: <174041161185.1746756.367131710339342415.b4-ty@bootlin.com>
Date: Mon, 24 Feb 2025 16:40:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejledujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtkeertdertdejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeifffhueelgfdtleetgfelvefggfehudelvdehuddulefgheelgfehieevvdegnecukfhppedvudejrdduuddvrddukeelrddukedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrudduvddrudekledrudekuddphhgvlhhopegludejvddrudelrdefrddvfedvngdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhgthhgvnhhgmhhinhhgkeekgeesghhmrghilhdrtghomhdprhgtphhtthhopehlvghohihusehmgihitgdrtghomhdrthifpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegthhgvn
 hhgmhhinhhglhhinhesmhigihgtrdgtohhmrdhtfidprhgtphhtthhopegrlhhvihhniihhohhusehmgihitgdrtghomhdrthifpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrth
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 24 Feb 2025 15:03:47 +0800, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> When the host ECC fails to correct the data error of NAND device,
> there's a special read for data recovery method which can be setup
> by the host for the next read. There are several retry levels that
> can be attempted until the lost data is recovered or definitely
> assumed lost.
> 
> [...]

Applied to nand/next, thanks!

[1/2] mtd: spi-nand: Add read retry support
      commit: c2c64e15172a1def9ccd104e1e7e3d41ac5d9853
[2/2] mtd: spi-nand: macronix: Add support for read retry
      commit: da3558d940c685048245c58ea536ca6f80025c87

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


