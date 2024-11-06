Return-Path: <linux-kernel+bounces-397669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E269BDED8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0561F22EC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B2192B7A;
	Wed,  6 Nov 2024 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="b6vnULjA"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E8191494;
	Wed,  6 Nov 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874549; cv=none; b=mgP9o4nqHu3FVScdlinGq0cmJf8DYVwto7oSHBlZqmOZM0Yq5orGQ22PB5bkac9RAjXSYQrpxMq7FicFFL+c5LXk6dIsb4cH7AIkw76umZMCJa7096eKLMl5si1snkoK3xd4HA7JynxiTwcJ+V9hNwbGg5jDrxxtsaSl4RUdOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874549; c=relaxed/simple;
	bh=dSpMyCB8tX2y9ay8at+BqhQfkfof+6FK4BjblUvLLTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQtszzN0rQz2VRFssjQbSfxkdzG0Yg4ChjofaPpA5lvp4PIEQsugAxNT9fhMndpDXLUZqawZORjw12d0w6XuSY+QMdeZSORuubInmYcgayp5jIMoA4U4HeNwpWxD6/QBeZXuAI39KhgUZQLRzMqN3gjNH4ArhB8bi3wGtbC7Ptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=b6vnULjA; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730874539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ScSQ5Hi0Ek8gBnhrGKjOX2ZbVjS+5O0kEt8qxKQvIqs=;
	b=b6vnULjAmBmKPhEvjzoYBHlufuYX9HQ2KW43xwJwSsNZLRO67i/2O9kHiOZhFVv+dn1+0v
	Ta0RdY3iYKCiUftuVbmqvC9C5yfmGQnbCd7QvCvZNd+lhP4Ach4Cg/0u8xxogub6NVX7hF
	ctyw3aihoHUoAChocMC7SlMp+jue2I+7d3hOKjO0mYjKdFxLpL5FY2mzm6lNLjGorfMFiP
	5zhk3o+2Yl0hCqCYvHifh38Q7MKyhYRkScE5E1b2epi5jCUSaMSqZLI7sdixv3hA2zbQ4z
	TI2RgQojgbJIp6331UbMRKIUtkXJJRpxpCxCY3sad5XsJGwV4QSzyk8V3m25Lw==
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
Subject: [PATCH v2 0/3] Make Helped-by tag supported
Date: Wed,  6 Nov 2024 07:28:39 +0100
Message-Id: <cover.1730874296.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This is a short series that adds Helped-by tag to the list of accepted
tags in scripts/checkpatch.pl, and describes the intended use of this new
tag in Documentation/process/submitting-patches.rst.

The proposed Helped-by tag fits well to indicate someone had helped with
the development of a patch, to the level that doesn't warrant providing
a Co-developed-by tag, but is much more than it would've been indicated
by providing a Suggested-by tag.

Changes in v2:
  - Changed into a small patch series
  - Added a patch that describes the intended use of proposed Helped-by
    tag to Documentation/process/submitting-patches.rst, to hopefully
    help with accepting this new tag, and to make its intended use more
    clear, as suggested by Chen-Yu [1]
  - Added a patch that reflows a bit one short paragraph in the same
    documentation file mentioned above

Link to v1: https://lore.kernel.org/linux-kernel/0e1ef28710e3e49222c966f07958a9879fa4e903.1729871544.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/linux-sunxi/CAGb2v67fLPf-yKObuds3LC77gT_W_OmgSK5y2KotRC-Zn9aL7w@mail.gmail.com/

Dragan Simic (3):
  checkpatch: Make Helped-by tag supported
  docs: submitting-patches: Reflow one short paragraph
  docs: submitting-patches: Describe the use of Helped-by tag

 Documentation/process/submitting-patches.rst | 17 ++++++++++++-----
 scripts/checkpatch.pl                        |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)


