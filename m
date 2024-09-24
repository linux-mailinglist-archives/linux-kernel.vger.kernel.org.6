Return-Path: <linux-kernel+bounces-337291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740FD984840
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CEE283173
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9F71AB6E1;
	Tue, 24 Sep 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SIwsw7G4"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB683155757
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190498; cv=none; b=bOp6Sz9+svKugHmcPUwAfgOYAfUiEoDSn5iUEZYsHvOK03mAxKcmXVHfNDpRsBmVmea991lzokCWk3yILo4xea8cWzctFAwlJBupdwwxqxr1S4pVuBbhEIWrEid+nhc8Uz3LtTzPbPVERgbZj04IM64hfLVR34aeOzIiUSoiWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190498; c=relaxed/simple;
	bh=ULMko6igJvaoBCPFqT+liu0gp1Fyz0QFilrMWEkY+mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGDZbFLD408ICEyVG6WGwa/geiw4Fi5MMhuvRE/onIyBCCq38/CVRwlNdlrwlzaYurjuS6lEmnPl5SnwNuz0bEDNTrqEkcEbikvl9t3st7Y62Ve7ppTR9cpjGvPZbk3QV8tO4id/stuPKykM7K06lfWlP04yAv7FuYfve+ZbT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SIwsw7G4; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=LwfC9PTnd4pszvKr1e64PP91HM2G1SYCij7IUmOm1mM=;
	b=SIwsw7G4nMUwUwRWxOmqysfssBJou4zdYnrV8qODR3rZiyVLaUagsTSnYWSyzU
	//EOIYBVw/divRMPLHllbZTEbdnB0cKfB+08aJvxUPCLzDrIg3zkvXgs3dg8ogMK
	aff/KRqXp4OmEa/u26OZbIZ5XF9eTBbrvnIVGbCSHlDv0=
Received: from localhost (unknown [60.168.209.67])
	by gzsmtp1 (Coremail) with SMTP id sCgvCgBHqp5A0vJmpZkTAA--.4626S2;
	Tue, 24 Sep 2024 22:52:49 +0800 (CST)
Date: Tue, 24 Sep 2024 22:52:48 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] [fbdev?] BUG: unable to handle kernel NULL
 pointer dereference in fbcon_putcs (3)
Message-ID: <ZvLSQLuLLGIkDthp@thinkpad>
References: <Zud_7s__fu1aVw_u@debian.debian.local>
 <000000000000d9c6880622323052@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d9c6880622323052@google.com>
X-CM-TRANSID:sCgvCgBHqp5A0vJmpZkTAA--.4626S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcsqXUUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwRkambysS70lgABsN

#syz test

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3f7333dca508..fedd796c9a5c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -847,6 +847,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
 			return err;
 
 		fbcon_add_cursor_work(info);
+	} else if (vc) {
+		set_blitting_type(vc, info);
 	}
 
 	con2fb_map[unit] = newidx;
-- 
2.34.1


