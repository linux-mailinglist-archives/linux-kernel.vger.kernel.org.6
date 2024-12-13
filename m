Return-Path: <linux-kernel+bounces-444447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4B49F0702
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386FC16AA20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFA31AD418;
	Fri, 13 Dec 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7ZLnkgY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D21502B1;
	Fri, 13 Dec 2024 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080149; cv=none; b=jUYpFUeFn9SeI1ARpIXe7V+t7+mWRTTSttjpUwKdsK1s5smSvBMukOfOduWoYfwI6mweDhOFxHRFpAephvKwyiKG2tOtDLWo5E8oGCFjpeeMR8JXzUDBUb+BwoKIvkKsv9F0oMQQXsD+HLbbEgoQYgguMHqmjTDhySGK4TGiqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080149; c=relaxed/simple;
	bh=ctju1O2xk24+Jenhm52LvUFDbfNHZcP7hOyuWseV9Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgA7LCGLhXAc/3nbc8M64d9R69+bV3sBnjSe6Dx0J1b19iHPdbuE8F5e6uK/Zd8l1mawEAoQIYg+1PjdsBWMcLES0s8m/O4JU9SP+5MKXm/b+gCCvoPVVxgAdopbk0qsBoUs4gaQAEUo0i7NqmQommUVwbaef+YNyLLAxKxFQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7ZLnkgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E52C4CED0;
	Fri, 13 Dec 2024 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734080149;
	bh=ctju1O2xk24+Jenhm52LvUFDbfNHZcP7hOyuWseV9Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7ZLnkgY/6kp59eWcD92U6v+flo/Tu4NIOY3s/5kfJH8sKeUNXr/nte1hMK2D5zSj
	 jX1+4wfkqgZhytRoP+kC3Dz+RRwb/wGlOxEzm72XVh83qNc0MdCiByIiNOOFQaY5i9
	 mSnX45VtBXP/wxA+7+BJPHeJ+c+Q/lxeZaKFuc5xWIW7QVh9y7s+ORPvTpXer1qmb0
	 0OZN7K4kaab8C3qPjteRjXsWFcD7AQznyOfjyGVV+TQ1pb3jz6tXtAjdgGuSNNuv4F
	 Y+zPufXvm7gRj5w23bJKY2IlGcDTe22IUeUeXvVhap2neJPyuZ0pnErxtZNbnTI2v4
	 E+YWVsGY8D36Q==
Date: Fri, 13 Dec 2024 09:55:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jingoohan1@gmail.com, michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [RESEND PATCH v5 0/3] Add support for AMD MDB IP as Root Port
Message-ID: <njrgaeqjw4csczzvkf7rqgc7fr5cctgidbstygrpasprcrja7v@oah6glzexhsf>
References: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>

On Fri, Dec 13, 2024 at 12:10:32PM +0530, Thippeswamy Havalige wrote:
> This series of patch add support for AMD MDB IP as Root Port.
> 
> The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.
> As Root Port it supports MSI and legacy interrupts.

Why are you resending patches after 5 days? Your cover letter should
explain this.

Read submitting patches about timeframes so you won't annoy/spam
maintainers.

Best regards,
Krzysztof


