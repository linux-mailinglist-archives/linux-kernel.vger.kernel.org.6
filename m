Return-Path: <linux-kernel+bounces-298492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515EE95C80D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1421281FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAC146A67;
	Fri, 23 Aug 2024 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JepBKPNg"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A866140397
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401682; cv=none; b=f+JmnXqu9O4jAqx6HzxB+M9H9Z3TSd2OdIqoNu3ZfKE1eRCJ/GTs10PiqTneoPwGEmrN/NclTOS3nQ2iMCzYwOCHUZU6CTxMf/9iO8J+zphMu9FtsYS1McJ7u9pk1ifALfaSt9q3VYKpFQD6qwrY64wCN/F/0Jc+GsUc0fbcJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401682; c=relaxed/simple;
	bh=WWkRZNcU1ZOfKgeuPdomK3ItRurd92AN6Edqxlu76Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=AWbdaPcQPBUU8VR2ajjx0Cp/UFV3NKeCREkSCBBl3FVZVxp1wxOx69H9ouuUprrMx1NRVS8WfNypNQ3lNZoUNyWOQoDXU0gDgB5+PqbvE8BHeUZdLE6+zQMvaYzLPs8W9fepX6PNkhc0WvJwaW/1cdbqUkXE+UK+CW6GISYZk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JepBKPNg; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A87AF60004;
	Fri, 23 Aug 2024 08:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724401679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnhTHq3+chm+k9TwdAZbwwShRi/4O5m2qm/IN/fZxRo=;
	b=JepBKPNgfIGjCRu8n1FAqc703zIKml9VqQO3rFQ6cTKWQQZzVik8GdiUFAv4cW7fswOa4P
	kTVR70P6OBq1YWXZMq0OSObTdgUd6gsKEbbDY7zHiym8G0QYwfStsiKuz8iW0ngKUWncF5
	Qs1xgEK3lgmVLmpeq887QLU8suo10O5lANgnPnc3/BTreQrvVUsOtb1fQrTmkMniswwESL
	nZ0WmZAMj3Gh5cMfdRJocRFO6kx434M01cLzG4Tx9cU1pc1XZfxaCr1uE6cYy7ZFT8mkkM
	rL0hlmUANxsw6xD8V0SdPUdf7Fmdc3r0R10YH9xZmbuEBgP/2DHYftkKf9+Vvw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 23 Aug 2024 10:27:43 +0200
Subject: [PATCH RESEND v2 2/3] scripts/decode_stacktrace.sh: clarify
 command line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-decode_stacktrace-find_module-improvements-v2-2-d7a57d35558b@bootlin.com>
References: <20240823-decode_stacktrace-find_module-improvements-v2-0-d7a57d35558b@bootlin.com>
In-Reply-To: <20240823-decode_stacktrace-find_module-improvements-v2-0-d7a57d35558b@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.14.1
X-GND-Sasl: luca.ceresoli@bootlin.com

The syntax as expressed by usage() is not entirely correct: "<modules
path>" cannot be passed without "<base path>|auto". Additionally human
reading of this syntax can be subject to misunderstanding due the mixture
of '|' and '[]'.

Improve readability in various ways:
 * rewrite using two lines for the two allowed usages
 * add square brackets around "<vmlinux>" as it is optional when using
   debuginfod-find
 * move "<modules path>" to inside the square brackets of the 2nd
   positional parameter
 * use underscores instead of spaces in <...> strings

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 scripts/decode_stacktrace.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 7f3fb5e82707..b56e79060e9f 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -5,7 +5,8 @@
 
 usage() {
 	echo "Usage:"
-	echo "	$0 -r <release> | <vmlinux> [<base path>|auto] [<modules path>]"
+	echo "	$0 -r <release>"
+	echo "	$0 [<vmlinux> [<base_path>|auto [<modules_path>]]]"
 }
 
 # Try to find a Rust demangler

-- 
2.34.1


