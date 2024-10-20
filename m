Return-Path: <linux-kernel+bounces-373155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964BE9A530A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7543282D94
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FD12AF1D;
	Sun, 20 Oct 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XlsWaD/D"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D0BA2D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729410960; cv=none; b=PLIHa/BeRFkRcBpBZ4naLzsrpW9UgJNrGqE29nG8QJjH8nvpll1PqotII3IC104svz2csmuWzoqZLlDTBUuA2BlFdXHrl3rKvKbW+opP2lGq7GqbMudkCYUuQWN8SYJsVnLTO9g+vJD7Vt/KDdXO1EcMUIGlc/OvMuKIX7BU1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729410960; c=relaxed/simple;
	bh=7aL5LzELG0tTYPdM5LGYfOHO7YjqPtAI8/gSpPTe1o8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgGI4bM72d1GMzSE4W38aT4h6s6+RmVNDt/m3KxJvkzPUA3HKBEg0nvIL5Px8jNnOfQxv6jEfVkxOTWXwIiHJLH2UvXElqG8jXRmZONL+gnb+qVAaNeLX1XIR9f/tJzjcQmusgjqFXpmYApfzfC79dBtS1j+waSl77Xmr8K7pz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XlsWaD/D; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729410886;
	bh=QlBcGlE34Va4z6tdQ+526erMjntc98YXGGaX0KDIwFY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XlsWaD/DXZ1HbBhsP7kaW/N06iyUa/Z5/mGZ5ntuHUfHr063638zvIoHxO/0aijTP
	 EkVXhtVbegJLzdm9Jp7b+T78UV+aVTkklXPdrK5TZdomLqCBO0v00zryPi+bS5d8u3
	 gNWT+EUSwi7svQhX7Tq8tDu7jBGkhqC3PHyQRPpQ=
X-QQ-mid: bizesmtp88t1729410881t0029a7e
X-QQ-Originating-IP: DNywZhexV8iN4Izdp5oTMn236th23b+y5ijrnx8ukaw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Oct 2024 15:54:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9097797976645357771
From: WangYuli <wangyuli@uniontech.com>
To: rostedt@goodmis.org,
	warthog9@eaglescrag.net,
	wangyuli@uniontech.com
Cc: linux-kernel@vger.kernel.org,
	standby24x7@gmail.com,
	jkosina@suse.cz
Subject: [PATCH] tools/testing: Fix typo "accesing"
Date: Sun, 20 Oct 2024 15:54:32 +0800
Message-ID: <154347BA9B9746F8+20241020075432.1869841-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N6+UlSQllctNI+UOVWAU/CwlTSoJXgNn1lUxHqfGLyK3ZJ8P4H9ag6/u
	r6oj5n8vrX+eNlZgBhVGqaJ9px4Uekt4BIEle9ycYJzLi3P19VvGY15XW1BbhvP7iqbGlqv
	7AYakVczjc2jOunYjA8L3k/g3ksv9xMo0zPIikd7jTeWuvGjAN/AZBRIx/oW2wGUkMm5UeO
	PaXt8EWsdmeEgP57jvfIgnLxoO5eTTOBGjA3cYLvL9h7/1ZTOYYI9m8bAmSl95EnEe0P/Xm
	wHeO3WTRWEp2XdKZgxhMTp0/Pia7Z6anh3LOuoSSoy2lpJWVeXK20gcP2aqC/5csTERvOs7
	31tPRusRvq3T+OFu/FgN2BcmCpN/san0rwac3D3mp1IrXpsr4R1MKkngO6KqlF5A0WOHXIS
	iFicnzClm4VbRZs5pRmCekv1qYVUh+0p+QqdteVaD0Y/vJm/9MLlOjhqUALG2V3l66/VSNQ
	IgjCCCxHuK/PwPHOxGUgsbzuZvULvWnfzqx8hD7dPBdKlYc2XJc1HOal2DSA4kCuZieFIjn
	gHWAdXNgKKM5HjHYGkTWLSv3++Ucbsfu/GpLiMJRV5QYHegi0Iny6CfFMJ9gj4fXG59RiwU
	96ByQbgYWZyx6mqh+tlytJbaInrJQDWjQ37/HJ//0sr0oT+2J2grm+t5w/xg/KM9E03wOGh
	Jl3hkJsyG5zcpuhJcsYhIqkchjifh01+4Bm1/8EVxosHSlqOUvBn0mUegHUWtiIoUIw1f+m
	Bl3thO1p2HePB21w4xpXOZPM2+kGOAvXlVrX1UkSxCUpNAOZYR1xaaVweWDsgE+c5/9Id7f
	2LacAfnNsqlqbP95MusGU9+ZanbBABoXfCDiBFHimW9A439G7vKQGLCNP+Iy+2OHBIjgDi4
	c1JGMT6Irs4Xtcjg8N46JRv0KaH/cnuxS7rQEqWAOVzP/ifhwY9uQS1TQRCIp6Nmmbhg+wR
	XjM+iwNYUKLrFvpXYq61N/ogg1AGAL3ytHaU=
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


