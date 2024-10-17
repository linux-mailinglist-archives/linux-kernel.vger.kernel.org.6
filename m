Return-Path: <linux-kernel+bounces-369145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2EA9A196D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EBC1F22B79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7B16BE0D;
	Thu, 17 Oct 2024 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="e/OX4j3l"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A717E575
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136536; cv=none; b=gibaQ6vQRBQ+6Vh2Iq7hc39OXS/b/rTRwz/AAhaUpF+r8lXWtyBSqCnJCylg2r1JhhnkR4mrD1GAAFCucHi7FGwllbmTQZPqDMWWnQwEADkHjy3HJm/DcGuj3MnXgGYHopBKrpm8eNciRJ8QOvOWg89pPR6oQTzl8dajzMa7yu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136536; c=relaxed/simple;
	bh=1A4VyPidRPzjffgEHunRjqNWTKRofBYCMgXWPZ31zPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGDDJ/zaxiH6ot/iSHegQI7CVL8+8SsLmswZy4/QXfXBIwj1CICUpLu6qeIIT383O7f7H8La6ovTyvKON1lBdNuCJGmymEWlTthNa3XhfTnRVp/LVndwT9rS2Nk4mqHy6/AJlwct7AgO4qxZeMIzuRc2XsnWbQLsbAMztB1KiJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=e/OX4j3l; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729136462;
	bh=RC2PbTe+FDm7zLc+8APOYm4+AzjmOpO3efPzB4XXvWM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=e/OX4j3lb122VzmkBRoA4OfJOBK1O2/aYUBoBuIFwiCehFduumxPQoY0qzRiP8Mrx
	 cGCiCDqqf5pKsnWGXp0RnyvkU+4PmEqqEgVolJlXxlJO7ubVluv8bH7WAUP0JKYdyV
	 QebD3XsLrobX1mwHzl6IVhULHuGhUaFa6oBFVkao=
X-QQ-mid: bizesmtpsz5t1729136426txbi37g
X-QQ-Originating-IP: 7TxsSelKf0dMgeMEChKRtZqHq7GfN6ly+pDP2DMneNw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 11:40:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4008574617543499355
From: WangYuli <wangyuli@uniontech.com>
To: helen.koike@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	wangyuli@uniontech.com,
	david.heidelberg@collabora.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com
Subject: [RESEND. PATCH 5/5] drm/ci: Upgrade certifi requirement to 2024.07.04
Date: Thu, 17 Oct 2024 11:39:52 +0800
Message-ID: <DDEA395AF9015F5F+20241017034004.113456-5-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017034004.113456-1-wangyuli@uniontech.com>
References: <20241017034004.113456-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Nwz8Cs33/Lpr8t5cDPma9YzNfP0jHpxsqyP3CJmidkZkevrV5JdfSJIj
	V6GQxc4uN0bqtGzZqaCXoj6esyUm4I6OVAxCnvLIHQxkqF40uvMyXluGBtrnJZXiMhNL858
	mEQN4ABmz73KnOOw8it8buUYBSU9cAq3fXP3NQbA7FdKoqBg1pcx7t7DicK0AUBdz+rJmaw
	sJurKDxljBfHWQwCQi+zCOhypzW9XBsZ5vlM2/D24VIA+lsQRFfZPABN5V8Z5j6LnY72eMF
	hgqmqJa+YkUU/JZBCEg16WcA8q3DmDYCtCCKljmlp3B5lEjgghsTrTiaa5jzlCemgK92nc6
	YUbdnoIcDQE3cFMDkU/ZRYe0oDSVADZt5kEnJQ9YIurhiJ1EETpdWLNC7VwMmzb//dQ8vgt
	zPacKmxPbyFg604ZIdVUUB3c1ZK4qOv4MT475ujA2gjcKMhswjG9W4qoqijHryqFUCrCLmq
	M1n0lJi9k22KxstA0waXdA5Bts8TVihdD0eFf72Hm+IfAgXaaNtgZq4555d642rIkssvxk5
	3cTfgCxiZPptoMArNCYuYZCK0j8rue2llg9+EDF0ay0moLuZDz/2dFCf6miwR4tIQFvOkwS
	VrEZEuZWcX9feYr/ilX74fOkxW0zWS8Ff2epuWQyHhzmhY+6c+K0zBRb7SLDxodU7L/26pt
	hbBE7dFc1RldUrVunTnSsWFfaOFWf6olSz83XLIxaQx5NtRjjhuLlpNRHLhyy0joy08dkje
	Ql+/RcVmhl/rnseeBUdmfPjrAes8O2veCPuCH2l223INV9UUxKvfmiWb97+B1QA9eRwCkCl
	HEyZVxNObUoUHZqLSW7JXoj2dWbxFO7OPjgm323FHyvzAQgWl8iQVV62cGkeZzOQ7cJ6NUA
	HiOz+4BiKE0rbBhXuto4nyLpm1qkwFJL/VX/MyI0OIN2E9MM1sVupENJFwpVPzAeLvjypEt
	4tLQITgwQ2AooK9OPGufnA5a9G/6iQ4R4D35duWV0NyRglrMVDzPCJMZ+EWxXTnTWOElwlC
	TwKHT9wilZboep3ghJIOjesObbuO8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

GitHub Dependabot has issued the following alert:

"build(deps): bump certifi from 2023.7.22 to 2024.7.4 in
 /drivers/gpu/drm/ci/xfails.

 Certifi 2024.07.04 removes root certificates from "GLOBALTRUST"
 from the root store. These are in the process of being removed from
 Mozilla's trust store.

 GLOBALTRUST's root certificates are being removed pursuant to an
 investigation which identified "long-running and unresolved compliance
 issues".

 Severity:          Low
 CVE ID: CVE-2024-39689"

To avoid disturbing everyone with the kernel repo hosted on GitHub,
I suggest we upgrade our python dependencies once again to appease
GitHub Dependabot.

Link: https://github.com/dependabot
Link: https://groups.google.com/a/mozilla.org/g/dev-security-policy/c/XpknYMPO8dI
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/ci/xfails/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/xfails/requirements.txt b/drivers/gpu/drm/ci/xfails/requirements.txt
index 8b2b1fa16614..4f7ac688d448 100644
--- a/drivers/gpu/drm/ci/xfails/requirements.txt
+++ b/drivers/gpu/drm/ci/xfails/requirements.txt
@@ -2,7 +2,7 @@ git+https://gitlab.freedesktop.org/gfx-ci/ci-collate@09e7142715c16f54344ddf97013
 termcolor==2.3.0
 
 # ci-collate dependencies
-certifi==2023.7.22
+certifi==2024.07.04
 charset-normalizer==3.2.0
 idna==3.7
 pip==23.3
-- 
2.45.2


