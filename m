Return-Path: <linux-kernel+bounces-397670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCCE9BDED9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CC228234E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94D4192B8F;
	Wed,  6 Nov 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="XBD907jq"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908C192581;
	Wed,  6 Nov 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874549; cv=none; b=KpYVoCzSUurIj9tAfjOrbH6aizp0gg6DRUCWwV0Eyf7UniR5oN7y4c83Bnf4Ge3XKkjEextiBnXivqPUSosUT9r/1kwkXZXV+0E09aZqVSKgziGv+k5REYKXSBrys3b1f/9Ol59PadwLvfQ/qYzUIHrQFWUQnPATqt63i4h7Tt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874549; c=relaxed/simple;
	bh=v4yDzdwdmKCTNq2JJwFmsmUgEFGcIFhHRpm2flf6WWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HyHVbIqNQW4NxPzZFpY8F5ypfaRc3OeEnFeh5LpM667Zg4usRbwBumBi7tBqWG0mwsFrGCOHcF+lgPyoDOW1pD+TgL+7xGhi/oceG2YtI7Z389cQ0EgchsKkxFtfNRiqpphGhcv4pIo3DRTuXWaWjgpsd0c4Kia2qw6gdWtHJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=XBD907jq; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730874540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9chjI8yf8DsjPo9gl1sBbaHEUuI28DbskiyOJJFDi0g=;
	b=XBD907jqcnt8ltatvFLetAF1CiDS6rnujO9pVVxcjqeVkedto4e5C4DRq9e/wghTsf+Hgi
	HsslplxPTc3V7ukYCXtwewL+m1j+rP/t+MkMxWLgTqxVMq5Cc2/qQbZ/VeouyK/3/yi4F9
	a662LKMOyZnkC6gFc0gkwYtbETv5rJ9wp7715h9DSpAMPHAaBr5v3QGKFzpAG+mUX5/zrT
	XqKgvuYDUd0HgBpGvda0vT5EKmSDl8FogDl1L2aKQM/GRZhdlxsRRcYSUjNZZouLn5Hj6r
	5QfjX1AaDRNblcxLNg5BAsqxlEyQw3u5n/5SGgZlZOm8FBMG5ei2v0+Q1pDUHg==
To: apw@canonical.com,
	joe@perches.com,
	corbet@lwn.net
Cc: dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	workflows@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	wens@csie.org,
	dsimic@manjaro.org
Subject: [PATCH v2 2/3] docs: submitting-patches: Reflow one short paragraph
Date: Wed,  6 Nov 2024 07:28:41 +0100
Message-Id: <69b22028203da533392c60debbeabe6932422e98.1730874296.git.dsimic@manjaro.org>
In-Reply-To: <cover.1730874296.git.dsimic@manjaro.org>
References: <cover.1730874296.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Reflow one spotted short paragraph, to make it more consistent with the rest
of the file.  No functional changes are introduced.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/process/submitting-patches.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 1518bd57adab..382c49659cb9 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -202,9 +202,8 @@ Style-check your changes
 ------------------------
 
 Check your patch for basic style violations, details of which can be
-found in Documentation/process/coding-style.rst.
-Failure to do so simply wastes
-the reviewers time and will get your patch rejected, probably
+found in Documentation/process/coding-style.rst.  Failure to do so simply
+wastes the reviewers time and will get your patch rejected, probably
 without even being read.
 
 One significant exception is when moving code from one file to

