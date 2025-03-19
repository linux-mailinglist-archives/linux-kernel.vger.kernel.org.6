Return-Path: <linux-kernel+bounces-567464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA65BA68669
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3C2188BBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B222505A6;
	Wed, 19 Mar 2025 08:08:58 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED78211484
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371738; cv=none; b=bjgN2TsGu4hgSTHnwg0HYAbiR0lTT4DnNePimz/s3TgRPjrcyjI7bPJt867LFtsHUiYzv7IuCyTeNkybfYLFMmkHsZv04i52+54E4yx0xiE7kOWoMs27zx0Hb/Mhzl6Jkt9bfk2nq9zd3NxkkcGTgxZWn7rH3Sxvz+Q0WvWXnRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371738; c=relaxed/simple;
	bh=yk+nvubqqyf6230LwsnMkGTUAn84BlEYVnHrFk73oTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfN0VQ6SO3aW5dBjoGbgENws2klirNsdA6FH571KpsrDCUKkTy7fkDpg+YN9L+Hk9QPtsWGKS8L4Y582oNUYGZyFLvO51lhc8/hmw1GO0GZViEc5yMPQp2A0btEVBiJlbSTXbKlwoWaXvzsC6pel3ncxlNaW3vrCvLo2kAxNgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD84C67373; Wed, 19 Mar 2025 09:08:51 +0100 (CET)
Date: Wed, 19 Mar 2025 09:08:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hillf Danton <hdanton@sina.com>
Cc: Huan Yang <link@vivo.com>, Christoph Hellwig <hch@lst.de>,
	bingbu.cao@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, opensource.kernel@vivo.com, urezki@gmail.com,
	vivek.kasireddy@intel.com
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
Message-ID: <20250319080851.GA26281@lst.de>
References: <20250317055304.GB26662@lst.de> <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com> <20250318064805.GA16121@lst.de> <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com> <20250318083330.GB18902@lst.de> <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com> <20250318084453.GB19274@lst.de> <20250319050359.3484-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319050359.3484-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 19, 2025 at 01:03:55PM +0800, Hillf Danton wrote:
> A quick fix is to add a vmap_pfn variant to walk around the pfn
> check in question, like the following diff (just for idea show).

No.


