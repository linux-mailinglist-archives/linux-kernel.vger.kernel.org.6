Return-Path: <linux-kernel+bounces-410143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59709CD510
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD7D1F21BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E841177F1B;
	Fri, 15 Nov 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbb74cxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF727468
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731634268; cv=none; b=j6uPI2H/1oLvmeu5Qoux7owdVDFvSVPCmMGqIy/4hyOcJsUF9UWDmG+TKUeXsIjbe8SLdM/eR2fBhemw19EpvRl+2IO643NvMFPCLfoiYSaiLCjYbY2OYNfWXFB2KtYCba6btkhDRIkqSNMD/mb5k1j37eDpray+nYlmhusfcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731634268; c=relaxed/simple;
	bh=W8vaLdqnGwwYrrONqRMfLRzQ2kpc3nPF0919FxV7+Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh4ZQ2fEPQcWh4ZcjIIsfwion59/4icK8CrpmVGr+URMP4sF20AAlPSoSQ+ySnnnxl/kQqWuqP6IY/FtWeHFDKpPjVyTy+O2JcvGiFI16n0BCXRySyGHtNS4NpxY3lBF3o3LoNE9u6Ne/GyZ5/a6MzJBjSxOfLyg4B3k/9390xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbb74cxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3170C4CECD;
	Fri, 15 Nov 2024 01:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731634266;
	bh=W8vaLdqnGwwYrrONqRMfLRzQ2kpc3nPF0919FxV7+Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbb74cxXpzdIjL6lCptrJbLiDziFRBRTz1qpT73U7psbUbODm6fzK8s8jU6Lm5TyF
	 w3T2bVKJ++aI8+43BrUw6a/0e290k2kLgK1LijrrOcATEnfuVU5qOHb0311pph/nNs
	 L20Yo9SaaLnIhJA9jZH2Nq6LbfW4x36Vmd2dYLozIoxeFFDoQh8/kfLVh60jdujQlU
	 vTvGf1RkQdK8aZKNh+ECUxrBG6br3+lSZ/ksYHbP0uP+STouXNGuzIhOwPrOgWCrIq
	 os9R2TtHQG9N9mGK+oJZbWtuKVWEmVbeGo+fke51GVtj2S9yjjkKNGnj4fTM7IbB6m
	 mVWZwoa2TkeGA==
Date: Thu, 14 Nov 2024 15:31:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: void@manifault.com, zhaomengmeng@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Replace scx_next_task_picked() with
 switch_class() in comment
Message-ID: <ZzakWdS6ctSusIrf@slm.duckdns.org>
References: <20241115011709.1022217-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115011709.1022217-1-zhaomzhao@126.com>

On Fri, Nov 15, 2024 at 09:17:09AM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> scx_next_task_picked() has been replaced with siwtch_class(), but comment
> is still referencing old one, so replace it.
> 
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Applied to sched_ext/for-6.13.

Thanks.

-- 
tejun

