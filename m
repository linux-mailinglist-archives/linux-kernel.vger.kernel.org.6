Return-Path: <linux-kernel+bounces-565406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2A1A6679D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5702319A31F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB671AAE13;
	Tue, 18 Mar 2025 03:42:15 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA91CAA98
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269335; cv=none; b=JCeP9Uug2/Pxzwwh6RRl7lMpg+am3JLIZDkFrOq/WuWCfHjDzGhRX1qmiEYo0aARXJpnmzwzg2nR0Ny+8TKgLXGlrQJhc4InoIYBrDZJly2P7tsIB92jxF5NzPqrcUldGEUoNzWAPTMjk9ha+x7X6KBPKDgeffta/ABC9u7PCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269335; c=relaxed/simple;
	bh=KxXiiRpdcj2qTFLPlX26QNgkeQEjYv4biOT4q5PE3+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEMkb8CbDqFI7bFkr6tQMQQYRSohfUV/60ramhbDwwwH5g4MXV3QjRCf9rWL8DWVeiDuudIOM5i3jL5AONcq8Mw8XgGNit8KjEWDHKt2m8Grt5fZxjjZ2mK6pcgedLTPnaZ4HWC5ufJN1mzqZftjc5/ETy/Gtmag/sIik1se9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fnK7012163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id ECC7D2E0118; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.com, yi.zhang@huaweicloud.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Minor cleanups to jbd2
Date: Mon, 17 Mar 2025 23:41:26 -0400
Message-ID: <174226639133.1025346.17805331764618272859.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
References: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 Jan 2025 23:50:08 +0800, Kemeng Shi wrote:
> v1->v2:
> -Collect RVB from Jan and Yi.
> -Remove more stale comment in patch 4/6 as Yi suggested.
> 
> This series contains some random minor cleanups to jbd2. No funtional
> change is intended. More details can be found in respective patches.
> Thanks.
> 
> [...]

Applied, thanks!

[1/6] jbd2: remove unused h_jdata flag of handle
      commit: ec22493849247d60d595c93573ac3b01534b1965
[2/6] jbd2: remove unused return value of jbd2_journal_cancel_revoke
      commit: 9e6d3f9c8a85ed0db0ed1586049321e6b2ac5138
[3/6] jbd2: remove unused return value of do_readahead
      commit: 0d26708d8ec488da96a64eb1c6c47a8b3252edc5
[4/6] jbd2: remove stale comment of update_t_max_wait
      commit: 6c146277903f1826729bfb4817947d97a97b07cd
[5/6] jbd2: correct stale function name in comment
      commit: da5803391e377a39d655d55b4ebf2e416f88a8d6
[6/6] jbd2: Correct stale comment of release_buffer_page
      commit: fd3b3d7f51e628f54329738e736a154f6929daab

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

