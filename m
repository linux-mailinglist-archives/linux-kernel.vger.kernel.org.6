Return-Path: <linux-kernel+bounces-426085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC289DEE9A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 03:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5577162BA5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EC143ACB;
	Sat, 30 Nov 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kz4QcoHy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949E3224
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732934159; cv=none; b=e2eRd7BiZLsSgPEmIt8KLIK0yZTkmxaXCEQ93ocAf410lO9NI82dqyXznHjYUcu+EhIjZ4sYvnv9M6pfohPwpXYh3nIJnCI6/5zEt3W/l9iGu6ZmhXSxG28Oq4TJCvkjafPnBOf07LSK254RSU27Khc/+xIJEtFcIMv/kKDSMp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732934159; c=relaxed/simple;
	bh=bzHt9T+FI2Nq3+fjIsmf95OgZrFD4R707PwXg8g8Jhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBjab62xfsuse/3MBG386+CHcdIUckOXAipiC6ub8eqrxiVkiX6AnAnfXGB8bYRZ/7aQpifKU5nP51UH8HiBo8+16c9rzo1qabwMx5gqE69Z34lxkzqRBBvYTsK3sG0lsL8HnNGaRhXpd2ytLhWU6qTOsxZJwu8eu9Xpg5mBUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kz4QcoHy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CENE67omF4txQDfD5xaTRSsaRoJ1PEywoIzFFsuu9cQ=; b=Kz4QcoHygPxmbQxjJMMyo0A+KU
	o1kfwJfpSWseWhXkC36WpvMxfXiV3gMWxmQwUJcYxOBM3GGTSmgSCtT4UUEi/KeBn2/qq8HzwFoXN
	9olro+cCrhEyiWmkb9KypYQ4rwqYc5soEPLa1MasMi//PA2FRrfTawlGVwcdTW8GRv95G25rf2vCc
	TD7iFMo+QaM8G/2/fOB9ZgoeVQ/7WyP4nAq8tBoqdxCo11actOT+RSXbKxrYI1iqFZsRMuES3nlfv
	iwZecaZnGxCzWpdIDSDr7aB6d1E1nfOFLLpA1SyowwPVTh8468+q4jKGG3OLCtF5l9IFbknEo64iE
	n7Un0FKg==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tHDKv-00000001Jkq-0lxW;
	Sat, 30 Nov 2024 02:35:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Aviya Erenfeld <aviya.erenfeld@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] devcoredump: cleanup some comments
Date: Fri, 29 Nov 2024 18:35:54 -0800
Message-ID: <20241130023554.538820-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a spello, remove an extra space between words, and fix
one kernel-doc warning:

drivers/base/devcoredump.c:292: warning: No description found for return value of 'devcd_read_from_sgtable'

Fixes: 522566376a3f ("devcoredump: add scatterlist support")
Fixes: 01daccf74832 ("devcoredump : Serialize devcd_del work")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Aviya Erenfeld <aviya.erenfeld@intel.com>
Cc: Mukesh Ojha <quic_mojha@quicinc.com>
---
I prefer "in parallel" but the internet says that "parallelly" is a word.

 drivers/base/devcoredump.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20241125.orig/drivers/base/devcoredump.c
+++ linux-next-20241125/drivers/base/devcoredump.c
@@ -186,9 +186,9 @@ static ssize_t disabled_show(const struc
  *             mutex_lock(&devcd->mutex);
  *
  *
- * In the above diagram, It looks like disabled_store() would be racing with parallely
+ * In the above diagram, it looks like disabled_store() would be racing with parallelly
  * running devcd_del() and result in memory abort while acquiring devcd->mutex which
- * is called after kfree of devcd memory  after dropping its last reference with
+ * is called after kfree of devcd memory after dropping its last reference with
  * put_device(). However, this will not happens as fn(dev, data) runs
  * with its own reference to device via klist_node so it is not its last reference.
  * so, above situation would not occur.
@@ -285,6 +285,8 @@ static void devcd_free_sgtable(void *dat
  * @offset: start copy from @offset@ bytes from the head of the data
  *	in the given scatterlist
  * @data_len: the length of the data in the sg_table
+ *
+ * Returns: the number of bytes copied
  */
 static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
 				       size_t buf_len, void *data,

