Return-Path: <linux-kernel+bounces-565408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9015A667A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A956C7A8206
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF91D9A5D;
	Tue, 18 Mar 2025 03:42:16 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D01D47A2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269336; cv=none; b=CzABq3zcbt0xU+vZ2HRVicl2/rVjeBVUJq4VioOIHIVqSrIxXiIrRwr+qEHaX7L/NA1jVuYV1xHQ9sDZ0iCpmbK8VN0zauzBB3kl7McXX8nXq5+B0OKao9mdFd9nsE/04wg6waHqGES6vG9VOehAd0mGxGr1e2NLxFY6Km3p1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269336; c=relaxed/simple;
	bh=PNDDas4uZq0wQTzv8n9ldswKA5eJyp8nrzElY4PpGJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQftNK2ZrzvqjLcvvmrrBOlG4it+HO27M1jRf2tfMlgCOGwqWvauvWQPL4Egx5/7F4Uys70z/aLSbQbS9T6qoiBdT1+kf+BM5yDT0/51+Lzlum/GBp6gOxqKeNcJpNF1dEDhpS3DJUE93B0CaRvdpecSFe1cwWaav3WAAzn9xAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fl1s012132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:48 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DE74B2E0113; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] jbd2: remove jbd2_journal_unfile_buffer()
Date: Mon, 17 Mar 2025 23:41:21 -0400
Message-ID: <174226639140.1025346.4909362228471277602.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306063240.157884-1-libaokun@huaweicloud.com>
References: <20250306063240.157884-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Mar 2025 14:32:40 +0800, libaokun@huaweicloud.com wrote:
> Since the function jbd2_journal_unfile_buffer() is no longer called
> anywhere after commit e5a120aeb57f ("jbd2: remove journal_head from
> descriptor buffers"), so let's remove it.
> 
> 

Applied, thanks!

[1/1] jbd2: remove jbd2_journal_unfile_buffer()
      commit: a015c4e6d19cf5e589d4ac877fa7cb7f4ee01094

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

