Return-Path: <linux-kernel+bounces-260712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13B93AD49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0925C1C208DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294017602D;
	Wed, 24 Jul 2024 07:41:22 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367D71B3A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806881; cv=none; b=SmsYCIuyJ0iC7FFuSmzUXccWh/QUVz/snzGut5oIZtxkoju9EP575TQfRPBI+j/XzOmtugndeXQjlqWei0BYREcvIS2k7kNQNKxOcVw6MnZ1T96z6KsMfiGRxntgC/OzbSXYe0Pv7MSSC0p9Kj/MtylNrApeajiMoA4PpeWS4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806881; c=relaxed/simple;
	bh=hE8ktlpj2I0sEfyauUuSarz3WiB52KyQR97yUyk6ygU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=T7nIgzSM1ot8TZ0qjLnY2QORRQXW/3nhDJK0qRq62EcgmIckVA6llxAdHoUchFYXWOKLucE9DrkiPCY9/Sdsg0TARVOAtMGIHzMrYi+B1n63bctSwHhG/HkHUnU2o32txiRC6eI9TIDV3QLMu1JXDFD5KLtapD+Yx4WzBxwq2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866a0b015e42-d2e6e;
	Wed, 24 Jul 2024 15:41:10 +0800 (CST)
X-RM-TRANSID:2ee866a0b015e42-d2e6e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866a0b01526c-9c7a5;
	Wed, 24 Jul 2024 15:41:10 +0800 (CST)
X-RM-TRANSID:2ee866a0b01526c-9c7a5
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	zhujun2@cmss.chinamobile.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/virtio:Fix the wrong format specifier
Date: Wed, 24 Jul 2024 00:41:08 -0700
Message-Id: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The unsigned int should use "%u" instead of "%d".

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/virtio/ringtest/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
index 5a18b2301a63..e471d8e7cfaa 100644
--- a/tools/virtio/ringtest/main.c
+++ b/tools/virtio/ringtest/main.c
@@ -276,7 +276,7 @@ static void help(void)
 	fprintf(stderr, "Usage: <test> [--help]"
 		" [--host-affinity H]"
 		" [--guest-affinity G]"
-		" [--ring-size R (default: %d)]"
+		" [--ring-size R (default: %u)]"
 		" [--run-cycles C (default: %d)]"
 		" [--batch b]"
 		" [--outstanding o]"
-- 
2.17.1




