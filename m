Return-Path: <linux-kernel+bounces-246644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9132F92C4A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B025282A21
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953CB13F43B;
	Tue,  9 Jul 2024 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MjQhK/BS"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA113C8EA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557481; cv=none; b=f44l432cxcpGxpbPpN07BL16KE6IV+Wcr83lHKJOjNJmauE4Oj/Gqpn44AuDLoBj0HDmAMrT4cBy056n2ZM7rsenTBwXFqBbb72zBNZpywFF9EBLIU3hlnllOxtO1hAyjr1lMBCqmr7YYB6Q5wOOrJGPrJokEwkhFKKFYA2UC2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557481; c=relaxed/simple;
	bh=ZVITLZw3RZWYg9D/gUYsaAPt39mhDi81cXcYf0kiYo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBU+qlGUsLxx+qR8Uuef9qmPfc40sWp8lv8d1ILHKmkkP9olEyqnpE92EVoqhY4IOhDvwdyYd9CZAL6jqO6n2j5ARXCktxP33+8v03aKKCRmT7pPhql+Sg9pnq2+fKwoshErsVxEG7dJlIx3r+jt2JyPts3BN+PsRj81qJ5ql2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MjQhK/BS; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.. ([77.130.249.53])
	by smtp.orange.fr with ESMTPA
	id RHavsh9C6phyvRHavsZbUA; Tue, 09 Jul 2024 22:37:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720557471;
	bh=Pf/cwNIvre1Xs+7SJVXgRoolLcWJeJYfmUMXMPn3ODo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MjQhK/BSIx30xmH7mN5f+J/v7FA+3Dx9jApKTwGVicxPrsrXS3NthcOcSEw/Q7e34
	 UhBeZtkGxt1lx+17JV17sGoWpFV04V7G3f1YaIYuYlzbzX6fsA6GqWJ6vp2kPusDD9
	 M6RHtkjKyjxxlu+UGIv+zYXJEJcbcGFfJonKdX+3QKgh6MH5Mta83sHtc5SeNx07EV
	 h7/BXjL/PaMMeMlhNj5jJpfQPf2mlc/Ix8UjY331Q4JclOtp9XucOnp0Yh/eSCFBOF
	 gUUY5vg0hRfvY9dmLx6VWStNeiDWFUaScgHon5jG4ElIPz/xOmX0ppe33XEMClIFZH
	 Bfb5AUaV9LzUA==
X-ME-Helo: fedora..
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 09 Jul 2024 22:37:51 +0200
X-ME-IP: 77.130.249.53
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: linus.walleij@linaro.org,
	lokeshvutla@ti.com,
	nm@ti.com,
	robh@kernel.org,
	tony@atomide.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] pinctrl: ti: ti-iodelay: Fix some error handling paths + 2 unrelated clean-ups
Date: Tue,  9 Jul 2024 22:37:42 +0200
Message-ID: <cover.1720556038.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is completly speculative. It is based on static analysis
when a function is called in the remove() function, but not in the
error handling path of the probe.
When looking deeper at it, it seems that part of
ti_iodelay_pinconf_init_dev() also needed to be fixed.

/!\ This is completly speculative. So review with care /!\


Patch 2 and 3 are just constification patches spoted while looking at
the code.

Christophe JAILLET (3):
  pinctrl: ti: ti-iodelay: Fix some error handling paths
  pinctrl: ti: ti-iodelay: Constify struct ti_iodelay_reg_data
  pinctrl: ti: ti-iodelay: Constify struct regmap_config

 drivers/pinctrl/ti/pinctrl-ti-iodelay.c | 58 ++++++++++---------------
 1 file changed, 24 insertions(+), 34 deletions(-)

-- 
2.45.2


