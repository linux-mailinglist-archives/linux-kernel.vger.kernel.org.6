Return-Path: <linux-kernel+bounces-335230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC697E2DE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B4C28121D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5252B9C6;
	Sun, 22 Sep 2024 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="Tb/pRIl4"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C57E1
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727028080; cv=none; b=dkBAj3snJ8dh7IBq84YD6fH4+NBi4aKQqdx1vGi4aoIhYN1oYC/fWUN9mznexYdPBrTWaV+ms2OeqBypDpGwRSWdfLb3Z6ZP8EIutdk3HSCrjlzmEZxvJ6NWKFtNQAAa/JThvLErtjdGuGnqbOfVLyu0TJt0wpXjBmyrtT5T6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727028080; c=relaxed/simple;
	bh=pobvNIkZbinovFfRdYlFAtZnq2HS/QDmmUxoi6pc/Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uet1Nt4Q6MCCfqyGMl0MKyLx7iEJbnMSE21zqKysxoNUFG6eDTXkBjwSSFIjepWJQM0mH+kYxR5/+drEMXaXtN8K0ynevFFN74mDBmGD1anPHD6Pj7s1wnY4sjs0kYJ4kLrTMeozy1IkocxikA/5meXhhXpu7Vfpd1mvmhMJNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=Tb/pRIl4; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1727028063; bh=b8X6oPZ7f9mqNV+UOmLjTpR7eDHxHaxiCPOgh+NHx9s=;
	h=From:To:Cc:Subject:Date;
	b=Tb/pRIl4SstJb/effMp6XJKLXCUPZPhvSpcPxv+N9O1gGVG6nmouIFTbIUcA5iuVL
	 4x0AlfJ2dz+sZh+28SwLpDRA0JNefIWGLN8qRoXlUszkzHSzDl0yOzEho803ZZZFyO
	 p84ChXrIejWlpTqyUjY+r/xwac/Xzze/5qh6emp4=
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fiona Behrens <me@kloenk.dev>
Subject: [PATCH] mailmap: update mail for Fiona Behrens
Date: Sun, 22 Sep 2024 19:57:29 +0200
Message-ID: <20240922175729.233070-1-me@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove old mails of Fiona Behrens

Signed-off-by: Fiona Behrens <me@kloenk.dev>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 7c7f171d0e55..0c798d53e784 100644
--- a/.mailmap
+++ b/.mailmap
@@ -206,6 +206,9 @@ Felix Moeller <felix@derklecks.de>
 Fenglin Wu <quic_fenglinw@quicinc.com> <fenglinw@codeaurora.org>
 Filipe Lautert <filipe@icewall.org>
 Finn Thain <fthain@linux-m68k.org> <fthain@telegraphics.com.au>
+Fiona Behrens <me@kloenk.dev>
+Fiona Behrens <me@kloenk.dev> <me@kloenk.de>
+Fiona Behrens <me@kloenk.dev> <fin@nyantec.com>
 Franck Bui-Huu <vagabon.xyz@gmail.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@am.sony.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@sony.com>
-- 
2.39.3 (Apple Git-146)


