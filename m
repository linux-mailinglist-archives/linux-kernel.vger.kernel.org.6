Return-Path: <linux-kernel+bounces-528497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F806A4186E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565EB1897BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCF32528FC;
	Mon, 24 Feb 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSshbgZs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83071245038;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=ZPTARBsYEhhaoBZ/vqnFngUeDZ1tKASBQq9CeajOD5YzDvxLvIxAU/rbmNVKsOIF7S8+ShqNrS4DQXoVOgpNFsc4mM8zToJ/7onpEbbNeV6S7ATYZfw0z8EQ76ioROW4jpL3+eDUZB3rQPwfvBvnSWOZsAQd/sHqToulpM48sBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=ojXYm2ybn18UU1+Rz9pniQpO3g763W9s/DzLh/PxuxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2aYmhSD4/KZ/JLq/a3G7V5sdiIMKNXTUFQe1WBdatmpSQQ8+EN2dQjDGixhv5kZlVGOU4wcV2CEEUglUrv/WALUBIWspL26hEFSkXnWDiAj3yTIOI5nxg9k1/O7su0xMP0OjCZcBGHRnoszWN0xTlbQXbHpK90YdcbQBYpeTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSshbgZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EB2C4CEF1;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=ojXYm2ybn18UU1+Rz9pniQpO3g763W9s/DzLh/PxuxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sSshbgZsMeokStFUJi1eBlmUK7wr57fVcHoaVLXSipJPDsre+Cd9hkhQ6JolQU/Or
	 1h87qo8nvw17NEUh5ougQ7HxWdS1Jv5MuGO/1ZewoSb7B8gD7rDGFZJ5SubomQ7AaK
	 xLWiCCGu8LiEus5gh2kydHoahF2sfmfAnNC/Mtj5AlY6A9WQNWnboYOzpBNRAhQBAy
	 6GOFFK/MGHzzeRs3wcfF7DoLMNRr0+xcGjBRpykyj2sYPtSiKEwfA43MGtmTUg3ehj
	 RqPwI1TsNFAYS9VfjKKtmp2b0a/2tiZZY60mjVgNYemQ38rdwW3Rx2QfTFhtVE8a5F
	 CF2ivkb+iN3bA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p3w-01Dp;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/39] scripts/kernel-doc: add a symlink to the Perl version of kernel-doc
Date: Mon, 24 Feb 2025 10:08:14 +0100
Message-ID: <1471724418841cf10ad61d2e502e3302417b7f77.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Preserve kernel-doc name, associating with the curent version
in Perl.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 scripts/kernel-doc

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
new file mode 120000
index 000000000000..f175155c1e66
--- /dev/null
+++ b/scripts/kernel-doc
@@ -0,0 +1 @@
+kernel-doc.pl
\ No newline at end of file
-- 
2.48.1


