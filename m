Return-Path: <linux-kernel+bounces-401655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC79C1D83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFD3B210FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA3D1E5721;
	Fri,  8 Nov 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DqHDRUEx"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F581D0400
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731070979; cv=none; b=hKZh6cPJNzz0FPsfTcNOt+x7QeXWB9fkaZxDtYxj3nMk4k04U2oszyTu3ADUbAGMRq8RZNUQxM6xsBXfBPz3+hPEZuxbRC00weqLyzcbqj9HPIjizWvasxQ6U4cruA7T0aAIQFfRBuXwCUmnhWNS2E0Z50Xn2ufvjIFs8VZCURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731070979; c=relaxed/simple;
	bh=UmnyIYha6CahhKYeCGhD2P4AtwudPXNy8mGMgkZKhYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHbDse0GVSEd8OZvDZq1QkpnxxTbkCrlbl6cXHGAS4WBBsPps1nRWPTLDw5qhIA3Y/b3cN+QVOBZQSS1MxB1uSWxSoMGolSlgpBoW5+c74hcKwFx0NlM+RRnROKOka/GMHUp1FKzfvkBq9lcwEZmuZFzbdcesl7biMHqECUK2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DqHDRUEx; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E073A2C112A;
	Fri,  8 Nov 2024 14:02:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1731070970;
	bh=UmnyIYha6CahhKYeCGhD2P4AtwudPXNy8mGMgkZKhYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqHDRUExugqwcUdamHJZK8aPA6sHR7VXnTT8woIQoRwpDVOhlt+ZALdx6pPvBO2A9
	 JBXpv+RNwzsvIG3zvJXzUEa0fLET3ru/cxpz2abfWfKxv6kBd5ooNNzEMjjcxVn5RM
	 VjhUfIKJ+1p7oIIE7p7Tt1mANFALw/TWnrjaT485pNtaxZ0xrwVWPCOP4ebV93MvBX
	 N0HWHWMFcitNJD6xBL3Vjxjg1hNV80hdGDKYSUAddIJzgtN0JPdUNLe0bO1I7uIF/1
	 qqFdyTImn1JcqLMh0LWEhAD0jPP1lHf4+x0yDC1iYd3z+Lf9PkZYnox+icXmjam3k6
	 nkfuDCcmbFPDA==
Date: Fri, 8 Nov 2024 14:02:48 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Gan Jie <ganjie182@gmail.com>
Cc: robin.murphy@arm.com, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, trivial@kernel.org,
	ganjie163@hust.edu.cn
Subject: Re: [PATCH] Driver:iommu:iova: Fix typo 'adderss'
Message-ID: <Zy4L-LE2ka_sUxT9@8bytes.org>
References: <20241101072709.702-1-ganjie182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101072709.702-1-ganjie182@gmail.com>

On Fri, Nov 01, 2024 at 03:27:09PM +0800, Gan Jie wrote:
> Fix typo 'adderss' to 'address'.
> 
> Signed-off-by: Gan Jie <ganjie182@gmail.com>
> ---
>  drivers/iommu/iova.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with adjusted subject line, thanks.

