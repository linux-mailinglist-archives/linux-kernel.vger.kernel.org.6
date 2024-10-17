Return-Path: <linux-kernel+bounces-369141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74739A1968
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95A91C21673
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B513B286;
	Thu, 17 Oct 2024 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WKRco6As"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D46BFC0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136523; cv=none; b=PwwILniYdVDCIavyvBTT7bUekJl/VYn8b16U61AXtGg/JwtgWHwed1gnpyElcbmnDrfwEc7b19J7DyaHsu8dt15fAAu5R2MXtq82ADSPrbG1fGNPv4autvoEqQRDyP7FpsbrV9ej40NiEXNpTyfaRYP0k2xDlSGkcTc5R1cpGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136523; c=relaxed/simple;
	bh=FheUAec7IZrrKH4+pc1ScbmLFr0EFfoZVGSVTBU6VbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdZF1Z0M2OhW1Vs6CeyV1hOItWzYHkmFsowfnxnYjOdvwAmCQnyJgQ2JU3khGB6pbT4pxvAmPkfInBOSQmTb0mOBUblGGrhLxwJhYRyweHugMTa1QZrpe8Azin+pHtBAAKzZwbBHdG4Fo2SEHtrFpB1yUdECGqp9qcNCuI82sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WKRco6As; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729136456;
	bh=+/DdLbFCN3x83oxAHHqnPnAEM1hgWNumW7T/6E5yt74=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=WKRco6AsmfxtEMP9CkPU7erStzwBvOrE0s2tcGLdGamLgj1bl3Tz2NfClzs+kSrJR
	 Ltfukwa1TQxH3MUOM+3/Y9rVFbJcL/hvhWvW2He6G1UkrTMYTIIxFVJ9Q50vj6MM/k
	 WX5JQeGt5pAZxK3G/8PzwPn/yMy8RAT0CjicfFLo=
X-QQ-mid: bizesmtpsz5t1729136418tu84pku
X-QQ-Originating-IP: MYne5dTKV5TL2KIkHVQVbuEnwE0v/dd4ms9SyKz2d5Y=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 11:40:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5065782363297022121
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
Subject: [RESEND. PATCH 3/5] drm/ci: Upgrade requests requirement to 2.32.0
Date: Thu, 17 Oct 2024 11:39:50 +0800
Message-ID: <0984066064003022+20241017034004.113456-3-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: MbSuBwOrED9vvWtKS77uCvoDSQ0z3MT2NGBfyfpRwX0hGDGKP2V5VBoV
	WWDImpLaFTOmvNgGnnpGuMlqx1J8RFmxCs54LUwBvrneRFvl+wYkGtqJdB5h2Bb33dHZE0c
	IkTgJXKijETjY6QH6OwKgJgej5/5nW7MrwbvqtlW3dfiUgKetWmZDLNZAK9RIcyAHI4tdd5
	Q7uPTaMmqy+rPwnO2EDgOS/EA4wEsWUFZCIRotw6lyWxHpEnl0i7PJmIl+2J+ZIybigUVhS
	M14dTYorZsrsWiGPPk8b3E6HY9qys3DzKdZ6iFmtt4SGSFrJieADtFtYp1d9x0Gt/7zqxOv
	GZbXla4cU3s3MIAyK3zrC4xYQeioWm/XnoUyCUldxkQYBfKWjjH68pdGo4i0nVYxQrAnRYl
	UgOmNTGa04BBDs4uevX3PAX+LChzBI58lBN05ZTzxGo4n5hJ9FPwYktSN8fP8yz7iKsOKnw
	MLJID96IDL9wFLXzmaLR4RtRBS/Ar0lZtZ9swy/0Ja8ncezf/MpQwqgJX5P71K0qsmsTnXp
	s4JAM5m8IJmNqXSMNdTMVMUA4o7H3N8W4nfC15yZjXTQOogzWm8esGTtoTNzs1YD6OWVqF/
	BEQCAZkgzDcGZ/El20zRhd3iymSkjAheB449rtKv6bM3mQyQqGK6oWWlIEIJpKe276tE8Uy
	CR9b1fcLRBlxDw0rw1Vo+1Iskb110dRPCzrhKkWsadgBRKpdGNxlKwVQzg8Od4YxLen27Oc
	DebbB0rW5JLNa8bZEOkv0U1aHudV6Yb5ZDSkvLNY3OQfVm6xI70WHXYcqnah+4YLBfqq2oU
	xfhE5YH/Joar/514+hqxC5vCVihmIZG9Y0/apSz7ozbv617gUUW5hqV6K0B11jCwY6L1SKD
	Y5zg/HhlVsmf6wYVuofwD5ZSjMUWJyDnMOvGq9uh51Xue8AUZifwdHqm3MKMv156WRBT5BO
	X6kgluQ6ZExm0bOQhBLk+45PY3Y5fkr3OQum9JXAqkqdYRl+chF6YreSkj/9lbBZojsZzwu
	oHQciMPKSuFeUJElWGBXR5gbrTBck=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

GitHub Dependabot has issued the following alert:

"build(deps): bump requests from 2.31.0 to 2.32.2 in
 /drivers/gpu/drm/ci/xfails.

 When making requests through a Requests Session, if the first
 request is made with verify=False to disable cert verification,
 all subsequent requests to the same origin will continue to ignore
 cert verification regardless of changes to the value of verify.
 This behavior will continue for the lifecycle of the connection in
 the connection pool.

 Severity: 5.6 / 10 (Moderate)
 Attack vector:          Local
 Attack complexity:       High
 Privileges required:     High
 User interaction:    Required
 Scope:              Unchanged
 Confidentiality:         High
 Integrity:               High
 Availability:            None
 CVE ID:        CVE-2024-35195"

To avoid disturbing everyone with the kernel repo hosted on GitHub,
I suggest we upgrade our python dependencies once again to appease
GitHub Dependabot.

Link: https://github.com/dependabot
Link: https://github.com/psf/requests/pull/6655
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/ci/xfails/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/xfails/requirements.txt b/drivers/gpu/drm/ci/xfails/requirements.txt
index 2fae1299e07b..f69b58356a37 100644
--- a/drivers/gpu/drm/ci/xfails/requirements.txt
+++ b/drivers/gpu/drm/ci/xfails/requirements.txt
@@ -7,7 +7,7 @@ charset-normalizer==3.2.0
 idna==3.4
 pip==23.3
 python-gitlab==3.15.0
-requests==2.31.0
+requests==2.32.0
 requests-toolbelt==1.0.0
 ruamel.yaml==0.17.32
 ruamel.yaml.clib==0.2.7
-- 
2.45.2


