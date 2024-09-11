Return-Path: <linux-kernel+bounces-324117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6FD974814
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEF9287B96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5523A8CB;
	Wed, 11 Sep 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBkkQBwz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153A39FD9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020720; cv=none; b=rvx5QcgrwW1LsQYqtvli72PYupVqJGb5zhQ0fzEp+3VM3gASVKINRBl4k7HsFRFGg74WzR5a4bYfVg/BNf7imGs6rz8IjYMLRf4//hAxyZ7J8SAw7lDobObh/qRGiKNqAL54Tl4nssIrO/qiO8JU6IuW0s3QIoHuQTtA+QgEGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020720; c=relaxed/simple;
	bh=XD3xU71GufM2mam+Bj4b7+0w5mWce4gp07uM3VRrjSc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D/881otLIUCKwS55Drk2cmFftVsgs/TcMV6nLYLZLec7gTelmZkuio+h9pMMmRny3HcKbSJKKRIr6hw0i32fo9doHwsnfx/i5BYjtrRcsRVL9CxGXns2+CNQpF+4Cz6PeUUTsxPnzogbfKztzzy8/f9ZRlykxPtzPgCKfWBb0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBkkQBwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70242C4CEC3;
	Wed, 11 Sep 2024 02:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020719;
	bh=XD3xU71GufM2mam+Bj4b7+0w5mWce4gp07uM3VRrjSc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GBkkQBwz2sdnZ8OQ2J/aw49QN7rsmPKVZFDZd0/PIcFCffgLjNHEgOccqA5nYDQKv
	 x7D+4Yg9oPQ4MwMETng0bP4Y43b88ofCiBrOLrlcQjnjrHg4oRUgu/hPKMZ4/OeVKr
	 ndVLmG948HoPtA0NDMQT05thK0vM2qPkqZ+FZJaJMB9/jvfIXoLNH/gOaI3QVB/oEl
	 hVkK+ZZeLT4R9W41esBVevbfZX/jTWgw7xdQumipIZ5D3QZBeNUU6aJFT90TMxw0xm
	 ffcVfMbEz3LR58Gr2SrW1F0TWrJfxg13WYTn2/OSfU0QyfpNCZ5L9V2zNEeV0B3NjO
	 D0FVx2DK1gaug==
Message-ID: <9b9ee9a3-af25-45eb-a85b-eb86234a4463@kernel.org>
Date: Wed, 11 Sep 2024 10:11:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 3/7] f2fs: add reserved_segments sysfs node
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
 <20240909221946.2004046-3-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240909221946.2004046-3-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> For the fine tuning of GC behavior, add reserved_segments sysfs node.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

