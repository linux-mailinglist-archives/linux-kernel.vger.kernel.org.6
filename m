Return-Path: <linux-kernel+bounces-562909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02117A63480
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 08:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1313AF8FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B493D18BC06;
	Sun, 16 Mar 2025 07:29:25 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698F4C80;
	Sun, 16 Mar 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742110165; cv=none; b=qFl2drRG6Cv7GKN0FPBtjLYIZBRVtqHUJFqeMyf+xWaakJocRCkx5Ins1NLN1Mtl46NOyRvu1tIcY1iXoO6cL6ogH+D0CZ22sVy+/F8fvOkD6rQIlimKitBp8JDZln9cx/SPhBF07B0Vt0bwGJcc5hQbltonAnFJbawJWkHzgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742110165; c=relaxed/simple;
	bh=FCO5ETrC8sv7GFOhyGezerIQ7NYAzhxlXNx0b5sbgn8=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=afV/ZPn5WVVdsZRPcOPfXk+A3zV6dP9LFV8zaCnghvjmtPg4OjrXZnT/rMwjgcIHykDJ4aKTuIXnvF57KAHRu61Iq5CvroRmJVOEi70wz2sTXlb1mmym6LayWEWHZVi4weoyuey2ZjoKRRDxhxeq0cNztKqN0lwcCiuMzVkg0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZFqSL4t0Jz1R6xR;
	Sun, 16 Mar 2025 15:27:30 +0800 (CST)
Received: from kwepemg500001.china.huawei.com (unknown [7.202.181.37])
	by mail.maildlp.com (Postfix) with ESMTPS id 78E4E14022E;
	Sun, 16 Mar 2025 15:29:13 +0800 (CST)
Received: from [10.67.111.53] (10.67.111.53) by kwepemg500001.china.huawei.com
 (7.202.181.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 16 Mar
 2025 15:29:13 +0800
Message-ID: <ae0422b3-61a7-4d2c-ab3c-de2d98a9d661@huawei.com>
Date: Sun, 16 Mar 2025 15:29:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <gregkh@linuxfoundation.org>
CC: <cve@kernel.org>, <linux-cve-announce@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <2025022618-CVE-2022-49562-1d2c@gregkh>
Subject: Re: CVE-2022-49562: KVM: x86: Use __try_cmpxchg_user() to update
 guest PTE A/D bits
From: zhangkunbo <zhangkunbo@huawei.com>
In-Reply-To: <2025022618-CVE-2022-49562-1d2c@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500001.china.huawei.com (7.202.181.37)

Hi, it seems the problem reflected by CVE-2022-49545 has been fixed by 
2a8859f373b0. I wonder if applying 2a8859f373b0 could solve the problem


