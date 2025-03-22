Return-Path: <linux-kernel+bounces-572159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F9A6C77B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 04:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C1C1B622B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 03:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71F3157493;
	Sat, 22 Mar 2025 03:37:03 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F378F54
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614623; cv=none; b=TbVBevqbI/Jwe4TbwCYKMSlCy7a7hRbfWABCacK6syndKwWEC08DONIXV3v8l5I3W0gME5gN8+6prO9JViJSxtjstxOK3xZc5mmIOTbb/sKpF0P/plMxo6vKcgG7HobjUpR0lxz7n6IxiNvd0UgbwxR9YXuTYHvE6LYDME6KtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614623; c=relaxed/simple;
	bh=G7S8mDnweQ0QEQVt0tgiIFlnUT/TmYty8hUukQIlgB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXyrZU2vnL5Cx87hJvuHr0tgxz2YBVDJ7nwrzuzjeoxlD+pIrXxp+4FPDLWe+TyWZqCih6QemQeyiCPVy85lSWhq+6TkdPN8uXAONon5x9SR9vr5Khim0E28HSN9Dj6KgFki7SBRcI3Y3Dvoj+vO9mlLoTGRvfcKFOKY0AoecOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aNo8007718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:24 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C3C8A2E0110; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next] ext4: correct the error handle in ext4_fallocate()
Date: Fri, 21 Mar 2025 23:36:19 -0400
Message-ID: <174261457018.1344301.14790065059237204237.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319023557.2785018-1-yi.zhang@huaweicloud.com>
References: <20250319023557.2785018-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Mar 2025 10:35:57 +0800, Zhang Yi wrote:
> The error out label of file_modified() should be out_inode_lock in
> ext4_fallocate().
> 
> 

Applied, thanks!

[1/1] ext4: correct the error handle in ext4_fallocate()
      commit: 129245cfbd6d79c6d603f357f428010ccc0f0ee7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

