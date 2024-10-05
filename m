Return-Path: <linux-kernel+bounces-351977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FBB99188E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B444B215BE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0A156880;
	Sat,  5 Oct 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="adLcWByV"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C828158524
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147432; cv=none; b=kD1O5Bmww6W9oXt0SZZV1KwQAVzaUvk7BzZWtY0lLc4sbN5SFIFFME3tNZ3YkUgsrEVkOvuFIJvEqU68l9plHPil7B2nSImg8e5OF+3M0nqw4bARtc8mBiCCtFPuSxhASkZcwV86VjnbZGMzndFBOTse7atUK0hFpV/VAcEIijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147432; c=relaxed/simple;
	bh=k5Rv1fYI/WzHQ64tkh4taN5k8BYoku63bu4tyz7AKoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=In56wojzeGyNdUcQYiA3YXy0Gq2Wq8r/Dc7gaO8RbEdB+SckOh7yfkf15uOf+NY1LHh9hw3hYuslTDL0YouKtO8olR0Ay7nyC1gjkR9RMNXpSYWUCqfR73br3HfS+C4rnCAzKpPHImSadMlKwDCoc4HaxDnzpxY3ZUYYhTnkSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=adLcWByV; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C03C623F1B;
	Sat,  5 Oct 2024 18:57:07 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D9D0kyBFcMpP; Sat,  5 Oct 2024 18:57:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1728147427; bh=k5Rv1fYI/WzHQ64tkh4taN5k8BYoku63bu4tyz7AKoY=;
	h=From:To:Cc:Subject:Date;
	b=adLcWByVPOB28f02XvQvvnl1xiyzH6gpaxsEQ6wLuJgVgJc5h1cRSiYEfSKcaDqDi
	 08XPzqiht8sUnNvpOZnQ8DJk7VSYuJ8LNYNmvVthqH6NumoMhIKM1dAWTu9MXpLMN5
	 YdxvdI5ILciURgTA7PKbJU3a7mWMNRxeB116f0lenBAxM7CTL3xb55RsEC+wtC5Hxn
	 JA4xEo21EnfMuRnHfOk0NtFODXmo4llLndMInKvQrkC5iDldgnyzwAwZUoBVvNgW1n
	 pp7GpZZmSnfCTrWOkHqw7lT+NAlUoRzZ0Nu0nkRRT6c2UdclRn8hcEgB3w3Zgr7wse
	 PBezHX5Vv4/tA==
From: Daniel Hejduk <danielhejduk@disroot.org>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	danielhejduk@disroot.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: eeprom_93xx46: Changing 'unsigned' to 'unsigned int'
Date: Sat,  5 Oct 2024 18:56:53 +0200
Message-ID: <20241005165653.26160-1-danielhejduk@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes checkpatch warning: Prefer 'unsigned int' to bare use of 'unsigned'.

Signed-off-by: Daniel Hejduk <danielhejduk@disroot.org>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index e2221be88445..9cae6f530679 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -229,7 +229,7 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 
 static ssize_t
 eeprom_93xx46_write_word(struct eeprom_93xx46_dev *edev,
-			 const char *buf, unsigned off)
+			 const char *buf, unsigned int off)
 {
 	struct spi_message m;
 	struct spi_transfer t[2] = {};
-- 
2.43.0


