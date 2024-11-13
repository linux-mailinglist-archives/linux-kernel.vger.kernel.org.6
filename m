Return-Path: <linux-kernel+bounces-407820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99D9C74BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D372E1F2254D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA68137C35;
	Wed, 13 Nov 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDPcLms2"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAC2AD21
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509321; cv=none; b=UrghGU5LbfHwgLUOO2LHBNRduKD+1JbBoWKiZpchXbYoUL9T822upeue8Ax0CpXsIccmsll3kNmh8sDzGHgePRt2nBZXA7N9125UgEYZyj5FzoW4MJG8Octrvg8JZ6N25AZlJ6JlMaOS1s83ynahvvsb/W7DmUi/vTlrLou7+30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509321; c=relaxed/simple;
	bh=7AqwuIIajl3uN68NwpTNsqmhDVUm0ZhPbp0j/41s8kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBLSxMWnfYWD4VHGAIDg1ssWWQbetOb65ZoLoPXv03kCgUgOhYSo4YkspLYJZhtNFmUcXQk5xihd8zjVH+aiuVL6lc/FxwaFOgI9IZy+FLmGbShyeImfrjTsp0A0gbkGAnPNmhefxhVyn1u4mdiHn6Ln/BNr8/wGsxq89esNEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDPcLms2; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731509316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3qRm8jB7U8ddgiJrGdGcNqdS4keaO/DQW1NYUZQlCa0=;
	b=WDPcLms2es67wax1OzwGWoyN/vecjS+U2Ji79XXvSCN56OeOy5Ya3XFNs5sLvXZcno3T4X
	qF8+5DH6VbHNU/j5Mc7LutGlpzZr8caHaXPXQZ2Z4s8mg++Gpi/kOCtjCMlub0H0Tz/Z2S
	vU9o26uy+n+IXAicIGmIddZhqNOd0IY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sctp: Remove commented out code
Date: Wed, 13 Nov 2024 15:47:52 +0100
Message-ID: <20241113144751.243799-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove commented out code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/sctp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sctp.h b/include/linux/sctp.h
index 836a7e200f39..812011d8b67e 100644
--- a/include/linux/sctp.h
+++ b/include/linux/sctp.h
@@ -222,7 +222,6 @@ struct sctp_datahdr {
 	__be16 stream;
 	__be16 ssn;
 	__u32 ppid;
-	/* __u8  payload[]; */
 };
 
 struct sctp_data_chunk {
-- 
2.47.0


