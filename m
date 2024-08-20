Return-Path: <linux-kernel+bounces-293508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0829580AC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7A71C2286E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A77189916;
	Tue, 20 Aug 2024 08:17:45 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDCA17758
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141864; cv=none; b=H/qcekkRNS0CsW1KPLAVJwCaoMVIVsZuBjPMkkUpIAU75a6haE+I82AfwV/ZgToYO4+hPrtT9KPoS1ty6cdUlHqI4pXKVpINP5aPqCaAanoS1trLycV9nVKSliPWLqPfHJDN8aXKUbBsg+xB+Z+5v6PIoEUVIDqOXUGzuvtKkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141864; c=relaxed/simple;
	bh=SFe1izGkwjVYtPxB/KDdjIhICL1QxgVmRHEntMFpEKE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qK4Hsuku7EGSaV3KwTxQWuEjudyUckSFefPezsq+JIwGhOsYl6kFxlvZGFX9te3FDnXRRiElZPL4K4fmvW3klRiKzqwLzsdj6Hek0oc3COmDLVfOaQj+qbgfn38FXsZOf/yR4zKofORbZc3Ohz2WPLcfTaAyY0TA8mHSVwtFEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366c451225f1-39dfc;
	Tue, 20 Aug 2024 16:17:39 +0800 (CST)
X-RM-TRANSID:2ee366c451225f1-39dfc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee666c45122fc1-006a4;
	Tue, 20 Aug 2024 16:17:38 +0800 (CST)
X-RM-TRANSID:2ee666c45122fc1-006a4
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: martin.lau@linux.dev
Cc: eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] samples/bpf:Remove unused variables
Date: Tue, 20 Aug 2024 01:17:37 -0700
Message-Id: <20240820081737.5460-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The variable is never referenced in the code, just remove them

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/bpf/tcbpf1_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/tcbpf1_kern.c b/samples/bpf/tcbpf1_kern.c
index e9356130f84e..dc4ba5fe9c73 100644
--- a/samples/bpf/tcbpf1_kern.c
+++ b/samples/bpf/tcbpf1_kern.c
@@ -56,7 +56,6 @@ SEC("classifier")
 int bpf_prog1(struct __sk_buff *skb)
 {
 	__u8 proto = load_byte(skb, ETH_HLEN + offsetof(struct iphdr, protocol));
-	long *value;
 
 	if (proto == IPPROTO_TCP) {
 		set_ip_tos(skb, 8);
-- 
2.17.1




