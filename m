Return-Path: <linux-kernel+bounces-537606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FFBA48E11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94394188B9A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8353C450EE;
	Fri, 28 Feb 2025 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="P1Es/sOT"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C741276D11
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706957; cv=none; b=bOiE5OhIYzLDkp/d87ppcOTGb/9TcSevxl1FYgpdXYYdA5Z24KxASR4DkUjElK+6WLhQE/pYk83bdAGApKCQGS3Q3jlzd4f2FSeX0bC/IdS0SWUsLUcZPsre+rAhxhVBAhVo3/naB43QGZvaxYk6RPHmfeWYI/frNT6ICgCXMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706957; c=relaxed/simple;
	bh=0Xz800KTQsMzMf/aTGUirftckoPiF1faIIqhUfnY7mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FylgN+symh7BQlNbCyUW8dNGCFqeB4o3VK13EKo2tqUtNH43kcttRVJV/nJwWP7h+up7biuWhdwgZs9xxvnSiKxMI+YT9S8sOEdpwXxsx3ACqWVtGWQS/emeAKreMN7bgWG2c4m68XiKUwBCCFfrDsM+3Tn7rJjx7i3bOWutFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=P1Es/sOT; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id nHVxtkEmJMETlnpOdtHblz; Fri, 28 Feb 2025 01:42:35 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id npObtoZxqrdF3npOctHxsj; Fri, 28 Feb 2025 01:42:34 +0000
X-Authority-Analysis: v=2.4 cv=O5I/vg9W c=1 sm=1 tr=0 ts=67c1148a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=iit3rYpcdqjZrRsmSfkA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ml+ZtiSZg6m5QioCesBYuryQ6UN65U0bEw11wXgplw4=; b=P1Es/sOTtmwWfMGk7jz8Crg1oi
	iV3sne7xu/X1QenquevXy7MmUn7PdDXjhR0jfLMM+Kv8PsjW745vcZQNr1aPpG1kOdX+RnX/eD+gY
	eGw471fKtYiZ2u8kc0m8UhlQjI0feDfPPzUgvnxAsTHTs3FrMZGHHVyHaFndq+eWe79gV1W+tRjP2
	r5sbEPr1Bvjs2PP+zWi8kqGswjRjGDOBD7c5TQGf8yskQ6g7AInmRDCdjTC7FlY1CPKb4QDa/+gHu
	7cOaQ/+aPFLnV4Vkl4sdINJIxcUFW5EbvXss2e5NnxQZy+mWUobyJzxoDDQSEGh6QlSai1P/MSvZR
	uKJwmknw==;
Received: from [45.124.203.140] (port=53610 helo=[192.168.0.158])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tnpOa-00000003AAi-1kQ8;
	Thu, 27 Feb 2025 19:42:33 -0600
Message-ID: <4a6c2392-3200-4e1c-ba5e-236f2e608daa@embeddedor.com>
Date: Fri, 28 Feb 2025 12:12:28 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: Avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Danilo Krummrich <dakr@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z6xjZhHxRp4Bu_SX@kspp>
 <df8b8d59-470f-43e6-a8c2-cc40a4ebe5d6@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <df8b8d59-470f-43e6-a8c2-cc40a4ebe5d6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tnpOa-00000003AAi-1kQ8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.158]) [45.124.203.140]:53610
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJw1YcrhK8asbmrCEh7aRx/SIvCSpqclg9w1ZoHFvHGxZGsvIvgcOMtREwNtqmBFc5SZhZLi7Kf/tE7biq+l19uX//OJHwbOO2RwN6H0RT7V+LFOUiT6
 vAYNdFYU/FfSYGailZ0Oq09Stg3vmUgeXna3wIhFZCjQSUvGCK2aDmtVo+R7Ew1AUo0g3bwpNgg9OEowTRDy0EtmXQcZd86OhHo8Zf2sgpM2KMRBRlEUfzw4

  > Applied to drm-misc-next, thanks!

Awesome. :)

Thank you, guys.
--
Gustavo


