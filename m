Return-Path: <linux-kernel+bounces-235120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1ED91D066
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D675AB214F4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187D4084C;
	Sun, 30 Jun 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=each.do header.i=@each.do header.b="fkBbQSVI"
Received: from mailserver.each.do (mailserver.each.do [208.85.243.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3F3A1DB;
	Sun, 30 Jun 2024 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.85.243.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719733471; cv=none; b=CnD6dtCX/TDdNQdc8pu37HvLBIXSmkyk1EopACBjxDYLCbl/x3NNh3FqgW4xRsyEODk5r+dkTk1DbNAU9IArz6T2JgGYnWWFsgp9KcOlNmVtqHpqMSa7myoAjJ4IZdmFIG4SHw8HOlWbh/yYkrMwjWR18nlcImo1j96pn+gb/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719733471; c=relaxed/simple;
	bh=WmKzGyTxOKjHDeNNXLsi9WwddmBRFjCsDB/9Q/LN+Vk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d6lfVYp6bEXu2d7mEaMu75VSxpy13cNZTjGP3uWqY7NG7wx4OE/THN+wuoci8XBPVpvguuqFfxaqjUCUQnbEos+85dzRx60x7OTAM4v9SbXezWLMaVwbtXfJdUqF5Bg0ZaAhp0IoVdzthOFT8QRQw/HW/EUi1sYcLoBPCqNz+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=each.do; spf=pass smtp.mailfrom=each.do; dkim=pass (2048-bit key) header.d=each.do header.i=@each.do header.b=fkBbQSVI; arc=none smtp.client-ip=208.85.243.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=each.do
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=each.do
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=each.do;
	s=mail; h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Cc:From;
	bh=BE4wXFOMOQSEPQ8BKbsxWwJ0Lw65dprzqQcl/RMuclc=; b=fkBbQSVI5uanEXdCmOPRjbnbML
	P/LQza3IngnTwtiSMJZ+UBRV842aoxGbIUI7bLXr34ttyke1DbFS4L7glw15x0pBga3XDEqoy8Aat
	ex4P8AkBhqfUPxAQ1gYE2G0ikhdpmUdGMEjH0DGRiG0zJ+yUtCXZeR8LksQz4int1KgjV1u/zvhly
	1iIl2UYTutl/ywggxQ0CYAV4wxrQNOTVx7+vJAMxBFrv8IItqvW2Oyus+syMx2B4KbsPU2ys7/pwb
	dv0hO5SC7dpU8EYz1hfj3A4azbhRFsSyf6ta+wPmjPW/ASaC2fnqH9rSn4yHiFivE5sr2fwzyY7sf
	R4sA45OQ==;
Received: from [2601:646:a100:237f:4d7b:976c:82bc:9550] (helo=trent-reznor)
	by mailserver.each.do with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ozzloy@each.do>)
	id 1sNoer-00AsGu-IJ; Sun, 30 Jun 2024 00:07:33 -0700
User-agent: mu4e 1.10.8; emacs 29.3
From: Daniel Watson <ozzloy@each.do>
To: Jonathan Corbet
 <corbet@lwn.net>,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org
Subject: [PATCH] docs/admin-guide/mm: correct typo 'quired' to 'queried'
Date: Sat, 29 Jun 2024 23:59:12 -0700
Message-ID: <878qymrjrg.fsf@trent-reznor>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Convert the word "quired" to the word "queried" which makes more
sense in this context.

Signed-off-by: Daniel Watson <ozzloy@each.do>
---
 Documentation/admin-guide/mm/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 1f883abf3f00f..8b35795b664be 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -10,7 +10,7 @@ processes address space and many other cool things.
 
 Linux memory management is a complex system with many configurable
 settings. Most of these settings are available via ``/proc``
-filesystem and can be quired and adjusted using ``sysctl``. These APIs
+filesystem and can be queried and adjusted using ``sysctl``. These APIs
 are described in Documentation/admin-guide/sysctl/vm.rst and in `man 5 proc`_.
 
 .. _man 5 proc: http://man7.org/linux/man-pages/man5/proc.5.html
-- 
2.43.0

