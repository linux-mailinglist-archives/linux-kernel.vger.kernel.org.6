Return-Path: <linux-kernel+bounces-403613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C5D9C3813
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07511C21245
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633B614A630;
	Mon, 11 Nov 2024 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ak1rTMor"
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505A18E1F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304716; cv=none; b=GDVSj4DB3SZDgA3N/LX3xDLowoBOsYiGqnYPDGFEAG1tJaAuC/W+trrwxJ2M47ahl3A0GLt8mzPQPzgNTJKpIRegy1Nw2NSEDUwKEv37RCS64URSjahCRI44BT0tLS21RtdH+dPm452fCzI2x3PeBqc+X4xlo2A6uK52N2nMi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304716; c=relaxed/simple;
	bh=7aL5LzELG0tTYPdM5LGYfOHO7YjqPtAI8/gSpPTe1o8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qf09DbAS5cLz5dctdjS5TbIuMGyVH2FAWnKKXp722pftNAKUm2K9UdXP+StrFmaw2TcS3qApfGWDlTL6FY67OjAP3Q1TiGQIyMga4OSWNSpS0AsShVQRKmoLnTDres6n+TJ+rMsarHGYKCswkiDi+pyDbbmef/9pwdbxhtW5h5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ak1rTMor; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731304627;
	bh=QlBcGlE34Va4z6tdQ+526erMjntc98YXGGaX0KDIwFY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ak1rTMor1XWSxuhlKl5Ltqgc4hzAnbfkosfrvJGT5JIw1bubL7JDJ1rUVPtDdhdTA
	 rVeS0TV/Nq5QYdSEwNyLHFCWPp9GSCJWaMMzeO98vnbTPTbZQnbVS10UIg/28wml7x
	 Pb+dgaBpW5VA9C+dTFAqud5rnuJvpmIDh7OQIEhM=
X-QQ-mid: bizesmtpsz8t1731304618tqb3uu4
X-QQ-Originating-IP: cvSgHr798D+Apd+pU6Xa5MeG/bYWCOgtQ5O9wX/QAV4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 13:56:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17814725511772650801
From: WangYuli <wangyuli@uniontech.com>
To: rostedt@goodmis.org,
	warthog9@eaglescrag.net,
	wangyuli@uniontech.com
Cc: linux-kernel@vger.kernel.org,
	standby24x7@gmail.com,
	jkosina@suse.cz,
	akpm@linux-foundation.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com
Subject: [RESEND. PATCH] tools/testing: Fix typo "accesing"
Date: Mon, 11 Nov 2024 13:56:53 +0800
Message-ID: <26276A748DB510FE+20241111055653.908372-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NiCl4APqUksbusz+C6FyrKfsm0znqwED6gDtyM/HfaRtvOvGIbYmN3QU
	cVF7AUu/EZJu05TKjj+/N1EFxvYzqaMncwS/9qkAVpRWCvujAlPGqIPR/Mwqd1XiYmgjs9H
	yUbVvi4fiBrFIyMZGvPEpG+Q1oVOAGMfUvObUeo3RB0S2/31HHJgf3GwjWjOmENJLXRfXjK
	e9TyPthlsVJ2SeY6EKE1SKwR/2VLSleKOqChTBPRj4fvQPb5p5CcIS7G46TM1mPtRpEWR+j
	0SlI7+BTpEJ8fbe8vdwbddO+zbXCKQRphuZrf81ENZpiwac07bxTcfSC8AbRkEot/Ni7siT
	E5sd22dD7UNZVVUdlbUtQDcZrltavFZANgBeXgA92Ats6et1t6GT0ckRPOdXN6W4kFkGy6w
	dQoGGWRb4rs5J6iFpseGfcxYQiEl0iOQ3VtsazyCwH07qS/1wX3Gox391+oHAVu6XZmuqnM
	d2FvRUTj+LiNOqt99ScxjyhwBrRCvSDrhHIB6B9HB89uFQpMaYx85FeCDFFPU15ltUHgelg
	c/unGvye82G8o06K537JXxmBvZdM13RbrhG4sQ8kLjhZ4VH61fFkdiZL3TJMBOZpd+cusVc
	EWSj7cKl9DUaVcA+vLYoscUdX8ztvu9Ra6W8rAL2SfGtkwDWyzXPQJzbkAR0lpj1xtLLrtv
	m590puKGwBnixCAZIzHBNFuKxk6JLVC+bzRAEWUyQHSIINFpRe8fuVWoxTJ5mZb35RBcG36
	k1jYQpAWcxSinae6JzsQj/tFzCMKjr8V12QvYkWqMaADqBTZc+nABHN1uByt1Y7f/nwOuMA
	EgQETBgMgE10B9pSqA9EeUfc/ShG/3N6r/C3CVXlOIQ7BbK/ptvuPWvdLHrGvKjAruB9ctK
	gJNzlEoSVFcsDlP5upRbWrOxLHEn9nw6sjtP9guk8NKTLAchtmtP9OSymPRJMoVVHxYvHIW
	7IV8Ci3JC5p3D2rX0uzdCAE5alV4aBh/RzdHVfOWQmpACQkAaSIwsPxtCw/zyLZDS7rmKxK
	zMTQZwH1dVZXK2feYxguuRCUHfvznWdSF4TV27SQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'accesing' in comments which should
be 'accessing'.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 tools/testing/ktest/examples/include/defaults.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/examples/include/defaults.conf b/tools/testing/ktest/examples/include/defaults.conf
index 63a1a83f4f0b..f6d8517a471e 100644
--- a/tools/testing/ktest/examples/include/defaults.conf
+++ b/tools/testing/ktest/examples/include/defaults.conf
@@ -46,7 +46,7 @@ CLEAR_LOG = 1
 
 SSH_USER = root
 
-# For accesing the machine, we will ssh to root@machine.
+# For accessing the machine, we will ssh to root@machine.
 SSH := ssh ${SSH_USER}@${MACHINE}
 
 # Update this. The default here is ktest will ssh to the target box
-- 
2.45.2


