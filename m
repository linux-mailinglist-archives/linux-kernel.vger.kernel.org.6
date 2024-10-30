Return-Path: <linux-kernel+bounces-388605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E029B6200
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FDC2814A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6BA1E4924;
	Wed, 30 Oct 2024 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUFHcqtN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E21D0E30
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288326; cv=none; b=ZGMbDev8vSxukgYaXhPmy8TrMwR1Mk8xAoNePahbTtYZEUECZxX6mzbvFw42PdQWGwCfgSeU864ptzA7Sa1X9imbFPjtkM4vTURrfkVOaZ+BI9TCC1+ODfWWoEdG4b3i8zP3DnyYv/mBD9KhBDRHj3xa+/NSjBHCe6F6fZrNMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288326; c=relaxed/simple;
	bh=kzV1E3Ls2Ygp/OOPQS1ESh2p6VkCY97SgmA7vvzamig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dW2wxstmde1LNmXczr7cw0iIDhwv/Ty+VRrWbIBptd/7bBUsshl20weZmFcCKtcoHxcR2vq6qlInItrUKPvrBETan090M2X4nIW5C/RhtKmhAKMklPNg/KxOP28jPViYMAwfINzjTnYxRaQ8CIFkrqQR+bJsVzrosXUNl+qYxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUFHcqtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792A6C4CEE3;
	Wed, 30 Oct 2024 11:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730288326;
	bh=kzV1E3Ls2Ygp/OOPQS1ESh2p6VkCY97SgmA7vvzamig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RUFHcqtNPgB9RpjadKuiBooMPQNspN1+0oEpAr7gkKL8F7AoqvC89tDHgn+Xu33FZ
	 PLVxC1c3wtDNtUtol+3YGWRtvPPT6sDrzoHMC10nW0G87Hls+YP9LdbcRy1W3g0+EZ
	 ahXKEhaOGYPm7xsSj+MkY7Dp7J/QsadC6rXMijW945OTO7znR5RbqB80BpuXz2l/RR
	 HhvfDvXyWn3jEWFMhZCsaZQU+c6yPWaCKqpAnr+D/dJAloJIHM1jOpLwM/0RC5N/Ym
	 dFoyadtC/D4+iq7P6v8pLDV4oh52x87or4yHSILOLAM38hk9k3AQVOhYFVMcE/WOJY
	 NbTc3kl++zhDQ==
Date: Wed, 30 Oct 2024 13:38:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Kiran Patil <kiran.patil@intel.com>,
	Martin Habets <mhabets@solarflare.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: auxiliary bus: Spelling s/pecific/specific/
Message-ID: <20241030113841.GA17187@unreal>
References: <f232a09c377cbe11c81b4ab69d4e7bf016e746c8.1730282860.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f232a09c377cbe11c81b4ab69d4e7bf016e746c8.1730282860.git.geert+renesas@glider.be>

On Wed, Oct 30, 2024 at 11:10:22AM +0100, Geert Uytterhoeven wrote:
> Fix a misspelling of the word "specific".
> 
> Fixes: 7de3697e9cbd4bd3 ("Add auxiliary bus support")
> Fixes: e1b5186810cc7d4e ("Documentation/auxiliary_bus: Move the text into the code")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The documentation was moved and reformatted, so I used two Fixes tags.
> ---
>  drivers/base/auxiliary.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

