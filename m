Return-Path: <linux-kernel+bounces-332666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4945997BCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA656B24D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863A18B461;
	Wed, 18 Sep 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fziZ1m9u"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D4518A932
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664878; cv=none; b=SI7O7pzJeDhcBWpqx0IjqLMMoIRRIs1L3oYAzCEdanj1+1xqljekqPOdZsw6eCIbqvtzzmz5WzV1EczreWbIN/Yd7LveykN0JVVb5HhlScrDrgNY/nodDRgLKcw0DQ2Auwy2couZlySxcgGDzkoHbew95rxILlYwq5B6+v9c4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664878; c=relaxed/simple;
	bh=1A4VyPidRPzjffgEHunRjqNWTKRofBYCMgXWPZ31zPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb0chx4c4YwmS1SikcBHeGMiUzaBaN8VTQwiCzXYH1WL0DHbaBPZY+axKzKWYmbcvUzSPvzQXceTOlEYc85CFRkzJKW9jRlKbRTJjO0zZSZnRVaAdw1rNJrtbbfOqcrEn6T04o54ieI+Ct/r9T6cSEcwTojgThp6oj8iIpzNyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fziZ1m9u; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726664872;
	bh=RC2PbTe+FDm7zLc+8APOYm4+AzjmOpO3efPzB4XXvWM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fziZ1m9uZILg6iORRnPQo9DcXUhjnMaWsNygK2O8m9Er+I9Aq3ScqvexpG81Nttmw
	 KMQmdKJd33u3mjRfxJhi6XGnYSgqccB00RD57sENIYXs3AQi6ugHR+LMlPsDFb5gEd
	 QIeXGB8CNFgZ8gXq4DthvFXFgaqfEOPmkeHxc0Sk=
X-QQ-mid: bizesmtp89t1726664868tv5pwabb
X-QQ-Originating-IP: 9lq6EIop9cgRFN5fQlSY/DQxz5cESd8ppts3gi20zuk=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Sep 2024 21:07:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5552265885235446597
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
Subject: [PATCH 4/4] drm/ci: Upgrade certifi requirement to 2024.07.04
Date: Wed, 18 Sep 2024 21:06:43 +0800
Message-ID: <EE4F19CBA2D3EB87+20240918130725.448656-5-wangyuli@uniontech.com>
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


