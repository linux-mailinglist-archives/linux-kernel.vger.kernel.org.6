Return-Path: <linux-kernel+bounces-408255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C137D9C7CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857EE2816F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E459206060;
	Wed, 13 Nov 2024 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="HL9WTd8/"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260F1FAC3E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528577; cv=pass; b=tqf8RNUn2QfFpd8iNxNn/yxHIkboBQHZYZ4pqb+0Ry/6eBUIHM/jUhz8q5MBcRmSaNjhtwM7vqUaAw8RbA3o1KgN79mYaKMkHIkjBwW9jw51VoFLUB+dRS0WJRaNNykkQxuWdKMCt8/SxtV6/aSUskKjcCnIlQVBvADC+9VyZBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528577; c=relaxed/simple;
	bh=DLtVyS1Gle0W3YvZb1ONvyig+nqqFm1VbDN4+kU9mvM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VWj0xfIdRszEjNXNDmuOE/d/XeySvInye/y1o2WFpoV8k8e68fTAkwleNetpVdmQ3tutcLcjkW/+V72N4FDiv6jl6TIRWo2jCuFW/O0utfV7FDjc4RLRH449Vk3VGm/dhRTjxsxfgszUpEAShOEjLuwReoZ8Z/X0R6Ho/yrpbpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=HL9WTd8/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731528559; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZFzX5aS+y1VRNZ7MaWQQQyDPBqnPt7/jrgPProgeKZ6Zl2VespVImQD2sq9WDv7hrxdPPBiR+B+T2MIws1qRd9DQRC/rwiNkIqktyXwJvw4YvwRNOoqY0oo113lGJ/QrfbmvYlWsdE9R1VuDn4lrD/nuUjkmpT8U/+Y62Wdida4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731528559; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dguBOGoGelrYVmBNPYN9y9wYEeTWSEzdw6LC5L93zYc=; 
	b=JwcEuR6zKWXyi8xQBJX0DJl9HBu6W04HSEEQm3cmmnF2wB+ANocSQRB5NOUAowjFBiwgoSlGrLDA5xknwm7GCqFY9P4JTiKy1w/gFvDHBBzltAy+7xbtTiZQsvGIivfNvzzbvQaHMsJ0zzsHp10o4sEhcP8v1Hs6Nt32IbhNUjk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731528559;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dguBOGoGelrYVmBNPYN9y9wYEeTWSEzdw6LC5L93zYc=;
	b=HL9WTd8/38/qjcGLHF57Lh1gXYxUV5k3u27JC5CI0Zt31pKIWok2LoyEbDpXJg8C
	ptG6eUZvxrJR9lIa3mNZGjg1ku1F4azXtvIhBPxeX/Yg5wSp5IPMqsfubLGWRaAeufl
	WamOmKSFLYR1YyKirHd4RIeM83Q2Y10IQ6sGjojk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1731528528260910.1748320725312; Wed, 13 Nov 2024 12:08:48 -0800 (PST)
Date: Wed, 13 Nov 2024 20:08:48 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "Jens Axboe" <axboe@kernel.dk>,
	"Sagi Grimberg" <sagi@grimberg.me>, "kernel" <kernel@collabora.com>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19327249129.1131b0ddd320896.1106904208694557670@collabora.com>
In-Reply-To: <ZzTqgXqjN4UrT392@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241113043151.GA20077@lst.de> <ZzTqgXqjN4UrT392@kbusch-mbp>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail






 ---- On Wed, 13 Nov 2024 18:05:53 +0000  Keith Busch  wrote --- 
 > On Wed, Nov 13, 2024 at 05:31:51AM +0100, Christoph Hellwig wrote:
 > > On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
 > > > From: Robert Beckett bob.beckett@collabora.com>
 > > > 
 > > > We initially put in a quick fix of limiting the queue depth to 1
 > > > as experimentation showed that it fixed data corruption on 64GB
 > > > steamdecks.
 > > > 
 > > > After further experimentation, it appears that the corruption
 > > > is fixed by aligning the small dma pool segments to 512 bytes.
 > > > Testing via desync image verification shows that it now passes
 > > > thousands of verification loops, where previously
 > > > it never managed above 7.
 > > 
 > > As suggested before, instead of changing the pool size please just
 > > always use the large pool for this device.
 > 
 > Well, he's doing what I suggested. I thought this was better because it
 > puts the decision making in the initialization path instead of the IO
 > path.
 > 
yep, this avoids any extra conditional in the fast path


