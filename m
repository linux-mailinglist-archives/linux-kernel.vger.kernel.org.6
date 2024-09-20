Return-Path: <linux-kernel+bounces-334399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B397D6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B622837C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F6217BB06;
	Fri, 20 Sep 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oMvePLgY"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE3145345
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841883; cv=none; b=L/TnpNLRZXtsELa/MPqV1pwBffay5BtlR/2TDw7NDbi32fx1Vh87xQmAMuzI+EiIiDDUaFPk2hox8V37CUDvm6cQVYTp1haMhlMW6PWEOCwWRUrvm9ZHhVDn0EYmDeWwgHh/6VXogPgIVeo3SheqmpraD42G4J6NNJ04Z+rbyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841883; c=relaxed/simple;
	bh=vkC9LJ7wr/yUOTjMnREn2YogWu54jCt01NPv91t0bz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThoLg+f9v9UmAxqR3he8YHPW4Ky+PCnnggq4Wi7245o+jubdY8OcGDQ2efq7RJEaWnVn3e9ltYodE5Fo9aI/G+MeehHvb/IuuvKthQKsmANjJ8o2vPBUIY4TCssxLYgQWfN4lkoHHSuUSRrt9PlGCG6uRCmIbUk4xi7tlVKAshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oMvePLgY; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726841838;
	bh=Od6QYms+epxEv2KZ2ZHKNs5K2uqUIAKuYW2CJnmrKog=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oMvePLgYNBZ2xhqElOK9LER3/nUFiqaQbRP38rJRh2cjUUGTxownvRz+P5m86dGTC
	 16Ndgy7nkSIxnCLcmAVTsXkRXrt7yfKZRWhr73JC+BEBzTSiTNpgw4yTx9nOG97EVG
	 k3RDXyyP/Mz51hOyio5OZcU95Y12OsX2zvWOUOYI=
X-QQ-mid: bizesmtpsz7t1726841830thcbxfa
X-QQ-Originating-IP: YnLcdraBHkhEhdPXQQdKNpmewBQ/1x15Q/EY49Azb4c=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Sep 2024 22:17:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3504659909987845671
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
Subject: [PATCH v3] platform/x86/intel/pmt: Correct the typo 'ACCCESS_LOCAL'
Date: Fri, 20 Sep 2024 22:17:04 +0800
Message-ID: <4F742FFF72DFD84F+20240920141704.34373-1-wangyuli@uniontech.com>
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


