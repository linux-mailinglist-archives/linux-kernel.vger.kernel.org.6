Return-Path: <linux-kernel+bounces-236913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A067D91E88E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D214D1C21747
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA816F855;
	Mon,  1 Jul 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfvP3TAt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AD16F0F0;
	Mon,  1 Jul 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862031; cv=none; b=rod+fuub7kVY1VSOJbV8/2iy+qONke6m82ztoU2F3KbXdUN20ly1hudPbCit9zuAzTif0RSJ5p5TH3OXONWNu2owpBbXN5Lm0CabCn2/AuuNoLAlYn7DyG37f0WHUx8D6r3iB72nvmVKaNrAw0FDDkyTK3tkEcTZcfLUIt73SP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862031; c=relaxed/simple;
	bh=OXbSvK9dxE6Kh54IRK7iqf4AbqeHSzT/rikFY0RySd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YCpGqwOq0EsAX0W01d+7QKK2ZcBRHPKX0s5iSbDcAOsY9Q0gXAVdLVlGQ0pl829WilmikkFAKErt4lA5ZBFRp0H5Z53RGgTLjAI6xQ/iaIW+REhLBu2qeYlgFVgaH30eXAM+dhlNDWQO2F0MLlEERnWayr3HXATBxkrA2i3wcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfvP3TAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C40C116B1;
	Mon,  1 Jul 2024 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719862031;
	bh=OXbSvK9dxE6Kh54IRK7iqf4AbqeHSzT/rikFY0RySd0=;
	h=From:To:Cc:Subject:Date:From;
	b=GfvP3TAt8OMnmuVAnPldXyQlsCzYw9cYOvZVn5ga2pp+9KL0Vch+r7PxCmjzIxP9c
	 DamY4/LEAeFrffWQgnLbIFqXPjBBgmzyFL4LadxEO/w2vttP0AjdqFpVFUC0IbvBb8
	 jvZYv5IhqVzJNOGF2THxWxvaSsVaQ2oYGTjXFLvpqUs5dOZpglyY3E0Rs6EixxtPey
	 T4jSWMIGgG6qwFFGYw+0AKkg5dsjHmZUc7fgwp3U73fhkovXpg8Plxqvk7rtsh3cBa
	 D8FRTdihEL4QoHy5sdOpDKOeDfAnzIwjq9eMC2/V/b1eHWWxve19GDoGc0t+b2CSjY
	 jD65v6TNyopXw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] Docs/damon: minor fixups and improvements
Date: Mon,  1 Jul 2024 12:26:57 -0700
Message-Id: <20240701192706.51415-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixup typos, clarify regions merging operation design with recent
change, add access pattern snapshot example use case, and improve
readability of the design document and subsystem documents index by
reorganizing/wordsmithing and adding links to other sections and/or
documents for easy browsing.


SeongJae Park (9):
  Docs/mm/damon/design: fix two typos
  Docs/mm/damon/design: clarify regions merging operation
  Docs/admin-guide/mm/damon/start: add access pattern snapshot example
  Docs/mm/damon/design: add links from overall architecture to sections
    of details
  Docs/mm/damon/design: move 'Configurable Operations Set' section into
    'Operations Set Layer' section
  Docs/mm/damon/design: Remove 'Programmable Modules' section in favor
    of 'Modules' section
  Docs/mm/damon/design: add links to sections of DAMON sysfs interface
    usage doc
  Docs/mm/damon/index: add links to design
  Docs/mm/damon/index: add links to admin-guide doc

 Documentation/admin-guide/mm/damon/start.rst |  46 +++++-
 Documentation/mm/damon/design.rst            | 145 +++++++++++++------
 Documentation/mm/damon/index.rst             |  22 +--
 3 files changed, 152 insertions(+), 61 deletions(-)


base-commit: 32b57f0583f399fc92419cb9db525d7b174d6d77
-- 
2.39.2


