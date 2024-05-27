Return-Path: <linux-kernel+bounces-190562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF78CFFDA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A655DB22EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794B15ECC6;
	Mon, 27 May 2024 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="klLEQzcT"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920D15ECC0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812328; cv=none; b=FQPDcSQNIieai/10vTJHqKOEBU6/kK+N4KDG5n+mxQvRHuQE3uchFP5zmQe9mLuc+ZFTjwnohQe6LXeA+Ai4mKdKuhnXkuhK2fG++JGGznHCgIDjL+eFvCe/laSxotUtXMHPJdKSvAcPt8YjQnj8QlPbsLjzzJ/i4/hpYe1g/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812328; c=relaxed/simple;
	bh=PrfAnfyHLTbfnvzQptfxVcqPG0YAV1cfI+USlWn0A8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdeQrxWAtX9aCNjFv+Znc60QC5Hqtrt/69J+hTg1tPgZjuu/rZ7EY1vAs2KlEMRQozL1MhfT0+u9C8S6Lj+nbV0nKCq3/ykDUSodjeiBHdlF/01nGvHHhWJyV0xLaURpZS802oOL9tQ1jmNZ/0WYs/Bo28uwAuM6i9jkQ3kiNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=klLEQzcT; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54D0260004;
	Mon, 27 May 2024 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716812325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hl3bQkHPFQ8/GmMTrEZ8jjN3v05GyKb6fkNFzKHfs8o=;
	b=klLEQzcTpq+3jqfXJZKwvnMPd9bKZdt7pcRbu5eiRCqVNiLXolAfp795pI/vjhPJwpWp2o
	zqZI0/6a+0rqVWnbZmdzku8gW0kKR1vVAQ7CIDxcIs6zwtZomYvpcK87gDAq9UsEZ+5kT2
	l4mr5tIhJr37NaFLkIuPOkckGphUitGknL0BKx7P7jwIGdeYEVsrfGyzMht1v16tCAu2Fd
	y38gy9u/vbRNrraycvGsUBWkYsvjEm3ws2wdsIwNgHD8npY3jl+fUaj0TnJN5eQ4lIwz+P
	QOeO1ntIB4cTdNH6FgbTf5w2EBs7MakdprzL1m5eG50nVZjRth+gfa77tzrgtw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux@treblig.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: cadence: remove unused struct 'ecc_info'
Date: Mon, 27 May 2024 14:18:44 +0200
Message-Id: <20240527121844.178514-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240525202529.120792-1-linux@treblig.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bcd904d0da4ad2746f7a62a2f70e705b7031f906'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Sat, 2024-05-25 at 20:25:29 UTC, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'ecc_info' has been unused since the original
> commit ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD
> subsystem").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

