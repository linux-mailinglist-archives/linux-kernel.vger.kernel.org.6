Return-Path: <linux-kernel+bounces-436620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3C29E88B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 01:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5DF1884F61
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 00:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91895234;
	Mon,  9 Dec 2024 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V82cAoKt"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40E29A0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 00:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733703390; cv=none; b=lzEcUypgVhZdebc2L6hv/yfAPjtlWoCKmYVpLTxkXa6oPWiZNq1P6lu9Djcv4yxUEz7aeHLrnZUjX6KmmT+UNbq1mANI583yMdc8aPC4V2SlzVNw4nlJON3R46HWRVf0DA41U6XNAdeg9piNyzBvI+GIvnOLBrKfryiCTe1/8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733703390; c=relaxed/simple;
	bh=BG0lYi8qENv1S6Z0qBZj8MIboPFVdp43e62P0arKhY8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=exOC97T8GntPoznnaSI+XyP9nwPeUbP8v7MNEg+V/hi8XFWVOluVXX78eiUCc0S+aWlZ/9cjRuLbmOXyt9NhBDg3a7TSyIFxqLmulRexVjzMZYJARiHGO1Ph+5+zqSMKdTnrgfYIXbB0kSKLJiBYQ+sz4TeS+NKT95dNLTwMx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V82cAoKt; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733703375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLoj+JdGdda/8Il0iOf2kOpmQkX1BduRIAZEjm01B2U=;
	b=V82cAoKt1hD1ukhOAYE58fpz5fdSXRVoknNzLepw69DA/bxxd7lgxN2qd5doCcdEym0Hwq
	zMTBkGaMiSd679CLoUBTg0l0WJvDTDpOa9S5gvgLNtbUADO/qyIGTt+dC1h6Blmfq4Bgqt
	we++6RBDCA0eRDgCuNeNuVrF8PcgxgM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] hv: hyperv.h: Annotate vmbus_channel_gpadl_header with
 __counted_by()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <Z1P94CdlCAzDc3d3@liuwe-devbox-debian-v2>
Date: Mon, 9 Dec 2024 01:16:01 +0100
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <77790477-238D-482F-9431-FA85091685BB@linux.dev>
References: <20241015101829.94876-2-thorsten.blum@linux.dev>
 <Z1P94CdlCAzDc3d3@liuwe-devbox-debian-v2>
To: Wei Liu <wei.liu@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 7. Dec 2024, at 08:48, Wei Liu wrote:
> On Tue, Oct 15, 2024 at 12:18:29PM +0200, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> range to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> 
>> Compile-tested only.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Applied to hyperv-fixes. Thanks.

This should probably not be applied anymore given the kernel test robot
build warnings. Unless I missed something and this works now?

Thanks,
Thorsten

