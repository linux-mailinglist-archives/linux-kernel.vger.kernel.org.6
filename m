Return-Path: <linux-kernel+bounces-185497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CDC8CB5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AF82819F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF4149C6A;
	Tue, 21 May 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b="cwBJ8UrY"
Received: from resqmta-a2p-658918.sys.comcast.net (resqmta-a2p-658918.sys.comcast.net [96.103.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567435894
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.103.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716329316; cv=none; b=IW9PxO29GVd/94phPp/qFo4N/bIIxQQ31ddm38TKB4L6o7vdfUOaX2MO7hbYslgrCUimsGvD//b8+bIRvT4jpjdYIjq0cEMZK/ruJLdPgR8ruv7omWjhspVSNQ2Q5zH1UcZtDF1roeytYihsr5NPSPyr7zz4t6zcJBHc+XX+K1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716329316; c=relaxed/simple;
	bh=VvcnJsNeVzvtHlrMnLECzZgGmPqh/9VpROwzGtVOijU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WlNicOLd6c49OaXEBSnGghHfUlVstzTmAlzmjcsrLnNlXGPuFAQtODWqV2fqU4FWxRLse/SFFRfqae21RM56WVrhlBbw6Q5C+OAD9jjZe+OpvjeQlzzGloGQROjvesH7WES7aMAIesBQqm9r62RwhUGRJE2irL2tZztDv1ki6Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=spacefreak18.xyz; spf=fail smtp.mailfrom=spacefreak18.xyz; dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b=cwBJ8UrY; arc=none smtp.client-ip=96.103.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=spacefreak18.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=spacefreak18.xyz
Received: from resomta-a2p-647345.sys.comcast.net ([96.103.145.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resqmta-a2p-658918.sys.comcast.net with ESMTPS
	id 9XW2sWENn9YKR9XcKsWUZc; Tue, 21 May 2024 22:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=comcastmailservice.net; s=20211018a; t=1716329156;
	bh=XMYQs+yiAtAGPujgqUTleiGX5VfEmUwbWPf5HS4uYw0=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type:Xfinity-Spam-Result;
	b=cwBJ8UrY7+HgUX2m7NlRbH+1IuPTV4gIKs7JfCAO+R6W5B3xs8Mn3ZnflT9eSr8t9
	 I9hPwDR0BtO4L5FbYQhoY/WWDL6jXoWVdUgvqPfKiCufExcXxtCWnTgwSfcC7y7dvX
	 qY4EkmfTn9kIE9XEpq14mLS2L2jV0/IyTmMYFrp9J4SP6VspvhvuIoCgUwg3Uog6+U
	 ain+By+Ki7F5/pHpS0WZbgMHye+iFvK8P/BY6HmIJwI7ROXp4GKvURhWg6pQNldjfV
	 tv3i5vTGReGR37TmL3vf9RGWFJ7vRqN2ufIj+vrSDegsOemy1eLLAjbTJP+7QF8tKH
	 24+vEHnXNx+2w==
Received: from Outgoing.brak ([73.233.191.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by resomta-a2p-647345.sys.comcast.net with ESMTPSA
	id 9XbxsUoayb3Kw9XbysnuLq; Tue, 21 May 2024 22:05:35 +0000
Received: from zitz (Linksys01880.brak [172.18.18.227])
	by Outgoing.brak (Postfix) with ESMTPSA id 0B6C48F01;
	Tue, 21 May 2024 22:00:58 +0000 (UTC)
Date: Tue, 21 May 2024 22:07:19 +0000
From: Paul Dino Jones <paul@spacefreak18.xyz>
To: anssi.hannula@gmail.com, jikos@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Interpret 0 length ff effects as infinite (0xffff)
 length effects
Message-ID: <20240521220719.niwhskc473he5r5o@zitz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Envelope: MS4xfJ5ewqc0jhetcKzzM98uQhq6iqmt8EKXe/On9fo4rmrowOOmcRoojZe7cH9+XD1T+De9UPYhoCFil7JVWAm30Y5c7kC8Z8O1NYoE5luz1F3xUHnILw1o
 B2onYtMKTigGtv/sH+j+1Miq00YfU5YzDeUbPAoMzud8GSu0UeUdRw7mrW5sfRCQHJkTdYhF8vBIr7a7uR+N/b56BuTj96uOrRJbbO3PRHTo8C+5ouOk4tRf
 +IZ648VpzAey5L7HSo4lQughNMMUSSDxNt73pQMttU8=

Greetings,

More and more vendors are entering the force feedback wheel space, and
many are supported well by this driver. Unfortunately a lot of new users
are hitting this issue.

It would be nice to have this merged.

I think we all agree a 0 length effect makes no sense, and this change
wouldn't break anything that sends 0xffff.

Signed-off-by: Paul Dino Jones <paul@spacefreak18.xyz>
---
 drivers/hid/usbhid/hid-pidff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 3b4ee21cd811..70653451c860 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -301,7 +301,7 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff->set_effect_type->value[0] =
 		pidff->create_new_effect_type->value[0];
-	pidff->set_effect[PID_DURATION].value[0] = effect->replay.length;
+	pidff->set_effect[PID_DURATION].value[0] = effect->replay.length == 0 ? 0xffff : effect->replay.length;
 	pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = effect->trigger.button;
 	pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] =
 		effect->trigger.interval;
-- 
2.35.1


