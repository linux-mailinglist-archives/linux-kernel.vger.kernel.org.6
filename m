Return-Path: <linux-kernel+bounces-517697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A14A3848F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BEC3A5C7E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09FA21C9F1;
	Mon, 17 Feb 2025 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nrU3+vgA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ojBYFnzM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F332185A3;
	Mon, 17 Feb 2025 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798458; cv=none; b=ntb0nJfuEvR7Rel97WhY36LwbMep1TpY/A35D+gGEbEqFEpH3OLwWXoTCNh6ZhGuz9jdcaAc/l2RGFkVwaxZ8hKMHnamSvdocgFJJ80EkCPtULy92+KpG0PQ1AVczfiILGvl/cTsbRjvLivBvvCMZrCNhb5LkMkbaMMBkDQQfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798458; c=relaxed/simple;
	bh=S6D6f6XcQVacKxAWbsLG8Xh73igMUnfYjfS04GYSDGo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AYBolF/s5/k0vJi8rWOApmjUCdrz/P9UUsPIUvZRRpmw6lPYzL5w67W+RkxpGrAu0fIZYBcNhvnb8fMgWh9NhOYgbBAhWfaNptNjWnpepGn8acvGvxx5f0n6tzqtxXxgDrp2rxlPbpIc/W5awQn9HHyewO0xNDfb5Jb9oPfMRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nrU3+vgA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ojBYFnzM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739798454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OwwKmFkAp2J0qb4yxIUg5I9TkgocSV5eAHa3wY7fqCY=;
	b=nrU3+vgAuO3eYcJhJ/xLeK7GhWTQOhJHC9lXbEUSX7onqiOBfV7nL+a0CBAOKMshioU5IU
	5unxTGhiRxTpuNwEq47+hmJt/clDHAHKo3pWBKO2Gfe4SZay9j7zdaiuO8FzN9tpm9i5Xq
	L7pNld+RbdCMstx/GlVwO5lXU/JJs32BRapLX58quEvuOVBUV7GmaX3vjZtD6Y8gtqkt0q
	KvbMY6Ixs6elHMYNdf4dBBhfw27ACGCHH6Q1OGJ8P76n6SGF6/AIscxTb3VS1e+diZLcVH
	7n7NKVD7Drz7yj6qEEp+/c7Xu2uFBp6RqFdlornt3mrKY7L7xqM2ci3j675SsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739798454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OwwKmFkAp2J0qb4yxIUg5I9TkgocSV5eAHa3wY7fqCY=;
	b=ojBYFnzMHGCI3ljD/hUOKv+fsbupD3JuAZnMzv/FTeInIKOlFOsIiJNfVy90dg3YjG+Pup
	LE5FStmyQeZAkuBw==
Subject: [PATCH 0/2] usb: Don't use %pK through printk
Date: Mon, 17 Feb 2025 14:20:50 +0100
Message-Id: <20250217-restricted-pointers-usb-v1-0-78da55158832@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALI3s2cC/x3MywqDMBBG4VeRWTtgQq2XV5EuYvzbzibKTJSC+
 O4NLr/FOScZVGA0VicpDjFZU4GrK4rfkD5gWYrJN75tvOtYYVklZiy8rZIy1Hi3mfvYOTcHPIf
 hQaXeFG/53efpdV1/Xn99c2kAAAA=
X-Change-ID: 20250217-restricted-pointers-usb-8c711bae6994
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739798454; l=880;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=S6D6f6XcQVacKxAWbsLG8Xh73igMUnfYjfS04GYSDGo=;
 b=wCRSdLbNARTGHY8b//DgQCLemBjgMNKOCCZ5RUk0+cvehKIs7PhfDCYDCHGN3CmzpmEjESL0A
 F5zRUzWoYm6BWq/GnyJjxzF1KECT658QQoHC/j3zaQUgwgKdZaCm4dV
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      usb: core: Don't use %pK through printk
      usb: dwc3: Don't use %pK through printk

 drivers/usb/core/hcd.c     | 4 ++--
 drivers/usb/core/urb.c     | 2 +-
 drivers/usb/dwc3/dwc3-st.c | 2 +-
 drivers/usb/dwc3/gadget.c  | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-restricted-pointers-usb-8c711bae6994

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


