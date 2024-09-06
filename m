Return-Path: <linux-kernel+bounces-318259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AB196EAC2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DBD1F256EB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658D414D29A;
	Fri,  6 Sep 2024 06:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3Oa1KQW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F6113D891
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604526; cv=none; b=WWrbIb5dk1v+ZtvysWzllMsF+aaFndU70Mj8NWOn0JDH9N3rsZMueF/n0bHfkT1CNe3du7lIHbiwuk6w6URoIFCh55GQOiKXYOjyuL5r4PGrKhiGWStX1GVT+L+76xoi9dLq75ZEJx6jyOm6EL/3Gs+m8ASl1qnVmM/4pD4WQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604526; c=relaxed/simple;
	bh=6D1Qdu6CCDog34qymmghISUPR07u436+iHRrGFdqmkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHq2BnWyL0xu1u6ll1TqRUrkuZbm+lnlPDVrQ2SCNL+rm8JhfcDTxy0k+olfKVaP/B4/G8wDcx7zfwSmRMInONYEZH3MjVcLEeU0YLgBkS1IUMXaJHvue8DNZ4XM9qg/yS70/4I/39aCs94na8w7f9/LJJEgQuqhBmKMhfhsF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3Oa1KQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352D8C4CEC4;
	Fri,  6 Sep 2024 06:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725604526;
	bh=6D1Qdu6CCDog34qymmghISUPR07u436+iHRrGFdqmkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o3Oa1KQWlh02lAVhFrd0SDVBbrR5MLa8pyIZ08AXfeCihhNNfoWuwAtG9lGIr6rFF
	 wCTPSIVxTLf9Selb7dTIvj8/TkLjmL1hQLB5NVU/+6gxt5jlmi0/t25/Zn9OWAnoLD
	 jt2xD5q1wnWGoDA/L8hcmfap4Ql7ihhxDiimUk+uRtGPuhCv1iiSKWd78HpnEhCaRA
	 7S+xfYcbPnxPZiepQvC0fdHy2OnWdLmRM6me1FGQWWAGtNB9PEhmRl87NcBZ9G1+XV
	 6l7WpaNoyBDzN/3/pBl1bkGq0CSgJbnKUMh54q+oWGBiD+sscHIZX0x/rWgNhcLdR+
	 49on5O9GeHGxg==
Message-ID: <f4aba59b-21a1-45c8-a8ec-443be37a859a@kernel.org>
Date: Fri, 6 Sep 2024 14:35:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 6/7] f2fs: create gc_no_zoned_gc_percent and
 gc_boost_zoned_gc_percent
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
References: <20240829215242.3641502-1-daeho43@gmail.com>
 <20240829215242.3641502-6-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240829215242.3641502-6-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 5:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added control knobs for gc_no_zoned_gc_percent and
> gc_boost_zoned_gc_percent.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

