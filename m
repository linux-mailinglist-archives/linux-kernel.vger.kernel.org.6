Return-Path: <linux-kernel+bounces-370862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A533E9A32FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFEB282163
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2A6126C10;
	Fri, 18 Oct 2024 02:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Pp5Os3ka"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D19381C4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219710; cv=none; b=Vcoy4UvY30xAeVfqdIOT8oUGQTXBHWTuJdzFOaUOJUX7FF7T4gUDINfWQXJcUrdCP0+fk/NDCRR+SLJzyM+F9EIGDufvcoRnhUJaRuF7Iqw/rnOahEfp1vHAml1m1++RXEZjh/g4sNox/CjuqjwQKjJ5AH9RpRtpNz2RR6pNZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219710; c=relaxed/simple;
	bh=4qnqftPF0lmrjv9V/IEcd2K0CbqYtNQQ0cmDwipG7/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InbGJtZzvHjfhkN2qNOPYAHkyNAzaSINYtoFpEDiCnVDuSlV7vPrSdKlgyIXJ2kTuPOcYd+EY0GLpLox0GUN1Z01ROvBErm3sqMXgqE2L5fhO7DqiJH+F9BKJNHQ4mqpEeEFFnEtcLSStQBzhpxC3r8BdSaIkRuIfzyMm2gw6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Pp5Os3ka; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729219669;
	bh=/w+j7hdy3vSS/0F5ZYtOXWOHGIP8CwQeuxD4AU/wBO0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Pp5Os3kavfTmFCoI9U9Lni74EWxiBpwAHFfm76nCKnLiID5GkDvZ0NePq7vLWmTwa
	 OfVuoZeevG7FoDr2rJ4dv0NS3L7XArdwDpqmy9pWnhQMsQ2yEMwGSR88xoXsJ2c78R
	 PySbdNnZplUWpaF0BZHUReYW1VMbKQbRJdY2IRqg=
X-QQ-mid: bizesmtp77t1729219647t1se00wc
X-QQ-Originating-IP: UZACEGoQIW/1zaVSnLCVaswfPR2CALpF8BnK+W0vua8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 18 Oct 2024 10:47:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5159950436051782867
From: WangYuli <wangyuli@uniontech.com>
To: akpm@linux-foundation.org,
	jesse.brandeburg@intel.com,
	colin.i.king@gmail.com,
	wangyuli@uniontech.com,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: Add typo "exprienced" and "rewritting"
Date: Fri, 18 Oct 2024 10:47:19 +0800
Message-ID: <C1FE2459CF066CA5+20241018024719.58325-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: M75I2DDAzREFleFXGqxsGbRjREvusOgts9W6uvi0E3bRvjse624yw0iy
	vA/2W5lOQN/voJrn+ss65K+HdyCSzKCnG7xRzmbsBvqa5jNE6DLtc3RVzmXjn4xZ1S1XbFP
	hRHvYH3xdRCkVPbO8cIDc2TQSUmEi773NZCMONunz/R9EIhfMMCQZCxOhnqatAtvV5ZA2A2
	YgTCZj+RhXFc/kt5h55Qm4wZXlGW0OP7T2fiFhk7t2WFxCaK5+sJPqkz42Xwf5JPPddUt5y
	+QSe01rVPTTdiIXI+Tw0N23OnIDi7cCFcJSWITpX4C7KkuhEy4P10vPxruolHQXDZxvDFy/
	UTHyFCRVvWscDI2UVCbm2RUeMnFjkXMTFiWa9Len9FJ357ceK+81WwOZdR3MYfponnPQnrQ
	biOu054AnKQ93Pj4cqUi9fFJcxw0MVyI9Qw/wgkQy3U08EQ/n5T3hlTKdH/HsdYhZkXfAXu
	Y2zyzwUfrZXeTv9haaZ0R02DKYtaqwLvDlvqk21+ApjsJySGage2C9aKAWvBPNFsHNiBs4H
	SpnDyOwzZBjv5jMlsEgwJ2rFeX09y6+faFMR0Qv1Dwno4dZ7iTZxeRuXoP1IZpvSz99gHPH
	7oT0VFRkQqbUVPNradtbOrpI5zhIqjcg4NuGFGxROw6ATJZwN1iqfhuqL66mUvTh6GEReAw
	Y6ZTERMiqCwWsZCnmmS2Id+9NForxi87hP5N0qFmYPX5h6+CSUEdOng8z5CwVrupfkJfpS8
	CGpwO/uIedesk2Pr8fVCaqOmQVJzLMfe6zOJCu8JX6kcTmnPnMsVSSQCGTSoBUkK8GzUBeX
	ywAdqBZpWlfoCnQNfSiqjpzM3MIUlRJ8GolE4PgkUtPHbTYQCDe10JEvhNXfQTP+XgFREjT
	8zEzaD5oomwribJlbPPaGWrUHuyXSporkYalLRd3IY+alY50GSO8tTxm3cdQpFmkKEvdQko
	FjiEx8vvBpo0QmUgycagxVeVzHKf7UCjB1z3VZhZvF1PA7ve6hREmz0eKILHGMHuKAFTuQ/
	j1VrXkLA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add typo "exprienced" and "rewritting".
They were found and fixed in follow patches:

Link: https://lore.kernel.org/all/90D42CB167CA0842+20241018021910.31359-1-wangyuli@uniontech.com/
Link: https://lore.kernel.org/all/45F06B5D4CA9F444+20241018023340.47617-1-wangyuli@uniontech.com/
Suggested-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20241017162846.GA51712@kernel.org/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 scripts/spelling.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 554329a074ce..5d3aa4fe0dfb 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -659,6 +659,7 @@ explict||explicit
 explictely||explicitly
 explictly||explicitly
 expresion||expression
+exprienced||experienced
 exprimental||experimental
 extened||extended
 exteneded||extended
@@ -1362,6 +1363,7 @@ reuest||request
 reuqest||request
 reutnred||returned
 revsion||revision
+rewritting||rewriting
 rmeoved||removed
 rmeove||remove
 rmeoves||removes
-- 
2.45.2


