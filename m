Return-Path: <linux-kernel+bounces-549249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2129A54F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7D4169F98
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3C31FDE37;
	Thu,  6 Mar 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Rbk7UeWE"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9551624C8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276325; cv=none; b=ez5sjLyfSIAY4rvI781iJ6K186dPG+e63BZgdsP2sxaaOi4eTDIEDpg+gpZbN20DgwkIpwb1r8vaIpt1eZo3+5Gl18+ml+Qrwx5TE+D9cP5NzFYBDPOVlVEwiNGNcIkblXlWZ2kDD/dQguDg7GaI914cYRPBrKAsZuPN51D5jtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276325; c=relaxed/simple;
	bh=kSEQScJyxlTn8UwpglyaqYuZ/5dPIwFF7vS1AAoDEy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hukT7z/ky5ElHvbjLmFy+DEjvqZqtsg5ZkIPnVvb2JJw2zVP1SR2EPnm7+Wf4BB+du0Jy90BJEP5yvGZjrneL0he9VqGFRJDkHBbt9/qL5CkIIxRm+z3sQt/mvm/NO+HOGierdhWqR9xXigTGbs2fcuCPGh6BeywT/43WiNn83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Rbk7UeWE; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9deaax2qNgBgrAndbg2toLKuqQ/n/z1VciNkUn5kl7A=; b=Rbk7UeWELJPa/pXj
	lzliUr7RGi4pWDjSFVcdxjeCrzILf+KGlzAXIBcEUreVpe42/ajBlYQqhnq7UB2JnV0D7KD3fbK26
	E0Rd4feJAbSld9Ayj98xZ0qqDYF5afGXeFlWsFtyKD/cZrEvl115jElJsOTa4qAxrWFcoHr41eifP
	gL9+MTKn2bTmCw414BWMuZcV9KfYzWRmGs7Xqt3gAjIuc9/m/azA2rA2WaheC9dbs9YjOtYB9n20H
	q5bH1lF8fMtkkz0mofomwSS6tsrXBQQ6Dz/NNyRKe85meFI/YPYLcUkMJynnzSkjzFUpo67rxPu27
	2HtzUOlKcZgffh+i0Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tqDVs-0039Ld-1V;
	Thu, 06 Mar 2025 15:51:56 +0000
From: linux@treblig.org
To: patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] drm/gma500: Remove unused mrst_clock_funcs
Date: Thu,  6 Mar 2025 15:51:55 +0000
Message-ID: <20250306155155.212599-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The mrst_clock_funcs const was added in 2013 by
commit ac6113ebb70d ("drm/gma500/mrst: Add SDVO clock calculation")
and commented as 'Not used yet'.

It's not been used since, so remove it.
The helper functions it points to are still used elsewhere.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
v2
  commit message fixed to use correct struct name, and add
  note about the functions used still being used.

 drivers/gpu/drm/gma500/oaktrail_crtc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index de8ccfe9890f..ea9b41af0867 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -658,10 +658,3 @@ const struct drm_crtc_helper_funcs oaktrail_helper_funcs = {
 	.prepare = gma_crtc_prepare,
 	.commit = gma_crtc_commit,
 };
-
-/* Not used yet */
-const struct gma_clock_funcs mrst_clock_funcs = {
-	.clock = mrst_lvds_clock,
-	.limit = mrst_limit,
-	.pll_is_valid = gma_pll_is_valid,
-};
-- 
2.48.1


