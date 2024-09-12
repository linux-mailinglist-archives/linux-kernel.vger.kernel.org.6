Return-Path: <linux-kernel+bounces-326665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40176976B80
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E511F220C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD101B12D9;
	Thu, 12 Sep 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="D2uHVoko";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tfCt+Cbp"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD911A2844
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149899; cv=none; b=azzDGKGBNnSsXVvvsmSdMqAXrKlXj4i/neHVaeNPtL+KALhoSFtqJzZrcrVBVQfx3bTSzV+LnBATvmtWan2gk30P8SZAE9KVOiIDu4aWnDHRUyoRMdXwFZ9ORGp0npjG5VT3d879cZ2PhGhL8saydcIFTnpw+KfbfGJjkTDazpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149899; c=relaxed/simple;
	bh=P+3Ch2RffdME/JodJgSREjtt6PmjWD98omOxI7HziA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxhZmYvFm7qOebh6cNN4BXd06D6s9T1sZQWVqGnhPNRa9MSmSoGbB/2AQS3f5gtPogN0KN3oB/TPddPZ+9bbKbv4dVuUr7YwKUAS9dMeSmGHdqmYH8o6kmr6p8aWrCzrAXtqPT6IRfGYz4B9jSo9CpxWk7g0b2vHq/OzszzfdnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=D2uHVoko; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tfCt+Cbp reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726149896; x=1757685896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4oFCpTK0ecVloYHiAmz691jkFwVgXePEzrsMShB1CE=;
  b=D2uHVoko/b5fIoILnPVDsZEcMZUcvwQfZ2yPnoPFN/NwXdUroJnygykP
   sbQyV59bSFfj8TlSrXiX9ff03ApnND33WOCIGz5rdTM9ml80t3D/lvhvT
   zIIVUajiX2AXhvrz4ZKkHs2CNJZHLysZy4LFY+haTOgP4XySPRsgp8Q8I
   NB8p0i39v907av0RsX4xm5YDtWAIbQFTlfpj8u5zEs2l0TGsRnztJaA3m
   Y9HauJAGUHUxcgLD7SeZ/jyNejDR8PGu1WBJ+VjZApfgcR1/pFynumTFs
   VrlkmcqR5KzZ0YD2I1mFCi8K4Ds4Asc1jNVh9G9UvExiZOfIZ/bD0NOn9
   w==;
X-CSE-ConnectionGUID: 5BcD8PofQxiuYNbLW0YyBw==
X-CSE-MsgGUID: 4aMNXCSmRS+ZscAbtxbWbQ==
X-IronPort-AV: E=Sophos;i="6.10,223,1719871200"; 
   d="scan'208";a="38915413"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Sep 2024 16:04:49 +0200
X-CheckPoint: {66E2F501-26-6568578B-E2E34638}
X-MAIL-CPID: 6D00FCD6D492B7B7E558D4F819CA6FDB_3
X-Control-Analysis: str=0001.0A782F22.66E2F501.00E0,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14A3316375C;
	Thu, 12 Sep 2024 16:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726149885;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=E4oFCpTK0ecVloYHiAmz691jkFwVgXePEzrsMShB1CE=;
	b=tfCt+CbpNZwyewC+Ylx3/KSdNpHenvn2k2HlXHvpzae5agh0Mlcy3nCogqBBXs0WKSJC6y
	MLKZn/U5VVdkKfFmMAWqNxur6heuKlOHgVWy8F5MmuwwlK6txGFMjRgN9x8B6BzM0SmCf9
	OoVqekX3CYwV3DiicwPhpzCc9TuRoutSM26moBdBKUoLO/AGEruM+p6pk+kpZTrV2lF6ai
	hdhaIQuOt6sH3zcqUo0VPGfap3QPO6dElxs3XO509Mxs3h924e/IoiSk1BgDDh35nt7OXJ
	KAjdLJV9bMS10nJnZ3XfdjT8f6/OZEeuRA+avv14F1KLY3Lc5tnJheNBM5e/AQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 1/5] mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and TQMxE41S
Date: Thu, 12 Sep 2024 16:04:08 +0200
Message-ID: <132aff890ed206dd313aa53482383c766a63cc4c.1726148801.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This adds support for 3 new TQMx86 COMs:

- TQMx120UC/TQMx130UC: COM Express Compact Type 6 modules with 12th and
  13th Generation Intel Core CPUs ([1, 2])
- TQMxE41S: SMARC 2.1 module with Intel Atom x7000E and compatible CPUs [3]

[1] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmx120uc/
[2] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmx130uc/
[3] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmxe41s/

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes
v3: no changes

 drivers/mfd/tqmx86.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index fac02875fe7d9..e15b9be98c2db 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -35,11 +35,14 @@
 #define TQMX86_REG_BOARD_ID_E39C2	7
 #define TQMX86_REG_BOARD_ID_70EB	8
 #define TQMX86_REG_BOARD_ID_80UC	9
+#define TQMX86_REG_BOARD_ID_120UC	10
 #define TQMX86_REG_BOARD_ID_110EB	11
 #define TQMX86_REG_BOARD_ID_E40M	12
 #define TQMX86_REG_BOARD_ID_E40S	13
 #define TQMX86_REG_BOARD_ID_E40C1	14
 #define TQMX86_REG_BOARD_ID_E40C2	15
+#define TQMX86_REG_BOARD_ID_130UC	16
+#define TQMX86_REG_BOARD_ID_E41S	19
 #define TQMX86_REG_BOARD_REV	0x01
 #define TQMX86_REG_IO_EXT_INT	0x06
 #define TQMX86_REG_IO_EXT_INT_NONE		0
@@ -132,6 +135,8 @@ static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 		return "TQMx70EB";
 	case TQMX86_REG_BOARD_ID_80UC:
 		return "TQMx80UC";
+	case TQMX86_REG_BOARD_ID_120UC:
+		return "TQMx120UC";
 	case TQMX86_REG_BOARD_ID_110EB:
 		return "TQMx110EB";
 	case TQMX86_REG_BOARD_ID_E40M:
@@ -142,6 +147,10 @@ static const char *tqmx86_board_id_to_name(u8 board_id, u8 sauc)
 		return "TQMxE40C1";
 	case TQMX86_REG_BOARD_ID_E40C2:
 		return "TQMxE40C2";
+	case TQMX86_REG_BOARD_ID_130UC:
+		return "TQMx130UC";
+	case TQMX86_REG_BOARD_ID_E41S:
+		return "TQMxE41S";
 	default:
 		return "Unknown";
 	}
@@ -154,11 +163,14 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	case TQMX86_REG_BOARD_ID_60EB:
 	case TQMX86_REG_BOARD_ID_70EB:
 	case TQMX86_REG_BOARD_ID_80UC:
+	case TQMX86_REG_BOARD_ID_120UC:
 	case TQMX86_REG_BOARD_ID_110EB:
 	case TQMX86_REG_BOARD_ID_E40M:
 	case TQMX86_REG_BOARD_ID_E40S:
 	case TQMX86_REG_BOARD_ID_E40C1:
 	case TQMX86_REG_BOARD_ID_E40C2:
+	case TQMX86_REG_BOARD_ID_130UC:
+	case TQMX86_REG_BOARD_ID_E41S:
 		return 24000;
 	case TQMX86_REG_BOARD_ID_E39MS:
 	case TQMX86_REG_BOARD_ID_E39C1:
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

