Return-Path: <linux-kernel+bounces-192560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C308D1F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC2CB218AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35E171E52;
	Tue, 28 May 2024 14:43:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51414170829
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907437; cv=none; b=oyssItOwF32GJBeScLx0xmJgnZOGgWiTiZTAzDq9fi8j49Lzt3sz7etp1XHgYu6VtT/kmD8ftionnpR1amT2/boci/+ZWZD0wfYsnfNB7ozr0VeYNetKDD/hzHiaUyVb2+2aT2M5fAqryXx9q6pay+bDxktKKcLHnf5LAYgDF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907437; c=relaxed/simple;
	bh=tlwUG6i2dN04+SFgN9SBdBQln0TBzFDCm4yq8WOlNIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ud/zIem33mjvsEFXrbUM3VyxmVxAGcX3MN+YKy9BzRL8oxdKiisCin1KeYlmysyMmZrKVKI5yxMu2Bq3MfwjrDEIzh60xbRBdcR0g+3QPtxfYUPHPhElkNdjq+CgOLB+GKSnT30tHh1Zo6OA2p24EjWDr50EjEicwTCPUs6vP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBn1fD031927;
	Tue, 28 May 2024 14:43:51 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3DKPsMX+2z7i40hslxQGSb/YJgYDxUNOarNeZ/dlWFyIc=3D;_b=3Dlju9reQT?=
 =?UTF-8?Q?cFHQ0dIZmRQwhF8PJeDvqSzT/JIYFGgXrVq4VvLFXIenPkxRrj0qWdvrGXVc_m1?=
 =?UTF-8?Q?DxJMi46GPSC2tpW900JNUjvXetxDBVFP1g/CUmNBKHmmAvC2/IRtRvw19BWpiSY?=
 =?UTF-8?Q?Ogb_aXcjtpvbsIJGY1uOk21FnsM0IBmvZq9FhRrsbkPQbiDdOs/ifB1GFVBHUCi?=
 =?UTF-8?Q?68RyLIUo8_LG7KWeqgoYESR/B4+N+Ch+DvyJXzX+FYPT1xi/fH7Ko3hrcQVjClq?=
 =?UTF-8?Q?tMJSw16wmZhbk7X_pS39Ilid3IS6UmTT2jZB+D0bEx9ew/DPr91avrV7kgBGrRh?=
 =?UTF-8?Q?UHkomkvZYfgDAopx+ycDb_Ww=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g9mkbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 14:43:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SDj2FL025795;
	Tue, 28 May 2024 14:43:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50py1mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 14:43:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SEhW7x035350;
	Tue, 28 May 2024 14:43:36 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yc50py1g5-5;
	Tue, 28 May 2024 14:43:36 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH  v4 4/5] x86/pkeys: Restore altstack before sigcontext
Date: Tue, 28 May 2024 14:43:30 +0000
Message-Id: <20240528144331.2758104-5-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240528144331.2758104-1-aruna.ramakrishna@oracle.com>
References: <20240528144331.2758104-1-aruna.ramakrishna@oracle.com>
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
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=723 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280111
X-Proofpoint-GUID: U9QO9qC6kx28ti4fNPuB14nCVQUkjv9j
X-Proofpoint-ORIG-GUID: U9QO9qC6kx28ti4fNPuB14nCVQUkjv9j

A process can disable access to the alternate signal stack and still
expect signals to be delivered correctly. handle_signal() updates the
PKRU value to enable access to the atlstack, and makes sure that the
value on the sigframe is the user-defined PKRU value so that it is
correctly restored. However, in sigreturn(), restore_altstack() needs
read access to the alt stack. But the PKRU is already restored from the
sigframe (in restore_sigcontext()) which will disable access to the
alt stack, resulting in a SIGSEGV.

Fix this by restoring altstack before restoring PKRU.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/signal_32.c | 4 ++--
 arch/x86/kernel/signal_64.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 68f2bfd7d6e7..c7a489f0d943 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -160,10 +160,10 @@ SYSCALL32_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+	if (restore_altstack32(&frame->uc.uc_stack))
 		goto badframe;
 
-	if (restore_altstack32(&frame->uc.uc_stack))
+	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
 
 	return regs->ax;
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 6b189de005b5..2d053333fcf5 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -260,13 +260,13 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-	if (restore_signal_shadow_stack())
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
-	if (restore_altstack(&frame->uc.uc_stack))
+	if (restore_signal_shadow_stack())
 		goto badframe;
 
 	return regs->ax;
-- 
2.39.3


