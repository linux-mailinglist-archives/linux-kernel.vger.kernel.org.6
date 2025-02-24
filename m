Return-Path: <linux-kernel+bounces-529712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F43A42A21
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450E416ED5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BB3264F9C;
	Mon, 24 Feb 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgGDeGIE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB0264A96
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418746; cv=none; b=J+E/faA3TLP+ZWvPr70qLgPMJ5cwD5cRQ2ev54RFKrodWqzRoBKyj8qciOGF2pnjSGwlaaPnMg/C/9xASN0H08NimUoXZHTJD13NcC+aWKEqEPd7LGV1F9TbKS7WQTGOLIqy73zNTxkdEFcy3J5pzR8h2zuOWdT0Gmg1Ynp/L1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418746; c=relaxed/simple;
	bh=619tZoHZ/f7HOS/Z4xlBpZuevxAd2Yv2WG8EAm0XZ3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQzD1jNn3Iz5NjF4GjRnRJuhxDw/1Ld7aiKjqEzn6Mmw3CE5smMp70kVqX6tElXS0Gehsj6oRxYOPJStH5sT86ocksC1mg6dg0iOdQL0ZRPjf3xQ/evTZLePAYYQ40eONsWZIZ4V9jqqqIQtypuvk/fUF0T8lESNtL5zgQrfnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgGDeGIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CDEC4CED6;
	Mon, 24 Feb 2025 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740418745;
	bh=619tZoHZ/f7HOS/Z4xlBpZuevxAd2Yv2WG8EAm0XZ3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgGDeGIEL8cx03ArxbzGGb3MJkcT+Jo+GHKrD9oazT/8uizVJuchGtgXwxXyewu0j
	 zqTBjQs8MzgF1JmuwLTNAbey7OWeMLtCGtwHYhBd3xkfK5U702tGhCNVsT5jnnh/DT
	 A+QL9akHhirE8MNFig4o6LtQ46VyPO0IQ4ilamvwcoayY/ztGvDa7jA1Lq4h5iFj61
	 f4pBE245KvfzG45vk7FSZzG1YiNYuQecRbI8G3YfEAySbQKrVp6ckuGN0bOaSPHrp0
	 yvL38KOv3ZLC6maTmB+qPSCoqzAi90mT4v8izVp5hFrJ2ATK4AEqGNIcnKU4DIW4lR
	 h6XSEXO/+O2jg==
Date: Mon, 24 Feb 2025 07:39:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: idle: Introduce
 scx_bpf_nr_node_ids()
Message-ID: <Z7yuuIL7-GMv2rsI@slm.duckdns.org>
References: <20250224164921.214455-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224164921.214455-1-arighi@nvidia.com>

On Mon, Feb 24, 2025 at 05:49:21PM +0100, Andrea Righi wrote:
> Similarly to scx_bpf_cpu_ids(), introduce a new kfunc scx_bpf_nr_node_ids()
> to expose the maximum number of NUMA nodes in the system.
> 
> BFP schedulers can use this information together with the new node-aware
> kfuncs, for example to create per-node DSQs, validate node IDs, etc.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15 w/ s/scx_bpf_cpu_ids()/scx_bpf_nr_cpu_ids()/
and s/BFP/BPF/.

Thanks.

-- 
tejun

