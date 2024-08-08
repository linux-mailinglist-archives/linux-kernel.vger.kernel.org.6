Return-Path: <linux-kernel+bounces-279304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C3394BB92
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90C41F221F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E251318A934;
	Thu,  8 Aug 2024 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="SAfcVST/"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA741119A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114015; cv=pass; b=nawqu9BLNcUHGVjEKPcwXT4Zx0Tty/08pHdEuoKadUO4nnvFxBse4QrT9D5sh5STONhHtXsUxeXr+StsskYwU46rag/HUlhCBdqy0WEL8kwsdZDftIddL3DJoUn06LdEl94WonnFNLzu/sBxCn9hctobL0TXV73mi1jpuntJg5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114015; c=relaxed/simple;
	bh=PCi2kA13TaJf7rDilsta9k7vNrUVkczLlvLDKO73aZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skYWBDrKSGBaVyNnKEydz1qXIx9VNSjsqYHrhQMiEDL4UEdipDvnGLfacMPlrTfY97Fhd1l05q7uQ3+yxGbCH+kG9QUlBs+Cdz6sGOkgw3Z+kW6szeEw3nTOAhcFTbKeK87ezW32W5Yfvkp6BSnBWnf7imiVL0XQorU5u8qUP5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=SAfcVST/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723114000; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=azZa5nZN8r5OSARZsTxJtopNC4e7YGJ/gVNjDiT3OiRtcDOpn+mpABebHioN4yPK4MU9lma+S0Yv/x6DEjedR10Vt6Qx/AzsgJKOUBKugOgCJve64sQ7KTwE/KHx4slc6gKklxk2sUKrdlURRD1xJs32L6GswMYmsCJYm3Kzo5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723114000; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t+M3wOJceEQXPoAOrjXdGi2Q9xB7lebSyy+tJxgoNSw=; 
	b=BfGq3BD/njaLrkcK2c8Pip+FuVFwWeOV/6AZ3Kldd/55hFrSdTX81aHW4ujdb58WtmgWtsMJaJJ2IXd9SVfBKYOULK15bP2VjvH8nqH3mnkot0tV2B1P0ICapDDjtyO0UiTsYvprTulBtntqe93dpMpQybmuE/z8y8hbOK7KDms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723114000;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=t+M3wOJceEQXPoAOrjXdGi2Q9xB7lebSyy+tJxgoNSw=;
	b=SAfcVST/jtPvJ0PH7j76QqnCjrVU9sIoAFZZaNZ26Vtuvz4WA2SeETuV4aSDVqWo
	Rdo7jRNTchUA2yieRGD49E9AlLD+WTtN5QqaXcqjGcA9YyMkK5qOqEGtQPffH4tPnXr
	y+ugi8sC6Vt1CPwyt02MpOTI2v9LjMkdyW3KKl1s=
Received: by mx.zohomail.com with SMTPS id 1723113999747624.924931961419;
	Thu, 8 Aug 2024 03:46:39 -0700 (PDT)
Date: Thu, 8 Aug 2024 12:46:34 +0200
From: Mary Guillemard <mary.guillemard@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/3] drm/panfrost: Add SYSTEM_TIMESTAMP and
 SYSTEM_TIMESTAMP_FREQUENCY parameters
Message-ID: <ZrSiCvq1mYid2BlA@kuroko.kudu-justice.ts.net>
References: <20240807160900.149154-1-mary.guillemard@collabora.com>
 <20240807160900.149154-2-mary.guillemard@collabora.com>
 <37be0bd0-219d-4e46-b17e-cde7f960becb@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37be0bd0-219d-4e46-b17e-cde7f960becb@arm.com>
X-ZohoMailClient: External

Hello Steve,

> VK_KHR_calibrated_timestamps says it should query 'quasi simultaneously
> from two time domains' - but this is purely providing an interface to
> read a single counter at a time.
> 
> It _may_ be useful to report the GPU's view of time and at the same time
> (or as near as possible) the architectural counters. That can be used to
> deal with drift between the GPU's counters and arch counters[1].
> 
> In general we try to avoid providing an interface to something which is
> unrelated to the GPU, especially when user space already has a mechanism.
> 
> Steve
> 
> [1] See Mihail's response to the panthor patches for details of
> differences that might occur.

I initially didn't saw the register to get the GPU timestamp and
wrongly assumed I would have to query it from the generic arch timer.

I will make SYSTEM_TIMESTAMP returns the value of the timestamp register
on v2 and keep SYSTEM_TIMESTAMP_FREQUENCY the same way as it is at the
moment.

Thanks for the review,

Mary


