Return-Path: <linux-kernel+bounces-318022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977FC96E73E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0011C22AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0B01B5AA;
	Fri,  6 Sep 2024 01:21:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B813211CA0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585675; cv=none; b=GT7U/rpXyyBL7EUDrb1TiBnieAfX0+AckBjiLi+Qpg9mUE5THyI5WHOAAJx4EfdFhZWwFKmlgPD+CgpeQ4o8H6ddXA/Ele7MY9gpCNBj+rKxpIBcsNoFLBfSmthQLxqNqWEdj1mmHegqwwVOpXyZR8TQQJM8v4KnPVByw9uvyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585675; c=relaxed/simple;
	bh=0NehYsBv1pWoQEhc/eK9a0m/1gXaQ57vOPMqhZ+Q7Nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJqYftakL2ohia8mOnJ5vhZK0uwlKeLAZ6SkTuuVwbIaurT48M7zME9TXaYqVYpVFtWWGvQk82q4wEPCxGZwl7CNQxaOY9vq8IRjVlsukBTbtEljV3KUhRNr6NjcTgsHxJz7Bxibnr5ZlBACpc7mwUQH0+NIpI1GDxMeyh6vtPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1401EC4CEC3;
	Fri,  6 Sep 2024 01:21:13 +0000 (UTC)
Message-ID: <fcc7ac5f-98e8-4f30-bb95-9cda52856cba@oppo.com>
Date: Fri, 6 Sep 2024 09:21:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fix wrong endian conversion
 related to i_flags
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240905212014.1094170-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao.yu@oppo.com>
In-Reply-To: <20240905212014.1094170-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/6 5:20, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fixed wrong endian conversions related to i_flags.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

