Return-Path: <linux-kernel+bounces-312287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C81A969484
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161491F23DBC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1371D6783;
	Tue,  3 Sep 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR2tuWx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF61CE6EA;
	Tue,  3 Sep 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346912; cv=none; b=OQPj9iAqYHovIlTeE0oRL545cA2Na9+rFD622HMr5u3K/TSKyj6lKSfJCKUEFP9RyZqss+Ru/wzOe8sSrUl5Co/dHe94Rh/s0Q4fCp/XEJZbM6wnVWyCbefDW2NY4lvUoFMEj3YS4eR/iCtIa3zKmBelVcpuJutftkpjLoIdOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346912; c=relaxed/simple;
	bh=PF81La/Nmxb900Q+rRwuTwsXTBfvX2KbOjEq2mtCfSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI2BME+986ABZacs229jZNtmTBejkf3yGSAb7eIJuskKbngClyTWpLC5qCniYsG7Gl1BqcMxANTZhHSOt/HZKxm9c/UFKRpoa8DieWMDD0F0hEeURVJ9O+qEFBXIeJOfUR+RPwXbT+PtWygdV0k991g40vhhQF2aIR62JuLHseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR2tuWx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32B8C4CEC5;
	Tue,  3 Sep 2024 07:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725346911;
	bh=PF81La/Nmxb900Q+rRwuTwsXTBfvX2KbOjEq2mtCfSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SR2tuWx0wps7Wxw0vdnVhG61v7p5F6UB7mpl+HxT/xUaCBzo1Cd5v4xj70wVq92mT
	 dsP2QU+z+ra60yPyUxR/eJ0u4GLbnWxa2LN1aZtHj9dbpLWNqeaOfj2kvooF7hYBwN
	 DGvYncSdBYKriAk6Aijw0JNJAzrEuPWf+eq6LUE0uDlJzngmeQ04VFKfRMGnTKcp2D
	 9YlKfGAroNAjoQAecMy7YxJHKgNmf3/5JK0NQAaerqfYtQ11WEbYiJS48Mr1T+aQAq
	 +SVxVvmpf49asrCWZ85TrmeObR2kssGHrVgDD2Iw4FNnihafOYXWISOj/737AJd0wL
	 EQ2xHAZevNjng==
Date: Tue, 3 Sep 2024 09:01:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, knoxchiou@google.com, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: mediatek: Add MT8186 Ponyta
Message-ID: <winiurki2vvkzgrembzbdxem3msqfxo632tlqtaju6ggafnxmt@r4wakh4lvxat>
References: <20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com>

On Tue, Sep 03, 2024 at 02:16:01PM +0800, Jianeng Ceng wrote:
> This is v2 of the MT8186 Chromebook device tree series.
> 

Where is the changelog? Why do you send the same patch as v2?

Best regards,
Krzysztof


