Return-Path: <linux-kernel+bounces-303897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD196169E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C831F23DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96711D27B4;
	Tue, 27 Aug 2024 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FakWBL8F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FC1C9EC8;
	Tue, 27 Aug 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782595; cv=none; b=GAqqDd6uEn2rxU/wgAoN039XwMqq84Wg0nPCoXTfuQHso0D0hv3uQidjTB6YlRAWGHvDI+FCXquT9Odh5Rh+f2PvnraKg1HkZRX7JhMpbSrci2jJNcQMpgMsikZU1xhKyBmdP/JSFHTyx87zBcp/QNnq8PElhhyHc/+SNXnEQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782595; c=relaxed/simple;
	bh=1GxHEPXrVAe6OIAhEpqeV+67xfNW4gro/ZqKgd5SEgo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TY0hp2ULW6675lxp7uRiT0ugqUQerbVQ8jm4HFOUHxCL7UdCIeUqEVmFFE90UjX5hT5CelKJDpd1Y3L3VaIq/VHK8/gG0dqtienJ7UbqwKxV+nD088wIOv11li5lHVGxsMH3WiZpJX+EC2UHa8jjF8u8mNr69v4WPeqlcVWZOvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FakWBL8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4707BC567C2;
	Tue, 27 Aug 2024 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782594;
	bh=1GxHEPXrVAe6OIAhEpqeV+67xfNW4gro/ZqKgd5SEgo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=FakWBL8Ff+52pY0kGshsQMNywCQSI+TbZ1IvN5XC0voIOWjz9wFOtbWJHItSwyKAM
	 49aVNjN/LVFFbZqhevLCwRhhXN7kjtAQhHjCdUPzNVI6IwReFFwbPwhP6/BvCyGlo1
	 Gg/GpUSiOVy5/wroNA0tp/rcW90+47tiWop8rZstDh5xephA7BzGh9dDY3n+50oacu
	 rLrg+XpMyh32z4QO2N4Sf/Cdf4pryYbdhzDW/JaCEu++gN+8cizAl8h/5IO4le+R9e
	 vMtLeconBLjwsteU6N71z8N9s5xuLgzLu0Oo3GET12SJYfx0xs6SAWSzRCvq2AdHmN
	 GUbDkhPUU5UDw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Aug 2024 21:16:31 +0300
Message-Id: <D3QWEFR2E2BZ.187FVXI3QQU9U@kernel.org>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <kai.huang@intel.com>, <tj@kernel.org>,
 <mkoutny@suse.com>, <chenridong@huawei.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>, <tim.c.chen@linux.intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>,
 <chrisyan@microsoft.com>
Subject: Re: [PATCH v16 12/16] x86/sgx: Revise global reclamation for EPC
 cgroups
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240821015404.6038-1-haitao.huang@linux.intel.com>
 <20240821015404.6038-13-haitao.huang@linux.intel.com>
In-Reply-To: <20240821015404.6038-13-haitao.huang@linux.intel.com>

On Wed Aug 21, 2024 at 4:54 AM EEST, Haitao Huang wrote:
> With EPC cgroups, the global reclamation function,
> sgx_reclaim_pages_global(), can no longer apply to the global LRU as
> pages are now in per-cgroup LRUs.
>
> Create a wrapper, sgx_cgroup_reclaim_global() to invoke
> sgx_cgroup_reclaim_pages() passing in the root cgroup. Call this wrapper
> from sgx_reclaim_pages_global() when cgroup is enabled. The wrapper will
> scan and attempt to reclaim SGX_NR_TO_SCAN pages just like the current
> global reclaim.
>
> Note this simple implementation doesn't _exactly_ mimic the current
> global EPC reclaim (which always tries to do the actual reclaim in batch
> of SGX_NR_TO_SCAN pages): in rare cases when LRUs have less than
> SGX_NR_TO_SCAN reclaimable pages, the actual reclaim of EPC pages will
> be split into smaller batches _across_ multiple LRUs with each being
> smaller than SGX_NR_TO_SCAN pages.
>
> A more precise way to mimic the current global EPC reclaim would be to
> have a new function to only "scan" (or "isolate") SGX_NR_TO_SCAN pages
> _across_ the given EPC cgroup _AND_ its descendants, and then do the
> actual reclaim in one batch.  But this is unnecessarily complicated at
> this stage to address such rare cases.
>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

