Return-Path: <linux-kernel+bounces-216525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E690A095
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FCE1C20DAF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D6F7344A;
	Sun, 16 Jun 2024 22:48:32 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7D61FDB;
	Sun, 16 Jun 2024 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718578111; cv=none; b=Az1fZwCyaorCtKlGuNOyvfRPqp0yO/xnzZBsljzwK3tZtmrMPOUp4khNwVL6YqbE6hUKnrToMUwZpe23D3d7VeIjZpidL5GbsCizdo2sz4yqFhRuiCKX294GQs4rf1LjqUJI3bOH4/gE1P0TQA1AlgbVFmIODabqO78utPZUeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718578111; c=relaxed/simple;
	bh=EdQVkTfH5pxx4y4UjUTm/ZyoIl3VmTB5HZXmOYMau9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us/inZfUb6H4bvbBz6AXf/5Hu7yrm/7cOS9j8G3vW7JbkSI1m5gpBENthNV38UGpfKxgbyG3SOEI8cSV4WR5phber9S7zt8xgc7LaOoqAKRAznkxeyUU7GPjkTykROWUD3bI9C+dvrfjbiwVUx2qWPZXDU3hcj9d/k9O+UShO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sun, 16 Jun 2024 22:48:11 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Conor Dooley <conor@kernel.org>
Cc: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jesse Taube <jesse@rivosinc.com>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Message-ID: <20240616224811.GC3983622@ofsar>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616-exorcism-computing-e11e26084a62@spud>

Hi Conor
 Thanks for bringing this up

On 19:35 Sun 16 Jun     , Conor Dooley wrote:
> On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
> 
> No MAINTAINERS update, so I figure that means you don't want to maintain
> it going forwards? If there's someone out that that does care about the
> spacemit k1 (Jesse maybe?), then I'd be more than happy to have them
> look after it.
Yangyu kind of has limited time, too many stuff for him..

I'd volunteered to help on this if it can fill the gap
Also I'd be more than happy if anyone willing step forward to co-maintain..

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

