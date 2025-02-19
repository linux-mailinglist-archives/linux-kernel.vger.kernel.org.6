Return-Path: <linux-kernel+bounces-521553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62DA3BF45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2814B189925E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326EB1E102A;
	Wed, 19 Feb 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtiLZmhK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94832198E81
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969632; cv=none; b=MpM959fksr48T9f4ZS3BHGNX0KHfXWklVXwjN2zudGd2OjYWb8B1UP/+mnzCIdvY3aN9kF1uXel2vHiRZqsTvO0cJmj7TwAMojk55cdfriwoeoX50pxjUO4D9B450gYcX3/c9q/U3iyU1Wbg/7CxgN9cTGJE48VAFuyFZPopHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969632; c=relaxed/simple;
	bh=o1vrbknKIaZg3v8eM8Gd3qfJuaEPRIedyoiJKVEUJBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlhcMWOOCRrMdox3P94YUBg47O3ovmYA88mPKLMChPNXuvdI8bEhTwei7zNxy3L1KlLRImcPjcfE8uOlvP6+Ix0cxB33xiQxK51/+T+b3/4SaP+9Gek3irgdbOz31bYe7zXGEaXA4GUwj9WMSNJwtthhCAdj8eaRCEr5C2RlT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtiLZmhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF33C4CED1;
	Wed, 19 Feb 2025 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739969632;
	bh=o1vrbknKIaZg3v8eM8Gd3qfJuaEPRIedyoiJKVEUJBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtiLZmhKlr528J6r/FF0G8RYi7LKgIXhNe9vWG3+/5yZiJACZa7vf2F0zNPCtnky/
	 C+ffLJ6OJAEElfxHvdsPNdJNUE0Cn6DNb35GsYQAZb2lFPmCEc4IZtpP7H4h/lhlCO
	 5A/wrWjLRGcYFqrpwFxX1GtUw6FxsGCVg4fkUAyRAmsOy/jySNBAyIBjbqfHitN72W
	 QD6NsoADotjMkUcgnmnlyCLgSZj//4BvoZVrBMmjBbbfhpZHI1L5n3p7LcAy3gAAgM
	 drfauWiSI5bgzU28CA67TuzObyJXoDMFrfk1x8eGxGx7wBf0QuCxnPjIR/+KdpDdo2
	 xa/gai+p4dHgw==
Date: Wed, 19 Feb 2025 13:53:47 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: webgeek1234@gmail.com
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/nouveau/pmu: Fix gp10b firmware guard
Message-ID: <Z7XUW6-wT-CXUMgT@polis>
References: <20250218-nouveau-gm10b-guard-v2-1-a4de71500d48@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-nouveau-gm10b-guard-v2-1-a4de71500d48@gmail.com>

On Tue, Feb 18, 2025 at 03:28:03AM -0600, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> Most kernel configs enable multiple Tegra SoC generations, causing this
> typo to go unnoticed. But in the case where a kernel config is strictly
> for Tegra186, this is a problem.
> 
> Fixes: 989863d7cbe5 ("drm/nouveau/pmu: select implementation based on available firmware")
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>

Applied to drm-misc-fixes, thanks!

