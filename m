Return-Path: <linux-kernel+bounces-177191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA78C3B39
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8871F21347
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4C14659B;
	Mon, 13 May 2024 06:16:13 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29634C81
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715580972; cv=none; b=lZuDzCtj4n7Xzww7FmCS1n0Qo9uoKR+zCKlMZj7TZlSApTrorZdxYXBrg9DXpaUNZRsrNLWXo1ervhTr4c/yUCDNFNZxCwdr+N/sDVbwoQwU7XXNpHwQsoO9eaTD4F62KaNYw//CfFhny6ALz4/uBy9klJm9QbumpcAEKSojeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715580972; c=relaxed/simple;
	bh=v/yags6cBHkXAioyFKr6dddV+gCs3r7vaAriPjpuPf0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P9SY+/kHOzE+W9gz8T75QgA4FsbA93IROXE8CIhUh6P9SI6mNDzngxGMdPr0tfRcAhpDFOxj4W1u3Pg92xsGEewlNmRv6XB4H7GY4eWhD1sOl+fyo0i3sVOi4nmFKinsCOvOdLlLb+l0yqIU1pq7qtVuR8AJlAdbLyTykoc3WhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id JBB00052;
        Mon, 13 May 2024 14:14:52 +0800
Received: from localhost.localdomain (10.94.2.243) by
 jtjnmail201606.home.langchao.com (10.100.2.6) with Microsoft SMTP Server id
 15.1.2507.35; Mon, 13 May 2024 14:14:53 +0800
From: Deming Wang <wangdeming@inspur.com>
To: <airlied@linux.ie>, <daniel@ffwll.ch>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] drm/i915/gem/i915_gem_ttm_move: Fix typo
Date: Mon, 13 May 2024 02:14:51 -0400
Message-ID: <20240513061451.1627-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2024513141452779b28cd68fca5655d37adb3049c7554
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The mapings should be replaced by mappings.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index 7078af2f8f79..03b00a03a634 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -155,7 +155,7 @@ void i915_ttm_adjust_gem_after_move(struct drm_i915_gem_object *obj)
  * @bo: The ttm buffer object.
  *
  * This function prepares an object for move by removing all GPU bindings,
- * removing all CPU mapings and finally releasing the pages sg-table.
+ * removing all CPU mappings and finally releasing the pages sg-table.
  *
  * Return: 0 if successful, negative error code on error.
  */
-- 
2.31.1


