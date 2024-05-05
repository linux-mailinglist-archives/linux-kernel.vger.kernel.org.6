Return-Path: <linux-kernel+bounces-169135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F08C8BC3A4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C460282597
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD1A71B30;
	Sun,  5 May 2024 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="NTy2C9bi"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC0D8C04
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714940404; cv=none; b=pjhcwjdRnK7Lz85OwThnEHEvE8Pg3relOb7DWGzj//ibk2ppWw41Hrq7YiCboFbCzSiQSfzAMDdrvU6cud6pM/QueBAkUUiuaMdCchjBbvyPRxNLmWnjSbG2rZHbBARDBzOdRwoTWhJnDZLFXPnGG1OAzukjf/BOdmj2VE2hSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714940404; c=relaxed/simple;
	bh=qVs35hEwWtbavB4gLhsEY875kDmX1lKGP1TOBWI+DK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUn+7a4OmO8SxwKzMAp/A1oF9VGiJaKXLKtUXGKP8L/F7IjNMt+Sg++gffZVd1WhecVdCLbBjtqHZLpHI0diYSzEI1cdKpgiBzf71YHo2z+FK23AS7yg3p9A+UcwogiZhsgikiZgVT8xxZjrKe0sK0pwWu1RCdypV0BZXgJNOZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=NTy2C9bi; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kC9z+BtIuwFPzCvxhtTRwUZVhh0RYTN2gDCiuvp4XGY=; b=NTy2C9biC9GYVcWV
	rRJPQn6ywmXrIvHsk+3d5DRrwR3vnKnDrSSnrP+wrGE9qb2OhLltOtfOQFVePgIw2IiJFGsXycGo3
	LGhR0QHLKPKfVGcUI1A6X8+CpBGzBEVa2GvZ3wzi3YKal80FuvcnNOgwDkWz5Zu+swNv52zc5HlJa
	X2tPEHJxkoFS5el+1XVpL/1Uu/GHSrg/ZxwrGubnXvvYVOyWvzxHpEC40kwVe+WY2LiPeJfe/H25Y
	N4iEBlnoUroknx0ICmg/Vuru0/LnFn4e5luPgzPv5iWltpi8OuM/Vl0cLfxf5CAOCHAHy8RqUNl2w
	jfkX6Bm2X4fpIUkNWg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3iKx-004oNu-2X;
	Sun, 05 May 2024 20:19:55 +0000
From: linux@treblig.org
To: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] arm: Remove unused struct 'mod_unwind_map'
Date: Sun,  5 May 2024 21:19:51 +0100
Message-ID: <20240505201951.623360-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

I think this has been unused since
Commit b6f21d14f1ac ("ARM: 9204/2: module: Add all unwind tables when
load module")

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/arm/kernel/module.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index e74d84f58b77c..5aa7f2c6a5378 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -429,11 +429,6 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 	return 0;
 }
 
-struct mod_unwind_map {
-	const Elf_Shdr *unw_sec;
-	const Elf_Shdr *txt_sec;
-};
-
 static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
 	const Elf_Shdr *sechdrs, const char *name)
 {
-- 
2.45.0


