Return-Path: <linux-kernel+bounces-236194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4F191DE98
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AC2282F33
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F414F121;
	Mon,  1 Jul 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JVny6elc"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22C14B08C;
	Mon,  1 Jul 2024 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835221; cv=none; b=f8zuPPsxXYSUbhGGzoSbYHkfpCPmmsJIPBjet8l8TcsCEHqRtUWACnMxJUL4NR4pFvHdYGysE8zfN4e9Be81da5gtK7SEJDz9dGnY9G0NxQ7Tw3Ca3f/FYsQzd+FlbXb9XSHSBBq+dJe1Ib8Y1TXSJrouvbZulKZP4ck1ckTes8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835221; c=relaxed/simple;
	bh=v+TJRSFG6vtG/HKelyZ/LwaHaHnu+Zm9P7RCd+736Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwcPjtwZgj7YziL5JV3wYrYAhFV5ZIDlp9amNI6rMik5d526TsEcBHQ0SRVG6mNGsj6Pzb4HWXp45gRKhCHRn8t/brDINDecDxTds+beNuYWiRaveuwun4tzRk+1IC94qCoh/Bs0aYXp/oknLrZnHwBtKR13mfmscfO+ql7t5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JVny6elc; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 371C16000B;
	Mon,  1 Jul 2024 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719835211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aHAgr1AUMIYTiMO4TzrlpHUTP45cb4Qfb4xfsok78g=;
	b=JVny6elc1jgoGI4XXcp9685XOb/1WhzbIDIqMMVc8bmAiIXiULq08TmGFtQvJp6gRMphnh
	P6hHzN7etB6rZhYkf2U+D35pCBwZvmg7GTsmTSWciYIkcB74sCTUx83yUG03A/1vi9ExVA
	aiL2O8EQgCnssKJxeq8gpmyS5gg/Bd/7db5D4o2EmM+tc7i99XQ8UULkj1MsIpOzgGfegL
	WbM8DxJWT/KeJu8hOpnyfJeOIyHv9N3S6YEyFyuu2DKJM9wmRcY8/F8lL9i5ZThzOxEkSW
	oBTrUiA9Xdt0eVHPrcXgQ1tTAsU0+qgLkO2x1eXmEyYgdUI94jIuEC9IX27K4A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtd: add missing MODULE_DESCRIPTION() macros
Date: Mon,  1 Jul 2024 14:00:07 +0200
Message-Id: <20240701120007.525382-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240610-md-drivers-mtd-v1-1-0f59183e4005@quicinc.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f32ded4b55753131272129c58e743d175d0a3c7e'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-06-11 at 05:07:13 UTC, Jeff Johnson wrote:
> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/parsers/brcm_u-boot.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/parsers/tplink_safeloader.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Acked-by: Vignesh Raghavendra <vigneshr@ti.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

