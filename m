Return-Path: <linux-kernel+bounces-549123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE2BA54DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5752B3B2380
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A916DEA9;
	Thu,  6 Mar 2025 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWIRhtaF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39B139CFA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271324; cv=none; b=k29CxbADFqKp+8gT/K07sx67LRH9QY9oaNx+/rTIZBpW87NZc3sP7c/XIHJOIFLzZViKxuiNugk5mIG6a7NmDFEX1pSAZHsFTj0zC4nszez+gbytTPYGn/jioCJYUvXhKyGjK8CTn74hQpny3qOTM76Kl70UDcxi2lC1mGC7HjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271324; c=relaxed/simple;
	bh=llfaZ6m1nVqICHV8YOp4t9+wLvbTps13KLEhVlvlLtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCoHI5lOjyE8Zmf286fxABrE4MzPECWoSyIjcFKWLh+IA/wc+gGe0Xu9GeUVVtXjrTD2tffVfg++9iL3/9qxgil0j7+ClqKuTQNKrXhAqc5CANoCpaMTn2gFAtaSKmor/7xntYm3nwHSu1Wr+yty6FoKg70uSvw0d4Wwqgs9zUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWIRhtaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA350C4CEE0;
	Thu,  6 Mar 2025 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741271323;
	bh=llfaZ6m1nVqICHV8YOp4t9+wLvbTps13KLEhVlvlLtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWIRhtaFAnBS7I8wMol1rWGTLH97nLXilojiNesJpQT7x276ika1HysjDCV4+fHSH
	 l2AVAobZ5uJhqcRcSmBMkHgu2To3Ql5WKYkt8VMV/fFyOpo/a7GQAu0jHu9ewVtImb
	 4O1A5E57NP1+Wth5yFjTclVcNVxT1jZIc9LqqKg8HjgnWkmFzvK8WmqmGTUUyFe+Gd
	 hfnmqRx7WN8Sg2U7hkIW5TgYcV+PkDk5/lDgH+2J/6IZFKC+kfDlw1AIuLbXtJ1grh
	 0gz50dbO3G15ksruGbqfzztnR6PzCOV6M2g5SwtVRh2Y86P44nyYzeeZEVvZRbxi31
	 IM2dTbtj5RFRw==
Date: Thu, 6 Mar 2025 15:28:38 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] drm/sched: Documentation and refcount improvements
Message-ID: <Z8mxFslgK-XE3EEX@cassiopeiae>
References: <20250305130551.136682-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305130551.136682-2-phasta@kernel.org>

On Wed, Mar 05, 2025 at 02:05:49PM +0100, Philipp Stanner wrote:
> Philipp Stanner (3):
>   drm/sched: Adjust outdated docu for run_job()
>   drm/sched: Document run_job() refcount hazard
>   drm/sched: Update timedout_job()'s documentation

Acked-by: Danilo Krummrich <dakr@kernel.org>

