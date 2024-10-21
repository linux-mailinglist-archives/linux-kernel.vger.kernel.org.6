Return-Path: <linux-kernel+bounces-374044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851C9A6106
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2201F23D40
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C2F1E572F;
	Mon, 21 Oct 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NNGjL8Wf"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00771E5716
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504946; cv=none; b=El82LiFQFfoFSBnVO71KHEwr9pd8AMUjQTfSOVzhwbgP+CJIr9VyXoaN27m1mstpysI/5tYbeMTrDwKbLlA6Y1VeM9owxLonYG6rm5iXE6tFlcJTRDYtSxNgXXsuozZoFZdcbjRLvzPkyh3fc2CLK68jzp5z2MBY7MKNOEz2RTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504946; c=relaxed/simple;
	bh=Y69u180EiHITWa8zp97o1zqMOgEBQPqr0jrzjpaTr9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyVBpw8S05AmOSD4rj4iI3fRFHihIWLEyrJJp+HwokZzi2Vz0FhIlYHLH3Gg3aGH44gZ3IveHieThXUSpgSZWfEyBi+E3Bzf/Ql80hX+UpwCdcZVENbbkwelfPZP52f1SsNMs7MThAyn0kHQPm+a+GZ2x/LqHrwfzgXLLd+aicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NNGjL8Wf; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1DBD240003;
	Mon, 21 Oct 2024 10:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvxIJEkIpMCFwUT4H7ccPVTQW18WobfYy9Wn/MtPQ18=;
	b=NNGjL8Wf/4yaEvDBev+kCrUwCIuqjGRKdH0A9lYnUdoctZi28bmg9XOuOQNGcByqZLtFTa
	gEp6E6nxLO1r8/XR8k3NswL2IirEMEuXTOyZxxhwo/mUlbhswM/HpcSQ+nWp8WSj07TIR2
	kTSzJI276lI73kjrzlsjKnV1fd0gCW+X3M6aNNampGrvEQFvgHtw6fslZeEJqe0DV+/dxc
	flGxFkDnlmS7fyQ3tw1w33OUOb/pA24ZVZVP+QJyCVvYL2Y8REh+J5/QJQKmSi/bqnIe47
	IKIDQV8AFHW6rEz8M830Bgrc071fSIRj1pn6t98E95nG6uisqk6yr+j6paqYHQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Han Xu <han.xu@nxp.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add mailing list for GPMI NAND driver
Date: Mon, 21 Oct 2024 12:02:18 +0200
Message-ID: <20241021100218.173185-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011182603.346435-1-han.xu@nxp.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'7b2e57c26d45d55aa00d9f2904db12633596ffdb'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-10-11 at 18:26:03 UTC, Han Xu wrote:
> Add the imx@lists.linux.dev mailing list for the GPMI NAND driver.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

