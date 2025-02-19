Return-Path: <linux-kernel+bounces-522464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 919BEA3CAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC1F189AD3D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A0725334E;
	Wed, 19 Feb 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b404JmWl"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6724FBE5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998862; cv=none; b=eLXcdJ197zngwBDZTRWS7s2jiVaJ7c8Jbg9eZAPJcVx618hQKbjzUsfMUvgNVpVxOOaUebPaiLJ7GqakJ1OcMO2hFEHsIgKrbl8AyOWIx9t75cLeUv78Q6svepCc86hdohzbHtI/5jvR8sN79+FagGdeY0JVFiKHBP1c6WPaYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998862; c=relaxed/simple;
	bh=xYjr57grpWT/STxWuEDHFwIohcZWguBHLQd3Ple1A84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swZyYwHQbDe5vwNN36aMjQLWVLj3HuFxC2vDhyljaAndP1M/bx5uuR3r9jll1JwpvJaq+TM2rnaJ7ftWq1NIWhvGcwWpPEbV50TndXjSQla+nYK36zn9xHpVlWMzUD0A7+girwC3SgK0t4UldyJEo7L0+52zFTwpXfiQXsEpkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b404JmWl; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739998858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ckywdOMAiK5RU7FTng5uRut6ZDZUFai0vbpS3/G+qwo=;
	b=b404JmWl/z+bKeCvatzkoURRjmQSOSE3BdL/Piy043BoBCno+RAzFz77AcASnfNDUF41Xn
	z2kW5XwwXr6oWsCN/PcgcVXjgzhNXdoNAG7+g1fkh2S2e3cESO7a5ZQqLsSP2xiPNbMYnC
	UslL0vPuPO3+KDwJ9Fsdr7lVYIqVVSk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] random: Add missing words in function comments
Date: Wed, 19 Feb 2025 22:00:31 +0100
Message-ID: <20250219210031.28963-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/good as/as good as/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2581186fa61b..b63372af9bce 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -427,7 +427,7 @@ static void _get_random_bytes(void *buf, size_t len)
 
 /*
  * This returns random bytes in arbitrary quantities. The quality of the
- * random bytes is good as /dev/urandom. In order to ensure that the
+ * random bytes is as good as /dev/urandom. In order to ensure that the
  * randomness provided by this function is okay, the function
  * wait_for_random_bytes() should be called and return 0 at least once
  * at any point prior.
@@ -490,7 +490,7 @@ static ssize_t get_random_bytes_user(struct iov_iter *iter)
 
 /*
  * Batched entropy returns random integers. The quality of the random
- * number is good as /dev/urandom. In order to ensure that the randomness
+ * number is as good as /dev/urandom. In order to ensure that the randomness
  * provided by this function is okay, the function wait_for_random_bytes()
  * should be called and return 0 at least once at any point prior.
  */
-- 
2.48.1


