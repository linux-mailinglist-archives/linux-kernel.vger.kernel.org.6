Return-Path: <linux-kernel+bounces-365344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338AA99E0DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCDD28233D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585A1D150D;
	Tue, 15 Oct 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="fm6R22uW"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C51C9EDF;
	Tue, 15 Oct 2024 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980505; cv=none; b=WXW6a7FjdUmoDE5vx6bkBgVOXueTKe5u50w7z24UTbxCnwIX0OBBeqzwT10/QfcHKXjxZZX8tK2P2kvnJZF+elqplqk1lxVU9c9UEVNVsW09EFNY/MvLkcmwhCGXY6RJHn4SOPK2pIEZ1hNSoxysQfJj53RHH99IaORPU243w6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980505; c=relaxed/simple;
	bh=FJu8jxT7yybdlKVwSMNi866ZJN5F9ybvNy+FS1T0B/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifKhn0l02MZkpOxsUvH/Dc2L1r6jDp3KrfkHnLdp8b+L+ukH/KYFlXTNSOcJcI4p6ot5ivcsQM2DYC1xLtXQCnJw44/kXUnru3fpj5TuaUHEAk+uRPALaevQqn6v58KWf10mJDUd3YRFALVCL8GXeqZgYZA1VA4ZF13n/LLl6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=fm6R22uW; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 55C1C2A7853;
	Tue, 15 Oct 2024 10:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728980503;
	bh=FJu8jxT7yybdlKVwSMNi866ZJN5F9ybvNy+FS1T0B/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fm6R22uWlTJA/xlFMaT7zegiH0tqkvyC8coAgom2ZDO1xhwDe9S++kP3FqI/FfEsU
	 gy4Xs8L3u1NkEe0wzEG8TlM1u56N9z/T3XObwsrb5azhSUabCU40NLhKEUY3UwuBfy
	 9OESxafPRMMMaGUTOpwFPGmjH9s42Rs2+cGu44wPQaUEudCgDun8fQukzeny3UrnZX
	 KJq8qDJ7WOKv+C/wqJbbEVVAKZxUiCA78uxBkF1mXfwN5IPZ4v/1ofUGt0tPiAryQk
	 txxcdbXHFKS+lkdMtiKxNb7GgagpiHQK+J2/d4EVgWnE8OvL4CPjn4p2WunBEckPHu
	 S/6jBl94svJYQ==
Date: Tue, 15 Oct 2024 10:21:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/35] iommu: Reorganize kerneldoc parameter names
Message-ID: <Zw4mFoOGqif1xmv_@8bytes.org>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-20-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930112121.95324-20-Julia.Lawall@inria.fr>

On Mon, Sep 30, 2024 at 01:21:05PM +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/iommu/iommu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

