Return-Path: <linux-kernel+bounces-332664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0897BCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BD628475F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF54F18A6D9;
	Wed, 18 Sep 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mIfddKlX"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1217C9A7
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664873; cv=none; b=Z8WzbqWKizaUuZelkm75l/GqwggK19vOygCOXBR8cOT3Cu/6INSG5RoTaQk7aos2cXfZ00vw+4i8qaPQMXK6ZqwV0xw9ycuuHGEr3ekHIdMdf4F0IqsHKii4SNEQkDfkuBj9ML79nzqW+/O+cpzAZzjA6lEDVjVnsLIy4M6zvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664873; c=relaxed/simple;
	bh=ghvE1wlUXx4GjU/Xz4moJ71Jpvavrq77P4YSow58dtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tViZJT4/ElLzQqMxiyt0pnuV1AKpW203FudiIREdPkNA2z9mfOgO9iSKzixnlK1/9dQ6RmAmjpmcIdcUmlDBwE9wN9D3uwymK6jMq3+FiUCvsP1oETTV3I3HeW6cuREEYo07D+sVI7caenn6uRJSfTCCAjt4SoPeNOdlbV7QdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mIfddKlX; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726664860;
	bh=/TNrOWNbUPEthzfhqHJKmziu43+uHykeH5RpYdRgBZo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mIfddKlXO6Ay9KBsnqEZ/KINBykzLkH2G+UWZrE582fnWHafSS7yEoJYnqX25hY95
	 yLr+7TlLj0KKM0yXd6nyXLe9FivHcB+HPxR5R6qYWQJrlgJxLcs7PCvzaQc9VxPoMi
	 fOEmysGktVCHa/RumWHF7EGMYtV/ai54POE1fedQ=
X-QQ-mid: bizesmtp89t1726664856tpxoq0ub
X-QQ-Originating-IP: TcS6ew3UVzNulMyjCAog1ndwGNkkrzCS8uXs46wt2io=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Sep 2024 21:07:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13190950233677462238
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
Subject: [PATCH 1/4] drm/ci: Upgrade urllib3 requirement to 2.2.2
Date: Wed, 18 Sep 2024 21:06:40 +0800
Message-ID: <AE44DC1999A1FDF9+20240918130725.448656-2-wangyuli@uniontech.com>
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

"build(deps): bump urllib3 from 2.0.7 to 2.2.2 in
 /drivers/gpu/drm/ci/xfails.

 When using urllib3's proxy support with, the header is only sent
 to the configured proxy, as expected.

 However, when sending HTTP requests without using urllib3's proxy
 support, it's possible to accidentally configure the header even
 though it won't have any effect as the request is not using a
 forwarding proxy or a tunneling proxy. In those cases, urllib3
 doesn't treat the HTTP header as one carrying authentication
 material and thus doesn't strip the header on cross-origin redirects.

 Because this is a highly unlikely scenario, we believe the severity
 of this vulnerability is low for almost all users. Out of an
 abundance of caution urllib3 will automatically strip the header
 during cross-origin redirects to avoid the small chance that users
 are doing this on accident.

 Users should use urllib3's proxy support or disable automatic
 redirects to achieve safe processing of the header, but we still
 decided to strip the header by default in order to further protect
 users who aren't using the correct approach.

 Severity: 4.4 / 10 (Moderate)
 Attack vector:        Network
 Attack complexity:       High
 Privileges required:     High
 User interaction:        None
 Scope:              Unchanged
 Confidentiality:         High
 Integrity:               None
 Availability:            None
 CVE ID:        CVE-2024-37891"

To avoid disturbing everyone with the kernel repo hosted on GitHub,
I suggest we upgrade our python dependencies once again to appease
GitHub Dependabot.

Link: https://github.com/dependabot
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/ci/xfails/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/xfails/requirements.txt b/drivers/gpu/drm/ci/xfails/requirements.txt
index 5e6d48d98e4e..2fae1299e07b 100644
--- a/drivers/gpu/drm/ci/xfails/requirements.txt
+++ b/drivers/gpu/drm/ci/xfails/requirements.txt
@@ -13,5 +13,5 @@ ruamel.yaml==0.17.32
 ruamel.yaml.clib==0.2.7
 setuptools==70.0.0
 tenacity==8.2.3
-urllib3==2.0.7
+urllib3==2.2.2
 wheel==0.41.1
-- 
2.45.2


