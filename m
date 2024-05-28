Return-Path: <linux-kernel+bounces-192555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B96A8D1F14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0872D1F2368C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035E516FF49;
	Tue, 28 May 2024 14:43:44 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09216F902
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907423; cv=none; b=NaTiroEQRh8FdsRTPznPTMtvkU4DNTemW9LFg4kyIAgATFJ5SYx5TnraLV8NyOAv65HY3LM/iGNvpeHpOLEccyb08iKZjtDw9vcZnSAdV3EryNPvHxIAUyDsPkeuytS0reWOAETeHqvh9Uyke6RuNkOQfhpAWzTjptUN/zchmDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907423; c=relaxed/simple;
	bh=AEMPCYijVQ3FjHfU8+MIpB4KRBaUR9tXiKkrF1Oz8mY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5gDJWFr6weJ0thNo9fWpnYJ1fX81px1VV5Ydy5BZk1U95hXMhn1eegwcV1aUxirayXrHoc9t7xjJRJ7xptvI6Rig1OfijEnPfq1IcZ4xpg7BIpNBNGAlAznWojlv3Q5HTNzRwuvTh9ZQTxl2PD81a5qEBhOeFdRegatI3SW5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBn37C019448;
	Tue, 28 May 2024 14:43:34 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:message-id:mime-versi?=
 =?UTF-8?Q?on:subject:to;_s=3Dcorp-2023-11-20;_bh=3DqONFGGvnWDmZHkGRAeYDb5?=
 =?UTF-8?Q?VDvvTkeSuCre4W1Lo4orU=3D;_b=3DIJSDL/FL9K+jXU1jqAVGEc+Zm3XKS3xQU?=
 =?UTF-8?Q?gO4RO8fzcjSNU1RZ0hAhEMuCDA4XXwOKGDJ_9o2kdcUGjzM5avmETT+4wumurK2?=
 =?UTF-8?Q?0hsn8NGAMMtpcse93H7PzlKG4nYzegsbYwsH8UtVV_k22Y2t39nZ8sv3lYsHpkE?=
 =?UTF-8?Q?dV6MuhDL5klD8Zc6e1kwZb5ivEj3vyF5y/+GdsUVrmPQbtS_4aLUuVGXS8hUrd+?=
 =?UTF-8?Q?urMrvK8IuNJhEatOMgzi70xzR+lmxYiuzOMKBPrEYG2ZTn1fkk3nF_JPTfpFDJL?=
 =?UTF-8?Q?jz0uauEIAeZU14GbHYp3kTzc0H3YnlSoecBGBRbk3OqkIkPjI5ExXN6Y7rc_9w?=
 =?UTF-8?Q?=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j84ery-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 14:43:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SDud91025822;
	Tue, 28 May 2024 14:43:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50py1hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 14:43:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SEhW7p035350;
	Tue, 28 May 2024 14:43:32 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yc50py1g5-1;
	Tue, 28 May 2024 14:43:32 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH  v4 0/5] x86/pkeys: update PKRU to enable pkey 0 before
Date: Tue, 28 May 2024 14:43:26 +0000
Message-Id: <20240528144331.2758104-1-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_10,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=850 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280111
X-Proofpoint-ORIG-GUID: dpJjDFvk0tZUvkGSS3B3Fdn_s0Kvkmtt
X-Proofpoint-GUID: dpJjDFvk0tZUvkGSS3B3Fdn_s0Kvkmtt

v4 updates (based on review feedback from Thomas Gleixner):
- Simplified update_pkru_in_sigframe()
- Changed sigpkru to enable minimally required keys (init_pkru and current
  pkru)
- Modified pkey_sighandler_tests.c to use kselfttest framework
- Fixed commit descriptions
- Fixed sigreturn use case (pointed out by Jeff Xu)
- Added a new sigreturn test case

v3 updates (based on review feedback from Ingo Molnar and Dave Hansen):
- Split the original patch into 3:
        - function interface changes
        - helper functions
        - functional change to write pkru on sigframe
- Enabled all pkeys before XSAVE - i.e. wrpkru(0), rather than assuming
that the alt sig stack is always protected by pkey 0.
- Added a few test cases in pkey_sighandler_tests.c.

I had some trouble adding these tests to
tools/testing/selftests/mm/protection_keys.c, so they're in a separate
file.

Aruna Ramakrishna (4):
  x86/pkeys: Add PKRU as a parameter in signal handling functions
  x86/pkeys: Add helper functions to update PKRU on sigframe
  x86/pkeys: Update PKRU to enable minimally required pkeys before XSAVE
  x86/pkeys: Restore altstack before sigcontext

Keith Lucas (1):
  selftests/mm: Add new testcases for pkeys

 arch/x86/include/asm/fpu/signal.h             |   2 +-
 arch/x86/include/asm/sighandling.h            |  10 +-
 arch/x86/kernel/fpu/signal.c                  |  27 +-
 arch/x86/kernel/fpu/xstate.c                  |  13 +
 arch/x86/kernel/fpu/xstate.h                  |   1 +
 arch/x86/kernel/signal.c                      |  42 +-
 arch/x86/kernel/signal_32.c                   |  12 +-
 arch/x86/kernel/signal_64.c                   |  14 +-
 tools/testing/selftests/mm/Makefile           |   5 +-
 tools/testing/selftests/mm/pkey-helpers.h     |  11 +-
 .../selftests/mm/pkey_sighandler_tests.c      | 480 ++++++++++++++++++
 tools/testing/selftests/mm/protection_keys.c  |  10 -
 12 files changed, 582 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c


base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
prerequisite-patch-id: d84439301b44c03df2555d3722ec512001ae52f2
-- 
2.39.3


