Return-Path: <linux-kernel+bounces-555721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCA9A5BBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8BA16EFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CEF222587;
	Tue, 11 Mar 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OsTgjHIS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D42AD2A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684575; cv=none; b=sUdeR3ZL9ps8jeV9iPSXESo4g2HvoI6Gbc2rcGTS4kgcJXkusXdfqwJA8Z6XNxWmMM478TA5M3Zlm5LBEzj1H/DpFmeWLRu6juCtAI9BesN5KRp8SyH95griqOe1EZKWib2++4x8g0FvGT0mNTey9ZGGPUlmgWRJ8wZwcmAF6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684575; c=relaxed/simple;
	bh=+LmbqfqjpLNk7GtSwJDOFlesjC4+wxWCYVNW6cSONUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYaYFMjcNuw0MKNHciw9yCUjQadLOaORlCoh15la4rhDT6+3C9ug+f3mdJLt0veJ52rzvlRhqd2qZ/LXxfqRcEosSJK7mmnnN5K0+UJ/hgM1fsrJWWzjQlgKdK31fxLQTEThrCl+iIh64nuGgCFTzjdAeaTY9Cp1Z+VCP0HKF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OsTgjHIS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741684571;
	bh=+LmbqfqjpLNk7GtSwJDOFlesjC4+wxWCYVNW6cSONUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OsTgjHIS83+R6Pd5t0aY4Go4mLKcy3qkW9KB8z7qOB4GPz04tCE6FSVwa5dgq/npa
	 /1LkVSwTKzUMjhx8CCJrinfpfkbezJgoVTFSkaFXbUlfi1jUOWOfw6YZmFNOe9Rjs5
	 Eq0XeTRxV/W1DYk8H8v8eDUbmgnkYRbvoYqTEymIvlU3GBr7g8pE9UFBsNhkA6qvPy
	 B339y6UtlH7KcSwD66lwY5xEvc/oMPYoEc1YuQzYeEJCGZwoXdy6kvs+IF9aGleeVS
	 3CMGeJFfsAexILHOhK+ymYTJ9mq5XBD8pmn4I7LNZCkPWbGikXzzcZCTK1eks3NW1M
	 3R2ooejUbim5Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8127617E09FB;
	Tue, 11 Mar 2025 10:16:10 +0100 (CET)
Message-ID: <62765c3c-7663-4b27-a839-7fe5ea9a3c12@collabora.com>
Date: Tue, 11 Mar 2025 10:16:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] drm/panfrost: Set IOMMU_CACHE flag
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kernel@collabora.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sjoerd@collabora.com
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
 <20250310195921.157511-2-ariel.dalessandro@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250310195921.157511-2-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/03/25 20:59, Ariel D'Alessandro ha scritto:
> Panfrost does not support uncached mappings, so flag them properly. Also
> flag the pages that are mapped as response to a page fault as cached.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


