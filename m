Return-Path: <linux-kernel+bounces-440624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB379EC1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA92188B9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5641DF75C;
	Wed, 11 Dec 2024 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g8y8Ihdr"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F61E0DCE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882375; cv=none; b=fNy6MiA8hvVGgI+GYkd3O6ekT9GhcsuMoYK27CgwOChs7TUdZqIDMQhX3XpMHy+G+Usaw3XDBixUHpfsCq9uPLpB4WuIutSIPZ0yR/6/Cav2CwEFqgLCsNWK/zAjUaCPy/Dq30gFSjnWiC4pSpew0Q20VfN9j39L0DJ+IW/4Y8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882375; c=relaxed/simple;
	bh=Lx+0Iqkp8+dDzJFn/6UO9R1nwb0jHmHFo/eOrmSei80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YTTY5NbAh/XoQYdIiWjygXGF7G371dz/sTRFKFVLWXwVmUalRKb+MZoWrEzfUvKMIf4GLKe7yxhT5rWYXCr6AN/1ko80vinpfK4hhepTojKx+jPa9ahDDfMiXo8bfdnu3M74r27/Kd19Cztr8o+yiimagsda/AYEjgMZiwdM5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g8y8Ihdr; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733882363; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uNKa5z04ZraNM6iZozg2spe37vtJmJIyeDj6cALGgG4=;
	b=g8y8IhdrLh+gwvg4pK6XWD44JU4ECtCOh9e8/Z17HLsqSUty/5Y8vfOI2UYRKKrKzknTQ99QqW2kNglElRJfB2b4R9rAKI2fF+ifegySmg2iXVtDSZKRbamwv0sY6V/KzEeMKG3+QLs/k8o9GSXiGKx943QK8kt5yjHLzMXJO/s=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WLGQprG_1733882315 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 09:59:23 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: kherbst@redhat.com
Cc: lyude@redhat.com,
	dakr@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/nouveau/gsp/r535: Modify mismatched function name
Date: Wed, 11 Dec 2024 09:58:34 +0800
Message-Id: <20241211015834.47562-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:2174: warning: expecting prototype for create_debufgs(). Prototype was for create_debugfs() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=12292
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index 58502102926b..93a7528a1193 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -2162,7 +2162,7 @@ r535_gsp_msg_libos_print(void *priv, u32 fn, void *repv, u32 repc)
 }
 
 /**
- * create_debufgs - create a blob debugfs entry
+ * create_debugfs - create a blob debugfs entry
  * @gsp: gsp pointer
  * @name: name of this dentry
  * @blob: blob wrapper
-- 
2.32.0.3.g01195cf9f


