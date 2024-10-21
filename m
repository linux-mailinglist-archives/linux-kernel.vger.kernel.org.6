Return-Path: <linux-kernel+bounces-374056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA9A9A6136
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7C5284514
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F41EB9FB;
	Mon, 21 Oct 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NikMChGk"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031B1EABBE
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504987; cv=none; b=gLnN4FKJuvbVm/pDwJMHjMR4yBCCZyF6ed/AV6nIvHYJ+Cfz3oYWPezQIR6PkwuXd24UmOKG10Nla70naCJwsXZeAxLkAX5iXH3k60EyzyQMyphkXzfW4zz50P8B4J+bIHaYkAlquoL2RRTVq8siJK9VWEBCGMOcKmbehPcpZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504987; c=relaxed/simple;
	bh=VZ/K/MXXw5QjoyzJNaNBbI9eVgTQcP9Ikp6Hi4XqNfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a65baDKMycozquTfS88P/QiINfbEKPTo2sw2yx2LZqaF79hsLkkJZARbUmyqE5F/F5ZOsWdX6XwNTF5w4MvzpbSajo2uziaDc8bBINYFTNdCQvi9L+uALIa/YT2NOUXxlr1mYG9mFSeo1RAvUc7pi3Z5HwDbwW5t/3F0gY8GgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NikMChGk; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BB976000D;
	Mon, 21 Oct 2024 10:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJZhQ6CMjsh3YkdMElA00TYYsXFupRYN7sb3b64Oh9A=;
	b=NikMChGku6eQx9kABXAlD79s3Qn7zq2DO1RJNqh3UTT7sBjzMxS8ljQxDQEmhAFkJ6GyZh
	U7KlvWFFPcTWiG64erPJ6ra/8CVQikIuDFqqCQ/34BXcUsF+tOKkHi1TV797GRg5pDo6WD
	8Uo56Nzf3mQyoivcQQWDGsWqflDac18P5O8FVRANc7G+kOIgxGa3tzAMnVe2WmNQA6hgyG
	4DtecHuYev46Mh79+SAztbbXCkekOagvu0khOXpSw42InsOaUA/+9Y1PocfYwY2osLMTvR
	BwtYYz454G12aGLtBQJF8NgqDdEPLaKx/P0ndzLpGsimylKYNJ61sQhXV/9SxQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Shen Lichuan <shenlichuan@vivo.com>,
	computersforpeace@gmail.com,
	kamal.dasu@broadcom.com,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	maximlevitsky@gmail.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	richard@nod.at,
	michal.simek@amd.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] mtd: rawnand: Correct multiple typos in comments
Date: Mon, 21 Oct 2024 12:03:00 +0200
Message-ID: <20241021100300.173547-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923065649.11966-1-shenlichuan@vivo.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8ab1b51fa45e29edcbd887208f046a2af0e92a08'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-09-23 at 06:56:49 UTC, Shen Lichuan wrote:
> Fixed some confusing spelling errors, the details are as follows:
> 
> -in the code comments:
> 	remaing		-> remaining
> 	alingment	-> alignment
> 	capabilitiies	-> capabilities
> 	operatoin	-> operation
> 	decriptors	-> descriptors
> 	stareted	-> started
> 	Unfortunelly	-> Unfortunately
> 	compatabable	-> compatible
> 	depenent	-> dependent
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

