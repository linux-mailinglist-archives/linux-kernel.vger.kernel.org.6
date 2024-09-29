Return-Path: <linux-kernel+bounces-342894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2613989479
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36C01C22784
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662EF22092;
	Sun, 29 Sep 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kzYtos7P"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5F13AD29;
	Sun, 29 Sep 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601875; cv=none; b=eD+NsGlnxd7ZK39LG36L26WLR+Louk5/TwEAZ3fP+43Eg2Y4ZoE/10KlHHqGBi8vSsQAqHhWU+Pa934hYWezRmPe90bZC7OeO0FS4R64ugHkdrblasxbPDcO7MmTVM7i3v34QjQzXSfapo6nBGFFhvj7VWFIRTWMzpCzFzt15Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601875; c=relaxed/simple;
	bh=vkC9LJ7wr/yUOTjMnREn2YogWu54jCt01NPv91t0bz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDlg4SLaeRP5eHlsB4PcDYUgaq5Fe6gfD8sTP9fKiVeGFCsH4SUDKvx8UhrcInTf+f3TVH+jzr2XwcMeT6BtbIFl09y94LZG7XyNx/g6O+/YbtoQ0nfMSv6G2/n7u/0wARfPP5z3ziiEWfc0aAFoUlMeiEVeBkXcbocv8QM3lso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kzYtos7P; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727601819;
	bh=Od6QYms+epxEv2KZ2ZHKNs5K2uqUIAKuYW2CJnmrKog=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kzYtos7P3Z83+IjUjspi9N7GB/K/8seK4iaUaQA1aOAx1AD/cs6ddPQav4gffaXWk
	 yNwliTnyevRfbp5Bw3ch06rg8hNSvjdJPIlPlmKoofobD28PmhPetXO39cEGosTVEG
	 QIgVkwneMYWBh5e/N/umIyvjN8f9NncmOOpeAnDc=
X-QQ-mid: bizesmtpsz13t1727601787tzhgkp
X-QQ-Originating-IP: SGNvCi3w14TdQF1FOO/C0w0HjnklS+oYEzIi6UDI5wc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 29 Sep 2024 17:23:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3664052709019664673
From: WangYuli <wangyuli@uniontech.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tzimmermann@suse.de,
	lee.jones@linaro.org,
	lee@kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND. PATCH v3] platform/x86/intel/pmt: Correct the typo 'ACCCESS_LOCAL'
Date: Sun, 29 Sep 2024 17:23:02 +0800
Message-ID: <0F3CB9A22C53A581+20240929092302.1039036-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: NGX5+lQVxpC+9jQ4p9eeUD5ZdvcrLCygPOD5rUPJOszl2TTOo/LEZ33H
	nJzQUWW3Mlgarcqqjo4uSHWodk7bXMwYuCs/w8/O0+VBWSM1JOgxsbAsTnmXKV3QMuI8f5v
	j8Gp57RZgWAWeZ/zD7yMyyKv58vodAxy9Z26oNmhSVxLwAm/WOOytf98EGgJPA8HY53+pPj
	k40QV/A23CZkiUYNUAXy49xWPuL0QBCQ6B/ZmTNxc/l3yTzH+WJ15j4OLX0KM7J+CG2bv4r
	ZkrwCPVyuScIBbzMSeypl7r1ca5xs9zSLPb88afOiQOk5DM4kwPzAtcU6Ms82iSxPX1KfeT
	DfLJ0KCSeRY1Dqqjc1FMqbLgKN2r74R7SyLS2iwr3BzG95lKsXRFmPd7WNrJz6tqOkkTvRV
	as7s6aiyzjP+MUZLdj0oP9quymj/0wa/8O8SoQygjeLSXNDoYKlhKOB3yE4iR+r6tWj4yjm
	xjQpYB0+YUcnW9xSNfm91Ph4GkUwo6pLuyLIlS6PonEoiETRWnazLXZi5p4Y+OgBdaXeLDv
	czjHmUBfY3+ztITtA0DapnGnkleWv2V0cU2yTR8DpCNxEH4JjcsHHr0MrCFTqI3d/9taslp
	V4kHM/TOUNjJQsdWTfoHBPXU5g3dr7K11l68GcHsSlpPLzhWqZ1/H/A+xaXLQwisgjFeZTI
	hV66YKBPus1JPwMsEbyuG3TNdZqd90dO6M6GDKCYls/XsTpICiIXrMUEF/bcuZPym44haBg
	prlctwn04HGxNrvrCEqXS2O286knPjr8t+TxYGleg4w3eWYYzqb2kVJ134sr6n8fDLSpHWe
	4Ft0ek/oqBYu/A1F2hj3ZscjDl6ZelbPdk4ulq6OUk9OGUQCsUsdI4d9b++1xCE62rZsDhg
	S/lEcbuYW3g0h0nW656L0Ox9Lps4fFacehZXD5KzVv3AvDWgxG3eYzzXNhVUVthPVy/i0vH
	SMIYPHs24a0XjWHbbGUc++UL0KqEStEOioHy/vrs7Z5IjsniNLdZp7EEgL3egj3YdRLn2/X
	wUV4xbinvobEebpP8u
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'ACCCESS_LOCAL' which should be
'ACCESS_LOCAL'.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/platform/x86/intel/pmt/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index c04bb7f97a4d..7680474c4f96 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -207,7 +207,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 		/*
 		 * Some hardware use a different calculation for the base address
 		 * when access_type == ACCESS_LOCAL. On the these systems
-		 * ACCCESS_LOCAL refers to an address in the same BAR as the
+		 * ACCESS_LOCAL refers to an address in the same BAR as the
 		 * header but at a fixed offset. But as the header address was
 		 * supplied to the driver, we don't know which BAR it was in.
 		 * So search for the bar whose range includes the header address.
-- 
2.45.2


