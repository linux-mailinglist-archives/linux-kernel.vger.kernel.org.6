Return-Path: <linux-kernel+bounces-332667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66497BCCC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482FB1F229A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0318B49B;
	Wed, 18 Sep 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VIU/p0Ge"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85F18A943
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664882; cv=none; b=rMruulECX6mS3A1PH3kW1AjRPIZoVLRJ/nhBloVe3rdbRAzdWmveA9eJZUy7Zze+Aa2/9OCMQL7eKcVWZLK8/gcVKbwAuhmwAJCThPLemTbP8y3r9a97L5sLmMdda8uzLlDKxFyyteqi6bggLbtX1vfWYz8ulQ+rF7JlPj8deSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664882; c=relaxed/simple;
	bh=VF/U7coP59QLIkEthcVbWcr0tETDPt+BHf+3qS5BH1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHQDt7gDyBFzXj11a/rjZtYAQ9TA7Yz9uC0FffCaAw/w6/xu/DFom75z+iiozX6yXyHx5sk9ZbC/cGyuHbYlHHygDl3MPQsT1JppwMSUy7izMukIVzbXzVXHwNHTSfxCD/1Ge8Sbu2Bj9Ce9fwjE8CGGBg1eJbplOR0XKLsvRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VIU/p0Ge; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726664869;
	bh=78SgngBKZBmCahApQZmS491yViuhV7ff/MsyOqzu+jA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VIU/p0GeKuFsOWOE46PX1SM3ibo7I41T+kIhsFLJZ2y8OYfWqDpxqwV9avWw7cD8p
	 fz5FZqCpkeWiqHXE3S4pkwVuzjqzTcVNCCu13TuFPMiNmD8IvKRlMITlBAqsakugkI
	 BU6c9rGSHq4+5bxRhPulgNCeIhSY6EHxH8IiTuok=
X-QQ-mid: bizesmtp89t1726664864tqxrduuz
X-QQ-Originating-IP: iStDSal+XfZLIbLXnFqWfb3b+vIvkE4Fj6sizXbwNow=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Sep 2024 21:07:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 880936769017630702
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
Subject: [PATCH 3/4] drm/ci: Upgrade idna requirement to 3.7
Date: Wed, 18 Sep 2024 21:06:42 +0800
Message-ID: <72EEE7B8B5E98035+20240918130725.448656-4-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240918130725.448656-1-wangyuli@uniontech.com>
References: <20240918130725.448656-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

GitHub Dependabot has issued the following alert:

"build(deps): bump idna from 3.4 to 3.7 in /drivers/gpu/drm/ci/xfails.

 A specially crafted argument to the function could consume
 significant resources. This may lead to a denial-of-service.

 The function has been refined to reject such strings without the
 associated resource consumption in version 3.7.

 Severity: 6.9 / 10 (Moderate)
 Attack vector:          Local
 Attack complexity:        Low
 Attack Requirements:     None
 Privileges required:     None
 User interaction:        None
 Confidentiality:         None
 Integrity:               None
 Availability:            High
 CVE ID:         CVE-2024-3651"

To avoid disturbing everyone with the kernel repo hosted on GitHub,
I suggest we upgrade our python dependencies once again to appease
GitHub Dependabot.

Link: https://github.com/dependabot
Link: https://huntr.com/bounties/93d78d07-d791-4b39-a845-cbfabc44aadb
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/ci/xfails/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/xfails/requirements.txt b/drivers/gpu/drm/ci/xfails/requirements.txt
index f69b58356a37..8b2b1fa16614 100644
--- a/drivers/gpu/drm/ci/xfails/requirements.txt
+++ b/drivers/gpu/drm/ci/xfails/requirements.txt
@@ -4,7 +4,7 @@ termcolor==2.3.0
 # ci-collate dependencies
 certifi==2023.7.22
 charset-normalizer==3.2.0
-idna==3.4
+idna==3.7
 pip==23.3
 python-gitlab==3.15.0
 requests==2.32.0
-- 
2.45.2


