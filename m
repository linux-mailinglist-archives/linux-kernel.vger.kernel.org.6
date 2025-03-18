Return-Path: <linux-kernel+bounces-565412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC01A667AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DE73BF0B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D853A1B043F;
	Tue, 18 Mar 2025 03:42:20 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021331DED4E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269340; cv=none; b=CU5xYqH1nBM79ourVq3Pp5mr16xzQ1L66y5v2swhKiHVdW9gnZoatCnlR+1l0+SqDMkl+N2lDdbiMgwHsiBI2+uqPekwTGaQ6SYuSM4fUArmjN7nCTT8XgnKamcM7a4Z/jqMJ4CGov3W0Vut+7U9+3XLqhv6DtNY9Kzdxl4kVCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269340; c=relaxed/simple;
	bh=Lo2NqF8xiou+MJCOyZZcCuVYQAN1YbMlZm8ZXxagtDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVhXlnGzrZgoCtf7aeh50rpm8ge/W1t8UWxhcp3B0CHRSsazE1/9XIbibVs8PTv3FeMtDwGjjZxv+/7yuHx56/sGXvV4ClYjM+NtHl8IdS5/abqjyj24SwdwXw6I6xllvnW51BelSqyuSg504NQQFO1YpTuguitQNaPM8hKJsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fjtt012114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:48 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D324D2E010F; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, shikemeng@huaweicloud.com,
        Charles Han <hanchunchao@inspur.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix potential null dereference in ext4 kunit test
Date: Mon, 17 Mar 2025 23:41:17 -0400
Message-ID: <174226639131.1025346.17589264624479359669.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250110092421.35619-1-hanchunchao@inspur.com>
References: <20250110092421.35619-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 10 Jan 2025 17:24:21 +0800, Charles Han wrote:
> kunit_kzalloc() may return a NULL pointer, dereferencing it
> without NULL check may lead to NULL dereference.
> Add a NULL check for grp.
> 
> 

Applied, thanks!

[1/1] ext4: Fix potential null dereference in ext4 kunit test
      commit: 57e7239ce0ed14e81e414c99d57f516f6220a995

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

