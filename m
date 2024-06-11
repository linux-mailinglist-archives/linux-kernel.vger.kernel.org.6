Return-Path: <linux-kernel+bounces-209341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E1903300
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584481F22590
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B506171E4C;
	Tue, 11 Jun 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UyR1qZfx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897BA171E43;
	Tue, 11 Jun 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088559; cv=none; b=Lc0atIvva4U4vrUlladamy+zTNnvbvC2LOWsuNNeAVe6LnUKZP2F04OQoZEtyYQWhtk2B5QDIrMt/sqWU0KRsUs1sTDpTaydA2csN6AcILlw2TfWtRE0ucxN91swkYLHru9zQS9Z+N08W7tyEOvUXx25mxLTEzl1Ul9/Q4gT2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088559; c=relaxed/simple;
	bh=Oo9VKE6v5A+22PRpPP/3nDTU91SX8xn3rk0fzBYXti4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eLi1AcNmpey7iI57yRTKLer53TAjQ8X0gnbtYYthyW7ki2utSm5gD2z5KRPqVXlJmfsoQ/K8hj9iTcxIhSyT1GhIwDLvLy0ff8QDY5YuraAbI9inYLwLeqDkmGrDLKOJsVZeelMz5u/EnwyqLObUaMzdhu9QK5+MO/b4w1UZ8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UyR1qZfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7777AC2BD10;
	Tue, 11 Jun 2024 06:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718088559;
	bh=Oo9VKE6v5A+22PRpPP/3nDTU91SX8xn3rk0fzBYXti4=;
	h=From:To:Cc:Subject:Date:From;
	b=UyR1qZfx0zeP3q/o5r7vOs6rKdHpQX0ggw2JWdLfuiFALrdd+ZNzWvve1MjmAXdGW
	 PEK5b0+AByNnrW/hyq8A7VBBtB1u2TapmJB0AjI/b9QMNCbrgiT9umpfAUoMON3MBn
	 q/Cjy/V7XvDyMmxVazAr6n6hbCyHB+VHRvP6A+/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danny Lin <danny@kdrag0n.dev>,
	=?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] .editorconfig: move to Documentation/ directory
Date: Tue, 11 Jun 2024 08:49:13 +0200
Message-ID: <2024061112-kilogram-poker-bacf@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Lines: 27
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Oo9VKE6v5A+22PRpPP/3nDTU91SX8xn3rk0fzBYXti4=; b=owGbwMvMwCRo6H6F97bub03G02pJDGnpnzN6b3E3lGSu9U99/nVp6cSnTBnzNHmdVuy9NEnke mLjJIW2jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIFWeG+VV/Yt8/+no4lNO5 fYpe91W5v+zZDQwL5nHUFrvvbGMoWPfksfCMvWfffhG5AQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Some editors (like the vim variants), when seeing "trim_whitespace"
decide to do just that for all of the whitespace in the file you are
saving, even if it is not on a line that you have modified.  This plays
havoc with diffs and is NOT something that should be intended.

As the "only trim whitespace on modified files" is not part of the
editorconfig standard, just move the whole thing off to the
Documentation/ directory so that those that wish to use such a thing can
pick it up from there.

Cc: Danny Lin <danny@kdrag0n.dev>
Cc: Íñigo Huguet <ihuguet@redhat.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .editorconfig => Documentation/.editorconfig | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename .editorconfig => Documentation/.editorconfig (100%)

diff --git a/.editorconfig b/Documentation/.editorconfig
similarity index 100%
rename from .editorconfig
rename to Documentation/.editorconfig
-- 
2.45.2


