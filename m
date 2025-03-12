Return-Path: <linux-kernel+bounces-557817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D432A5DE32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8417B1673AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8A2459D8;
	Wed, 12 Mar 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4Ix+MnN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C64E23BD0C;
	Wed, 12 Mar 2025 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786763; cv=none; b=rfIyClxajPxBm8G0AgbTJLYTuvXA8ILNch8yF4xknXiC0hRS3Ur9TEgetSj1D45xsJW3H4uoyfNqAMQjEc7lO7EcF/QfdPt1JKhL6PdQiFI8M55K6p0Hf1j2hdv2QottTrLY71A2Al1KrkKSoeK8ODzDR5+uMkyjxP56NX2GFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786763; c=relaxed/simple;
	bh=9q9pTFFDp0VqclePp1DPC4Aqwa4kz8lpmBphXdxkMW0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dlu8lTY6sLSLcSrbgIrePreVF4jaaayPGJKAhvPSzJ7SF8DOaF8dR5od/G3ujuavEIhet0h53SoC2O2HI5LhP+nQBc5YhNnvdxuJ0hlxkgiavX6/fbFPY3sbP/5ZtnmkJpPMYaX/r4aK21AEC5gJUppS0SpyN/uD6yhbEBEhyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4Ix+MnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ED3C4CEE3;
	Wed, 12 Mar 2025 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741786762;
	bh=9q9pTFFDp0VqclePp1DPC4Aqwa4kz8lpmBphXdxkMW0=;
	h=From:Subject:Date:To:Cc:From;
	b=h4Ix+MnN5Alq2Q/xvt3sYssB1OcAbSfSozxyt8JWssMb2o1XrJF3OP1yrP/QTNT59
	 TEgRv4Vg+SCTMoEUVONzdUudAR5nKq1VIZB886zyYfdmnq6lzX3VMqpheaTcPXAM9G
	 fkTDFMSarHUlyk3+/H8/UipqDayY+mg3720cof846fHa0ClVgI/iomKzyQYhDdiJYD
	 4T2Lbs8BsX0KoTZ3IfusI9mAk9s1m7uJ8Fui/0q5UOoyJwJNYscKhe281h8zpBxjOF
	 YuaBda3mCuoEFu8gbZLIA0+o4UrFiGxc+rw1cAItIWVUSDVEHyt+tVWmi0bdSbl7zn
	 FkuKLnUWeXYJw==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 0/2] drm/display: HDMI documentation improvements
Date: Wed, 12 Mar 2025 14:39:15 +0100
Message-Id: <20250312-drm-hdmi-state-docs-v2-0-6352a5d68d5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOO0WcC/32NQQ6CMBBFr0Jm7Zi2CAIr72FYFDrARGnNlBAN4
 e5WDuDyveS/v0EkYYrQZBsIrRw5+ATmlEE/WT8SsksMRplC5apEJzNObmaMi10IXegjVvVV5Z0
 2l64bIC1fQgO/j+q9TTxxXIJ8jpNV/+z/3qpRYVFaXbu8UoXVtweJp+c5yAjtvu9fxdhSzLcAA
 AA=
X-Change-ID: 20250306-drm-hdmi-state-docs-89703b124bbf
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9q9pTFFDp0VqclePp1DPC4Aqwa4kz8lpmBphXdxkMW0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOkX+9pCddZuWGmU/OahT1GX0NFYlZj1EWXzMt4xlriZr
 BfeyH+0o5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABPZfoPhn62I8OpbR076FR14
 sEfNhP81z8t5u1/UJVi1mS0/4nrdPJCRYVLhXyW9HQGHCg3csxzXZl1mFvaYkmzzq5U5m5EjwnU
 fAwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Hi,

These patches improve the HDMI infrastructure documentation, in
particular to mention that edid-decode can help debug and check
infoframes issues.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Put a link to the v4l-utils repo
- Used a newer edid-decode version
- Link to v1: https://lore.kernel.org/r/20250306-drm-hdmi-state-docs-v1-0-56a19d3805a1@kernel.org

---
Maxime Ripard (2):
      drm/display: hdmi: Create documentation section
      drm/display: hdmi: Mention Infoframes testing with edid-decode

 Documentation/gpu/drm-kms-helpers.rst           |  15 ++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 292 ++++++++++++++++++++++++
 2 files changed, 307 insertions(+)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250306-drm-hdmi-state-docs-89703b124bbf

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


