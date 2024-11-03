Return-Path: <linux-kernel+bounces-394046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9EB9BA9A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 00:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C571C20F92
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BACF18C03C;
	Sun,  3 Nov 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kmc0Hjy7"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A218BBA3
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730677523; cv=none; b=A4J2LseMG6BsVSzIJT+5O1eZnISoJbr/SWGJ3fFzFhZeeasVnTyrACkinU+u39FJ/cJh5g1QIapAQuklJK+Q7DmmMUrqZOn4pGiU01mbDiOIfpTPTLi7enDUjFqRmxjhaozOfeTpPSPj5qK/AmMWs4HG/YVA3Aw0zjTnKbua2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730677523; c=relaxed/simple;
	bh=Et/TCAEMJ6jDbiN63WbZVCcGd36zA/mhhw/lCJ7ZaSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qsppk9cJWlf9JckWHvrDXmukRFybkd6neIPdds8eSwqfeTWdMivOTYxz46ZF4VB8njEv4vR/y5BLYs/5FnRP1Ii+00ZkiN0mUaLDaT7Mule8SpEEUE/ZZUabHGzXGvw+KUez5J5RFSTH80WpS0FVc+PFn1j8ZnuLvTig2Jjz+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kmc0Hjy7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730677517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WA3TnPACWY+URs7RqNz//gfcsatHrX5uRuzHMJzNGT0=;
	b=kmc0Hjy7KtoOQx68O0w8mM8noLDH3IBguj4ggLUZt88q578mwQHLMjjQbVabPPxiTxWbxP
	6PZaSo8rTTDjYII2b7iw8kzCKG39J0iGtvhBGSk26pUOhNiArod1sfbu8uTO6197xnFtlT
	AC09fveizbB83W+NOnhawNYkX4uO5Jg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alex Elder <elder@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Matt Ranostay <matt@ranostay.sg>,
	Quentin Monnet <qmo@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: Add entry for Thorsten Blum
Date: Mon,  4 Nov 2024 00:44:09 +0100
Message-ID: <20241103234411.2522-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Map my previously used email address to my @linux.dev address.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9a94c514e32c..55f780402f0b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -664,6 +664,7 @@ Tomeu Vizoso <tomeu@tomeuvizoso.net> <tomeu.vizoso@collabora.com>
 Thomas Graf <tgraf@suug.ch>
 Thomas Körper <socketcan@esd.eu> <thomas.koerper@esd.eu>
 Thomas Pedersen <twp@codeaurora.org>
+Thorsten Blum <thorsten.blum@linux.dev> <thorsten.blum@toblux.com>
 Tiezhu Yang <yangtiezhu@loongson.cn> <kernelpatch@126.com>
 Tingwei Zhang <quic_tingwei@quicinc.com> <tingwei@codeaurora.org>
 Tirupathi Reddy <quic_tirupath@quicinc.com> <tirupath@codeaurora.org>
-- 
2.47.0


