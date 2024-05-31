Return-Path: <linux-kernel+bounces-196716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8E8D6059
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31A31C21EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD66156F5D;
	Fri, 31 May 2024 11:13:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964A3153BC1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153989; cv=none; b=rx5S+Asqy5fKVi45b8i0030M75GcCvk9Ge29j+qirEdTHVcxv9a4D+NsYctk0im/ub/+04uA2AtD5E4Tz1sc9xoxrSD0rDIlSlGYpRquQbRVsmCUkvHAgkkqVwl1gKnN/j7f4z6LbDfgIDbuos8FgOehhLZ+aVkNjBPHQOJ+Xmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153989; c=relaxed/simple;
	bh=oc6lrDMKbWiYtQFQjAfAoGtAl4pVkqeda6FlEYXC2zk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=INHTlx8/Z4ZTNYvecjfGg/y6dUpaQbb2ksHuqO4NXp3SmiZ6cXHNMQAJLxyyFfc+edKEjCeWW7JJRyvpCOvoGyH6x619VwUmadmzmDuNO+9m1SAIWnzb3CWNttxkEjgBP+XeNnSS8Xwpf0g9fj2Z36c08hv7hvIM9IQjAYXPz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2451A1424;
	Fri, 31 May 2024 04:13:31 -0700 (PDT)
Received: from [10.162.41.15] (e116581.arm.com [10.162.41.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5513F792;
	Fri, 31 May 2024 04:13:05 -0700 (PDT)
Message-ID: <e5f01ffe-de51-4079-a87f-2886788422f9@arm.com>
Date: Fri, 31 May 2024 16:42:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: zhouchengming@bytedance.com
From: Dev Jain <dev.jain@arm.com>
Subject: [QUESTION] mm: Redundant const parameter?
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chengming,

In mm/slub.c, you had defined slab_test_node_partial() to take a const 
parameter.

Is there any point of taking in a const, when you are anyways 
typecasting it to

a (struct folio *) from (const struct folio *) ? In fact, at the place 
where you call

slab_test_node_partial(), the struct slab *slab is not const.

Please comment.


Thanks

DJ




