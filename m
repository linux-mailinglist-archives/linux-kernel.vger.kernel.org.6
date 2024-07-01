Return-Path: <linux-kernel+bounces-236882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0F91E836
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C851A1C22203
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBF116F292;
	Mon,  1 Jul 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwNorOyf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B2C8C7;
	Mon,  1 Jul 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860718; cv=none; b=tL99DKrZUntmHao2RuIgcKWZkqGB7W5CH9wfKD/3Ie5Nwqq7p783QXGxldiKwhFbYJ29BJ3QsT0kYZGRltNHTqPEV+DUnYhWb2BpC7U59+Isd93Dp2VOjYOFR6zBoNnIGXmmJ8lSz1Oqj7zkNGhTAFYKCcvMhGyn0ECM8URLxW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860718; c=relaxed/simple;
	bh=loOnHwMBg9M4XS+nNRQF1gsL0DMqhFJUC65jQbSLJQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LTOueykfa1H8oeuR4YPMmPv0WHi93OzKIKvho808HLOKi4sPcBVkC/yNdcUnrM0mjfhprXmfrLFRG9sJfsaryIw0o+38fRGxqgmnvfGuG+L7DJAN7n+9SO2Hl7Cp9ojCUaqpSyrtEMnlUUNy+N0ECzzdz5lUaooQgaefZgDSe4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwNorOyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDD9C32781;
	Mon,  1 Jul 2024 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719860718;
	bh=loOnHwMBg9M4XS+nNRQF1gsL0DMqhFJUC65jQbSLJQk=;
	h=From:To:Cc:Subject:Date:From;
	b=IwNorOyf8vRAMM5+BWhA6pgc1oGRd1BpgHsyAu7Z6bXbohhmbHKtPSlhwcq4CO06g
	 wAITEWtmVG3MG1o8NeAFOCgHdYqEaKRa4hBnFsd37yRZOKKDq4feP6vORf2Wl8qrs8
	 SGqCEi25KDpxiyKvCo3ERTbBMF+4BVu03KTxuJydn6gLfobaW0SPAD8bDz0Io1PVIn
	 5DokqnfnEUUrsRonCm73P+ZaMnHKn97PSpy/WRI4k+9U/70bb7ndo0lg4u3dxTx4cH
	 QK0OdHYsJ6I9FiINZ2mo21Ir4lkLFsRNT2JvhuV+o1DJIJWd3OL7W7EZlFbL0uBF9u
	 eOD2lP/heDG1g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Docs/mm: rename legacy docs to unsorted docs
Date: Mon,  1 Jul 2024 12:05:08 -0700
Message-Id: <20240701190512.49379-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The work for changing the memory mangement documentation outline has
started from 2022.  For that, old documents have placed under new
chapter, "Legacy Documentations".  The plan is to eventually move all
old documentations into new outline, while asking new documents to be
added on the new outline from the beginning.

However, it is unclear where on the new outline each document should be
placed for some cases.  Meanwhile, the name ("legacy") makes readers
feel the documents under the chapter might be outdated or not actively
maintained.  The absence of clear criteria for new outline also makes
new documents difficult to find where those should be placed.  A new
document was put on the bottom of the new outline recently, apparently
not based on a clear guideline but just because it is the bottom of the
list.

Rename the "Legagy Documentation" chapter to "Unsorted Documentations"
with minor fixups.

SeongJae Park (4):
  Docs/mm/allocation-profiling: mark 'Theory of operation' as chapter
  Docs/mm/index: Remove 'Memory Management Guide' chapter marker
  Docs/mm/index: rename 'Legacy Documentation' to 'Unsorted
    Documentation'
  Docs/mm/index: move allocation profiling document to unsorted
    documents chapter

 Documentation/mm/allocation-profiling.rst |  1 -
 Documentation/mm/index.rst                | 19 ++++++++-----------
 2 files changed, 8 insertions(+), 12 deletions(-)


base-commit: 5dc709e59ba6486e519b22f86278c978b422a025
-- 
2.39.2


