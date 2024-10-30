Return-Path: <linux-kernel+bounces-388907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A359B65F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABD02849AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C6A1F7082;
	Wed, 30 Oct 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="He3jaf3J"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9FB672
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298633; cv=pass; b=CVYH9FuFOpQrN1zSz4pInpGqmmNTqsq8Ti8s1jFwuI03XsjMB1mtynn9nhdk4g9C6gy1+3FRHvxZpyIw5GdBwoJ0OOSxvLiJ97LvHLS23TCuJ9uXmBvE5S6E8Dk6+PpnDuSDdc9DE3pVS5n+I5HqlZVe1ghLF2Dd8WXC4aMYPTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298633; c=relaxed/simple;
	bh=xqKaSZIQCBFRkz75kPS41zkYUG80s6hEjC6yKaiWRGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhuiMx5XR+zkbuuiXguPRDZfS2eQSi1NzPiO4kULVqZCxsXFW8D4HoSe5zzFA/h9x4vUDSBUmLuKwRKhtJtdFVfAIdsj+q/9PkDfwWuCncDfYxux0KFg4uu12SxHBTdzeYspvzPxDaEgAXFuZGkSL1YzmAh658aVO4P5BCtFBBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=He3jaf3J; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730298623; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RM3U1/PbSO3uL9wQezWek4QHo4FLsF+C8jbFLwByC6fwFYitFzIYDVeJYGUdGb8dsleor503gU69ioDd9YNb8462K2p2TgYOYd+CphRzlr//5T+FzzPzemxZCkZjt4DXVTo6P4JrLLPMUBZ4FuuGcMyfYxWOw/2Ijn5oAR9ppIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730298623; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N8AMRED8QNkKaZeQLm0zw/I7Q/T3Sk2PTgWcUJixhts=; 
	b=nsRaPYw2TYVI1lrGzzSEavJUEzzQ9wVWf3tqfPlewm4VxLaKV5Gw71yZkZvdeXjlwRU/+UnsHVMoh2fA9MKs8W/vDo18UCwihapK98KFE1s+8a1kgU6GXKRtKB+lWcFw70F6xZQVSfDLnBwwaAewwplbY8l/lWmWWN6AsmU97tw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730298623;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=N8AMRED8QNkKaZeQLm0zw/I7Q/T3Sk2PTgWcUJixhts=;
	b=He3jaf3J1+LeY7kusRxFZqoxpA15oqdg6Uc4s+E2o36nG6Vdva2yMV6wszHgNjXi
	33UbZch/hzHaD+X8xk/t07ltVJRyacizHjHy9ixAwiPTegUIR1UJUIedOCobB4pGlUK
	sNAYQorGfnzXKrPUPu6+ewiZshqQsHWaf/JIbvZo=
Received: by mx.zohomail.com with SMTPS id 1730298622814993.5661764694705;
	Wed, 30 Oct 2024 07:30:22 -0700 (PDT)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com,
	dan.carpenter@linaro.org
Cc: anders.roxell@linaro.org,
	ben.copeland@linaro.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	nfraprado@collabora.com,
	rafael@kernel.org
Subject: Re: [RFC] driver core: add a dbg printk for successful probes
Date: Wed, 30 Oct 2024 15:30:45 +0100
Message-Id: <20241030143045.24965-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241025125834.19758-1-laura.nao@collabora.com>
References: <20241025125834.19758-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi all,

On 10/25/24 14:58, Laura Nao wrote:
> The main challenge with these tests is building a list of devices expected
> to be probed on a given platform, rather than knowing if a certain driver
> was probed. From our experience with KernelCI and bootrr[1], manually
> creating and maintaining such lists can become a high-maintenance task.
> Relying on kernel output with the suggested debug prints as a reference
> file would still require significant upkeep - generating, storing, and
> updating the reference for each platform over time. Additionally, there's a
> risk that some failures could go undetected, if for example a driver is
> missing from the kernel config at the time the reference is created or
> updated.
> 

Building on this, what do you think about adding a sysfs attribute to
identify devices that aren’t meant to be probed by a driver?
I can think of a few cases, like class devices or devices not assigned to a
subsystem, but there are likely many more.

A recent example I encountered is with I2C adapters: while the device for 
the I2C controller itself is expected to bind to a driver, the devices 
created for each I2C bus segment are managed by the same driver but 
don’t have a driver symlink in sysfs. From userspace, looking at all 
devices in sysfs, it’s difficult to tell which ones represent actual 
hardware and which are software abstractions managed by the same driver 
but not directly probed. Having a specific sysfs attribute for these 
cases would make it much easier to tell them apart.  

Any thoughts on this?

Best,

Laura


