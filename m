Return-Path: <linux-kernel+bounces-318715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1995796F1F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AC41F252AA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74281CB133;
	Fri,  6 Sep 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="O8sYKdS3"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D41CA6AA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620105; cv=pass; b=ABPPRpJiD2rsnvXLVCc47kDjUiaesB1mseQKWMrv/V0W0snW1Eus1Ge8hq8SONCGxq3eFAp3x72KENq/UnlWbF+tP3c04z89k+rNRBk+jyQWuhAB0IkKPyAsmObfic3YzhwodO+sndXvDgj44O25CWLIT5Qg+XmCMFIVLYQ7Ml8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620105; c=relaxed/simple;
	bh=e1SgrX//vcgc8W2rTXlur0ijWcVQfMawXaz73iZNQnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W/Hpg5JG1GPjLftFuqH1AKm+2Y2VFJ7JGPiBNxyUhvuuqpq5QIZeiVj5Q543Z2VmS+ZTO9z2AZRAqWvlni3iaKGCCjt4doA3f0gYJ6L6r6/BgI8MJA+1uxgU+hA6Lg4KmaxIeNFAWhWjPv52AXaYJcsMjr17s4n4lhvqQuh6Flk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=O8sYKdS3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: usama.anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725620092; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DCJ27+XodNHaIsOouraC0sMnipDxWdpBm0GNjxR6yLkpaNrOtl8OMZv6fonxjGR32izGGtV3szYeNzWeAyD2WSJZ6XQegp081AWC4NeOS1ZAiSANepzQL/OP4I1GV1FaXnFD7TYbCefjcrTgCaGtyNnBAd7SoSOKGwa7mDjJ63Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725620092; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DFX8XXFOcRvz6fa1WMFBM/40+k4bgQonMZz5XOdb6z0=; 
	b=DJVmFSoUgkIodKx8//ZT1FeLpAG+zmqj59xPYgT+t25Zf0lCTJ066ORVGh7J0h4SLB3vss50Qq5ejotL3wbllyIO3TMG3F7juxf8KKkerE77W7pSnMSd+VNGwcIcAK/ELnC4kWMPZRVYLb4lX/V9nyObK9xd9TZYbIAuyYIRRXk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725620092;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=DFX8XXFOcRvz6fa1WMFBM/40+k4bgQonMZz5XOdb6z0=;
	b=O8sYKdS3YGqqW8g4aiNP1ykw+PYwajSL/T9/MiSS3N9frEzUMUQNLJy6WaahcQXL
	CSx6ok2lR2lLE1/qdwVvz8HLolnnG6bJ71er1xGYFNCDDszp2Yc3hJeueUwVZgxUFRw
	kfaCybrzLzssse3HICNEiMg3qN509H9NvEJK9okE=
Received: by mx.zohomail.com with SMTPS id 172562009001826.953507390782875;
	Fri, 6 Sep 2024 03:54:50 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	lei lu <llfamsec@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs3: Remove duplicate code
Date: Fri,  6 Sep 2024 15:54:33 +0500
Message-Id: <20240906105434.263323-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Don't check validity of asize second time once it has been checked
before. Remove the duplicate code.

Fixes: 556bdf27c2dd ("ntfs3: Add bounds checking to mi_enum_attr()")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/ntfs3/record.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 427c71be0f087..0f400366231d5 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -268,10 +268,6 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
-		/* Check resident fields. */
-		if (asize < SIZEOF_RESIDENT)
-			return NULL;
-
 		t16 = le16_to_cpu(attr->res.data_off);
 		if (t16 > asize)
 			return NULL;
-- 
2.39.2


