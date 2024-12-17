Return-Path: <linux-kernel+bounces-449021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0847F9F4898
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FBC188E435
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFAE1DFD9C;
	Tue, 17 Dec 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="rXQjLCcN"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0A1DF97E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430213; cv=none; b=dGFqomqPN91Ze2bD2TCeIP1Cb5FW3zHgTYwSTSvDTmlvT67ROgtCMnDlQpvMM8Eq9qFO12Q0tL6rP9+qQkKIzNfJKSanFVJGGALTFypwGPs7E3DDQU1VVTbcInP9VF5jvypBePfS6F4TYOTO1PAlg5TLqmI8EWSWCq4uMGA5/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430213; c=relaxed/simple;
	bh=2OTn+7Wtp1+ju4Om8/5R483LdSHxnVmt9UZu06mmsPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hiwPqR22cvVqUSzQEsuzOLrrkxIlsJz4yA6IEHLB8vZzKXvYICgo06fLuSstCqHEbWQH0FA4fYJHImBcDO8RIJFW0u7AJ3yGM7zMA7l307E2bdae1aqFw4yZUsGt4C5H4mmObfBjCckWCsO6K/Dukum62vALxkQaA87YOKATNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=rXQjLCcN; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1tNUWk-0002bZ-V7; Tue, 17 Dec 2024 05:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=nSo/QZCeasOzIOtIpeJAWWOjM0xxfzS+7FbMLI2RyOQ=; b=rXQjLCcN+JJUCR
	CDxGA+/lqcyMLXbScyEC/r1KxH39vf6lhuAVs0aeqdR6KlQDAzc0yrUGLikHhzZ/17OWXN6+gB0bp
	J6yUz2PrrO0pvcJjRsDncQoimLuthDXASFAKhtII+3H+h32ST3XgogXrVO+/7+MZxtC+YstB0xn8l
	9wOboKled94JuMkmfC0mkUxrHPRlQMNn8Gbhc3V2aDCkYoTnwsoFSrXyKJ/60UnJIphmEQ7XeVUec
	iBS7kCUBvGgzt77zasp+WJ+NcyE/QPvUGFSQxr5T+6B00TLk8Av6MXPEUL6J3ob3XCVkCfV65lOno
	78LceGQaB7AsZqpYx4CA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alex Elder <elder@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Quentin Monnet <qmo@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: modify the entry for Mathieu Othacehe
Date: Tue, 17 Dec 2024 11:09:21 +0100
Message-ID: <20241217100924.7821-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set my gnu address as the main one.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 7efe43237ca8e..f5f97f9470209 100644
--- a/.mailmap
+++ b/.mailmap
@@ -435,7 +435,7 @@ Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
-Mathieu Othacehe <m.othacehe@gmail.com> <othacehe@gnu.org>
+Mathieu Othacehe <othacehe@gnu.org> <m.othacehe@gmail.com>
 Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
 Mat Martineau <martineau@kernel.org> <mathewm@codeaurora.org>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
-- 
2.46.0


