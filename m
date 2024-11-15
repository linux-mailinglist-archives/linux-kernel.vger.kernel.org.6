Return-Path: <linux-kernel+bounces-410372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4139CDA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D38B24758
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5D18E056;
	Fri, 15 Nov 2024 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="F2vwKLTn"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908EC18C33C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659551; cv=none; b=LcMf/RUtWOxrLQNzvS85B+udd/QBflIOxkPS5M1PDlk8RGhwaNzx8qSvRJmw9tI0Dv8un3m90jEHPuplaevAg3TfXJyzM/JNMTm322vpUffRTbEcfUJ/gPTvBzJ+Cdi2SqPYToluIiQowbR1cl9TtFIpSf7hcyLokadVaB/APN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659551; c=relaxed/simple;
	bh=ddyxbqxMF4oFoUnh8kdfqjS/EgpzWIB8AfoREuHj214=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am2yvI6TkRt6Vl0CxGJsNFDRqECyIWrgHgTW+DJc8fIdL+/IF6xwKXl3SL8knCtcIa0OxZ0lI0G/zog0Gz88aE3/71GVp9UdysfS6Z0+USIDcvHR2UHtphJyAKltR9Nll/Xn/HAoWRL+/6G0mFjsQPq6ladKp8/QTOwRQJYg3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=F2vwKLTn; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 014DE2C1435;
	Fri, 15 Nov 2024 09:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1731659180;
	bh=ddyxbqxMF4oFoUnh8kdfqjS/EgpzWIB8AfoREuHj214=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2vwKLTnRedZtouBv7ykR8mVjofKq/jjctu8ciEhMsAxCR/rScmyH+Uvqor2b7qfu
	 Omz7FxHMijGktUpxZocWS1X2I+SP3bRoYzuSq+VFxZU9CbUHOGgIgYiEysX30c7uKc
	 NIJ/f8Id/s1JBmXCphPlJpNidMcmiesQ4FG1MtSaXt/gJEAxR1ZFQnReeG3VD033OF
	 FuEBXfAXa6lebusYJs1bwvVgFEQXQhQo8v1RSbNCBNMF3voS70+e8j+yj671riozv7
	 SfBDB3TobT/NGDoLEC8Shd8spTjbNLigVytSDleNd+gwjxijUSXBKVIusk2hm8gFUU
	 tzoDm/T87s4fA==
Date: Fri, 15 Nov 2024 09:26:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.13
Message-ID: <ZzcFqvfa6BoFBiE0@8bytes.org>
References: <20241114171808.GA24017@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114171808.GA24017@willie-the-truck>

On Thu, Nov 14, 2024 at 05:18:09PM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.

