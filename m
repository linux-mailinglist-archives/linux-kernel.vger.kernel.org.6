Return-Path: <linux-kernel+bounces-192558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366018D1F16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D0C1C22434
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB9F170848;
	Tue, 28 May 2024 14:43:44 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634816FF27
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907424; cv=none; b=AyAD/ZuJuONokE7lG/AnzEBL7Got2jWTIS97g//fBMvsqedLIVi2aZfP0HASGWvXyYOdvEo5tIprL1AQwMJAcMbjRJ/A6RW/Fe/v1I2mMRdIOJI9Ynd4a2BTeZgTAvaYETrBuXNngX2qvjIlUHAeSSJjX8l4EtQ2ndq9joJyc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907424; c=relaxed/simple;
	bh=byLEVOEAyGF2WqnaDcyJv5bVHKJ/dSgrdufHxeMItgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hx+bf2rkLqZCq10wcGlLowxKqrBWGTBb7H/SFHlA9tGN7h6Jh2k9rFpepxLjz+RqJ7mIyJDHE05bEolaBqlZUvQSqoTzdS1L2bp0g7hk+OS3VELgonw6JDPn9sLaryrG6p5LjNlCadSIIliQH7p/0Aj5QWDiMoN9yuArV+9+ksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SBoe6s028715;
	Tue, 28 May 2024 14:43:37 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:date:from:in-reply-to:message-i?=
 =?UTF-8?Q?d:mime-version:references:subject:to;_s=3Dcorp-2023-11-20;_bh?=
 =?UTF-8?Q?=3DnqR21MDKuxMT1J9GlTYAm6s4qP6FtJSxTQTSf2k0Uf8=3D;_b=3DEX6aVNYT?=
 =?UTF-8?Q?pxpdW0HFvAi26ft5ixWR7ipjgPfStKQ9um8sUGU6Y4jn6h9cvmRcInFVWdxD_WS?=
 =?UTF-8?Q?EG3eHpvKm4NOjRLT0lny/JIofurzgWQkTM68BiHej17wtUNeL0GmlAvS4Z3TXEx?=
 =?UTF-8?Q?PNh_tcGjXY/yBtKRQxQnTdRPz9/bM4K22DL3OU0jwwhLao/A44iwmps/keQSgB/?=
 =?UTF-8?Q?SjNKkoY+s_A1LasH3AegroZ18Nq8jHp9jPwlnNLeImitkBQUrWsM9Zx/0Rv1Drn?=
 =?UTF-8?Q?u8rGAEm5fSbosfi_YDrioGSlStTwVHBqmsX3fcHoo8DlnLgM7Zs2mSnJ4lzmbjJ?=
 =?UTF-8?Q?t8khySCVuMd8xZrzxoCgn_gQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg4jdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 14:43:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44SE3K5g025874;
	Tue, 28 May 2024 14:43:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50py1ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 14:43:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SEhW7v035350;
	Tue, 28 May 2024 14:43:35 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yc50py1g5-4;
	Tue, 28 May 2024 14:43:35 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH  v4 3/5] x86/pkeys: Update PKRU to enable minimally required pkeys before XSAVE
Date: Tue, 28 May 2024 14:43:29 +0000
Message-Id: <20240528144331.2758104-4-aruna.ramakrishna@oracle.com>
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
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=801 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280111
X-Proofpoint-GUID: OFLcUnhIgVuZGPihZtmhrk3F3T4uZHW1
X-Proofpoint-ORIG-GUID: OFLcUnhIgVuZGPihZtmhrk3F3T4uZHW1

If the alternate signal stack is protected by a different pkey than the
current execution stack, copying xsave data to the sigaltstack will fail
if its pkey is not enabled. Enable the extra pkey needed, before xsave,
so that the signal handler accessibility is not dictated by the PKRU
value that the thread sets up. But this updated PKRU value is also
pushed onto the sigframe, so overwrite that with the original, user-defined
PKRU value so that the value restored from sigcontext does not have the extra
pkey enabled.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/fpu/signal.c | 10 ++++++++--
 arch/x86/kernel/signal.c     | 10 +++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index b0b254b931fd..1065ab995305 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -168,8 +168,14 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
-	if (use_xsave())
-		return xsave_to_user_sigframe(buf);
+	int err = 0;
+
+	if (use_xsave()) {
+		err = xsave_to_user_sigframe(buf);
+		if (!err)
+			err = update_pkru_in_sigframe(buf, pkru);
+		return err;
+	}
 
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 3fa66b2fe753..659faf076b48 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -243,8 +243,8 @@ static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct fpu *fpu = &current->thread.fpu;
-	u32 pkru = read_pkru();
 	bool stepping, failed;
+	u32 pkru;
 
 	if (v8086_mode(regs))
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
@@ -280,6 +280,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	if (stepping)
 		user_disable_single_step(current);
 
+	/* Update PKRU to enable access to the alternate signal stack. */
+	pkru = sig_prepare_pkru();
 	failed = (setup_rt_frame(ksig, regs, pkru) < 0);
 	if (!failed) {
 		/*
@@ -297,6 +299,12 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		 * Ensure the signal handler starts with the new fpu state.
 		 */
 		fpu__clear_user_states(fpu);
+	} else {
+		/*
+		 * Restore PKRU to the original, user-defined value; disable
+		 * extra pkeys enabled for the alternate signal stack, if any.
+		 */
+		write_pkru(pkru);
 	}
 	signal_setup_done(failed, ksig, stepping);
 }
-- 
2.39.3


