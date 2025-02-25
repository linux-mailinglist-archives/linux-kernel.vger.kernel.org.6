Return-Path: <linux-kernel+bounces-531357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB5CA43F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AEA16EA00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0844267F55;
	Tue, 25 Feb 2025 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="s7zLi+W5"
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5E264A62
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486794; cv=none; b=gzTr92CFrzau5+pZ2epAloiS5Ui9JVZGO76IrPfSzH2jXVOmGeVoA2Ok4AmAmExiOeq0lbmK7UBeTBPQ8nre84dChwwGlYzu3SNgcFv6R5ycEPw2WVY0sm2tJf5jwkAdBFp88hoMvpEdI566VkMH86n8exXWLVwNXo5ssafoHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486794; c=relaxed/simple;
	bh=flqKRrG+cUbNuOxatPRrz3/xQCwHu4Csd5h3eiZGLzI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B1pSWyx2zTqChAi6x2AKmRlbkVmmuN+vJtrN3i3VdyxCiiaH1hX6I4tFuMLwGgfCX5FV4/ikzEJKfYR1J2erw42C/1z+LYuSRghKPeMdymb1UYVCIjugo8k7nAyTjtadK/yDItUYA4Q7qteHTFyZpbA3wBDEpy6ymUqs80Itn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=s7zLi+W5; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=b2KIEz2420Bb2pMgV6oZ8yidp4SHbkJXc5kwpa6Ezmw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme;
	b=s7zLi+W5e6GuO2xN4gm26yNFYJzhl8upFxKnD6eKHIf03zgJfuIaJqOqMu6hU7D00
	 aMbPQ8hGa6cIOxWXZ1Jgbl0GtNTPSDbLrk3mUeubUL4w3rnW5mLCRIM374CKVc52ku
	 wkEuuXmZdAM+ItF/mlgZDxDWKB7ePq0y0ulQNa1pK3XiY0v22PyUtlxvU5M/4+NCWq
	 C2udzH6dgZwHB3kIDx6wzNzwDBdQB6CzMlDozxqTaOolbdCEILaurlGiPJVxXGu1BR
	 OkdJjy8KCAr1Xit61DpG7g74Sv0JfaLti+/JdDbOVquFHvWGLDXR6q1FBGOd7Pld2Q
	 Ua/nqjTQjVInQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id DBA9E6803DD;
	Tue, 25 Feb 2025 12:33:05 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH RESEND 0/2] phy: core: Remove 2 APIs
Date: Tue, 25 Feb 2025 20:32:37 +0800
Message-Id: <20250225-remove-apis-v1-0-e49b4a1941fd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: 4yt0iayngGT9xwSqldJKZ_x5gqqXu5m-
X-Proofpoint-GUID: 4yt0iayngGT9xwSqldJKZ_x5gqqXu5m-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=557 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250088
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

This patch series is to remove the following 2 APIs:

devm_of_phy_provider_unregister()
devm_phy_destroy()

Both APIs have not had callers for more than 10 years.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Zijun Hu (2):
      phy: core: Remove API devm_of_phy_provider_unregister()
      phy: core: Remove API devm_phy_destroy()

 Documentation/driver-api/phy/phy.rst               | 11 ++-----
 .../translations/zh_CN/driver-api/phy/phy.rst      | 12 ++------
 drivers/phy/phy-core.c                             | 36 ----------------------
 include/linux/phy/phy.h                            | 11 -------
 4 files changed, 6 insertions(+), 64 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250210-remove-apis-b4e48d4c4712

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


