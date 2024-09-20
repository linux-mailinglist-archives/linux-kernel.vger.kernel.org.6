Return-Path: <linux-kernel+bounces-333944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E427397D026
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F66D1C21F72
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 03:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30D817578;
	Fri, 20 Sep 2024 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="N5NTPZA4"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6B101C8
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726802348; cv=none; b=LMaPBbK4+z5fdYYuOBjv23RCxUM2u1gKJrt7xen5QYetaCZGH4fUDsMwv8pkBAvfUZIOm/hnQ6uYkAu2JmVHhKi78HFI7DYF5qrFs597dmtEjirPFTTudCZUiBKpAxjjdP8WfAZ8b9H3iweBfGyBuXUr/ee0Os1ttbTNJC+Lozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726802348; c=relaxed/simple;
	bh=M5rN54qA5rVUrODvgLOg+DMIwvOB0Hj59wVhuW0Emks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dz/21fPMndBlPs2GCLaRz4SG5/kx/Nnqj9Rj/XlDG/BIktxicFZRoVepCEdh+hdGTA+P9hkGx344BH4MB0csvuW0boO9SeKplIH5SiI0UGl0VIpZ5ywzpnvUDlwNB31QZceJ+JBO+3qW+WGUu7wylg9xRBTOlvY4sFQFpH3NkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=N5NTPZA4; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726802195;
	bh=GF2Am1EBaW0aKWs0P0U1SrDB1E0DigRM28jfgRVw8L4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=N5NTPZA4hVWJuw/b9CduwgimLsv/E0unDtqa+VKpxdFrfPXsH1CcWITqA6oR31xBJ
	 EPLbGp5CmRDa8RYUjo7bcrvkqIrcq+59dOPguDeULejPpIiK+SGyWdOjBtpqlQnNcQ
	 y+ReWG6HclF5V7Nkq/d2UB4hJYkpybeKsz46Y9yw=
X-QQ-mid: bizesmtpsz8t1726802187tolf78l
X-QQ-Originating-IP: K44m2XNNdMuRI7n2PLIjQFE90u+LWrqfbttPLcCjzoU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Sep 2024 11:16:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13448690296646782473
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
Subject: [PATCH] platform/x86/intel/pmt: Correct the typo 'ACCCESS_LOCAL'
Date: Fri, 20 Sep 2024 11:16:20 +0800
Message-ID: <781C12799421D366+20240920031620.1211752-1-wangyuli@uniontech.com>
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

There is a spelling mistake of 'ACCCESS_LOCAL' which should be
instead of 'ACCESS_LOCAL'.

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


