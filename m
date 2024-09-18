Return-Path: <linux-kernel+bounces-332692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B224B97BD38
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2ADC1C21775
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C518B476;
	Wed, 18 Sep 2024 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diekuehnen.com header.i=@diekuehnen.com header.b="BD6KQBFX"
Received: from mail.diekuehnen.com (mail.diekuehnen.com [78.47.205.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83818B46E
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.205.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666919; cv=none; b=bz3poL+g16ChxHvtKeTdyht8iK7zzg9lRqzKVo6YeRCMjN71viHT9NQsAz7BSTIcfmy14UVhklAZvO4G5peuXX80XzZu4ykDo6AbNnUp+1jsTFDz4QR8sPM/GG7XplC64+zjCUu25U8m3rgcVwarGHFB/DoP0Ci6LOQkYpyp988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666919; c=relaxed/simple;
	bh=fw8m8qS2iq0UwtgMVHq6qAzX0bQfvkLoR4STxt7Kh+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omdpOkXQsSDnLIwuI9IfCgUM5AGuyHaCOV4alNEfKIxXEnwmSDu5PA2BH/uYCCe4bVNgk4aY2odS4h19z4m5J+bP63eYNd7MnFoWsDEzuVfvcfGYxGxw4kKLaent9zov8ooFQLe6caczNKsniDvyxTBs481G3RpVQNh5QkwoS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diekuehnen.com; spf=pass smtp.mailfrom=diekuehnen.com; dkim=pass (2048-bit key) header.d=diekuehnen.com header.i=@diekuehnen.com header.b=BD6KQBFX; arc=none smtp.client-ip=78.47.205.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diekuehnen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diekuehnen.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16B377DEEB;
	Wed, 18 Sep 2024 15:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=diekuehnen.com;
	s=dkim; t=1726666474;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vFY1Q/yY/2f1ySUxHG7WeFHTFi9YXR7Cv/l4WMqD5Vc=;
	b=BD6KQBFXw0mdb9jAo+lTa7ijwv9y+tHJzgQ4YmvC6+uhXxu8GlWCVa8udgZxjz9+E2Sf1V
	4yk3JLhQb7Aq9CcKS59MbOUecED6CJsJeovWM83OPW1AP34XM5Dir4C+B0hNxxvhpJ4x7M
	LsKI7rNJdZ7vJCToJMhIw71Hu8V/dOuNXdPxWWPPYtdf7ONZc13KQ/yFQSbz2ZVhQNgpDL
	zOiTcAtp0Vu24VzUx2RugaTKmwIrm0GdM8a0HYN3DbQeFX8QwhlFJUwUrzGj8KhJi0jXFx
	BcMq8twOgEcCqmMTwQpwew6OJVzQlhh7QYilsPZ9hCiKfdvxnjHSaIcIykXVSA==
From: =?UTF-8?q?Andreas=20K=C3=BChn?= <andreas.kuehn@diekuehnen.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: =?UTF-8?q?Andreas=20K=C3=BChn?= <andreas.kuehn@diekuehnen.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Open brace following function definition on next line
Date: Wed, 18 Sep 2024 15:29:35 +0200
Message-ID: <20240918132939.10127-1-andreas.kuehn@diekuehnen.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Open brace following function definition go on the next line. Fix it.

Signed-off-by: Andreas Kühn <andreas.kuehn@diekuehnen.com>
---
 drivers/nvme/host/constants.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 2b9e6cfaf2a8..66d6158822c5 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -195,7 +195,8 @@ const char *nvme_get_admin_opcode_str(u8 opcode)
 }
 EXPORT_SYMBOL_GPL(nvme_get_admin_opcode_str);
 
-const char *nvme_get_fabrics_opcode_str(u8 opcode) {
+const char *nvme_get_fabrics_opcode_str(u8 opcode)
+{
 	if (opcode < ARRAY_SIZE(nvme_fabrics_ops) && nvme_fabrics_ops[opcode])
 		return nvme_fabrics_ops[opcode];
 	return "Unknown";
-- 
2.43.0


