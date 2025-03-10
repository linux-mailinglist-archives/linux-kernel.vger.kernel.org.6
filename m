Return-Path: <linux-kernel+bounces-555067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEF4A5A529
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2FC3AD679
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C01DF273;
	Mon, 10 Mar 2025 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="prjJ0YQw"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A81DE3DB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639287; cv=none; b=Qimut7qFN0ofAZa+bXUiXTXhIgrJCUAIfbYeSEGrSMSbQuz40MNQJk7BZuKNq5ZfwXzgphDS9htaWKmB3Dma7HXtEh7faDkAd0mLovH23UyQbQtDd5D6F11D+VOqVsaU4i32rlfZBsO5uXfXKzmp/QyQBDJBVuNhYC+F+jtizmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639287; c=relaxed/simple;
	bh=XaYmuIa8pdHbKO20OqOLuUKA34Gu5VlIGwnaCX1yhJ0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nFZEJ3tRNP1FfeKMAytMUxFnlZIqIZ1SdRM+z86b8epcE0OV4Py+s6LQ9IU75ocRmoiW1+hNzKye3h3n8eU7AcYNLO04jMxmBkJJfSRIbZ29ajvL3JQqfhqZ84sAseVse4xqWIwzBZ9U61dl3lREnSFuAFhVxPHJ4GDl4LfXq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=prjJ0YQw; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741639273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMcxh/t5+kcUHyzKMCwlELhSKRx1YeqwAaQpOmzXW1c=;
	b=prjJ0YQwkY2aEYeQY5mPLQQaabDwgkIORIWtOaM++myt2BMe3/saOpzjw4MfJNDHwBrLJJ
	c2xpSyrVURT75WsqU7bkwledmTD8pYaKtfJZP3PKiDAhUsh8w6/X8ZLGyRnWhdwfQgcmrS
	di2hb/906UURST/z+2vh523ZvoLu6Pk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] hyperv: Remove unused union and structs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <BN7PR02MB414819702EA59A53FE581943D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
Date: Mon, 10 Mar 2025 21:40:59 +0100
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <ACB6A959-C2CD-44E7-A1D6-AB9263C29D4D@linux.dev>
References: <20250310192629.443162-1-thorsten.blum@linux.dev>
 <BN7PR02MB414819702EA59A53FE581943D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
To: Michael Kelley <mhklinux@outlook.com>
X-Migadu-Flow: FLOW_OUT

On 10. Mar 2025, at 21:21, Michael Kelley wrote:
> 
> It appears to me that struct vmdata_gpa_direct and struct
> vmadditional_data are also unused. Did you keep them for
> some reason? Or could they also be deleted in this patch?

I kept vmdata_gpa_direct because it is referenced in multiple comments
of other structs, for example:

/* The format must be the same as struct vmdata_gpa_direct */
struct vmbus_channel_packet_page_buffer {
	...
}

I only checked the structs used in the union and didn't check
vmadditional_data or any others, but I'll submit a v2 and remove it.

Thanks,
Thorsten


