Return-Path: <linux-kernel+bounces-369142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2790A9A1969
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F7F1C21453
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E4013B5B6;
	Thu, 17 Oct 2024 03:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SvD6ex0M"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6907E575
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136524; cv=none; b=EyIYijxicbKjZK1qA8M1cdOjEFdUCSLWjuF13I4l2fPjGCsChwRIpV1I7mI/6YkcZDOwrytSXemhNM6Ey9IwZYw5Z5mp6oNp1HZUfLdcc7YEprccAQpTHGpnH8t56HWuMLhPwWN4F+Uay9l75+S+3yjI3fiZSvqMAnWDY3IqmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136524; c=relaxed/simple;
	bh=ghvE1wlUXx4GjU/Xz4moJ71Jpvavrq77P4YSow58dtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQM01LlRut76rHnxuXR2mvIgNesksRJyJA/en/OYZkqDqj4o5ggYMQuKyGZmWzFz537tdzp6/MTUsaKE8y73mk2PDiafn29nHZ+7K6oKU/TOHmGOyAV7QhFEkPyodCEKezRkTgmqvnrCAL26FJKFDYzmRVs4Fc5pkn7JIP9s/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SvD6ex0M; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729136455;
	bh=/TNrOWNbUPEthzfhqHJKmziu43+uHykeH5RpYdRgBZo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SvD6ex0M5IW+A6r0nw4pLv3eVYxYj3WHgK80/DozgCKDEUNb+8XP7lYW4nX6JF90w
	 2Q6bqhtCIwLAf+Bh6aVLdMVfk6t+4wbtdxqSkBpKqL0MIaiO08laLRNS+nJrEHH5Qq
	 BSFrgYVeYYKYuZBvvf3pS5HQQ/L+SWLyBQUcW0a4=
X-QQ-mid: bizesmtpsz5t1729136414tml4pwk
X-QQ-Originating-IP: KK23v6DESCX+/i0Va+sOnkKrvO+uca82q25Wknc1Hzc=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 11:40:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17913914486552868709
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
Subject: [RESEND. PATCH 2/5] drm/ci: Upgrade urllib3 requirement to 2.2.2
Date: Thu, 17 Oct 2024 11:39:49 +0800
Message-ID: <BF18622263EEE575+20241017034004.113456-2-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: NWTQ68Yg3gczqLNk2+yhNuroKrMwGQaRQm6e+oQJcts6cnXT3TgT2Wtq
	1483Oez39KAaGpvx28VKP2HZLugRXizyP28MtKSvqkSskWMR6ABxY3wCcZPpaHVDHg+AxAU
	VmbElLkvOe1Uq4GPQ6rpCc6XxH2wo5eC9R/QIylDGnspwxQUsJz6lQb9Rqj3p2AikEkOMSm
	nfPStfSSq4ghBGWoaJMah2BJF8NDqRf5KkJEOSIPbfb2f6L17oTo8uPDKNoJ6rG+6aS8w5a
	u+AYCL1as833qsmijDyZst7rmB1ljis03h3zJy36kxkfRde9VIKyYqxPIcp7YBDNpt6en4Z
	tBgAB/O1xeR1k2Iabm6/vE28pSYOIoBaT+fKWRRofmcVfipT+7AN2PPgDd8krPRuWNhia8T
	n+sDELrEU07lZpoNk0QHXlGKCTFKalafalT4IGmTwQ+GPDA9598MrjxqQBhbkhPQzqS++ej
	s97ORI5gwt/CTaqazPFJ43ZeUdKSRc2uYk4glTvEE00GYqtkWV38XXZlWXQmBIiMWv3agA1
	hyfVAB8GjzWLa0uDD73dtzZqWvVAq8IXoMZl6unxvRYoKlXzSzeegulG9ku2zxN992n5vca
	ZCYJAh5F/Kwu983gkSd1Ec4zNoEZnbeDwZA5KSV2ub45AOb85zBHcLYazWlvHhsH6iZFBfx
	+Hk5lzFFB9AiudobvyIS3zl8ic82T5Zl/750bhJhxS93AYef91DPZSXrW56G2Ty/EnNjcbg
	lSC8WMxqza+gKTplABYIvnt7DFzE+bHjD8re0KJIs3xyU1TeFhBnE6BC62zQbD11fOruook
	nnFHHUWfpgl3VQaPluAZrM7jDHqUJTVLh2QOkxE1hwA90u60JkHKIaunT4cUUJpv2ZSEz2d
	9v86PbNebUk+tpOQE0Z1pZWJBqOrrS1Kgz5L8O1iulzSFy7cOpV+VpDFoPseAIkGFvBMaoO
	0k8gri0ayo1Y/Kz7jSFOzGnrvBhYQMdq80aXL9tMTYDUVhhiPhcQBLrGvsLWsuLtL2+pM3j
	CK2X8O1rb8jdFUOyDeP5t541e6A1o=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

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


