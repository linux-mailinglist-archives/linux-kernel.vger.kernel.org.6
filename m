Return-Path: <linux-kernel+bounces-307057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BEF96478B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBBFB256F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CD01AE860;
	Thu, 29 Aug 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sS48Fecv"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F41AD41B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940008; cv=none; b=gJXq0hi9qbBd6j8VuFet95TssMt2iv3eqEw1xvuK1pYwyFByuJAEnhZgI3jMcde31Pa/lGR07s9YxTElHL0rkEiwLYcdoHj2Dg/b7mOPQ6eEzZORWnSZe5N/TDSN7p/D1QXoAWCf5pzzxsmkkz7wQ8EpnueydQ1PR3fHwDkP9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940008; c=relaxed/simple;
	bh=AGFDpfa+bqvaKAyzR3i8XqMbzLG42VLnwzugz17jL9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnsRYt4PplIslTEcUmt46cYQuW6grMQbwRPAS87Z+tHbg6FYmS9je9dTpmqMU6biOQC+ZVZXxEZDGJNM07j4pdmaY1P1RqMKaYX4W6diz7UEZ/NMbxPCd4NAAdjlbt1vfTkvkCdvxLr63amHtDKG5laDrtg4kS+EdoVHHxSoEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=sS48Fecv; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724939999;
	bh=AGFDpfa+bqvaKAyzR3i8XqMbzLG42VLnwzugz17jL9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sS48Fecvdc8VDjaawHe1Gz1xZXn9YvKWE27J4RI8FQsuK3bIEFdLs3TCxJGLDkl2y
	 6Nj/wlj/NZUyBH0OKSmHBBddT0Mm73zC9pGgu/aNxwNC87t2g08VsHAWL6EsqxycRz
	 hQJQXBXjH6O3HFLiKVSIxzGUtt1HZJCN6WmITKItuUU0uO4sCd+/J158uuXa34kBen
	 YN6W+GB5ciw3OqcguZQOt1HWIOY1rQF6iXoa09Hml+Lh6w4XvewyLobstLNqxEsRvo
	 ZB9+4tH8rtY4toah9aj8x5klmCy8riAd+oS913QKeMjtzUycZnzZldKNPazvwZOK5T
	 aUNHfBF6/k8Sg==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wvjb31pXVz1JQc;
	Thu, 29 Aug 2024 09:59:59 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2 1/6] lib: Clarify comment on top of find_next_andnot_bit
Date: Thu, 29 Aug 2024 09:59:21 -0400
Message-Id: <20240829135926.926603-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
References: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the comment on top of find_next_andnot_bit clearer by discussing in
terms of "cleared bits" rather than "excluding bits".

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/find.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5dfca4225fef..8a170aa55634 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -102,15 +102,14 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 
 #ifndef find_next_andnot_bit
 /**
- * find_next_andnot_bit - find the next set bit in *addr1 excluding all the bits
- *                        in *addr2
+ * find_next_andnot_bit - find the next set bit in *addr1, cleared in *addr2
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
  * @size: The bitmap size in bits
  * @offset: The bitnumber to start searching at
  *
- * Returns the bit number for the next set bit
- * If no bits are set, returns @size.
+ * Returns the bit number for the next bit set in *addr1, cleared in *addr2.
+ * If no such bits are found, returns @size.
  */
 static inline
 unsigned long find_next_andnot_bit(const unsigned long *addr1,
-- 
2.39.2


